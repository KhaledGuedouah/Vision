% Coordonnées Image
Mp1=[1628;1141;1];  %Bleu ciel
Mp2=[1816;1442;1] ; %Grena
Mp3=[2172;1348;1] ; %Violet grand
Mp4=[2474;1163;1] ;%Bleu foncé
% Coordonnées Reels
p1=[932;84;1];
p2=[275;576;1];
p3=[665;439;1];
p4=[948;254;1];

 A = [zeros(1,3) -transpose(p1)  Mp1(2)*transpose(p1); ...
    transpose(p1) zeros(1,3) -Mp1(1)*transpose(p1);...
    zeros(1,3) -transpose(p2) Mp2(2)*transpose(p2);...
    transpose(p2) zeros(1,3) -Mp2(1)*transpose(p2);...
    zeros(1,3) -transpose(p3) Mp3(2)*transpose(p3);...
    transpose(p3) zeros(1,3) -Mp3(1)*transpose(p3);...
    zeros(1,3) -transpose(p4) Mp4(2)*transpose(p4);...
    transpose(p4) zeros(1,3) -Mp4(1)*transpose(p4)];
[U,S,V] = svd(A);
H= [V(9,1:3) ; V(9,4:6);V(9,7:9)];
H=H/H(9);
K= GetCameraParams(calibrationSession);
RRT = K\H
Re1= RRT(:,1)
Re2= RRT(:,2)
T = RRT(:,3)
