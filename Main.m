%   Main script
close all ;
clear all ;
load('calibrationSession.mat')
K= GetCameraParams(calibrationSession);

%object tracking using a video
videoReader = VideoReader('TestVideo.avi');
objectFrame = readFrame(videoReader);
% Premier frame de la video
imshow(objectFrame);
%Definition des points a suivre 
[x_old,y_old] = ginput(4);
objectRegion = [x_old,y_old] ;


% Initialisation du Tracker 
tracker = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker,objectRegion,objectFrame);

while hasFrame(videoReader)
      frame = readFrame(videoReader);
      % Recuperation des coordonnées des points dans le frame actuelle
      [points,validity] = tracker(frame);
      x_new = points(:,1);
      y_new = points(:,2);
      % Calcule de la matrice de projection pour les points dans le frame
      % actuelle et precedent 
      P=Projection_matrix(x_new,y_new,x_old,y_old,K);
      % Recuperation des coordonnées des points projetés
      P_projected=Projection(x_new,y_new,P);
      x=cat(1,x_new,x_new(1));
      y=cat(1,y_new,y_new(1));
      p1=[x';y'; ones(1,5);ones(1,5)];
      imshow(frame); % creates a new window for each image
      hold on
      %Tracé des droite reliant les points 3D et leur projections 
      for i=1:5
          hold on
          plot([P_projected(1,i),p1(1,i)],[P_projected(2,i),p1(2,i)],'y-',LineWidth=3)
      end
      plot(P_projected(1,:), P_projected(2,:),'b',LineWidth=2)
      hold on
      plot(p1(1,:),p1(2,:),'r',LineWidth=2)
      hold on
      %Pause pour montré le mouvement de la video
      pause(0.00000000000000000000001);
      % Mise a jour des points 
      x_old=x_new;
      y_old=y_new;
    
end

