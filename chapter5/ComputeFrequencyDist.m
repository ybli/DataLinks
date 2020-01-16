function [ fs ] = ComputeFrequencyDist( A, B )
%Set the window size parameter K
K = 1;

Asize = size(A);
Bsize = size(B);
LSegA = GetLength(A);
LSegB = GetLength(B);
%Calculate the average frequency
fA = 0;
for a = 2:Asize(2)-1  
    up = LSegA(a)+LSegA(a+1);
    down = GetDis(A(:,a-1),A(:,a+1));
    fA = fA + up/down;
end
fA=fA/(Asize(2)-2*K);
%Calculate the average frequency
fB = 0;
for a = 2:Bsize(2)-1  
    up = LSegB(a)+LSegB(a+1);
    down = GetDis(B(:,a-1),B(:,a+1));
    fB = fB + up/down;
end
fB=fB/(Bsize(2)-2*K);

fs = abs(fA-fB);
end

function [dis] = GetDis(a,b)
x1=a(1);y1=a(2);
x2=b(1);y2=b(2);
dis = sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2));
end

function [ LSeg ] = GetLength( A )
SizeA = size(A);
LSeg = zeros(SizeA(2)+1);
StartP = A(:,1);
for a = 2:SizeA(2)    
    EndP = A(:,a);
    tempL = GetDis(StartP,EndP);
    LSeg(a) = tempL;
    StartP = EndP;
end
end