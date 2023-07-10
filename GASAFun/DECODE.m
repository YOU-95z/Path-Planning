function [x]=DECODE(to2)
    % decode single number from bin to dec
    to2=char(to2); % string to char
    len=length(to2);
    x=0;
    % integer
    for i=4:4:len-9
        x=x*10+bin2dec(to2(i-3:i));
    end
    
    x=x+bin2dec(to2(len-8:len-5))*0.1+bin2dec(to2(len-4:len-1))*0.01;
    % sign
    if to2(end)=='1'
        x=-x;
    end
end