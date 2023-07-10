clc;clear;close all;
addpath("getObstacles","GASAFun","drawFun","screwTheoryFun","screwTheoryFun/mrlib")

%% Change simulation enviroments here
e=1;
% [x,y,z,r];
if  ~exist("e","var")
    e=1;
end
if e==1
    [e,obstacles,target,entry_point]=getObstacles_6sphere_Tan();% environment 1
elseif e==2
    [e,obstacles,target,entry_point]=getObstacles_8sphere();% environment 2
elseif e==3
    [e,obstacles,target,entry_point]=getObstacles_vessel();% environment 3 
end

%%
tic
disp("running...")
run planning_5_1.m
% t_end=clock;%timer end
loss=getLoss_4(helix_r,helix_p,phi,w_x,w_y,w_z,entry_point,obstacles,target,k_l,k_att,k_rep,rho_0)
toc

if e==1
    load ./PathPoints_e1.mat
elseif e==2
    load ./PathPoints_e2.mat
elseif e==3
    load ./PathPoints_e3.mat
end
figure(1);
p1=plot3(Path3D_P_PSO(:,1),Path3D_P_PSO(:,2),Path3D_P_PSO(:,3),"r","linewidth",2);
p2=plot3(Path3D_P_AI_PSO(:,1),Path3D_P_AI_PSO(:,2),Path3D_P_AI_PSO(:,3),"g","linewidth",2);
legend([p1,p2,p3],["Cai et al","Tan et al","Proposed"],"Location","North");
