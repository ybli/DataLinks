function [ mhd ] = ModHausdorffDist( A, B )

% Compute the sizes of the input point sets
Asize = size(A);
Bsize = size(B);
% Compute the length of the input point sets
[LA,LSegA] = GetLength(A);
[LB,LSegB] = GetLength(B);
% Check if the points have the same dimensions
%if Asize(2) ~= Bsize(2)
    %error('The dimensions of points in the two sets are not equal');
%end
% Calculating the forward HD
fhd = 0;                    % Initialize forward distance to 0
for a = 1:Asize(2)          % Travel the set A to find avg of d(A,B)  
    [tempdist,i] = PointToSegDist(A(:,a),B);  
    if rem(i,1)==0
        weight = 0.5*(LSegA(i)+LSegA(i+1));
    else
        weight = LSegA(i+0.5);
    end
    fhd = fhd + tempdist * weight;    % Sum the forward distances
end
fhd = fhd/LA;         % Divide by the total no to get average
% Calculating the reverse HD
rhd = 0;                    % Initialize reverse distance to 0
for b = 1:Bsize(2)          % Travel the set B to find avg of d(B,A)        
    [tempdist,i] = PointToSegDist(B(:,b),A);
    if rem(i,1)==0
        weight = 0.5*(LSegB(i)+LSegB(i+1));
    else
        weight = LSegB(i+0.5);
    end
    rhd = rhd + tempdist * weight;    % Sum the reverse distances
end
rhd = rhd/LB;         % Divide by the total no. to get average

mhd = max(fhd,rhd);         % Find the maximun of fhd/rhd as 
                            % the mod hausdorff dist
end

function [ L , LSeg ] = GetLength( A )
SizeA = size(A);
L = 0;
LSeg = zeros(SizeA(2)+1);
StartP = A(:,1);
for a = 2:SizeA(2)    
    EndP = A(:,a);
    tempL = sqrt( (StartP(1)-EndP(1))*(StartP(1)-EndP(1)) +  (StartP(2)-EndP(2))*(StartP(2)-EndP(2)) );
    LSeg(a) = tempL;
    L = L + tempL;
    StartP = EndP;
end
end
