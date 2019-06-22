function [Q,reachable] = goto(X)
    %This script move the end-effector to a certain position X in joint
    %coordinates. First it calculates the angle 
    
    % Calculate Q
    Q = inverseKinematics(X);
    
    % Check if the 
    if (Q(1)>90 || Q(1)<-90 || Q(2)>205.3 || Q(2)<-25.3 || Q(3)>115.3 || Q(3)<-115.3)
        reachable = 0;
    else
        reachable = 1;
        MoveJ(Q); 
    end
end