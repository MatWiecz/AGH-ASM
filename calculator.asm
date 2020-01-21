data1   segment

labels  db      "Kalkulator slowny", 10, 13     ;stringi sluzace do komunikacji
        db      "Wyrazenie: ", 10, 13           ;z uzytkownikiem
        db      "Wynik:     ", 10, 13, '$'      ;

e0      dw      v0, s0, a0                      ;definicje kolejnych wyrazen
e1      dw      v1, s1, a1                      ;vi - wyrazenie po zewaluowaniu
e2      dw      v2, s2, a2                      ;si - reprezentujacy string
e3      dw      v3, s3, a3                      ;ai - mozliwe wyrazenie po tym
e4      dw      v4, s4, a4                      ;
e5      dw      v5, s5, a5                      ;
e6      dw      v6, s6, a6                      ;
e7      dw      v7, s7, a7                      ;
e8      dw      v8, s8, a8                      ;
e9      dw      v9, s9, a9                      ;
e10     dw      v10, s10, a10                   ;
e11     dw      v11, s11, a11                   ;
e12     dw      v12, s12, a12                   ;
e13     dw      v13, s13, a13                   ;
e14     dw      v14, s14, a14                   ;
e15     dw      v15, s15, a15                   ;
e16     dw      v16, s16, a16                   ;
e17     dw      v17, s17, a17                   ;
e18     dw      v18, s18, a18                   ;
e19     dw      v19, s19, a19                   ;
e20     dw      v20, s20, a20                   ;
e21     dw      v21, s21, a21                   ;
e22     dw      v22, s22, a22                   ;
e23     dw      v23, s23, a23                   ;
e24     dw      v24, s24, a24                   ;
e25     dw      v25, s25, a25                   ;
e26     dw      v26, s26, a26                   ;
e27     dw      v27, s27, a27                   ;
e28     dw      v28, s28, a28                   ;
e29     dw      v29, s29, a29                   ;

v0      db      130, 0, 128                     ;wyrazenia po ewaluacji
v1      db      130, 1, 128                     ;stringow
v2      db      130, 2, 128                     ;0 - 127 => liczby dodatnie
v3      db      130, 3, 128                     ;133 - 255 => liczby ujemne
v4      db      130, 4, 128                     ;128 => koniec def wyrazenia
v5      db      130, 5, 128                     ;129 => grupator wyrazen
v6      db      130, 6, 128                     ;130 => operacja dodawania
v7      db      130, 7, 128                     ;131 => operacja odejmowania
v8      db      130, 8, 128                     ;132 => operacja mnozenia
v9      db      130, 9, 128                     ;
v10     db      130, 10, 128                    ;
v11     db      130, 1, 128                     ;
v12     db      130, 4, 128                     ;
v13     db      130, 5, 128                     ;
v14     db      130, 6, 128                     ;
v15     db      130, 9, 128                     ;
v16     db      130, 10, 128                    ;
v17     db      132, 10, 128                    ;
v18     db      132, 10, 128                    ;
v19     db      130, 100, 128                   ;
v20     db      130, 128                        ;
v21     db      130, 128                        ;
v22     db      131, 128                        ;
v23     db      131, 128                        ;
v24     db      132, 128                        ;
v25     db      129, 128                        ;
v26     db      129, 128                        ;
v27     db      129, 128                        ;
v28     db      132, 10, 128                    ;
v29     db      130, 10, 128                    ;
        
a0      dw      e25, e26, 0                     ;dla kazdego stringu
a1      dw      e25, e26, e29, 0                ;lista wszystkich wyrazen,
a2      dw      e25, e26, e16, e17, 0           ;jakie moga wystapic
a3      dw      e25, e26, e16, e18, 0           ;po danym wyrazeniu
a4      dw      e25, e26, 0                     ;
a5      dw      e25, e26, e28, 0                ;
a6      dw      e25, e26, e28, 0                ;
a7      dw      e25, e26, e16, e28, 0           ;
a8      dw      e25, e26, e16, e28, 0           ;
a9      dw      e25, e26, e28, 0                ;
a10     dw      e25, e26, 0                     ;
a11     dw      e16, 0                          ;
a12     dw      e16, e18, 0                     ;
a13     dw      e16, 0                          ;
a14     dw      e16, 0                          ;
a15     dw      e16, 0                          ;
a16     dw      e25, e26, 0                     ;
a17     dw      e25, e26, 0                     ;
a18     dw      e25, e26, 0                     ;
a19     dw      e25, e26, 0                     ;
a20     dw      e25, e26, 0                     ;
a21     dw      e25, e26, 0                     ;
a22     dw      e25, e26, 0                     ;
a23     dw      e25, e26, 0                     ;
a24     dw      e25, e26, 0                     ;
a25     dw      e25, e26                        ;
        dw      e0, e1, e2, e3, e4, e5, e6, e7  ;
        dw      e8, e9, e10, e11, e12, e13, e14 ;
        dw      e15, e19, e20, e21, e22, e23    ;
        dw      e24, 0                          ;
