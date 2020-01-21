data1   segment
quest1  db      "Enter BMP file path: $"        ;
err1    db      "Cannot open file!", 10, 13, '$';
err2    db      "Invalid BMP format!"           ;
        db      10, 13, '$'                     ;
err3    db      "File is too large!"            ;
        db      10, 13, '$'                     ;

data1   ends

code1   segment
    
start:  mov     ax, seg top1                    ;inicjalizacja stosu
        mov     ss, ax                          ;
        mov     sp, offset top1                 ;                                         
        
        mov	    al, 3                           ;tryb tekstowy 80 x 24 znakow
	    mov	    ah, 0                           ;zmiana trybu
	    int	    10h                             ; 
        
        mov     ax, seg quest1                  ;wypisywanie tekstu powitalnego
        mov     ds, ax                          ;
        mov     dx, offset quest1               ;
        mov     ah, 9                           ;
        int     21h                             ;
        
        mov     ax, seg fpath                   ;pobieranie sciezki do pliku
        mov     ds, ax                          ;od uzytkownika
        mov     dx, offset fpath                ;
        ;jmp     fopen
        ;push    dx                              ;
        mov     ah, 3fh                         ;
        int     21h                             ;
        mov     si, dx                          ; 
        mov     bx, 0                           ;
        mov	    ax, 0b800h                      ;ustawianie adresu bufora  
	    mov	    es, ax                          ;tekstowego

prpfp:                                          
        mov     al, byte ptr ds:[si+bx]
        cmp     al, 13                          ;ustawianie wartosci 0
        jz      fopen                           ;na koncu nazwy pliku
        inc     bx                              ;
        cmp     bx, 16                          ;
        jz      exit                            ;bufor na nazwe pliku za maly!
        jmp     prpfp                           ;
        
fopen:                                          
        mov     byte ptr ds:[si+bx], 0          ; 
        
        mov     al, 0                           ;otwieranie pliku
        mov     ah, 03dh                        ;
        int     21h                             ; 
        jb      foerr                           ;jezeli wyst blad podczas otw
        mov     word ptr cs:[file], ax          ;
        jmp     vldbmp
        
vldbmp: 
        mov     ax, seg mgcnum
        mov     ds, ax
        mov     dx, offset mgcnum
        mov     bx, word ptr cs:[file]
        mov     cx, 54
        mov     ah, 3fh
        int     21h
        cmp     ax, 54                          ;czy wczytano caly naglowek
        jnz     invfor
        mov     ax, word ptr cs:[mgcnum]
        cmp     ax, 04d42h                      ;czy to ta magiczna liczba
        jnz     invfor
        mov     ax, word ptr cs:[ehsize]
        cmp     ax, 028h                        ;czy extra naglowek ma rozmiar
        jnz     invfor                          ;40 bajtow
        mov     ax, word ptr cs:[ehsize+2]
        cmp     ax, 0
        jnz     invfor    
        mov     ax, word ptr cs:[cplnum]        ;czy ilosc warstw = 1
        cmp     ax, 1
        jnz     invfor                              
        mov     ax, word ptr cs:[cmprmt]        ;czy metoda kompresji = 0
        cmp     ax, 0                           ;dane musza byc surowe
        jnz     invfor
        mov     ax, word ptr cs:[cmprmt+2]
        cmp     ax, 0
        jnz     invfor  
                                
        mov	    al, 13h                         ;tryb graficzny 320 x 200
	    mov	    ah, 0                           ;polecenie zmiany trybu
	    int	    10h                                                  
	    
        mov     ax, word ptr cs:[bperpx]        ;sprawdz ilosc bitow na piksel
        cmp     ax, 24
        jz      f24bit  
        cmp     ax, 8
        jz      f08bit
        jmp     invfor  
        
f24bit:     
        ;mov     ax, word ptr cs:[imgsize]       ;czy rozmiar danych obrazka = 0
        ;cmp     ax, 0                           ;musi to byc dla BI_RGB (24bit)
        ;jnz     invfor
        ;mov     ax, word ptr cs:[imgsize+2]
        ;cmp     ax, 0
        ;jnz     invfor                          
        mov     byte ptr cs:[btperpx], 3
        call    fxxbit1  
        call    initpal
        cmp     ax, 0ffh
        jz      invfor
        jmp     display 
        
        
