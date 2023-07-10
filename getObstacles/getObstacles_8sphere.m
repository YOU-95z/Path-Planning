%https://www.kdocs.cn/l/cdt8OpjmXTbS?openfrom=docs
%A new path planning method for bevel-tip ﬂexible needle insertion in 3D space with multiple targets and obstacles
function [e,obstacles,target,entry_point]=getObstacles_8sphere()
    e=2;
    % set the ideal point for inserting the needle
    entry_point_=[-13,-20,0]; 
    entry_point=[0,0,0];
    
    
    % set the target
    target=[-19,-15,105]-entry_point_; 
    
    plot3(target(1),target(2),target(3),"g*");hold on;%draw the target
    plot3(entry_point(1),entry_point(2),entry_point(3),"r*");

    n=8;
    obstacles(1,:)=[-14,-3,70,11];
    obstacles(2,:)=[-14,22,70,11];
    obstacles(3,:)=[-14,-10,60,9];
    obstacles(4,:)=[-11,6,55,9];
    obstacles(5,:)=[-11,-3,57,9];
    obstacles(6,:)=[-16,-53,65,7];
    obstacles(7,:)=[-16,-53,74,7];
    obstacles(8,:)=[-13,-20,45,5];
    
    obstacles(1:n,1:3)=obstacles(1:n,1:3)-entry_point_;
   
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
    view([-40,30]);
    xlim([-30,30]);
    ylim([-60,60]);
    xlabel('x[mm]');
    ylabel('y[mm]');
    zlabel('z[mm]');
end