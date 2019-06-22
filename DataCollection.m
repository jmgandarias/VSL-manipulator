%%
n_loads = 5;
n_q1 = 10;
n_q2 = 10;
n_p1 = 5;
n_p2 = 5;
M=[];

q1_min=0;
q2_min=0;
p1_min=0;
p2_min=0;

r_q1=zeros(1,n_q1);
r_q2=zeros(1,n_q2);
r_p1=zeros(1,n_p1);
r_p2=zeros(1,n_p2);
for i=1:n_q1
    r_q1(i) = 10*(i-1)+ 5*rand(1);
end
for i=1:n_q2
    r_q2(i) = 10*(i-1)+5*rand(1);
end
for i=1:n_p1
    r_p1(i) = 0.5*(i-1)+0.25*rand(1);
end
for i=1:n_p2
    r_p2(i) = 0.5*(i-1)+0.25*rand(1);
end
%%

for l=1:n_loads
    L = input('Introduce the load:\n');
    Q(1) = q1_min;
    Q(2) = q2_min;
    P(1) = p1_min;
    P(2) = p2_min;
    for q1=1:n_q1
        Q(1) = r_q1(q1);
        for q2=1:n_q2
            Q(2) = r_q2(q2);
            for p1=1:n_p1
                P(1) = r_p1(p1);
                for p2=1:n_p2
                    P(2) = r_p2(p2);
%                         setPressure(P);
%                         MoveJ(Q);
%                         pause(1);
%                         M(q1,q2,p1,p2,q1,q2,l)=[getData(),L];
                     M=[M;Q(1),Q(2),P(1),P(2),Q(1),Q(2),L];
                end
            end
        end
    end
end