f08bit:
        mov     dx, 0
        mov     ax, word ptr cs:[bmpw]          ;sprawdzanie czy wysokosc
        mov     bx, word ptr cs:[bmph]          ;razy szerokosc = ilosci bajtow
        mul     bx                              ;obrazka
        cmp     dh, byte ptr cs:[imgsize+3]     ;odwrotnie zapisana wartosc
        jnz     invfor                          ;w rejestrach
        cmp     dl, byte ptr cs:[imgsize+2]
        jnz     invfor
        cmp     ah, byte ptr cs:[imgsize+1]
        jnz     invfor
        cmp     al, byte ptr cs:[imgsize]
        jnz     invfor                                
        mov     byte ptr cs:[btperpx], 1
        call    fxxbit1
        call    readpal
        cmp     ax, 0ffh
        jz      invfor
        jmp     display
        
fxxbit1:
        mov     ax, word ptr cs:[bmpw]
        xor     bx, bx
        mov     bl, byte ptr cs:[btperpx]
        mul     bx
        mov     cx, ax
        and     ax, 00003h
        mov     bx, 4
        sub     bx, ax
        and     bx, 00003h
        mov     ax, bx
        add     ax, cx
        mov     word ptr cs:[rowsize], ax
        ;jmp     zomdec   
        ret    
        
readpal:        
        mov     ax, seg palette                 ;instalowanie palety kolorow,
        mov     ds, ax                          ;ktora jest zapisana w pliku
        mov     dx, offset palette
        mov     bx, word ptr cs:[file]
        mov     cx, 256  
        jmp     rdpall
        
initpal:        
        mov     ax, seg palette                 ;instalowanie palety kolorow,
        mov     ds, ax                          ;ktora jest zapisana w pliku
        mov     dx, offset palette
        mov     bx, 0
        mov     cx, 256  
        jmp     rdpall
        
rdpall:
        push    cx  
        mov     si, dx
        cmp     bx, 0
        jz      setsamp         
        mov     cx, 3
        mov     ah, 3fh
        int     21h  
        cmp     ax, 3                           ;czy wczytano kolor dla danego
        jnz     rpalerr                         ;indeksu
        mov     si, dx
        mov     al, byte ptr ds:[si]
        mov     ah, byte ptr ds:[si+2]
        mov     byte ptr ds:[si+2], al
        mov     byte ptr ds:[si], ah
        jmp     shrsamp
       
setsamp:
        push    bx
        mov     ax, 256
        sub     ax, cx
        push    ax       
        mov     cx, 3
        and     al, 0E0h
        mov     bx, ax
        shr     bl, cl
        or      al, bl
        mov     byte ptr ds:[si], al
        pop     ax
        push    ax
        and     al, 01Ch  
        mov     bx, ax
        shl     bl, cl
        or      al, bl
        mov     byte ptr ds:[si+1], al
        pop     ax
        push    ax
        mov     cx, 2
        and     al, 003h
        shl     al, cl
        mov     bx, ax
        shl     bl, cl
        or      al, bl
        shl     bl, cl
        or      al, bl 
        mov     byte ptr ds:[si+2], al
        pop     ax
        pop     bx
        
shrsamp:               
        push    cx
        xor     cx, cx
        mov     cl, 2
        mov     ah, byte ptr ds:[si]
        shr     ah, cl
        mov     byte ptr ds:[si], ah 
        mov     ah, byte ptr ds:[si+1]
        shr     ah, cl
        mov     byte ptr ds:[si+1], ah 
        mov     ah, byte ptr ds:[si+2]
        shr     ah, cl
        mov     byte ptr ds:[si+2], ah
        pop     cx   
        add     dx, 3
        cmp     bx, 0
        jz      skpfsh1   
        push    dx
        mov     ah, 42h
        mov     al, 1
        mov     cx, 0
        mov     dx, 1
        int     21h
        jc      mvptre1
        pop     dx 
        
skpfsh1:
        pop     cx
        dec     cx
        cmp     cx, 0
        jnz     rdpall
        jmp     setpal   
        
mvptre1:
        pop     dx
        jmp     rpalerr   
        
