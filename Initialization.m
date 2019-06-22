%% DECLARE GLOBAL VARIABLES

global L1 L2 L3 bIni arm_config lib_name PROTOCOL_VERSION DXL1_ID DXL2_ID...
    BAUDRATE DEVICENAME TORQUE_ENABLE TORQUE_DISABLE DXL_MINIMUM_POSITION_VALUE ...
    DXL_MAXIMUM_POSITION_VALUE DXL_MOVING_STATUS_THRESHOLD DXL_MINIMUM_PWM_VALUE...
    DXL_MAXIMUM_PWM_VALUE COMM_SUCCESS COMM_TX_FAIL ADD_OPERATING_MODE ADD_MOVING_THRESHOLD...
    ADD_TEMPERATURE_LIMIT ADD_MAX_VOLTAGE_LIMIT ADD_MIN_VOLTAGE_LIMIT ADD_PWM_LIMIT...
    ADD_CURRENT_LIMIT ADD_VELOCITY_LIMIT ADD_MAX_POSITION_LIMIT ADD_MIN_POSITION_LIMIT...
    ADD_TORQUE_ENABLE ADD_LED ADD_VELOCITY_I_GAIN ADD_VELOCITY_P_GAIN ADD_POSITION_D_GAIN...
    ADD_POSITION_I_GAIN ADD_POSITION_P_GAIN ADD_FEEDFORWARD_2ND_GAIN ADD_FEEDFORWARD_1ST_GAIN...
    ADD_GOAL_PWM ADD_GOAL_CURRENT ADD_GOAL_VELOCITY ADD_PROFILE_ACCELERATION...
    ADD_PROFILE_VELOCITY ADD_GOAL_POSITION ADD_REALTIME_TICK ADD_MOVING ADD_PRESENT_PWM...
    ADD_PRESENT_CURRENT ADD_PRESENT_VELOCITY ADD_PRESENT_POSITION ADD_PRESENT_TEMPERATURE...
    LEN_GOAL_POSITION LEN_PRESENT_POSITION groupwrite_num groupread_num dxl_comm_result...
    dxl_addparam_result dxl_getdata_result dxl1_goal_position dxl2_goal_position... 
    dxl_error  dxl1_present_position dxl2_present_position arduinoSerial_pressure...
    arduinoSerial_stepper DXLPort dxl_port_num PressurePort StepperPort DIST_THRESHOLD...
    N_points linear_vel PROFILE_ACC PROFILE_VEL DXL_MAXIMUM_VEL_VALUE

%% ROBOT PARAMETERS %%
L1 = 79.9;                  % Distance from the base to the first joint
L2 = 255.5;                 % Distance from the first to the second joint
L3 = 209.5;                 % Distance from the second joint to the end-effector
arm_config = 1;             % Set elbow down (-1) or elbow up (1)
DIST_THRESHOLD = 6;         % Distance threshold until considere that a movement is completed
N_points = 200;             % Number of points for the trajectory
linear_vel = 0.04;          % Linear velocity of the end-effector when moving in a linear trajectory

%% DYNAMIXEL %%
lib_name = 'dxl_x64_c';

%% ARDUINO %%
% Protocol version
PROTOCOL_VERSION            = 2.0;          % See which protocol version is used in the Dynamixel

% DEFAULT SETTING
DXL1_ID                     = 1;            % Dynamixel#1 ID: 1
DXL2_ID                     = 2;            % Dynamixel#2 ID: 2
BAUDRATE                    = 1000000;

TORQUE_ENABLE               = 1;            % Value for enabling the torque
TORQUE_DISABLE              = 0;            % Value for disabling the torque
DXL_MINIMUM_POSITION_VALUE  = 736;          % minimum position limit
DXL_MAXIMUM_POSITION_VALUE  = 3360;         % maximum position limit
DXL_MOVING_STATUS_THRESHOLD = 20;           % Dynamixel moving status threshold
DXL_MINIMUM_PWM_VALUE  = 0;                 % minimum pwm limit
DXL_MAXIMUM_PWM_VALUE  = 885;               % maximum pwm limit
DXL_MAXIMUM_VEL_VALUE = 4.8171;             % maximum velocity [rad/s]

COMM_SUCCESS                = 0;            % Communication Success result value
COMM_TX_FAIL                = -1001;        % Communication Tx Failed


%% EEPROM CONTROL TABLE %%
ADD_OPERATING_MODE = 11;
ADD_MOVING_THRESHOLD = 24;
ADD_TEMPERATURE_LIMIT = 31;
ADD_MAX_VOLTAGE_LIMIT = 32;
ADD_MIN_VOLTAGE_LIMIT = 34;
ADD_PWM_LIMIT = 36;
ADD_CURRENT_LIMIT = 38;
ADD_VELOCITY_LIMIT = 44;
ADD_MAX_POSITION_LIMIT = 48;
ADD_MIN_POSITION_LIMIT = 52;

