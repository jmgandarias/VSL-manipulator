function [w1,w2,w3] = getVelocity(arduinoSerial_stepper,dxl_port_num, PROTOCOL_VERSION, ADD_PRESENT_VELOCITY)
    

% Get J2 velocity
w2 = read4ByteTxRx(dxl_port_num, PROTOCOL_VERSION, DXL1_ID, ADD_PRESENT_VELOCITY);

% Get J3 velocity
app.J3_present_velocity = read4ByteTxRx(dxl_port_num, PROTOCOL_VERSION, DXL2_ID, ADD_PRESENT_VELOCITY);
app.J3_array_velocity = [app.J3_array_velocity app.J3_present_velocity];

end