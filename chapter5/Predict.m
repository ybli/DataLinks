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
    for num2 = 1:N
    [pos(num1,num2),fre(num1,num2)] = ComputeSim( File(num1,:), File(num2,:) );
    end
end
%Normalize
pos = pos/max(max(pos));
fre = fre/max(max(fre));
res = 0.8 *pos + 0.2 * fre;
res = res/max(max(res));
disp(res);
figure(1);
%MyPlot(File,res,'PF distance');

%Reality
[R,tR] = LoadData(File(4,:));
%Current
[C,tR] = LoadData('D:\Backup\Desktop\1319-c.txt');
SR = size(R,2);SC = size(C,2);

[First,tR] = LoadData(File(2,:));index1=GetIndex(C(:,SC),First);
w1=res(4,2);w1=0;
[Second,tR] = LoadData(File(1,:));index2=GetIndex(C(:,SC),Second);
w2=res(4,1);
[Third,tR] = LoadData(File(3,:));index3=GetIndex(C(:,SC),Third);
w3=res(4,3);
s=w1+w2+w3;
w1=w1/s;w2=w2/s;w3=w3/s;

%Predict
P=zeros(2,5);P(:,1)=C(:,SC);
for num = 2:size(P,2)
    P(:,num)=w1*First(:,index1+num-1)+w2*Second(:,index2+num-1)+w3*Third(:,index3+num-1);
end
plot(C(1,:),C(2,:));
hold on;
plot(P(1,:),P(2,:),'r');
%figure(2);
plot(R(1,:),R(2,:),'--');

%Compute Residual
Residual = 0;
for num = 2:size(P,2)
    d = sqrt((P(1,num)-R(1,SC+num-1))*(P(1,num)-R(1,SC+num-1))+(P(2,num)-R(2,SC+num-1))*(P(2,num)-R(2,SC+num-1)));
    Residual = Residual + d;
end
Residual = Residual/(size(P,2)-1);
disp(Residual);