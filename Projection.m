function [P_projected] = Projection(x_new,y_new,P)
% Ce fonction renvoie les point projeté a partir de la matrice de
% projection P et les coordonnées des points du prochain frame de la video
x=cat(1,x_new,x_new(1));
y=cat(1,y_new,y_new(1));
zprop = 100 ;
p1=[x';y'; ones(1,5)*zprop;ones(1,5)];
P_projected= P*p1;
