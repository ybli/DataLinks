%Get the index of the point in Line L which is closest to point P
function [index] = GetIndex(P,L)
dmin=99999;
index=-1;
for n = 1:size(L,2)
    X=L(1,n);Y=L(2,n);
    d = sqrt((X-P(1,1))*(X-P(1,1))+(Y-P(2,1))*(Y-P(2,1))); 
    if d < dmin
        dmin = d;
        index = n;
    end
end
end