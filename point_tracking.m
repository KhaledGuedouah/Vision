location = 'C:\Users\ferie\OneDrive\Bureau\M1 ISI\Vision\Projet_vision\Vision\IMAGES';       %  folder in which your images exists
ds = imageDatastore(location);      %  Creates a datastore for all images in your folder

pointTracker = vision.PointTracker; % creating a point tracker object


% points, must be an M-by-2 array of [x y] coordinates
%The initial video frame, I, must be a 2-D grayscale or RGB image 
img = imread("IMG2.png");
imshow(img);
points_initial=ginput(4);
initialize(pointTracker, points_initial, img); %initialize the pointTracker object

while hasdata(ds) 
    I = read(ds) ;             % read image from datastore
    [points,point_validity] = pointTracker(I);
    points = cat(1,points,points(1,:));
    x=points(:,1).';
    y=points(:,2).';
    
    if point_validity      
    imshow(I); % creates a new window for each image
    hold on
    plot(x,y,LineWidth=2,Color="red");
    end 
end


