close all
%x = cat(2,PIN(1,:),PIN(1,1))
%y = cat(2,PIN(2,:),PIN(2,1))
%x = cat(2,PIN(1,:),PIN(1,1));
%y = cat(2,PIN(2,:),PIN(2,1));
x= [0,6.8,6.8,0,0]*10^(-2);
y = [0 , 0,14,14,0]*10^(-2);
z=[0 0 0 0 0];
imshow(img)
axis on
hold on
%plot(x,y,LineWidth=10,Color="blue")

%hold on
%plot(x,y,LineWidth=2,Color="blue")
xn = zeros (1,5) ;
yn = zeros(1,5) ;

a1 = P*[x(1);y(1);z(1);1];
a2 = P*[x(2);y(2);z(2);1];
a3 = P*[x(3);y(3);z(3);1];
a4 = P*[x(4);y(4);z(4);1];
a5 = P*[x(5);y(5);z(5);1];

xn = [a1(1), a2(1),a3(1),a4(1), a5(1)];
yn = [a1(2), a2(2),a3(2),a4(2), a5(2)];
zn = [a1(3), a2(3),a3(3),a4(3), a5(3)];
%figure()

%plot(xn,yn,LineWidth=2,color="red")

plot(xn,yn,LineWidth=2,color="red")



