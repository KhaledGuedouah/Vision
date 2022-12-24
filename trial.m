clear all ;
close all ;
load('calibrationSession.mat')
%img = imread("Pattern.png");
img1 = imread("new.png");

imshow(img1)
[x1,y1]=ginput(4);

img2 = imread("new.png");
imshow(img2)
[x2,y2]=ginput(4);


K= GetCameraParams(calibrationSession);
P=Projection_matrix(x2,y2,x1,y1,K);

%plotting the output
imshow(img1)
x=cat(1,x2,x2(1));
y=cat(1,y2,y2(1));

p1=[x';y'; ones(1,5);ones(1,5)];
p_proj= P*p1;

for i=1:5
    hold on
    plot([p_proj(1,i),p1(1,i)],[p_proj(2,i),p1(2,i)],'y-',LineWidth=3)
end

plot(p_proj(1,:),p_proj(2,:),'b',LineWidth=2)
hold on 
plot(p1(1,:),p1(2,:),'r',LineWidth=2)


