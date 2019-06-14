function [q1,q2,q3] = getPosition(arduino_stepper,dxl_port_num,PROTOCOL_VERSION,ADD_PRESENT_POSITION)
    % Get J1 angle
    q1 = str2double(fscanf(arduino_stepper));
    q1 = q1*360/3200;
    
    % Get J2 angle
    q2 = read4ByteTxRx(dxl_port_num, PROTOCOL_VERSION, DXL1_ID, ADD_PRESENT_POSITION);

    % Get J3 angle
    q3 = read4ByteTxRx(dxl_port_num, PROTOCOL_VERSION, DXL1_ID, ADD_PRESENT_POSITION);

end

