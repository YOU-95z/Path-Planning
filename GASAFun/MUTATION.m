function new=MUTATION(old)
    new=old;
    j=randi(length(old(1,:))-1);%choose one of six parameters
    to2=CODE(old(j),j);
    to2=char(to2);
    pos=randi(length(to2)-1);
    if to2(pos)=='1'
        to2(pos)='0';
    else
        to2(pos)='1';
    end
    a=floor((pos-1)/4);
    % abnormal value test
    while bin2dec(to2(a*4+1:a*4+4))>9
        to2=CODE(old(j),j);
        to2=char(to2);
        pos=randi(length(to2)-1);
        if to2(pos)=='1'
            to2(pos)='0';
        else
            to2(pos)='1';
        end
        a=floor((pos-1)/4);
    end
    new(j)=DECODE(to2);
end