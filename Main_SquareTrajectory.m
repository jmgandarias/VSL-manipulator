
N_points = 10;
Initialization();

goto(X_0);

X = [x1,y1,z1;
    x2,y2,z2;
    x3,y3,z3;
    x4,y4,z4];

for i=1:4
    CartesianMove(X(i,:),N_points);
    Q_0 = getPosition();
    X_0 = forwardKinematics(Q_0);
end