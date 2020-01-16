A = 'D:\Backup\Desktop\0608.txt';
B = 'D:\Backup\Desktop\1211.txt';
C = 'D:\Backup\Desktop\1311.txt';
D = 'D:\Backup\Desktop\1319.txt';
E = 'D:\Backup\Desktop\1604.txt';
F = 'D:\Backup\Desktop\1614.txt';
G = 'D:\Backup\Desktop\1713.txt';
File = [A;B;C;D;E;F;G];
N = size(File,1);
%！！！！！！！！！！！！Calculate the PF distance
pos = zeros(N,N);fre = zeros(N,N);
for num1 = 1:N
    for num2 = num1:N
    [pos(num1,num2),fre(num1,num2)] = ComputeSim( File(num1,:), File(num2,:) );
    end
end
%Normalize
pos = pos/max(max(pos));
fre = fre/max(max(fre));
%disp(pos);
%disp(fre);
res = 0 *pos + 0.9 * fre;
res = res/max(max(res));
disp(res);
figure(1);
MyPlot(File,res,'PF distance');
%！！！！！！！！！！！！Calculate the DTW distance
dtw = zeros(N,N);
for num1 = 1:N
    for num2 = num1:N
    [dtw(num1,num2)] = DTW( File(num1,:), File(num2,:) );
    end
end
%Normalize
dtw = dtw/max(max(dtw));
disp(dtw);
figure(2);
MyPlot(File,dtw,'DTW distance');
%！！！！！！！！！！！！Calculate the CPD distance
cpd = zeros(N,N);
for num1 = 1:N
    for num2 = num1:N
    [cpd(num1,num2)] = CPD( File(num1,:), File(num2,:) );
    end
end
%Normalize
cpd = cpd/max(max(cpd));
disp(cpd);
figure(3);
MyPlot(File,cpd,'CPD distance');
%！！！！！！！！！！！！Calculate the SPD distance
spd = zeros(N,N);
for num1 = 1:N
    for num2 = num1:N
    [spd(num1,num2)] = SPD( File(num1,:), File(num2,:) );
    end
end
%Normalize
spd = spd/max(max(spd));
disp(spd);
figure(4);
MyPlot(File,spd,'SPD distance');
%！！！！！！！！！！！！Calculate the Frechet distance
frechet = zeros(N,N);
for num1 = 1:N
    for num2 = num1:N
    [frechet(num1,num2)] = DiscreteFrechetDist( File(num1,:), File(num2,:) );
    end
end
%Normalize
frechet = frechet/max(max(frechet));
disp(frechet);
figure(5);
MyPlot(File,frechet,'Frechet distance');
%！！！！！！！！！！！！Calculate the EDR distance
edr = zeros(N,N);
for num1 = 1:N
    for num2 = num1:N
    [edr(num1,num2)] = EDR( File(num1,:), File(num2,:) );
    end
end
%Normalize
edr = edr/max(max(edr));
disp(edr);
figure(6);
MyPlot(File,edr,'EDR distance');