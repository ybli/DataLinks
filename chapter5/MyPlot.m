function  MyPlot(File,res,t)
N=size(res,1);
for p=1:N
    for q=1:N
        if res(p,q)==0
            res(p,q)=9999;
        end
    end
end
index = find(res==min(min(res)),1);
i=ceil(index/N);
j=rem(index,N);
for n=1:size(File,1)
    [P,tA] = LoadData(File(n,:));
    Px = P(1,:);Py=P(2,:);
    if j==0
        j=7;
    end
    if n==i
        plot(Px,Py,'r')
    elseif n==j
        plot(Px,Py,'r')
    else
        plot(Px,Py,':')
    end
    hold on;
end
    hold off;
    title(t);
end