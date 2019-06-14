function CartesianMove(X_f,N_points)
    Q_current = getPosition();
    X_current = forwardKinematics(Q_current);
    for i=1:N_points
        X_next = NextPosition(X_current,X_f,N_points-i-1);
        goto(X_next);
        Q_current=getPosition();
        X_current=forwardKinematics(Q_current);
    end

end