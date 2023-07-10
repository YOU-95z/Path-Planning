% function []=draw_coordinate_system(axis_length,Rotation_matrix,origin,
                                                      %colorstring,cs_name)
% this function draws a coordinate system in the requested orientation
% given by rotation matrix R and at a specific origin example:
% draw_coordinate_system(10,rotd([0,0,1],45),[10,10,10]','rgb') uses
% functions rotd() and cone() and matlab function cylinder() copyright
% Author: Prof: Nabil Simaan, Ph.D., 2003
% Modified: Mengtang Li, Ph.D. 2018
%---------------------------------------------------------------------------
function []=draw_coordinate_system(axis_length,Rotation_matrix,...
                                                origin,colorstring,cs_name)
hold on;
R=Rotation_matrix;

x_axis_unit_vec=R(:,1);  %the axis directions in WCS
y_axis_unit_vec=R(:,2);
z_axis_unit_vec=R(:,3);

x_axis=axis_length*R(:,1); %end point of x_axis in wcs
y_axis=axis_length*R(:,2);
z_axis=axis_length*R(:,3);

%drawing the axis lines
line([origin(1);origin(1)+x_axis(1)],[origin(2);origin(2)+x_axis(2)],...
    [origin(3);origin(3)+x_axis(3)],'color',colorstring(1),'linewidth',2);
line([origin(1);origin(1)+y_axis(1)],[origin(2);origin(2)+y_axis(2)],...
    [origin(3);origin(3)+y_axis(3)],'color',colorstring(2),'linewidth',2);
line([origin(1);origin(1)+z_axis(1)],[origin(2);origin(2)+z_axis(2)],...
    [origin(3);origin(3)+z_axis(3)],'color',colorstring(3),'linewidth',2);

% setting cone variables
cone_height=axis_length/5;
cone_base_radius=axis_length/10;
numpoints=20;

%drawing the cone for x_axis%
Rx=rotd(y_axis_unit_vec,90)*R; 
%since I am specifying all my rotations about axes specified in WCS I
%premultiply same result can be obtained by Rx=R*rotd([0;1;0],90), where I
%am rotating about the y axis given in the new system
x_cone_origin=[origin(1)+x_axis(1); origin(2)+x_axis(2);...
                                                 origin(3)+x_axis(3)];
[X,Y,Z]=cone(cone_height,cone_base_radius,numpoints,Rx,x_cone_origin);
h=surf(X,Y,Z);
set(h,'facecolor',colorstring(1));

%drawing the cone for y_axis%
Ry=rotd(x_axis_unit_vec,-90)*R;
y_cone_origin=[origin(1)+y_axis(1); origin(2)+y_axis(2);...
                                                 origin(3)+y_axis(3)];
[X,Y,Z]=cone(cone_height,cone_base_radius,numpoints,Ry,y_cone_origin);
h=surf(X,Y,Z);
set(h,'facecolor',colorstring(2));

%drawing the cone for z_axis%
Rz = R;
z_cone_origin=[origin(1)+z_axis(1); origin(2)+z_axis(2);...
                                                 origin(3)+z_axis(3)];
[X,Y,Z]=cone(cone_height,cone_base_radius,numpoints,R,z_cone_origin);
h=surf(X,Y,Z);
set(h,'facecolor',colorstring(3));

if nargin==5 %add text labels
   x_label_pos= x_cone_origin + 1.8*cone_height*x_axis/axis_length; 
   y_label_pos= y_cone_origin + 1.8*cone_height*y_axis/axis_length;
   z_label_pos= z_cone_origin + 1.8*cone_height*z_axis/axis_length;
   disp(';ls;ls;ls;');
   text(x_label_pos(1),x_label_pos(2),x_label_pos(3),...
                         ['X_',cs_name],'FontWeight','bold','color','k');
   text(y_label_pos(1),y_label_pos(2),y_label_pos(3),...
                         ['Y_',cs_name],'FontWeight','bold','color','k');
   text(z_label_pos(1),z_label_pos(2),z_label_pos(3),...
                         ['Z_',cs_name],'FontWeight','bold','color','k');
end
return

%-------------------------------------------------------------------------
% function cone(cone_height,cone_base,numpoints,R,cone_origin) returns the
% [X,Y,Z] such that surf([X,Y,Z]) draws a cone in the specific orientation
% given by rotation matrix R and in origin specified by cone_origin written
% Author: Prof: Nabil Simaan, Ph.D., 2003
%-------------------------------------------------------------------------
function [X,Y,Z]=cone(cone_height,cone_base_radius,...
                                   numpoints,R,cone_origin)
%calculating a cone 1 unit in height and centered at [0,0,0] with axis in Z
%direction%
[X,Y,Z]=cylinder([cone_base_radius,0],numpoints);  
Z=Z.*cone_height;

Cone_base=[];
Cone_top=[];
for i=1:1:numpoints+1
    Cone_base(:,i)=[X(1,i);Y(1,i);Z(1,i)];
    Cone_top(:,i)=[X(2,i);Y(2,i);Z(2,i)];
    
    %rotating the cone base and translating
    Cone_base(:,i)=R*Cone_base(:,i)+cone_origin;
    %rotating the cone top points and translating
    Cone_top(:,i)=R*Cone_top(:,i)+cone_origin;  
    
    X(1,i)=Cone_base(1,i);
    X(2,i)=Cone_top(1,i);
    
    Y(1,i)=Cone_base(2,i);
    Y(2,i)=Cone_top(2,i);
    
    Z(1,i)=Cone_base(3,i);
    Z(2,i)=Cone_top(3,i);
end
return;







