% location = 'C:\Users\ferie\OneDrive\Bureau\M1 ISI\Vision\Projet_vision\Vision\Newcarre';       %  folder in which your images exists
% ds = imageDatastore(location);      %  Creates a datastore for all images in your folder

% Tracker = vision.PointTracker; % creating a point tracker object
% 
% 
% % points, must be an M-by-2 array of [x y] coordinates
% %The initial video frame, I, must be a 2-D grayscale or RGB image 
% img = imread("Linda1.jfif");
% imshow(img);
% points_initial=ginput(4);
% initialize(Tracker, points_initial, img); %initialize the pointTracker object
% 
% %while hasdata(ds) 
%    % I = read(ds) ;     % read image from datastore
% %     I = imread("Linda3.jfif");
% %   [points,point_validity] = Tracker(I);
% % % 
% %      points = cat(1,points,points(1,:));
% %      x=points(:,1).';
% %      y=points(:,2).';
% % %     
% % % %     if point_validity      
% % %     imshow(I); % creates a new window for each image
% % %     hold on
% %     plot(x,y,LineWidth=2,Color="red");
% 
% %     %point2
%     I2 = imread("Linda5.jfif");
%     [points,point_validity] = Tracker(I2);
% 
%     points = cat(1,points,points(1,:));
%     x=points(:,1).';
%     y=points(:,2).';
%     
% %     if point_validity      
%     imshow(I2); % creates a new window for each image
%     hold on
%     plot(x,y,LineWidth=2,Color="red");
% 
% 
% %     end 
% %end
% 
% 
%getting intrinsic parameters 
close all ;
clear all ;
load('calibrationSession.mat')
K= GetCameraParams(calibrationSession);

%object tracking using a video
videoReader = VideoReader('VID_20221224_003628.avi');
objectFrame = readFrame(videoReader);
imshow(objectFrame);
% objectRegion=ginput(4);
[x_old,y_old] = ginput(4);
objectRegion = [x_old,y_old] ;
% P_old=cat(1,objectRegion,objectRegion(1,:));


tracker = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker,objectRegion,objectFrame);
k= 0 ;
while hasFrame(videoReader)
      frame = readFrame(videoReader);
      [points,validity] = tracker(frame);
%       points = cat(1,points,points(1,:));
%       plot(points(:,1),points(:,2),'r',LineWidth=2);
      x_new = points(:,1);
      y_new = points(:,2);
      P=Projection_matrix(x_new,y_new,x_old,y_old,K);
      
      P_projected=Projection(x_new,y_new,P);
      x=cat(1,x_new,x_new(1));
      y=cat(1,y_new,y_new(1));
      p1=[x';y'; ones(1,5);ones(1,5)];
% 
      imshow(frame); % creates a new window for each image
      hold on

      for i=1:5
          hold on
          plot([P_projected(1,i),p1(1,i)],[P_projected(2,i),p1(2,i)],'y-',LineWidth=3)
      end
      plot(P_projected(1,:), P_projected(2,:),'b',LineWidth=2)
      hold on
      plot(p1(1,:),p1(2,:),'r',LineWidth=2)
      hold on
      pause(0.01);

      x_old=x_new;
      y_old=y_new;
    
end

