% using draw_coordinate_system.m
% draw the result include the helix and four coordinate system
% {s} at [0,0,0];
% {b} at the entry_point
% {i} at the point of the insertion, {b} rotate pi about its own y axis and move to the point of insertion to get {i} 
% {o} at the end of the docking tube
function drawPath(helix_r,helix_p,phi,w_x,w_y,w_z,entry_point,target)
    size_of_space=200;
    draw_coordinate_system(size_of_space/10,rotd([0,0,1],0),[0,0,0]','rgb','{s}');
    disp("radius");
    disp(helix_r);
    disp("pitch");
    h=helix_p*2*pi;
    disp(h);

    w=[w_x,w_y,w_z];
    [Tsi,Tis]=T(w,entry_point);
    disp("Tsi")
    disp(Tsi);
    
    %{i}
    draw_coordinate_system(size_of_space/10,Tsi(1:3,1:3),entry_point','rgb','{i}'); 


    % draw the helix
    target_i=Tis*[target,1]';
    THETA=target_i(3)/helix_p;
    disp("\phi");
    phi=mod(phi,2*pi);% [0,2*pi];
    disp(phi);
    disp("\Theta");
    disp(THETA);
    disp("PathLength");
    disp(THETA*sqrt(helix_r^2+helix_p^2));
    
    theta=0:0.001:THETA;
    helix_x=helix_r*(cos(theta+phi)-cos(phi));
    helix_y=helix_r*(sin(theta+phi)-sin(phi));
    helix_z=helix_p*theta;
    helix_base=[helix_x;helix_y;helix_z;ones(size(theta))];
    helix=Tsi*helix_base;
    plot3(helix(1,:),helix(2,:),helix(3,:),"linewidth",2,"color","blue");hold on;% draw the helix

    helix_end_x_b=helix_r*(cos(THETA+phi)-cos(phi));
    helix_end_y_b=helix_r*(sin(THETA+phi)-sin(phi));
    helix_end_z_b=helix_p*THETA;
    helix_end_b=[helix_end_x_b;helix_end_y_b;helix_end_z_b;1];
    helix_end=Tsi*helix_end_b;
    real_target=[helix_end(1),helix_end(2),helix_end(3)];
    
    disp("TipError")
    disp(norm(real_target-target));

    % {b} 
    zb0 = [-helix_r/sqrt(helix_r^2+helix_p^2)*sin(theta(1)); 
        helix_r/sqrt(helix_r^2+helix_p^2)*cos(theta(1)); 
        helix_p/sqrt(helix_r^2+helix_p^2)];
    xb0 = [-1; 0; 0];% rotate the point on the screw axis
    yb0 = cross(zb0,xb0);
    M0 = [xb0(1) yb0(1) zb0(1)  0;
          xb0(2) yb0(2) zb0(2)  0;
          xb0(3) yb0(3) zb0(3)  0;
          0      0      0       1]; % its correct. Its not rotated.
%     draw_coordinate_system(10,M0(1:3,1:3),M0(1:3,4),'rgb','{b0}');
    S1=[0,0,1,0,0,0]';
    T1 =MatrixExp6(VecTose3(S1*phi));
    
    ws2=[0,0,1];
    qs2=[-helix_r,0,0];
    vs2=-cross(ws2,qs2)+helix_p*ws2;
    S2=[ws2,vs2]';
    T2 = MatrixExp6(VecTose3(S2*THETA));
    Tsb=Tsi*T1*T2*M0;
    draw_coordinate_system(size_of_space/10,Tsb(1:3,1:3),real_target','rgb','{b}');
    

    %docking tube
    dock_r = 1*size_of_space/105; % radius of the docking tube
    dock_h = 60; % height of the docking tube
    [Tio,~]=T([0,0,2*pi],[0,0,-dock_h]);
    Tso=Tsi*Tio;
    o_p=(Tsi*[0,0,-dock_h,1]')';
    draw_coordinate_system(size_of_space/10,Tso(1:3,1:3),o_p(1:3)','rgb','{o}');


    [x_dock,y_dock,z_dock] = cylinder; % unit cylinder
    x_dock = x_dock*dock_r;
    y_dock = y_dock*dock_r;
    z_dock = z_dock*dock_h;
    dock=Tso*[x_dock(1,:);y_dock(1,:);z_dock(1,:);ones(size(x_dock(1,:)))];
    x_dock(1,:) = dock(1,:);
    y_dock(1,:) = dock(2,:);
    z_dock(1,:) = dock(3,:);
    dock=Tso*[x_dock(2,:);y_dock(2,:);z_dock(2,:);ones(size(x_dock(2,:)))];
    x_dock(2,:) = dock(1,:);
    y_dock(2,:) = dock(2,:);
    z_dock(2,:) = dock(3,:);
    % plot the straight docking tube
    surf(x_dock,y_dock,z_dock,'facecolor','g','facealpha',0.2,'edgecolor','none');
    patch(x_dock(1,:),y_dock(1,:),z_dock(1,:),'facecolor','g','facealpha',0.2,'edgecolor','none');
    patch(x_dock(2,:),y_dock(2,:),z_dock(2,:),'facecolor','g','facealpha',0.2,'edgecolor','none');
end