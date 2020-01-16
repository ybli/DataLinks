function [ posSim,freSim ] = ComputeSim( A, B )
%sim = 0;

[posA,tA] = LoadData(A);
[posB,tB] = LoadData(B);

posSim = ModHausdorffDist( posA, posB );
freSim = ComputeFrequencyDist( posA, posB );

%sim = posSim + freSim;
                            
end
