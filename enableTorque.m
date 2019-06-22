function enableTorque(dxl_ID)
    global dxl_port_num PROTOCOL_VERSION ADD_TORQUE_ENABLE TORQUE_ENABLE COMM_SUCCESS...

    % Enable Dynamixel#1 Torque
    write1ByteTxRx(dxl_port_num, PROTOCOL_VERSION, dxl_ID, ADD_TORQUE_ENABLE, TORQUE_ENABLE);
    dxl_comm_result = getLastTxRxResult(dxl_port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(dxl_port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    else
        fprintf('Dynamixel #%d has been successfully connected \n', dxl_ID);
    end
end