a26     dw      e25, e26                        ;
        dw      e0, e1, e2, e3, e4, e5, e6, e7  ;
        dw      e8, e9, e10, e11, e12, e13, e14 ;
        dw      e15, e19, e20, e21, e22, e23    ;
        dw      e24, 0                          ;
a27     dw      e25, e26                        ;
        dw      e0, e1, e2, e3, e4, e5, e6, e7  ;
        dw      e8, e9, e10, e11, e12, e13, e14 ;
        dw      e15, e19, e22, 0                ;
a28     dw      e25, e26, 0                     ;
a29     dw      e25, e26, 0                     ;
        
s0      db      "zero$"                         ;kolejne stringi reprezentujace
s1      db      "jeden$"                        ;dostepne cyfry, liczby,
s2      db      "dwa$"                          ;przedrostki, przyrostki    
s3      db      "trzy$"                         ;dzialania arytmetyczne
s4      db      "cztery$"                       ;i inne znaki
s5      db      "piec$"                         ;(ogolnie wyrazenia)
s6      db      "szesc$"                        ;
s7      db      "siedem$"                       ;
s8      db      "osiem$"                        ;
s9      db      "dziewiec$"                     ;
s10     db      "dziesiec$"                     ;
s11     db      "jede$"                         ;
s12     db      "czter$"                        ;
s13     db      "piet$"                         ;
s14     db      "szes$"                         ;
s15     db      "dziewiet$"                     ;
s16     db      "nascie$"                       ;
s17     db      "dziescia$"                     ;
s18     db      "dziesci$"                      ;
s19     db      "sto$"                          ;
s20     db      "plus$"                         ;
s21     db      "dodac$"                        ;
s22     db      "minus$"                        ;
s23     db      "odjac$"                        ;
s24     db      "razy$"                         ;
s25     db      " $"                            ;
s26     db      9, '$'                          ;
s27     db      ">$"                            ;
s28     db      "dziesiat$"                     ;
s29     db      "ascie$"                        ;
                                                                           
 
data1   ends

code1   segment
    
start:  mov     ax, seg top1                    ;inicjalizacja stosu
        mov     ss, ax                          ;
        mov     sp, offset top1                 ;
        
        mov	    al, 3                           ;tryb tekstowy 80 x 24 znakow
	    mov	    ah, 0                           ;zmiana trybu
	    int	    10h                             ;
	    
	    mov	    ax, 0b800h                      ;ustawianie adresu bufora  
	    mov	    es, ax                          ;tekstowego 
        
        mov     ax, seg labels                  ;wypisywanie tekstu powitalnego
        mov     ds, ax                          ;
        mov     dx, offset labels               ;
        mov     ah, 9                           ;
        int     21h                             ;
        
        mov     ax, seg input                   ;zerowanie licznika znakow
        mov     ds, ax                          ;wejscia
        mov     si, offset input                ;
        mov     byte ptr ds:[si], 0             ;
        
        mov     ax, seg eval                    ;wstawienie wyrazenia '>'
        mov     ds, ax                          ;inicjujacego skladnie
        mov     si, offset eval                 ;kalkulatora
        mov     ax, offset e27
        mov     word ptr ds:[si], ax            ;
         

read:   
        mov     ax, seg input                   ;ladowanie ilosci znakow*2+2
        mov     ds, ax                          ;
        mov     di, offset input                ;
        xor     cx, cx                          ;
        mov     cl, byte ptr ds:[di]            ;
        add     cx, cx
        add     cx, 2
        mov     ax, seg eval
        mov     es, ax
        mov     si, offset eval
        mov     ax, seg labels
        mov     ds, ax
        xor     bx, bx
        xor     dx, dx

