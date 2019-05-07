function current_position = moveStepper(n_steps,velocity,current_position,step_pin,arduino_object)
    for i=0:n_steps
        writeDigitalPin(arduino_object,step_pin,1); 
        pause(0);%10/velocity);
        writeDigitalPin(arduino_object,step_pin,0);  
        pause(0);%10/velocity); 
        assignin('base','i',i);
        current_position = current_position - 360/3200;  % 1 step = 0.1125º 
    end
end