function [Q,status] = goto(X)
    %This script move the end-effector to a certain position X in joint
    %coordinates. First it calculates the angle 
    
    %
    Q = inverseKinematics(X);
    
    if (Q(1)>180 || Q(1)<-180 || Q(2)>115.3 || Q(2)<-115.3 || Q(3)>115.3 || Q(3)<-115.3)
        status = 'Position not reachable';
    else
        status = 'Moving...';
        MoveJ1(Q(1));
        MoveJ2(Q(2));
        MoveJ3(Q(3));
    end
end