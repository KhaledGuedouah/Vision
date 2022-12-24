function [P_projected] = Projection(P1,P)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


P1=[P1(:,1)';P1(:,2)'; ones(1,5);ones(1,5)];
P_projected= P*P1;
end