rpalerr:
        pop     cx 
        mov     ax, 0ffh
        ret
        
setpal:           
        mov     ax, seg palette
        mov     es, ax
        mov     dx, offset palette
        xor     bx, bx
        mov     cx, 256
        mov     ax, 01012h
        int     10h
        ret
        
gtrowc:   
        push    bx
        push    dx 
        xor     bx, bx
        xor     dx, dx 
        mov     ax, 200 
        mov     bl, byte ptr cs:[zoom]
        cmp     bl, 100
        jz      gtrowc2
        jb      gtrowc1
        sub     bl, 99
        dec     ax
        xor     dx, dx
        div     bx
        inc     ax
        jmp     gtrowc2 
        
gtrowc1:
        mov     dl, 101
        sub     dl, bl
        mov     bx, dx
        mul     bx
        
gtrowc2:
        mov     bx, word ptr cs:[bmph]
        sub     bx, word ptr cs:[ypos]
        cmp     ax, bx
        jna     gtrowc3
        mov     ax, bx 
        
gtrowc3:
        pop     dx
        pop     bx 
        ret
        
gtbtc:   
        push    bx
        push    cx
        push    dx 
        xor     bx, bx
        mov     ax, 320
        mov     bl, byte ptr cs:[zoom]
        cmp     bl, 100
        jz      gtbtc2
        jb      gtbtc1
        sub     bl, 99
        dec     ax
        xor     dx, dx
        div     bx 
        inc     ax
        jmp     gtbtc2 
        
gtbtc1:
        mov     dl, 101
        sub     dl, bl
        mov     bx, dx
        mul     bx 
        
gtbtc2: 
        xor     bx, bx        
        mov     bl, byte ptr cs:[btperpx]
        mul     bx 
        jnc     gtbtc4
        mov     cx, 0FFFFh 
        
gtbtc4:
        push    ax
        mov     ax, word ptr cs:[bmpw]
        sub     ax, word ptr cs:[xpos]
        mov     bl, byte ptr cs:[btperpx]
        mul     bx
        mov     bx, ax
        pop     ax
        cmp     cx, 0FFFFh
        jz      gtbtc5
        cmp     ax, bx
        jna     gtbtc3 
        
gtbtc5:        
        mov     ax, bx 
                       
gtbtc3:                       
        pop     dx
        pop     cx
        pop     bx 
        ret 
        
gtrepc:    
        push    bx
        mov     ax, 1
        xor     bx, bx
        mov     bl, byte ptr cs:[zoom]
        cmp     bl, 100
        jbe     gtrepc1 
        sub     bl, 100
        add     al, bl
        xor     ah, ah
        
gtrepc1: 
        pop     bx  
        ret
        
display:          
        mov     ax, 0a000h
        mov     es, ax
        mov     ch, byte ptr cs:[bmpbeg+3]
        mov     cl, byte ptr cs:[bmpbeg+2]
        mov     dh, byte ptr cs:[bmpbeg+1]
        mov     dl, byte ptr cs:[bmpbeg]
        mov     ah, 42h
        mov     al, 0  
        mov     bx, word ptr cs:[file]
        int     21h
        jc      invfor  
        mov     ax, seg frbuf                 
        mov     ds, ax
        call    gtrowc   
        mov     cx, ax 
        mov     ax, word ptr cs:[bmph]
        sub     ax, word ptr cs:[ypos]
        sub     ax, cx
        mov     bx, word ptr cs:[rowsize]
        mul     bx
        mov     cx, dx
        mov     dx, ax
        mov     ah, 42h
        mov     al, 1  
        mov     bx, word ptr cs:[file]
        int     21h
        jc      invfor 
        mov     cx, word ptr cs:[bmph]
        xor     ax, ax
        mov     al, byte ptr cs:[zoom]
        cmp     al, 100
        jz      fixzomn
        ja      fixzomi
        mov     bx, 101
        sub     bl, al
        call    gtrowc
        xor     dx, dx  
        div     bx
        mov     cx, ax
        jmp     skprnck
        
fixzomi:
        sub     al, 99
        mov     bx, ax 
        mov     ax, cx
        mul     bx
        mov     cx, ax 
        
fixzomn:   
        cmp     cx, 200
        jna     skprnck  
        mov     cx, 200
        jmp     skprnck
        
