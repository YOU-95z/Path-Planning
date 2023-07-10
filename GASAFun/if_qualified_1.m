% Check whether the individual is qualified
% if the individual is qualified, flag=1, otherwise flag=0
function flag=if_qualified_1(helix_r,helix_p,phi,w_x,w_y,w_z,entry_point,target)
    flag=0;
    if w_x==0 && w_y==0 &&w_z==0% these three numbers can't be 0 at the same time, otherwise R=NaN
        return
    end
    if helix_r==0||helix_p==0
        return
    end
    [Tsi,~]=T([w_x,w_y,w_z],entry_point);
    THETA_MAX=5;
    helix_x_b=helix_r*(cos(THETA_MAX+phi)-cos(phi));
    helix_y_b=helix_r*(sin(THETA_MAX+phi)-sin(phi));
    helix_z_b=helix_p*THETA_MAX;
    helix_b=[helix_x_b;helix_y_b;helix_z_b;1];
    helix=Tsi*helix_b;
    
    while helix(3) < target(3) && helix(3) > 0
        THETA_MAX=2*THETA_MAX;
        helix_x_b=helix_r*(cos(THETA_MAX+phi)-cos(phi));
        helix_y_b=helix_r*(sin(THETA_MAX+phi)-sin(phi));
        helix_z_b=helix_p*THETA_MAX;
        helix_b=[helix_x_b;helix_y_b;helix_z_b;1];
        helix=Tsi*helix_b;
    end

    if helix(3)<0 %the end of the helix get the bottom
        return
    end
    flag=1;
end