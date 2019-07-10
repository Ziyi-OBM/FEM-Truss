function [ Ke ] = PlaneBar2Stiffness( ncoor, Em, A )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
x1=ncoor(1);
y1=ncoor(2);
x2=ncoor(3);
y2=ncoor(4);

x21=(x2-x1);
y21=(y2-y1);

coeff=Em*A/sqrt(x21^2+y21^2)^3;

Ke=coeff*[x21*x21, x21*y21, -x21*x21, -x21*y21;
          y21*x21, y21*y21, -y21*x21, -y21*y21;
          -x21*x21, -x21*y21, x21*x21, x21*y21;
          -y21*x21, -y21*y21, y21*x21, y21*y21];



end

