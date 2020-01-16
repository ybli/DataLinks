function [ distance,index ] = PointToSegDist( a, B )
index = -1;
minD = 9999;
Bsize = size(B);
% loop
for b = 1:Bsize(2)-1 
    P1 = B(:,b);
    P2 = B(:,b+1);    
    x1 = P1(1,1);y1 = P1(2,1);
    x2 = P2(1,1);y2 = P2(2,1);
    x = a(1,1);y = a(2,1);
    % Calculate the Point To Segment Distance
    cross = (x2 - x1) * (x - x1) + (y2 - y1) * (y - y1);
    d2 = (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1);    
    if cross <= 0
        D = sqrt((x - x1) * (x - x1) + (y - y1) * (y - y1));
        tempIndex = b;
    else
        if cross >= d2
            D = sqrt((x - x2) * (x - x2) + (y - y2) * (y - y2));
            tempIndex = b+1;
        else
            r = cross/d2;
            px = x1 + (x2 - x1) * r;
            py = y1 + (y2 - y1) * r;
            D = sqrt((x - px) * (x - px) + (py - y) * (py - y));
            tempIndex = b+0.5;
        end
    end    
    % Get the Minimun Value
    if D < minD
        minD = D;
        index = tempIndex;
    end
end

distance = minD;
end