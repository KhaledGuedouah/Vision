location = 'C:\Users\ferie\OneDrive\Bureau\M1 ISI\Vision\Projet_vision\Vision\Newcarre';       %  folder in which your images exists
ds = imageDatastore(location);      %  Creates a datastore for all images in your folder

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
load('calibrationSession.mat')
K= GetCameraParams(calibrationSession);

%object tracking using a video
videoReader = VideoReader('VID_20221224_003628.avi');
objectFrame = readFrame(videoReader);
imshow(objectFrame);
objectRegion=ginput(4);

P_old=cat(1,objectRegion,objectRegion(1,:));


tracker = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker,objectRegion,objectFrame);
while hasFrame(videoReader)
      frame = readFrame(videoReader);
      [points,validity] = tracker(frame);
      points = cat(1,points,points(1,:));

      P_new=points;
      P=Projection_matrix(P_new,P_old,K);
      P_projected=Projection(P_new,P);

      imshow(frame); % creates a new window for each image
      plot(P_projected(:,1), P_projected(:,2),'b',LineWidth=2)
      hold on
      plot(P_new(:,1),P_new(:,2),LineWidth=2,Color="red");
      hold on
      pause(0.1);

      P_old=P_new;
    
end

