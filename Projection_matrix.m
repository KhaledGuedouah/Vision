function [P] = Projection_matrix(x1,y1,x2,y2,K)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 
n = 4 ;
PIN = [x1(1:4)';y1(1:4)';[1,1,1,1]];

POUT = [x2(1:4)';y2(1:4)';[1,1,1,1]];

% Normalization 
u_ = mean (PIN(1,:));
v_ =  mean (PIN(2,:));
u_o = mean (POUT(1,:));
v_o =  mean (POUT(2,:));
sm = 0;
smo = 0;
for i=1:n 
    sm = sm + sqrt((PIN(1,i)-u_)^2 + (PIN(2,i)-v_)^2);
    smo = smo +sqrt((POUT(1,i)-u_o)^2 + (POUT(2,i)-v_o)^2);
end 
s = sqrt(2)*n/sm ;
so = sqrt(2)*n/smo ;
Tin = s*[1, 0 , -u_ ;...
        0, 1 , -v_ ;...
        0, 0 , 1/s];
Tout = so*[1, 0 , -u_o ;...
          0, 1 , -v_o ;...
          0, 0 , 1/so];
for i=1:n 
    PIN(:,i)
    PIN(:,i) = Tin*PIN(:,i);
    POUT(:,i) = Tout*POUT(:,i);
end 

PIN = cat(1,PIN(1,:),PIN(2,:));
POUT = cat(1,POUT(1,:),POUT(2,:));

Hbefore=homography_solve(PIN,POUT);
%Hsans=homography_solve(PIN,POUT)

H=inv(Tout)*Hbefore*Tin ;
%H=homography_solve(PIN,POUT);
H =H/H(3,3);
%out = homwarp(H, img);
%imshow(out)


RRT = inv(K)*H;
Re1= RRT(:,1);
Re2= RRT(:,2);
Te = RRT(:,3);
Re3 = cross(Re1,Re2);
alpha = (nthroot(det([Re1,Re2,Re3]),4));
R1 = Re1/alpha;
R2 = Re2/alpha;
R3 = Re3/alpha^2;
R = [R1,R2,R3];
% detR= det(R);
T = Te/alpha ;
RT = cat(2,R,T);
P = alpha*K*RT;

end