%% RAM CONTROL TABLE %%
ADD_TORQUE_ENABLE = 64;
ADD_LED = 65;
ADD_VELOCITY_I_GAIN = 76;
ADD_VELOCITY_P_GAIN = 78;
ADD_POSITION_D_GAIN = 80;
ADD_POSITION_I_GAIN = 82;
ADD_POSITION_P_GAIN = 84;
ADD_FEEDFORWARD_2ND_GAIN = 88;
ADD_FEEDFORWARD_1ST_GAIN = 90;
ADD_GOAL_PWM = 100;
ADD_GOAL_CURRENT = 102;
ADD_GOAL_VELOCITY = 104;
ADD_PROFILE_ACCELERATION = 108;
ADD_PROFILE_VELOCITY = 112;
ADD_GOAL_POSITION = 116;
ADD_REALTIME_TICK = 120;
ADD_MOVING = 122;
ADD_PRESENT_PWM = 124;
ADD_PRESENT_CURRENT = 126;
ADD_PRESENT_VELOCITY = 128;
ADD_PRESENT_POSITION = 132;
ADD_PRESENT_TEMPERATURE = 146;

%%
% Velocity and Position trajectory
PROFILE_ACC = 280;
PROFILE_VEL = 350;

% Byte length
LEN_GOAL_POSITION       = 4;
LEN_PRESENT_POSITION    = 4;

%%
% If the robot hasn't been intialized
if ~bIni
    % Load library
    if ~libisloaded(lib_name)
        [notfound, warnings] = loadlibrary(lib_name, 'dynamixel_sdk.h', 'addheader', 'port_handler.h', 'addheader', 'packet_handler.h', 'addheader', 'group_sync_write.h', 'addheader', 'group_sync_read.h');
        assignin('base', 'errors_library', [notfound warnings]);
    end

    % Load Control table
    BAUDRATE = 3000000;
    DEVICENAME =  DXLPort;

    % Get methods and members of PortHandlerLinux or PortHandlerWindows
    dxl_port_num = portHandler(DEVICENAME);

    % Initialize PacketHandler Structs
    packetHandler();

    % Initialize Groupsyncwrite Structs
    groupwrite_num = groupSyncWrite(dxl_port_num, PROTOCOL_VERSION, ADD_GOAL_POSITION, LEN_GOAL_POSITION);

    % Initialize Groupsyncread Structs for Present Position
    groupread_num = groupSyncRead(dxl_port_num, PROTOCOL_VERSION, ADD_PRESENT_POSITION, LEN_PRESENT_POSITION);

    dxl_comm_result = COMM_TX_FAIL;           % Communication result
    dxl_addparam_result = false;                  % AddParam result
    dxl_getdata_result = false;                   % GetParam result
    dxl1_goal_position = (DXL_MAXIMUM_POSITION_VALUE+DXL_MINIMUM_POSITION_VALUE)/2;         % Initial position
    dxl2_goal_position = dxl1_goal_position;

    dxl_error = 0;                              % Dynamixel error
    dxl1_present_position = 0;                  % Present position
    dxl2_present_position = 0;


    % Open port
    if (openPort(dxl_port_num))
        fprintf('Succeeded to open DXL port\n');
    else
        unloadlibrary(lib_name);
        fprintf('Failed to open DXL port\n');
    end

    % Set port baudrate
    if (setBaudRate(dxl_port_num, BAUDRATE))
        fprintf('Succeeded to set the baudrate\n');
    else
        unloadlibrary(lib_name);
        fprintf('Failed to set the baudrate\n');
    end
    
    % Change acceleration and velocity profiles
    write4ByteTxRx(dxl_port_num, PROTOCOL_VERSION, DXL1_ID, ADD_PROFILE_ACCELERATION, PROFILE_ACC);
    write4ByteTxRx(dxl_port_num, PROTOCOL_VERSION, DXL1_ID, ADD_PROFILE_VELOCITY, PROFILE_VEL);
    write4ByteTxRx(dxl_port_num, PROTOCOL_VERSION, DXL2_ID, ADD_PROFILE_ACCELERATION, PROFILE_ACC);
    write4ByteTxRx(dxl_port_num, PROTOCOL_VERSION, DXL2_ID, ADD_PROFILE_VELOCITY, PROFILE_VEL);
    
    
    % Create the arduino pressure serial
    arduinoSerial_pressure  = serial(PressurePort);
    arduinoSerial_pressure.BaudRate = 115200;
%     fopen(arduinoSerial_pressure);



    % Create the arduino serial for the stepper motor                
    arduinoSerial_stepper = serial(StepperPort);
    arduinoSerial_stepper.BaudRate = 115200;
    fopen(arduinoSerial_stepper);  
    
    % Update initialization state
    bIni = 1;
    fprintf('System Ready\n');
end

