
load('calibrationSession.mat')
img = imread("Pattern.png");
n = 4 ;
imshow(img)
[x,y]=ginput(n);
%[x,y]=ginput(8);
POUT = [x(1:4)';y(1:4)';[1,1,1,1]];
pm = [0 , 6.8 , 6.8 , 0 ; ...
    0 , 0 , 14, 14];...
  
PIN = cat(1,pm*10^(-2),[1,1,1,1]);

%POUT = [x(5:8)';y(5:8)'];
PIN = cat(1,PIN(1,:),PIN(2,:));
POUT = cat(1,POUT(1,:),POUT(2,:));

PIN = cat(1,PIN(1,:),PIN(2,:));
POUT = cat(1,POUT(1,:),POUT(2,:));
H_noNorm =homography_solve(PIN,POUT);

H_noNorm  = H_noNorm /H_noNorm (3,3);

K= GetCameraParams(calibrationSession);

RRT = inv(K)*H_noNorm;
Re1= RRT(:,1);
Re2= RRT(:,2);
Te = RRT(:,3);
Re3 = cross(Re1,Re2);
alpha = (nthroot(det([Re1,Re2,Re3]),4));
R1 = Re1/alpha;
R2 = Re2/alpha;
R3 = Re3/alpha^2;
R = [R1,R2,R3];
detR= det(R);
T = Te/alpha ;
RT = cat(2,R,T);
P_noNorm = alpha*K*RT;



