% char：' '，string: " "
% a="111", a(1)="111";
% a='111',a(1)='1';
% Binary encoding with two decimal places
function [to2]=CODE(x,j)
    % helix_r、helix_p use 17(16+1) bits
    % phi uses 13 bits
    % w uses 9 bits
    % the final bit indicates ±
    if j==1||j==2 % helix_r or helix_p 
        n=4;
        to2="0"; % helix_r and helix_p can only be positive numbers
    elseif j==3 % phi
        n=3;
        to2="0";
    else % w
        n=2;
        if x < 0 % encode the sign
            to2="1";
            x=abs(x);
        else
            to2="0";  
        end
    end
    x=x*100; % 3.14->314
    for i=1:n
        r=mod(x,10);
        to2=strcat(dec2bin(r,4),to2);
        x=(x-r)/10; % 314->31
    end
end