skprnck:   
        mov     bx, 199*320  
        
disrow:                 
        push    bx
        push    cx
        mov     ax, word ptr cs:[xpos]
        xor     bx, bx
        mov     bl, byte ptr cs:[btperpx]
        mul     bx
        xor     cx, cx
        mov     dx, ax
        push    dx 
        mov     bx, word ptr cs:[file]
        mov     ah, 42h
        mov     al, 1  
        int     21h
        jc      invfor
        pop     dx
        pop     cx
        push    cx              
        call    gtbtc                 
        mov     cx, ax
        push    cx
        mov     ax, seg frbuf                 
        mov     ds, ax
        push    dx                      
        mov     dx, offset frbuf   
        mov     ah, 3fh
        mov     al, 0               
        int     21h                       
        cmp     ax, cx
        jnz     invfor
        mov     word ptr cs:[actvbuf], cx
        pop     dx 
        pop     cx
        mov     ax, word ptr cs:[rowsize]
        sub     ax, cx
        sub     ax, dx 
        xor     cx, cx
        mov     dx, ax
        mov     ah, 42h
        mov     al, 1  
        int     21h
        jc      invfor  
        xor     ax, ax
        mov     al, byte ptr cs:[zoom]
        cmp     al, 100
        jnb     skpfsh2
        mov     bx, 100
        sub     bl, al
        mov     al, bl
        mov     bx, word ptr cs:[rowsize]
        mul     bx
        mov     cx, dx
        mov     dx, ax
        mov     ah, 42h
        mov     al, 1  
        mov     bx, word ptr cs:[file]
        int     21h
        jc      invfor         
        
skpfsh2:
        pop     cx
        pop     bx
        mov     di, offset frbuf
        push    cx
        xor     cx, cx 
        call    gtrepc
        mov     cl, al
        
drwfrwl:
        push    cx
        call    drawrow 
        pop     cx
        mov     di, offset frbuf
        sub     bx, 640
        jc      abrtdfr
        loop    drwfrwl
        
abrtdfr:
        pop     cx  
        call    gtrepc
        sub     cl, al
        jc      abrtdim
        cmp     cx, 0  
        jnz     disrow                               

abrtdim:
        add     bx, 320
        cmp     bx, 0
        jz      enddisp
        
clrscra:
        dec     bx
        cmp     bx, 0FFFFh
        jz      enddisp
        mov     byte ptr es:[bx], 0
        jmp     clrscra                  
        
enddisp:        
        xor     ax, ax                          ;odczytywanie klawisza
        int     16h                             ;z klawiatury
        
        cmp     ax, 0011Bh                      ;jezeli ESC
        jz      fclose                          ;=> zakoncz prace programu 
        
        cmp     ax, 04800h
        jz      mvimgu
        
        cmp     ax, 05000h
        jz      mvimgd    
         
        cmp     ax, 04b00h
        jz      mvimgl
        
        cmp     ax, 04d00h
        jz      mvimgr
        
        cmp     ax, 04e2bh
        jz      zominc
        
        cmp     ax, 04a2dh
        jz      zomdec
        
        jmp     display  
        
drawrow:    
        xor     ax, ax   
        ;xor     ax, ax                          ;odczytywanie klawisza
        ;int     16h                             ;z klawiatury
        mov     cx, 320
        push    dx
        mov     dx, bx
        add     dx, 320   
        
drwrwl: 
        push    di
        sub     di, offset frbuf
        cmp     di, word ptr cs:[actvbuf]
        jb      bufgood
        mov     ax, 0FFFFh
        
bufgood: 
        pop     di 
        cmp     ax, 0FFFFh
        jz      abrtdrw
        call    getclid   
        push    cx
        push    ax 
        xor     cx, cx 
        call    gtrepc
        mov     cl, al 
        pop     ax
        
drwfpxl:
        mov     byte ptr es:[bx], al
        inc     bx
        cmp     bx, dx
        jz      abrtdpx
        loop    drwfpxl
        
abrtdpx:   
        pop     cx
        cmp     bx, dx
        jz      abrtdrw
        push    bx
        xor     bx, bx
        mov     bl, byte ptr cs:[btperpx]
        add     di, bx
        xor     ax, ax
        mov     al, byte ptr cs:[zoom]
        cmp     al, 100
        jnb     skppxsh
        push    cx
        mov     cx, 100
        sub     cl, al
        
