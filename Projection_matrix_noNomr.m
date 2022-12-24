function [P_noNorm] = Projection_matrix_noNomr(x1,y1,x2,y2,K)
%Cette Fonction renvoie la matrice de Projection a partir de points 
% x1 : La composante x des coordonnées des points en entrée 
% y1 : La composante y des coordonnées des points en entrée
% x2 : La composante x des coordonnées des points en sortie
% y2 : La composante y des coordonnées des points en sortie 
% K : Parametre insrinseque de la camera

n = 4 ; % Nombre de points 
PIN = [x1(1:4)';y1(1:4)';[1,1,1,1]];
POUT = [x2(1:4)';y2(1:4)';[1,1,1,1]];


PIN = cat(1,PIN(1,:),PIN(2,:));
POUT = cat(1,POUT(1,:),POUT(2,:));
% Calcule de l'homographie 
H_noNorm =homography_solve(PIN,POUT);
H_noNorm  = H_noNorm /H_noNorm (3,3);
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

T = Te/alpha ;
RT = cat(2,R,T);
P_noNorm = alpha*K*RT;


end