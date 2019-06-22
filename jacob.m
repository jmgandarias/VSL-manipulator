function J = jacob(Q)
    global L2 L3
    Q = deg2rad(Q);
    
    J = [-sin(Q(1))*(L3*cos(Q(2)+Q(3))+L2*cos(Q(2))), -cos(Q(1))*(L3*sin(Q(2)+Q(3))+L2*sin(Q(2))), -L3*cos(Q(1))*sin(Q(2)+Q(3));...
        cos(Q(1))*(L3*cos(Q(2)+Q(3))+L2*cos(Q(2))), sin(Q(1))*(L3*sin(Q(2)+Q(3))+L2*sin(Q(2))), -L3*sin(Q(1))*cos(Q(2)+Q(3));...
        0, L3*cos(Q(2)+Q(3))+L2*cos(Q(2)), L3*cos(Q(2)+Q(3))];                 
end