function [Tsb,Tbs]=T(w,target)
%%
%example:
%input:
%     w=[1,2,3];
%     target=[1,1,1];
%output:
%     T=[-0.6949    0.7135    0.0893    1.0000
%        -0.1920   -0.3038    0.9332    1.0000
%         0.6930    0.6313    0.3481    1.0000
%              0         0         0    1.0000]
%%
theta_sb=norm(w,2);
w=w/theta_sb;
w_so3=[0,-w(3),w(2);w(3),0,-w(1);-w(2),w(1),0];
Rsb=eye(3)+sin(theta_sb)*w_so3+(1-cos(theta_sb))*w_so3^2;
Tsb=[Rsb target';0 0 0 1];
Tbs=[Rsb' -Rsb'*target';0,0,0,1];
end