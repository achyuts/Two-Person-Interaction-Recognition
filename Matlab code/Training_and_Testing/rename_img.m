% Utility to rename some images

for i=2000:3279
    fname1=sprintf('%d.jpeg',i);
    fname2=sprintf('%d.jpeg',i-1999);

    img=imread(fname1);

    imwrite(img,fname2,'jpeg');
end