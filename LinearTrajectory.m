function reachable = LinearTrajectory(X_f)
    global N_points
    Q_current = getPosition();
    X_current = forwardKinematics(Q_current);
    a=[];
    for i=1:N_points
        X_next = NextPoint(X_current,X_f,N_points-i+1);
        [Q_next,reachable] = goto(X_next);
        if reachable
%             Q_current=getPosition();
%             X_current=forwardKinematics(Q_current);
% %             d_error = sqrt((X_next(1)-X_current(1))^2);
%             a = [a; X_current];
%             % While until the point is reached
%             while d_error>DIST_THRESHOLD
% %                 d_error = sqrt((X_next(1)-X_current(1))^2+(X_next(2)-X_current(2))^2+(X_next(3)-X_current(3))^2);
%                 d_error = sqrt((X_next(1)-X_current(1))^2);
%                 pause(0.01);
%             end
%             pause(2);
            Q_current=getPosition();
            X_current=forwardKinematics(Q_current);
            a = [a; X_current];
            assignin('base','X_next',X_next);
            assignin('base','X_current',X_current);
%             assignin('base','d_error',d_error);
        else
            break;
        end
    end
assignin('base','a',a);
end