evexpr: 
        cmp     bx, cx
        jz      eevexpr
        mov     ax, word ptr es:[si+bx]
        add     bx, 2
        cmp     ax, 0
        jz      evexpr
        push    bx
        push    es
        push    si
        mov     di, ax                
        mov     ax, seg expr
        mov     es, ax
        mov     si, offset expr
        mov     ax, word ptr ds:[di]
        mov     di, ax
        mov     bx, dx

wrexpr: 
        push    bx
        sub     bx, dx
        mov     al, byte ptr ds:[di+bx]
        pop     bx
        cmp     al, 128
        jz      ewrexpr
        mov     byte ptr es:[si+bx], al
        inc     bx
        jmp     wrexpr

ewrexpr:
        mov     dx, bx        
        pop     si
        pop     es
        pop     bx
        jmp     evexpr
        
eevexpr:
        mov     ax, seg expr
        mov     es, ax
        mov     si, offset expr
        mov     bx, dx
        cmp     bx, 64
        jz      trans1
        mov     byte ptr es:[si+bx], 128  
        
trans1:   
        mov     ax, 0             
        mov     bx, 0
        mov     cx, 0
        mov     dx, 0
        
trans1l:             
        cmp     bx, 64
        jz      trans2
        mov     al, byte ptr es:[si+bx]
        inc     bx
        cmp     al, 128
        jz      trans2
        cmp     al, -123       ;
        jge     trans1a                         ;liczba
        cmp     al, 130        ;
        jz      trans1b                         ;dodawanie
        cmp     al, 132
        jz      trans1b                         ;mnozenie
        jmp     trans1c        ;                ;restartowanie licznika
        
trans1a:                                        ;liczba
        mov     dh, dl         ;
        mov     dl, al
        mov     ch, cl         ;
        mov     cl, bl
        cmp     ah, 0
        jz      trans1l        ;                ;nic nie rob
        mov     al, dh
        cmp     ah, 130        ;
        jz      trans1d        ;                ;dodwawanie
        cmp     ah, 132        ;
        jz      trans1e        ;                ;mnozenie
        mov     ah, 0
        jmp     trans1l                         ;nic nie rob
        
trans1d:
        add     al, dl                          ;dodaj dh+dl
        jmp     trans1f        ;
        
trans1e:
        mul     dl                              ;pomnoz dh*dh->ax
        jmp     trans1f         ;
        
trans1b:
        cmp     cl, 0
        jz      trans1l                         ;nic nie rob, nie bylo liczby
        mov     ah, al                          ;zapisanie operatora
        jmp     trans1l

trans1c:
        xor     ah, ah          ; 
        xor     cx, cx
        jmp     trans1l        ;
        
trans1f:
        push    bx
        mov     bl, ch
        dec     bl
        mov     byte ptr es:[si+bx], al
        mov     byte ptr es:[si+bx+1], 129
        mov     byte ptr es:[si+bx+2], 129
        pop     bx
        jmp     trans1l
        
trans2:  
        mov     ax, 0             
        mov     bx, 0
        mov     cx, 0
        mov     dx, 0
        
trans2l:         
        cmp     bx, 64
        jz      trans3
        mov     al, byte ptr es:[si+bx]
        inc     bx
        cmp     al, 128
        jz      trans3
        cmp     al, -123       ;
        jge     trans2a                         ;liczba
        cmp     al, 130
        jz      trans2c        ;                ;restartowanie licznika 
        cmp     al, 131
        jz      trans2c        ;                ;restartowanie licznika   
        cmp     al, 132
        jz      trans2c        ;                ;restartowanie licznika
        jmp     trans2l
        
trans2a:                                        ;liczba
        mov     dh, dl         ;
        mov     dl, al                ;;;;;;;;;;;;;;;;
        mov     ch, cl         ;
        mov     cl, bl
        cmp     ch, 0
        jz      trans2l        ;                ;nic nie rob
        mov     al, dh
        add     al, dl 
        push    bx
        mov     bl, ch
        dec     bl
        mov     byte ptr es:[si+bx], al
        
trans2b:
        inc     bx
        cmp     bl, cl
        jz      trans2d 
        mov     byte ptr es:[si+bx], 129        
        jmp     trans2b
        
trans2d:         
        pop     bx    
        mov     cl, ch
        jmp     trans2l                         ;nic nie rob

