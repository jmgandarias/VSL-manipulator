function MoveJ(Q)
    % Move to a certain position
    moveStepper(Q(1));
    moveDxl([Q(2)*4096/360 + 1024, Q(3)*4096/360 + 2048]);   
end
