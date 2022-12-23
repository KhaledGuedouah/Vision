function [H] = Homographie(p,Mp,nbpts)
% Exemple de formes de Mp (Coordonées Camera) , p(Coordonées monde)  
% Mp = [[1628;1141;1], [1816;1442;1], [2172;1348;1], [2474;1163;1]];
% p =[[932;84;1],[275;576;1],[665;439;1],[948;254;1]];
A = [[zeros(1,3) -transpose(p(:,1))  Mp(2,1)*transpose(p(:,1))];
  [transpose(p(:,1)) zeros(1,3) -Mp(1,1)*transpose(p(:,1))]] ;

for i=2:nbpts 
 A = cat(1,A,[[zeros(1,3) -transpose(p(:,i))  Mp(2,i)*transpose(p(:,i))];
  [transpose(p(:,i)) zeros(1,3) -Mp(1,i)*transpose(p(:,i))]] );
end 
[~,~,V] = svd(A);
H= [V(9,1:3) ; V(9,4:6);V(9,7:9)];
H=H/H(9);
end