close all
%x = cat(2,PIN(1,:),PIN(1,1))
%y = cat(2,PIN(2,:),PIN(2,1))
%x = cat(2,PIN(1,:),PIN(1,1));
%y = cat(2,PIN(2,:),PIN(2,1));
xr= [0,6.8,6.8,0,0]*10^(-2);
yr = [0 , 0,14,14,0]*10^(-2);
zr=[1 1 1 1 1]*1*10^(-2);
imshow(img)
axis on
hold on
%plot(x,y,LineWidth=10,Color="blue")

%hold on
%plot(x,y,LineWidth=2,Color="blue")
xn = zeros (1,5) ;
yn = zeros(1,5) ;
xd =  cat(2,transpose(x),x(1));
yd =  cat(2,transpose(y),y(1));
a1 = P*[xr(1);yr(1);zr(1);1];
a2 = P*[xr(2);yr(2);zr(2);1];
a3 = P*[xr(3);yr(3);zr(3);1];
a4 = P*[xr(4);yr(4);zr(4);1];
a5 = P*[xr(5);yr(5);zr(5);1];
a_noNorm1 = P_noNorm*[xr(1);yr(1);zr(1);1];
a_noNorm2 = P_noNorm*[xr(2);yr(2);zr(2);1];
a_noNorm3 = P_noNorm*[xr(3);yr(3);zr(3);1];
a_noNorm4 = P_noNorm*[xr(4);yr(4);zr(4);1];
a_noNorm5 = P_noNorm*[xr(5);yr(5);zr(5);1];

xn = [a1(1), a2(1),a3(1),a4(1), a5(1)];
yn = [a1(2), a2(2),a3(2),a4(2), a5(2)];
zn = [a1(3), a2(3),a3(3),a4(3), a5(3)];

xn_noNorm = [a_noNorm1(1), a_noNorm2(1),a_noNorm3(1),a_noNorm4(1), a_noNorm5(1)];
yn_noNorm = [a_noNorm1(2), a_noNorm2(2),a_noNorm3(2),a_noNorm4(2), a_noNorm5(2)];
zn_noNorm = [a_noNorm1(3), a_noNorm2(3),a_noNorm3(3),a_noNorm4(3), a_noNorm5(3)];
%figure()
xe = xn - xd;
ye = yn - yd;
err = 0 ;
xe_noNorm = xn_noNorm - xd;
ye_noNorm = yn_noNorm - yd;
xe = xe_noNorm;
ye = ye_noNorm;

for i =1:length(xe) 
    err = err + norm([xe(i),ye(i)]);
end 
err = err / length(xe);


%plot(xn,yn,LineWidth=2,color="red")

plot(xn_noNorm,yn_noNorm,LineWidth=2,color="red")
plot(xd,yd,LineWidth=2,color="blue")
% e = zeros(1,21);
% e_noNorm = zeros(1,21);
% for k=0:20 
% xr= [0,6.8,6.8,0,0]*10^(-2);
% yr = [0 , 0,14,14,0]*10^(-2);
% zr=[1 1 1 1 1]*k*10^(-2);
% a1 = P*[xr(1);yr(1);zr(1);1];
% a2 = P*[xr(2);yr(2);zr(2);1];
% a3 = P*[xr(3);yr(3);zr(3);1];
% a4 = P*[xr(4);yr(4);zr(4);1];
% a5 = P*[xr(5);yr(5);zr(5);1];
% a_noNorm1 = P_noNorm*[xr(1);yr(1);zr(1);1];
% a_noNorm2 = P_noNorm*[xr(2);yr(2);zr(2);1];
% a_noNorm3 = P_noNorm*[xr(3);yr(3);zr(3);1];
% a_noNorm4 = P_noNorm*[xr(4);yr(4);zr(4);1];
% a_noNorm5 = P_noNorm*[xr(5);yr(5);zr(5);1];
% xn = [a1(1), a2(1),a3(1),a4(1), a5(1)];
% yn = [a1(2), a2(2),a3(2),a4(2), a5(2)];
% zn = [a1(3), a2(3),a3(3),a4(3), a5(3)];
% xn_noNorm = [a_noNorm1(1), a_noNorm2(1),a_noNorm3(1),a_noNorm4(1), a_noNorm5(1)];
% yn_noNorm = [a_noNorm1(2), a_noNorm2(2),a_noNorm3(2),a_noNorm4(2), a_noNorm5(2)];
% zn_noNorm = [a_noNorm1(3), a_noNorm2(3),a_noNorm3(3),a_noNorm4(3), a_noNorm5(3)];
% 
% xe = xn - xd;
% ye = yn - yd;
% 
% xe_noNorm = xn_noNorm - xd;
% ye_noNorm = yn_noNorm - yd;

% 
% err = 0 ;
% err_noNorm = 0 ;
% for i =1:length(xe) 
%     err = err + norm([xe(i),ye(i)]);
%     err_noNorm = err_noNorm + norm([xe_noNorm(i),ye_noNorm(i)]) ;
% end 
% err = err / length(xe);
% err_noNorm = err_noNorm /length(err_noNorm); 
% % err = err / max([xn,yn]);
% % err_noNorm = err_noNorm / max([xn_noNorm,yn_noNorm]);
% e(k+1)=err;
% e_noNorm(k+1) =err_noNorm; 
% end 
% 
% figure()
% plot(0:length(e)-1,e/max(e),color='blue')
% % hold on 
% % plot(0:length(e_noNorm)-1,e_noNorm/max(err_noNorm),color='red')
% % legend("Homographie avec normalisation","Homographie Sans normalisation")
% xlabel("Z (cm)")
% ylabel("Erreur (pixels)")
% grid on 


