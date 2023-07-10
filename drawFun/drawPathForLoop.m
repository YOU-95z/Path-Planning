% using draw_coordinate_system.m
% draw the result include the helical tube 
function [error,len,h]=drawPathForLoop(helix_r,helix_p,phi,w_x,w_y,w_z,entry_point,target)

[Tsi,Tis]=T([w_x,w_y,w_z],entry_point);
target_i=Tis*[target,1]';
THETA=target_i(3)/helix_p;

theta=0:0.01:THETA;
helix_x=helix_r*(cos(theta+phi)-cos(phi));
helix_y=helix_r*(sin(theta+phi)-sin(phi));
helix_z=helix_p*theta;
helix_base=[helix_x;helix_y;helix_z;ones(size(theta))];
helix=Tsi*helix_base;
h=plot3(helix(1,:),helix(2,:),helix(3,:));hold on; % draw the helix


helix_end_x_i=helix_r*(cos(THETA+phi)-cos(phi));
helix_end_y_i=helix_r*(sin(THETA+phi)-sin(phi));
helix_end_z_i=helix_p*THETA;
helix_end_i=[helix_end_x_i;helix_end_y_i;helix_end_z_i;1];
helix_end=Tsi*helix_end_i;

real_target=[helix_end(1),helix_end(2),helix_end(3)];
% plot3(helix(1,end),helix(2,end),helix(3,end),"o");
error=norm(real_target-target);
len=THETA*sqrt(helix_r^2+helix_p^2);
end