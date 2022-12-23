% pixeltocm = 0.264583333 ;
% Coordonnées Image
% Mp1=[x(1);y(1);1] ; %Bleu ciel
% Mp2=[x(2);y(2);1] ; %Grena
% Mp3=[x(3);y(3);1] ; %Violet grand
% Mp4=[x(4);y(4);1] ;%Bleu foncé
% %Coordonnées Reels
% p1=[x(5);y(5);1];
% p2=[x(6);y(6);1];
% p3=[x(7);y(7);1];
% p4=[x(8);y(8);1];
% 
%  A = [zeros(1,3) -transpose(p1)  Mp1(2)*transpose(p1); ...
%     transpose(p1) zeros(1,3) -Mp1(1)*transpose(p1);...
%     zeros(1,3) -transpose(p2) Mp2(2)*transpose(p2);...
%     transpose(p2) zeros(1,3) -Mp2(1)*transpose(p2);...
%     zeros(1,3) -transpose(p3) Mp3(2)*transpose(p3);...
%     transpose(p3) zeros(1,3) -Mp3(1)*transpose(p3);...
%     zeros(1,3) -transpose(p4) Mp4(2)*transpose(p4);...
%     transpose(p4) zeros(1,3) -Mp4(1)*transpose(p4)];
% [U,S,V] = svd(A);
% H= [V(9,1:3) ; V(9,4:6);V(9,7:9)];
% H=H/H(9)
% PIN = [Mp1(1),Mp2(1),Mp3(1),Mp4(1);...
% Mp1(2),Mp2(2),Mp3(2),Mp4(2)];
% POUT = [p1(1),p2(1),p3(1),p4(1);...
% p1(2),p2(2),p3(2),p4(2)];
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
% PIN = cat(1,PIN(1,:),PIN(2,:));
% POUT = cat(1,POUT(1,:),POUT(2,:));
% Normalization 
u_ = mean (PIN(1,:));
v_ =  mean (PIN(2,:));
u_o = mean (POUT(1,:));
v_o =  mean (POUT(2,:));
sm = 0;
smo = 0;
for i=1:n 
    sm = sm +sqrt((PIN(1,i)-u_)^2 + (PIN(2,i)-v_)^2);
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
K= GetCameraParams(calibrationSession);

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
detR= det(R);
T = Te/alpha ;
RT = cat(2,R,T);
P = alpha*K*RT;



