function setPWM(dxl_ID, dxl_PWM)
    global dxl_port_num PROTOCOL_VERSION ADD_GOAL_PWM
    % Set PWM
    write2ByteTxRx(dxl_port_num, PROTOCOL_VERSION, dxl_ID, ADD_GOAL_PWM, typecast(int32(dxl_PWM), 'uint32'));
    getLastTxRxResult(dxl_port_num, PROTOCOL_VERSION);
    getLastRxPacketError(dxl_port_num, PROTOCOL_VERSION);
    
end