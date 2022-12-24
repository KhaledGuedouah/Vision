% ce script est pour le test de la matrice de Projection
load('calibrationSession.mat')
img1 = imread("new.png");
n = 4 ;
imshow(img1)
[x,y]=ginput(n);
POUT = [x(1:4)';y(1:4)';[1,1,1,1]];
img2 = imread("new.png");
imshow(img2)
[x2,y2]=ginput(n);
PIN = [x2(1:4)';y2(1:4)';[1,1,1,1]];

% Normalization des points
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
% Calcule de l'homographie 
Hbefore=homography_solve(PIN,POUT);
H=inv(Tout)*Hbefore*Tin ;
H =H/H(3,3);
% Parametre insrinseque de la camera
K= GetCameraParams(calibrationSession);
% Calcule de RRT
RRT = inv(K)*H;
Re1= RRT(:,1);
Re2= RRT(:,2);
Te = RRT(:,3);
Re3 = cross(Re1,Re2);
% Calcule de la proportionalité alpha
alpha = (nthroot(det([Re1,Re2,Re3]),4));
% Calcule des parametres extrinseque 
R1 = Re1/alpha;
R2 = Re2/alpha;
R3 = Re3/alpha^2;
R = [R1,R2,R3];
% Determinant de R (pour verifier le calcul)
detR= det(R);
T = Te/alpha ;
RT = cat(2,R,T);
% Matrice de projection P
P = alpha*K*RT;

%Tracé de l'image, des points 3D et leur projections
imshow(img1)
x=cat(1,x,x(1));
y=cat(1,y,y(1));
p1=[x';y';ones(1,5);ones(1,5)];
p_proj= P*p1;
%Tracé des droite reliant les points 3D et leur projections 
for i=1:5
    hold on
    plot([p_proj(1,i),p1(1,i)],[p_proj(2,i),p1(2,i)],'y-',LineWidth=3)
end

plot(p_proj(1,:),p_proj(2,:),'b',LineWidth=2)
hold on 
plot(p1(1,:),p1(2,:),'r',LineWidth=2)


