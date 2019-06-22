function moveDxl(goal_pos)
    global DXL1_ID DXL2_ID dxl_port_num PROTOCOL_VERSION groupwrite_num LEN_GOAL_POSITION

   % Add Dynamixel#1 goal position value to the Syncwrite storage
    groupSyncWriteAddParam(groupwrite_num, DXL1_ID, typecast(int32(goal_pos(1)), 'uint32'), LEN_GOAL_POSITION);

    % Add Dynamixel#2 goal position value to the Syncwrite parameter storage
    groupSyncWriteAddParam(groupwrite_num, DXL2_ID, typecast(int32(goal_pos(2)), 'uint32'), LEN_GOAL_POSITION);

    % Syncwrite goal position
    groupSyncWriteTxPacket(groupwrite_num);
    getLastTxRxResult(dxl_port_num, PROTOCOL_VERSION);

    % Clear syncwrite parameter storage
    groupSyncWriteClearParam(groupwrite_num);

end