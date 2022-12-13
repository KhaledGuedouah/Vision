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
img = imread("Board.png");
imshow(img)
[x,y]=ginput(8);
PIN = [x(1:4)';y(1:4)'];
POUT = [x(5:8)';y(5:8)'];
H=homography_solve(PIN, POUT);
H =H/H(3,3);
H(3,1) = round(H(3,1));
H(3,2) = round(H(3,2));
out = homwarp(H, img);
imshow(out)
K= GetCameraParams(calibrationSession);
K(1,1)=1;
K(2,2)=1;
RRT = K\H;
Re1= RRT(:,1);
Re2= RRT(:,2);
T = RRT(:,3);
Re3 = cross(Re1,Re2);
alpha = nthroot(det([Re1,Re2,Re3]),4);
R1 = Re1/alpha;
R2 = Re2/alpha;
R3 = Re3/alpha^2;
R = [R1,R2,R3];
detR= det(R);
RT = cat(2,R,T);
P = K*RT;



