function [Q_goal,W_goal] = MoveL(X_goal)
    global linear_vel
    Q_current = getPosition();
    X_current = forwardKinematics(Q_current);
    V = linear_vel*(X_goal-X_current)/norm(X_goal-X_current);
    W_goal = jacob(Q_current)\V';
    Q_goal = inverseKinematics(X_goal);
    dif = Q_goal-Q_current;
    for i=1:length(dif)
        if dif(i)<3
            Q_goal(i) = Q_current(i);
        end
    end
end