% Path planning of surgical needle:A new adaptive intelligent particle swarm optimization method
function [e,obstacles,target,entry_point]=getObstacles_6sphere_Tan()
    e=1; % environment 1 
    
    % set the target
    target=[0,0,120];
    % set the needle entry point
    entry_point=[0,0,0]; 
    
    % set the obstacles 
    obstacles(1,:)=[-10,-2,25,5];
    obstacles(2,:)=[5,-8,40,8];
    obstacles(3,:)=[-2,10,10,7];
    obstacles(4,:)=[12,2,40,6];
    obstacles(5,:)=[6,15,60,5];
    obstacles(6,:)=[2,10,90,10];
    n=6;
    plot3(target(1),target(2),target(3),"g*");hold on;%draw the target
    plot3(entry_point(1),entry_point(2),entry_point(3),"r*");%draw the ideal enrty point
   
%     % 蛋壳色 252 230 201
%     CO(:,:,1) = 252/255.*ones(size(x)); % red
%     CO(:,:,2) = 230/255.*ones(size(x)); % green
%     CO(:,:,3) = 201/255.*ones(size(x)); % blue
    [x,y,z]=sphere();%unit sphere
    for i=1:n
        x0=obstacles(i,1);
        y0=obstacles(i,2);
        z0=obstacles(i,3);
        r0=obstacles(i,4);
%         surf(r0*x+x0,r0*y+y0,r0*z+z0,CO,"edgecolor","none");hold on;
        surf(r0*x+x0,r0*y+y0,r0*z+z0);hold on;
    end
    axis equal;grid on;box on;
    set(gca,"linewidth",0.8,"fontsize",12.5);
    xlim([-30,30]);
    ylim([-30,30]);
%     zlim([0,120]);
    xlabel('x[mm]');
    ylabel('y[mm]');
    zlabel('z[mm]');
    view([-80,20]);
end