trans2c:
        mov     ah, byte ptr es:[si+bx-2]
        cmp     ah, 129
        jnz     trans2l
        mov     ah, byte ptr es:[si+bx]
        cmp     ah, 129
        jnz     trans2l
        xor     dx, dx          ; 
        xor     cx, cx
        jmp     trans2l        ;    ;;;;
        
trans3:  
        mov     ax, 0             
        mov     bx, 0
        mov     cx, 0
        mov     dx, 0
        
trans3l:         
        cmp     bx, 64
        jz      trans4
        mov     al, byte ptr es:[si+bx]
        inc     bx
        cmp     al, 128
        jz      trans4
        cmp     al, -123       ;
        jge     trans3a                         ;liczba
        cmp     al, 130
        jz      trans3c        ;                ;znak '+'
        jmp     trans3b                         ;restartowanie licznika
        
trans3a:                                        ;liczba
        cmp     cl, 0
        jz      trans3l                         ;nic nie ma do usuniecia
        push    bx
        mov     bl, cl
        dec     bl
        mov     byte ptr es:[si+bx], 129
        pop     bx
        jmp     trans3l
        
trans3b:
        xor     cl, cl           
        jmp     trans3l

trans3c:
        mov     cl, bl
        jmp     trans3l     
        
trans4:  
        mov     ax, 0             
        mov     bx, 0
        mov     cx, 0
        mov     dx, 0
        
trans4l:         
        cmp     bx, 64
        jz      read2
        mov     al, byte ptr es:[si+bx]
        inc     bx
        cmp     al, 128
        jz      read2
        cmp     al, -123       ;
        jge     trans2a                         ;liczba
        cmp     al, 132
        jz      trans2c        ;                ;znaleziono operator mnozenia 
        jmp     trans2l
        
trans4a:                                        ;liczba
        mov     dh, dl         ;
        mov     dl, al                ;;;;;;;;;;;;;;;;
        mov     ch, cl         ;
        mov     cl, bl
        cmp     ch, 0
        jz      trans2l        ;                ;nic nie rob
        mov     al, dh
        add     al, dl 
        push    bx
        mov     bl, ch
        dec     bl
        mov     byte ptr es:[si+bx], al
        
trans4b:
        inc     bx
        cmp     bl, cl
        jz      trans2d 
        mov     byte ptr es:[si+bx], 129        
        jmp     trans2b
        
trans4d:         
        pop     bx    
        mov     cl, ch
        jmp     trans2l                         ;nic nie rob

trans4c:
        mov     ah, byte ptr es:[si+bx-2]
        cmp     ah, 129
        jnz     trans2l
        mov     ah, byte ptr es:[si+bx]
        cmp     ah, 129
        jnz     trans2l
        xor     dx, dx          ; 
        xor     cx, cx
        jmp     trans2l        ;    ;;;;            
                
read2:                                                
	    mov	    ax, 0b800h                      ;ustawianie adresu bufora  
	    mov	    es, ax                          ;tekstowego
             
        xor     ax, ax                          ;odczytywanie klawisza
        int     16h                             ;z klawiatury
        
        cmp     ax, 0011Bh                      ;jezeli ESC
        jz      exit                            ;=> zakoncz prace programu
        
        mov     bx, seg input                   ;ladowanie ilosci znakow
        mov     ds, bx                          ;
        xor     bx, bx                          ;
        mov     si, offset input                ;
        mov     bl, byte ptr ds:[si]            ;
        
        cmp     ax, 05300h                      ;jezeli nie DEL
        jnz     notdel                          ;=> przeskocz to etykiety
        cmp     bl, 0                           ;jezeli DEL i ilosc znakow = 0
        jz      read                            ;oczekuj na nastepny znak
        mov     cx, bx 
        
        
rundel:
        push    bx                              ;zachowaj liczbe znakow
        add     bx, bx                          ;ustaw pozycje wygasniecia
        add     bx, 180                         ;przesun w buforze tekstowym
        mov     byte ptr es:[bx], ' '           ;wygas znak z ekranu
        pop     bx                              ;odzyskaj ilosc znakow
        dec     bx                              ;dekrementuj ilosc znakow
        cmp     bx, 0                           ;jezeli ilosc znakow != 0
        jnz     rundel                          ;kontynuuj czyszczenie stringa
        mov     byte ptr ds:[si], 0             ;zapisz ilosc znakow = 0
        mov     ax, seg eval
        mov     ds, ax
        mov     si, offset eval                 
        mov     bx, cx
        add     bx, bx
        
