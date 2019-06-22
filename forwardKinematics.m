function X = forwardKinematics(Q)
% This function calculates the cartesian position (X(1),X(2),X(3)) in [mm] from the
% current joint position (q1,q2,q3) in [º]%
%   L1 - Length betweeen the stepper and the reference frame {1} 
%   L2 - Length between reference frames {1} and {2}
%   L3 - Length between reference frames {2} and {3}
%
%   AuX(1)iliar variables: T01,T12,T23,T03

% sX(2)ms q1 q2 q3 L1 L2 L3

global L1 L2 L3

theta1 = deg2rad(Q(1));
theta2 = deg2rad(Q(2));
theta3 = deg2rad(Q(3));
% 
% T01 = [cos(theta1)  0  sin(theta1)  0;...
%        sin(theta1)  0  -cos(theta1) 0;...
%        0        1   0       L1;...
%        0        0   0       1];
%    
% T12 = [cos(theta2)  -sin(theta2)  0  L2*cos(theta2);...
%        sin(theta2)  cos(theta2)   0  L2*sin(theta2);...
%        0        0         1  0;...
%        0        0         0  1];
%    
% T23 = [cos(theta3)  -sin(theta3)  0  L3*cos(theta3);...
%        sin(theta3)  cos(theta3)   0  L3*sin(theta3);...
%        0        0         1  0;...
%        0        0         0  1];
%    
%  
% T02 = T01*T12;
% T03 = T01*T12*T23;

T03 = [ cos(theta2 + theta3)*cos(theta1), -sin(theta2 + theta3)*cos(theta1),  sin(theta1), cos(theta1)*(L3*cos(theta2 + theta3) + L2*cos(theta2));...
        cos(theta2 + theta3)*sin(theta1), -sin(theta2 + theta3)*sin(theta1), -cos(theta1), sin(theta1)*(L3*cos(theta2 + theta3) + L2*cos(theta2));...
                sin(theta2 + theta3),          cos(theta2 + theta3),        0,      L1 + L3*sin(theta2 + theta3) + L2*sin(theta2);...
                           0,                     0,        0,                                      1];
        
                       
% I = eye(4);
% createFRAME(I,'k','0',30);
% createFRAME(T01,'r','1',30);
% createFRAME(T02,'g','2',30);
% createFRAME(T03,'b','3',30);
% hold on
% plot3([-500;500],[0;0],[0;0],'k','LineWidth',1);
% plot3([0;0],[-500;500],[0;0],'k','LineWidth',1);
% plot3([0;0],[0;0],[-500;500],'k','LineWidth',1);

% plot3([I(1,4);T01(1,4)],[I(2,4);T01(2,4)],[I(3,4);T01(3,4)],'r','LineWidth',3);
% plot3([T01(1,4);T02(1,4)],[T01(2,4);T02(2,4)],[T01(3,4);T02(3,4)],'g','LineWidth',3);
% plot3([T02(1,4);T03(1,4)],[T02(2,4);T03(2,4)],[T02(3,4);T03(3,4)],'*b','LineWidth',3);
% 
% grid on
% daspect([1 1 1]);
% axis([-500 500 -500 500 0 500]);
                   
X(1) = T03(1,4);
X(2) = T03(2,4);
X(3) = T03(3,4);

end