pxshl:
        add     di, bx
        loop    pxshl
        pop     cx
        
skppxsh:
        pop     bx
        loop    drwrwl
        
abrtdrw:  
        cmp     bx, dx
        jz      enddrw
        mov     byte ptr es:[bx], 0
        inc     bx
        jmp     abrtdrw 
        
enddrw:     
        pop     dx
        ret
        
getclid:        
        cmp     byte ptr cs:[btperpx], 1
        jz      gtclid1
        cmp     byte ptr cs:[btperpx], 3
        jz      gtclid2
        ret
        
gtclid1:              
        mov     al, byte ptr ds:[di] 
        ret
        
gtclid2:          
        xor     ax, ax
        push    bx
        push    cx
        mov     bl, byte ptr ds:[di+2]
        and     bl, 0E0h
        or      al, bl
        mov     bl, byte ptr ds:[di+1]
        and     bl, 0E0h 
        mov     cx, 3
        shr     bl, cl
        or      al, bl
        mov     bl, byte ptr ds:[di]
        and     bl, 0C0h
        mov     cx, 6
        shr     bl, cl
        or      al, bl
        pop     cx
        pop     bx
        ret        
        
mvimgu:  
        mov     ax, word ptr cs:[ypos]
        xor     cx, cx                   
        mov     bl, byte ptr cs:[ddpos]
        mov     cl, byte ptr cs:[dpos]
        cmp     bl, 1
        jz      mvimgu1
        xor     cx, cx
        mov     byte ptr cs:[ddpos], 1
        
mvimgu1:
        cmp     cx, 10
        jz      mvimgu2
        inc     cx
        mov     byte ptr cs:[dpos], cl     
        
mvimgu2:
        sub     ax, cx  
        jc      mvimgu3
        mov     word ptr cs:[ypos], ax
        jmp     display 
        
mvimgu3: 
        mov     word ptr cs:[ypos], 0
        jmp     display 
        
mvimgd:  
        mov     ax, word ptr cs:[ypos]
        xor     cx, cx                   
        mov     bl, byte ptr cs:[ddpos]
        mov     cl, byte ptr cs:[dpos]
        cmp     bl, 3
        jz      mvimgd1
        xor     cx, cx
        mov     byte ptr cs:[ddpos], 3
        
mvimgd1:
        cmp     cx, 10
        jz      mvimgd2
        inc     cx
        mov     byte ptr cs:[dpos], cl     
        
mvimgd2:
        add     ax, cx  
        push    ax
        mov     bx, word ptr cs:[bmph]
        call    gtrowc
        mov     cx, ax
        pop     ax
        sub     bx, cx
        cmp     ax, bx
        ja      mvimgd3
        mov     word ptr cs:[ypos], ax
        jmp     display
        
mvimgd3:  
        mov     word ptr cs:[ypos], bx
        jmp     display
        
mvimgl:  
        mov     ax, word ptr cs:[xpos]
        xor     cx, cx                   
        mov     bl, byte ptr cs:[ddpos]
        mov     cl, byte ptr cs:[dpos]
        cmp     bl, 4
        jz      mvimgl1
        xor     cx, cx
        mov     byte ptr cs:[ddpos], 4
        
mvimgl1:
        cmp     cx, 10
        jz      mvimgl2
        inc     cx
        mov     byte ptr cs:[dpos], cl     
        
mvimgl2:
        sub     ax, cx
        jc      mvimgl3
        mov     word ptr cs:[xpos], ax
        jmp     display 
        
mvimgl3: 
        mov     word ptr cs:[xpos], 0
        jmp     display    
        
mvimgr:  
        mov     ax, word ptr cs:[xpos]
        xor     cx, cx                   
        mov     bl, byte ptr cs:[ddpos]
        mov     cl, byte ptr cs:[dpos]
        cmp     bl, 2
        jz      mvimgr1
        xor     cx, cx
        mov     byte ptr cs:[ddpos], 2
        
mvimgr1:
        cmp     cx, 10
        jz      mvimgr2
        inc     cx
        mov     byte ptr cs:[dpos], cl     
        
