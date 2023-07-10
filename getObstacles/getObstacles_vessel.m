function [e,obstacles,target,entry_point]=getObstacles_vessel()
    e=3;
    size_of_space=100;
    
    target=[0,0,80];
    plot3(target(1),target(2),target(3),"g*");hold on;%draw the target

    % set the ideal point for inserting the needle
    entry_point=[0,0,0]; 
    plot3(entry_point(1),entry_point(2),entry_point(3),"r*");hold on;

    % 第一根血管，（x，0，40）；
    r1=size_of_space/40;
    x1=-size_of_space/2:1.5*r1:size_of_space/2;
    y1=zeros(size(x1));
    z1=40*ones(size(x1));

    % 第二根血管(x,-20,60)
    r2=size_of_space/40;
    x2=-size_of_space/2:1.5*r2:size_of_space/2;
    y2=-10*ones(size(x2));
    z2=60*ones(size(x2));

    % (x,20,60)
    r3=size_of_space/40;
    x3=-size_of_space/2:1.5*r3:size_of_space/2;
    y3=10*ones(size(x3));
    z3=60*ones(size(x3));

    obstacles=[[x1,x2,x3]',[y1,y2,y3]',[z1,z2,z3]',[r1*ones(size(x1)),r2*ones(size(x2)),r3*ones(size(x3))]'];


    % 画图
    [x,y,z]=sphere();%基础球型
    CO(:,:,1) = 255/255.*ones(size(x)); % red
    CO(:,:,2) = 0/255.*ones(size(x)); % green
    CO(:,:,3) = 0/255.*ones(size(x)); % blue
    for i=1:1:length(obstacles)
        x0=obstacles(i,1);
        y0=obstacles(i,2);
        z0=obstacles(i,3);
        r0=obstacles(i,4);
        surf(r0*x+x0,r0*y+y0,r0*z+z0,CO,"EdgeColor","none");hold on;
    end
    axis equal;grid on;box on;
    set(gca,"linewidth",0.8,"fontsize",12.5);
%     xlim([0,100]);
%     ylim([30,70]);
%     zlim([0,100]);
    xlabel('x[mm]');
    ylabel('y[mm]');
    zlabel('z[mm]');
    view(90,10)
end