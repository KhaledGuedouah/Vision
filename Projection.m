function [P_projected] = Projection(x_new,y_new,P)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

x=cat(1,x_new,x_new(1));
y=cat(1,y_new,y_new(1));

p1=[x';y'; ones(1,5)*100;ones(1,5)];
P_projected= P*p1;

% imshow(frame); % creates a new window for each image
% hold on
% 
% for i=1:5
% hold on
% plot([P_projected(1,i),p1(1,i)],[P_projected(2,i),p1(2,i)],'y-',LineWidth=3)
% end
% plot(P_projected(:,1), P_projected(:,2),'b',LineWidth=2)
% hold on
% plot(p1(:,1),p1(:,2),'r',LineWidth=2);
% hold on
% pause(0.1);
% end