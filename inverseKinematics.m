function Q = inverseKinematics(X)
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

global L1 L2 L3 arm_config

% Calculate q1
Q(1) = rad2deg(atan2(X(2),X(1)));

% Calculate auxiliar variables
r1 = sqrt(X(1)^2+X(2)^2);
r2 = X(3)-L1;
phi2 = atan2(r2,r1);
r3 = sqrt(r1^2+r2^2);
phi1 = acos((r3^2+L2^2-L3^2)/(2*r3*L2));
phi3 = acos((L2^2+L3^2-r3^2)/(2*L2*L3));

% Calculate q2 and q3
Q(2) = rad2deg(phi2+arm_config*phi1);
Q(3) = rad2deg(pi+arm_config*phi3);

if Q(3)>180
    Q(3) = Q(3)-360;
end

% for i=1:3
%     if Q(i)>180
%         Q(i)=Q(i)-360;
%     end
% end

end