% Artificial potential field method
function loss=getLoss_4(helix_r,helix_p,phi,w_x,w_y,w_z,entry_point,obstacles,target,k_l,k_att,k_rep,rho_0)
    
    
    [Tsi,Tis]=T([w_x,w_y,w_z],entry_point);
    target_i=Tis*[target,1]';
    THETA=target_i(3)/helix_p;
    LENGTH=THETA*sqrt(helix_r^2+helix_p^2);
    
    
    % Gravitation with the ideal insertion point
    real_target_x=helix_r*(cos(THETA+phi)-cos(phi));
    real_target_y=helix_r*(sin(THETA+phi)-sin(phi));
    real_target_z=helix_p*THETA;
    real_target=Tsi*[real_target_x,real_target_y,real_target_z,1]';
    real_target=real_target(1:3)';
    d=sqrt(sum((real_target-target).^2));
    Uatt=0.5*k_att*sum((real_target-target).^2);
    
    
    
    n=length(obstacles(:,1)); % get the number of obstacles
    o_s=obstacles(:,1:3); % coordinates in {s}
    o_i=Tis*[o_s,ones(n,1)]'; % coordinates in {b}
    o_i=o_i';
    o_i=o_i(:,1:3);
    Urep=0;
    % repulsion
    for theta=0:0.01:THETA
        helix_x=helix_r*(cos(theta+phi)-cos(phi));
        helix_y=helix_r*(sin(theta+phi)-sin(phi));
        helix_z=helix_p*theta;
%         helix=[helix_x,helix_y,helix_z];
        for i=1:1:n
            d=sqrt((helix_x-o_i(i,1)).^2+(helix_y-o_i(i,2)).^2+(helix_z-o_i(i,3)).^2)-obstacles(i,4);
%             Urep=Urep+0.5*k_rep*(1/d-1/rho_0)^2;
            if d < rho_0
%                 Urep=Urep+100000;
                Urep=Urep+0.5*k_rep*(1/d-1/rho_0)^2;
            end
        end
    end
    Uatt;
    Urep;
    loss=Uatt+Urep+k_l*LENGTH;


end