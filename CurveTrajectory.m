function CurveTrajectory_v2(X_f)
    global N_points linear_vel DXL_MAXIMUM_PWM_VALUE DXL_MAXIMUM_VEL_VALUE...
        DXL1_ID DXL2_ID
    
    X_0 = forwardKinematics(getPosition());
    %%
    V = linear_vel*[1;1;1];
    t_w = norm(X_f-X_0)/(N_points*linear_vel*100);
    Q = zeros(N_points+1,3);
    TAU = zeros(N_points+1,3);
    TAU_min = 200;
    X_i=X_0;
    Q(1,:) = X_i;
    for k=1:N_points
        X_next = NextPoint(X_i,X_f,N_points-k+1);
        Q(k+1,:) = inverseKinematics(X_next);
        J = jacob(deg2rad(Q(k+1,:)));  
        W = J\V;
        TAU(k+1,:) = abs(DXL_MAXIMUM_PWM_VALUE/DXL_MAXIMUM_VEL_VALUE*W')+TAU_min;
        if abs(det(J))<0.001
            disp('Singular point avoided');
            Q(k+1,:) = Q(k,:);
            TAU(k+1,:) = TAU(k,:);
        end
        X_i = X_next;
    end

    %%
    t=0;
    tic;
    for k=1:N_points
        setPWM(DXL1_ID,TAU(k+1,2));
        setPWM(DXL2_ID,TAU(k+1,3));
        MoveJ(Q(k+1,:));
        t=toc-t;
        t_w = t_w-t;
        pause(t_w);
    end    
end