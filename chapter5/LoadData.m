function [ pos,t ] = LoadData( A )

%jsondata = loadjson('D:\Backup\Desktop\1614.txt');
jsondata = loadjson(A);
 
position = zeros(2,length(jsondata.Trajectory));
time = cell(2,length(jsondata.Trajectory));
for a = 1:length(jsondata.Trajectory)        
    position(1,a) = jsondata.Trajectory{1,a}.L.x;
    position(2,a) = jsondata.Trajectory{1,a}.L.y;
    DT = jsondata.Trajectory{1,a}.T;
    DT = strsplit(DT);
    time{1,a} = DT(1);
    time{2,a} = DT(2);
end        
     
pos = position; 
t = time;
                           
end