clreval:
        mov     word ptr ds:[si+bx], 0
        sub     bx, 2
        loop    clreval
        jmp     read                            ;oczekuj na nastepny klawisz
        
        
notdel:
        cmp     ax, 00E08h                      ;jezeli nie znak backspace
        jnz     notback                         ;=>przejdz do zapisz znak w buf
        cmp     bl, 0                           ;jezeli znak back sprawdz ilosc
        jz      read                            ;jezeli 0 => nic nie rob
        push    bx                              ;zachowaj liczbe znakow
        add     bx, bx                          ;ustaw pozycje wygasniecia
        add     bx, 180                         ;przesun w buforze tekstowym
        mov     byte ptr es:[bx], ' '           ;wygas znak z ekranu
        pop     bx                              ;odzyskaj ilosc znakow
        push    ds
        push    si
        mov     ax, seg eval
        mov     ds, ax
        mov     si, offset eval
        push    bx
        add     bx, bx
        mov     ax, word ptr ds:[si+bx]
        cmp     ax, 0
        jnz     frcclr
        mov     ax, word ptr ds:[si+bx-2]
        cmp     ax, 0
        jz      prvgood

frcclr:  
        mov     word ptr ds:[si+bx], 0
        mov     dx, 1
        sub     bx, 2

mkred:
        mov     ax, word ptr ds:[si+bx]
        cmp     ax, 0
        jnz     emkred
        push    bx
        add     bx, 180
        mov     byte ptr es:[bx+1], 00Ch
        pop     bx
        sub     bx, 2
        inc     dx
        jmp     mkred
        
emkred: 
        cmp     ax, offset e27
        jz      prvgood
        cmp     dx, 1
        jnz     prvgood
        push    ds
        push    si
        mov     dx, seg labels
        mov     ds, dx
        mov     si, ax
        mov     ax, word ptr ds:[si+4]
        mov     si, ax
        mov     ax, word ptr ds:[si]
        cmp     ax, offset e25
        jnz     prvbad
        mov     ax, word ptr ds:[si+2]
        cmp     ax, offset e26
        jnz     prvbad
        pop     si
        pop     ds
        jmp     prvgood

prvbad: 
        pop     si
        pop     ds
        mov     word ptr ds:[si+bx], 0
        jmp     mkred 

prvgood:
        pop     bx
        pop     si
        pop     ds
        dec     bx                              ;=> dekrementuj ilosc znakow                          
        mov     byte ptr ds:[si], bl            ;zapisz ilosc znakow
        jmp     read                            ;odczytaj na nastepny znak
        
notback:        
        cmp     bl, 63                          ;jezeli bufor pelny
        jz      read                            ;=> czekaj dalej na backspace
        
        inc     bl                              ;aktulizuj ilosc znakow
        mov     byte ptr ds:[si+bx], al         ;zapisz odczytany znak do buf
        mov     byte ptr ds:[si], bl            ;zapisz ilosc znakow
        add     bx, bx                          ;ustaw pozycje wyswietlenia
        add     bx, 180                         ;przesun w buforze tekstowym
        mov     byte ptr es:[bx], al            ;wyswietl nowy znak na ekranie
        mov     byte ptr es:[bx+1], 00Ch        ;pokoloruj znak na czerwono
        
        xor     bx, bx                          ;
        mov     ax, seg input
        mov     es, ax
        mov     si, offset input
        mov     bl, byte ptr es:[si]
        mov     ax, seg eval
        mov     ds, ax
        mov     di, offset eval
        mov     dx, bx
        add     bx, bx
        
gevpos:
        mov     ax, word ptr ds:[di+bx]
        cmp     ax, 0
        jnz     egevpos
        sub     bx, 2
        dec     dx
        jmp     gevpos
        
egevpos:
        inc     dx        
        mov     cx, dx                          ;
        
        mov     dx, ax                          ;
        
        mov     ax, seg labels                  ;ustawienie pozycji na poczatek
        mov     ds, ax                          ;segmentu stalych
        mov     si, dx                          ;wskazanie na ost zewal wyraz
        push    si                              ;!push ost zewal wyrazenie
        mov     dx, word ptr ds:[si+4]          ;odczyt adr wska na pocz dost w

