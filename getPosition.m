function Q = getPosition()
    global arduinoSerial_stepper dxl_port_num PROTOCOL_VERSION DXL1_ID DXL2_ID...
        ADD_PRESENT_POSITION

    % Get J1 angle
    flushinput(arduinoSerial_stepper); 
    q1 = str2double(fscanf(arduinoSerial_stepper));
    Q(1) = q1*360/3200;
    
    % Get J2 angle
    q2 = read4ByteTxRx(dxl_port_num, PROTOCOL_VERSION, DXL1_ID, ADD_PRESENT_POSITION);
    Q(2) = (q2-1024)*360/4096; 

    % Get J3 angle
    q3 = read4ByteTxRx(dxl_port_num, PROTOCOL_VERSION, DXL2_ID, ADD_PRESENT_POSITION);
    Q(3) = (q3-2048)*360/4096; 
end

