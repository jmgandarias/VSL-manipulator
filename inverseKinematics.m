function [q1,q2,q3] = inverseKinematics(x,y,z,L1,L2,L3,m)
% This function calculates the joint position (q1,q2,q3) angles in [º] from
% a desired cartesian position (x,y,z) in [mm]
%
%   L1 - Length betweeen the stepper and the reference frame {1} 
%   L2 - Length between reference frames {1} and {2}
%   L3 - Length between reference frames {2} and {3}
%
%   m=1 -> elbow up     m=-1 -> elbow down
%
%   Auxiliar variables: r1,r2,r3,phi1,phi2,phi3

% Calculate q1
q1 = rad2deg(atan2(y,x));

% Calculate auxiliar variables
r1 = sqrt(x^2+y^2);
r2 = z-L1;
phi2 = atan2(r2,r1);
r3 = sqrt(r1^2+r2^2);
phi1 = acos((r3^2+L2^2-L3^2)/(2*r3*L2));
phi3 = acos((L2^2+L3^2-r3^2)/(2*L2*L3));

% Calculate q2 and q3
q2 = rad2deg(phi2+m*phi1);
q3 = rad2deg(pi+m*phi3);

end