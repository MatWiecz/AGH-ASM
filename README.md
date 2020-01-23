# AGH-ASM
Source code from laboratories of assembler course.

## For pass this course, I had to prepare two miniprojects in the Assembly language (MASM dialect):

1. Simple verbal calculator.

    A calculator should provide three operations on integers: addition, substraction and multiplication;
    and range of input operands = [0, 9].

1. Simple Windows Bitmap viewer.

    A viever should provide ability to load 24-bit and 256-color bitmaps, with small resolution.
    You should use arrow keys to move over whole bitmap and + and - keys to zoom the view.

## My completion of these tasks.

1. Simple verbal calculator.

    I write code of calculator program which features are:
    * three operations on integers number (basic assumption)
    * range of input operands = [-120, 120]
    * real-time parser with syntax inspection
    * ability to enter complex expressions

    After run of the application, in two rows are displaying: user input and output result of entered expression (via Arabic numbers). If entered expression is markered with green color then this part of expression is currently included to final result. If some expression is markered with red color then this part of expression has errors and is excluded from final result.

    Calculator know only Polish and only expression entered in Polish can be parsered.

    Some example expressions:
    
    ![1.png](./doc/1.png)
    
    <i>Right long numbers parsing.</i>
    
    ![2.png](./doc/2.png)
    
    ![3.png](./doc/3.png)
    
    <i>Right simple expression parsing.</i>
    
    ![4.png](./doc/4.png)
    
    ![5.png](./doc/5.png)
    
    <i>Some errors in expression (not typed correctly or an operation not defined).</i>
    
    ![6.png](./doc/6.png)
    
    ![7.png](./doc/7.png)
    
    ![8.png](./doc/8.png)
    
    <i>Right complex expression parsing.</i>

1. Simple Windows Bitmap viewer.

    I write code of bitmap viewer program which features are:
    * handling 24-bit and 256-color bitmap formats (basic assumption)
    * ability to move of the view over whole bitmap (basic assumption)
    * ability to zoom in and zoom out the view (basic assumption)
    * fast loading of files (only needed data in particular time)
    * low memory usage

    After run of the application, an user will be asked for name of file to load. After enter of filename, the program will try open an image. If program will load image successfully, the user will be able to view the image via 320x200 VGA mode.

    Some screenshots from program executing:
    
    ![9.png](./doc/9.png)
    
    ![10.png](./doc/10.png)
    
    ![11.png](./doc/11.png)
    
    ![12.png](./doc/12.png)
    
    <i>Viewing small 24-bit image.</i>
    
    ![13.png](./doc/13.png)
    
    ![14.png](./doc/14.png)
    
    <i>Viewing small 256-color image.</i>
    
    ![15.png](./doc/15.png)
    
    ![16.png](./doc/16.png)
    
    ![17.png](./doc/17.png)
    
    ![18.png](./doc/18.png)
    
    ![19.png](./doc/19.png)
    
    ![20.png](./doc/20.png)
    
    <i>Viewing large 24-bit image.</i>

