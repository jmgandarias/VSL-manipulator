function moveStepper(q1_goal)
    global arduinoSerial_stepper J1_velocity
    % calculate the direction and number of steps to go from the current position
    % to the goal position
    % Get the current position and convert it to number of degrees
    flushinput(arduinoSerial_stepper); 
    current_J1 = str2double(fscanf(arduinoSerial_stepper));
    n_degrees = q1_goal- current_J1*360/3200;
    
    % Get the direction
    if (n_degrees > 0)
        dir = 1;
    else
        dir = 0;
    end
    
    % Calculate the number of steps (integer)
    n_steps = uint16(abs(n_degrees*3200/360));      % 3200 steps per revolution
    
    % Send the number of steps, the diretion, and the velocity
    if n_steps ~= 0
        fprintf(arduinoSerial_stepper,mat2str([n_steps, dir, J1_velocity]));           

        % Check if the movement is carrying out
        moving = 0;
        while ~moving
            %Get the current position
            flushinput(arduinoSerial_stepper); 
            prev_J1 = str2double(fscanf(arduinoSerial_stepper));

            %Get the position 0.1secs later
            pause(0.1)  
            flushinput(arduinoSerial_stepper);
            current_J1 = str2double(fscanf(arduinoSerial_stepper));

            %If both are the same, send the desired position again
            if current_J1 == prev_J1
                fprintf(arduinoSerial_stepper,mat2str([n_steps, dir, J1_velocity]));
            else
                moving = 1;
            end
        end
    end
end