mvimgr2:
        add     ax, cx 
        push    ax
        call    gtbtc
        xor     dx, dx
        xor     bx, bx
        mov     bl, byte ptr cs:[btperpx]
        div     bx
        mov     cx, ax
        pop     ax
        mov     bx, word ptr cs:[bmpw]
        sub     bx, cx
        cmp     ax, bx
        ja      mvimgr3
        mov     word ptr cs:[xpos], ax
        jmp     display 
        
mvimgr3:  
        mov     word ptr cs:[xpos], bx
        jmp     display
        
zominc:
        mov     al, byte ptr cs:[zoom]
        cmp     al, 199
        jz      display
        inc     al
        mov     byte ptr cs:[zoom], al
        jmp     display  
        
zomdec:
        mov     al, byte ptr cs:[zoom]
        cmp     al, 1
        jz      display
        dec     al     
        mov     byte ptr cs:[zoom], al  
        mov     bx, word ptr cs:[bmph]
        mov     dx, word ptr cs:[ypos]
        mov     word ptr cs:[ypos], 0
        call    gtrowc
        mov     word ptr cs:[ypos], dx
        sub     bx, ax
        mov     ax, word ptr cs:[ypos]
        cmp     ax, bx
        jna     zomdec1 
        mov     word ptr cs:[ypos], bx
        
zomdec1: 
        mov     dx, word ptr cs:[xpos]
        mov     word ptr cs:[xpos], 0
        call    gtbtc               
        mov     word ptr cs:[xpos], dx
        xor     bx, bx
        xor     dx, dx
        mov     bl, byte ptr cs:[btperpx]
        div     bx
        mov     bx, word ptr cs:[bmpw]
        sub     bx, ax  
        mov     ax, word ptr cs:[xpos] 
        cmp     ax, bx
        jna     zomdec2
         
        mov     word ptr cs:[xpos], bx
        
zomdec2:
        jmp     display                       
        
invfor: 
        mov	    al, 3                           ;tryb tekstowy 80 x 24 znakow
	    mov	    ah, 0                           ;zmiana trybu
	    int	    10h                             ;                     
	    
        mov     ax, seg err2                    ;wypisywanie powiadomienia
        mov     ds, ax                          ;o blednym formacie
        mov     dx, offset err2                 ;
        mov     ah, 9                           ;
        int     21h                             ;
        jmp     fclose                          ;
        
        
        
fclose:
        mov     bx, word ptr cs:[file]          ;zamykanie pliku
        mov     ah, 03eh                        ;
        int     21h                             ;
        jmp     exit                                 
	    
foerr:                  
        mov	    al, 3                           ;tryb tekstowy 80 x 24 znakow
	    mov	    ah, 0                           ;zmiana trybu
	    int	    10h                             ; 
	    
        mov     ax, seg err1                    ;wypisywanie powiadomienia
        mov     ds, ax                          ;o bledzie podczas otw pliku
        mov     dx, offset err1                 ;
        mov     ah, 9                           ;
        int     21h                             ;
        jmp     exit                            ;
         

exit:        
        mov     ax, 04c00h                      ;polecenie powrotu do systemu
        int     21h                             ;wykonaj

btperpx db      0
rowsize dw      0

xpos    dw      0
ypos    dw      0
dpos    db      0
ddpos   db      0

zoom    db      100

fpath   db      16 dup(0)     
;fpath   db      "blis.bmp", 0
file    dw      0 
mgcnum  db      2 dup(?)
fsize   db      4 dup(?)
rsrv1   db      4 dup(?)
bmpbeg  db      4 dup(?)

ehsize  db      4 dup(?)
bmpw    db      4 dup(?)
bmph    db      4 dup(?)
cplnum  db      2 dup(?)
bperpx  db      2 dup(?)
cmprmt  db      4 dup(?)
imgsize db      4 dup(?)
himgres db      4 dup(?)
vimgres db      4 dup(?)
palsize db      4 dup(?)
actcol  db      4 dup(?)

palette db      768 dup (?)
actvbuf dw      0         
frbuf   db      16000 dup(?)

code1   ends      

stack1  segment STACK
        dw      200 dup(?)
top1    dw      ?
stack1  ends   

end start   