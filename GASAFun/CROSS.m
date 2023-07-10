function [o1,o2]=CROSS(p1,p2)
    % p1,p2: string
    p1=char(p1);
    p2=char(p2);
    pos=randi(length(p1));%choose a position as the crossover point 
    o1=string(strcat(p1(1:pos-1),p2(pos:end)));
    o2=string(strcat(p2(1:pos-1),p1(pos:end)));
end