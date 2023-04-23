    Project made to learn shell, it converts a high contrast, black and white, square image into an aproximation in "ASCII" caracthers.
    Right now it works by dividing the image into squares and determining if the majority of the sqaure is black or white and printing a character accordingly. It could be worked upon by determining wich character to print accordinging to the shape of the black parts in the square and by fixing the number of characters printed depending of the size of the image.


    ---------------------------Instructions--------------------------------

                           ImgToText.sh                           
                           
    install Imagick -> https://imagemagick.org/index.php
    give permission to sh ->"chmod 775 ImgToText.sh"
    run -> "./ImgToText.sh [path/to/image] [color]"

    -----------------------------------------------------------------------

    Available colors:
    - white
    - black
    - red
    - green
    - yellow
    - blue
    - purple
