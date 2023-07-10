function r = rotd(n,phi)
  phi=phi*pi/180;  
  n = n ./ norm(n);
  s = phi*[0 -n(3) n(2);n(3) 0 -n(1);-n(2) n(1) 0];
  r = expm(s);
return;