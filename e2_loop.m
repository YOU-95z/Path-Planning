clear all;close all; clc;
addpath("getObstacles","GASAFun","drawFun","screwTheoryFun")


t_start=clock;%timer start


%% set the simulation environment
% [x,y,z,r];
[e,obstacles,target,entry_point]=getObstacles_8sphere();

% set simulation times
FLAG=50;

% list to record the results
LENGTH=[];
ERROR=[];

%%
for flag=1:FLAG
    run planning_5_1.m
    % draw the result
    helix_r=parents(1,1);
    helix_p=parents(1,2);
    phi=parents(1,3);
    w_x=parents(1,4);
    w_y=parents(1,5);
    w_z=parents(1,6);
    [error,len,h]=drawPathForLoop(helix_r,helix_p,phi,w_x,w_y,w_z,entry_point,target);
    LENGTH(flag)=len;
    ERROR(flag)=error;
end
%% calculate the result
disp("max error");
max_error=max(ERROR);
disp(max_error);
disp("min error");
min_error=min(ERROR);
disp(min_error);
disp("error: mean±standard deviation");
m=num2str(mean(ERROR));
sd=num2str(std(ERROR));
disp(strcat(m,'±',sd));
disp("max length");
max_length=max(LENGTH);
disp(max_length);
disp("min length");
min_length=min(LENGTH);
disp(min_length);
disp("length: mean±standard deviation");
m=num2str(mean(LENGTH));
sd=num2str(std(LENGTH));
disp(strcat(m,'±',sd));

%%
t_end=clock;%timer end
disp("用时");
disp(etime(t_end,t_start));