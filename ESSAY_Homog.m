load('calibrationSession.mat')
img = imread("Pattern.png");
imshow(img)
[x,y]=ginput(8);
n = 4 ;
POUT = [x(1:4)';y(1:4)';[1,1,1,1]];
PIN = [x(5:8)';y(5:8)';[1,1,1,1]];
H=Homographie(PIN,POUT,n);
H =H/H(3,3);
out = homwarp(H_noNorm, img);
imshow(out)


% K= GetCameraParams(calibrationSession);
% 
% RRT = inv(K)*H;
% Re1= RRT(:,1);
% Re2= RRT(:,2);
% Te = RRT(:,3);
% Re3 = cross(Re1,Re2);
% alpha = (nthroot(det([Re1,Re2,Re3]),4));
% R1 = Re1/alpha;
% R2 = Re2/alpha;
% R3 = Re3/alpha^2;
% R = [R1,R2,R3];
% detR= det(R);
% T = Te/alpha ;
% RT = cat(2,R,T);
% P = alpha*K*RT;