ckexpr:                                         
        mov     si, dx                          ;ustaw pozycje w liscie do spr
        mov     ax, word ptr ds:[si]            ;zaladuj nastepne wyr do spr
        cmp     ax, 0                           ;sprawdz czy to nie koniec list
        jz      eckexpr                         ;P => zakoncz porownywanie
        push    si                              ;!push pozycja aktualn przetw
        mov     dx, word ptr ds:[si]            ;przeskok do odpowied wyrazenia
        mov     si, dx                          ;
        push    si                              ;!push adr przetwarz wyrazenia
        mov     dx, word ptr ds:[si+2]          ;adr na poczatek przetwarz str
        mov     si, dx                          ;
        mov     bx, 0                           ;rozpoczecie porownywania wyraz
        push    si
        mov     si, offset input
        mov     dl, byte ptr es:[si]
        sub     dl, cl
        inc     dl
        pop     si

cmpgo:        
        push    si                              ;!push pozycja porown znaku
        mov     ah, byte ptr ds:[si+bx]         ;zaladuj nast znak z slownika
        cmp     ah, '$'                         ;sprawdz czy nie koniec stringa
        jz      cmpok                           ;P => porown zak powodzeniem
        cmp     bl, dl
        jz      cmpabrt
        mov     si, offset input                ;zaladuj przesuniecie inputa
        add     si, cx                          ;zaladuj pozycje pierw znaku
        mov     al, byte ptr es:[si+bx]         ;zaladuj nast znak z inputu
        cmp     al, ah                          ;sprawdz czy sa rowne
        jnz     cmpabrt                         ;F => porown zak niepowodzeniem
        inc     bx                              ;przejdz do nastepnego znaku
        pop     si                              ;!pop pozycje znaku w slown
        jmp     cmpgo                           ;kontynuuj porownywanie
        
cmpabrt:                                       
        pop     si                              ;!pop pozycja porown znaku
        pop     si                              ;!pop adr przetwarz wyrazenia
        pop     dx                              ;!pop pozycja aktualn przetw
        add     dx, 2                           ;przejdz do nast wyraz do spr
        jmp     ckexpr                          ;sprawdz nast wyrazenie 
        
nsingl:                                       
        pop     si                              ;!pop adr przetwarz wyrazenia
        pop     dx                              ;!pop pozycja aktualn przetw
        add     dx, 2                           ;przejdz do nast wyraz do spr
        jmp     ckexpr
        
cmpok:                    
        pop     si                              ;!pop pozycja porown znaku
        pop     si                              ;!pop adr przetwarz wyrazenia
        mov     al, dl
        sub     al, bl
        cmp     al, 0
        jnz     wouteck
        mov     ax, word ptr ds:[si+4]          
        push    si
        mov     si, ax
        mov     ax, word ptr ds:[si]
        cmp     ax, offset e25
        jnz     nsingl
        mov     ax, word ptr ds:[si+2]
        cmp     ax, offset e26
        jnz     nsingl
        pop     si  
        
wouteck:
        mov     ax, seg eval
        mov     ds, ax
        mov     dx, si
        mov     si, offset eval
	    mov	    ax, 0b800h                      ;ustawianie adresu bufora  
	    mov	    es, ax                          ;tekstowego
        xor     ax, ax
        mov     al, cl
        push    ax
        add     bl, al
        dec     bl
        add     bl, bl                 
        mov     word ptr ds:[si+bx], dx            
        mov     ax, bx
        add     ax, 182
        pop     bx
        add     bx, bx
        add     bx, 180
        
mkgrn:  
        cmp     ax, bx
        jz      emkgrn
        mov     byte ptr es:[bx+1], 00Ah
        add     bx, 2
        jmp     mkgrn

emkgrn:
        pop     si                              ;!pop pozycja aktualn przetw
        jmp     eckexpr

eckexpr:
        pop     si                              ;!push ost zewal wyrazenie
        jmp     read
         
        

exit:        
        mov     ax, 04c00h                      ;polecenie powrotu do systemu
        int     21h                             ;wykonaj

input   db      64 dup(0)
output  db      64 dup(0)
expr    db      64 dup(128)
eval    dw      64 dup(0)

code1   ends       

stack1  segment STACK
        dw      200 dup(?)
top1    dw      ?
stack1  ends

end start