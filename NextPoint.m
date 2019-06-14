function X_next = NextPoint(X_1,X_2,n)
    X_next = zeros(1,3);
    for i=1:3
        s = (X_2(i)-X_1(i))/n;
        X_next(i) = X_1(i)+s;
    end
end