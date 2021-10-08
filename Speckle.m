clc
clear all;
close all;

A=imread('lena.tif');
A1=double(A);
noisyimage = imnoise(A, 'speckle', .03);
subplot(1,3,1);
imshow(A);
title('Original image');
subplot(1,3,2);
imshow(noisyimage);
title('Noisy image');
Image1=double(noisyimage);
[m,n]=size(Image1);
B=Image1;
 for i=2:m-1
         for j=2:n-1
                    zb1=sqrt(1-(((Image1(i-1,j-1)-Image1(i,j))/255)^2));
                    zb2=sqrt(1-(((Image1(i-1,j)-Image1(i,j))/255)^2));
                    zb3=sqrt(1-(((Image1(i-1,j+1)-Image1(i,j))/255)^2));
                    zb4=sqrt(1-(((Image1(i,j+1)-Image1(i,j))/255)^2));
                    zb5=sqrt(1-(((Image1(i+1,j+1)-Image1(i,j))/255)^2));
                    zb6=sqrt(1-(((Image1(i+1,j)-Image1(i,j))/255)^2));
                    zb7=sqrt(1-(((Image1(i+1,j-1)-Image1(i,j))/255)^2));
                    zb8=sqrt(1-(((Image1(i,j-1)-Image1(i,j))/255)^2));
                
                c=(zb1*Image1(i-1,j-1)+zb2*Image1(i-1,j)+zb3*Image1(i-1,j+1)+zb4*Image1(i,j+1)+zb5*Image1(i+1,j+1)+zb6*Image1(i+1,j)+zb7*Image1(i+1,j-1)+zb8*Image1(i,j-1))/(zb1+zb2+zb3+zb4+zb5+zb6+zb7+zb8);  
                B(i,j)=c; 
         end
 end

 B1=round(B);
 subplot(1,3,3);
 imshow(B1,[]);
 title('Filtered image');
 
A1(1,:)=[];
A1(1,:)=[];
A1(m-2,:)=[];
A1(m-3,:)=[];
A1(:,1)=[];
A1(:,1)=[];
A1(:,n-2)=[];
A1(:,n-3)=[];

B1(1,:)=[];
B1(1,:)=[];
B1(m-2,:)=[];
B1(m-3,:)=[];
B1(:,1)=[];
B1(:,1)=[];
B1(:,n-2)=[];
B1(:,n-3)=[]; 
 
mse=mean( (A1(:) - B1(:)).^2 )
psnr=10*log10( 255*255 / mse )
MI=mutual_information_images(A1,B1)
[ssimval, ssimmap] = ssim(A1,B1);
fprintf('SSIM =\n   %0.4f.\n',ssimval)


