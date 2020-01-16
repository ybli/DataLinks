%function [cm, cSq] = DiscreteFrechetDist(A,B,dfcn)
function [cm] = DiscreteFrechetDist(A,B,dfcn)

[P,tA] = LoadData(A);
[Q,tB] = LoadData(B);
P=P';Q=Q';
plot(P)%绘制曲线P
plot(Q)%绘制曲线Q

sP = size(P);
sQ = size(Q);
 
% check validity of inputs
if sP(2)~=sQ(2)
    error('Curves P and Q must be of the same dimension')
elseif sP(1)==0
    cm = 0;
    return;
end
 
% initialize CA to a matrix of -1s
CA = ones(sP(1),sQ(1)).*-1;
 
% distance function
if nargin==2
    dfcn = @(u,v) sqrt(sum( (u-v).^2 )); %  @表示定义匿名函数
end
 
% final coupling measure value
cm = c(sP(1),sQ(1));
 
% obtain coupling measure via backtracking procedure
if nargout==2
    cSq = zeros(sQ(1)+sP(1)+1,2);    % coupling sequence
    CApad = [ones(1,sQ(1)+1)*inf; [ones(sP(1),1)*inf CA]];  % pad CA
    Pi=sP(1)+1; Qi=sQ(1)+1; count=1;  % counting variables
    while Pi~=2 || Qi~=2
        % step down CA gradient
        [v,ix] = min([CApad(Pi-1,Qi) CApad(Pi-1,Qi-1) CApad(Pi,Qi-1)]);
        if ix==1
            cSq(count,:) = [Pi-1 Qi];
            Pi=Pi-1;
        elseif ix==2
            cSq(count,:) = [Pi-1 Qi-1];
            Pi=Pi-1; Qi=Qi-1;
        elseif ix==3
            cSq(count,:) = [Pi Qi-1];
            Qi=Qi-1;
        end
        count=count+1;
    end
    % format output: remove extra zeroes, reverse order, subtract off
    % padding value, and add in the last point
    cSq = [flipud(cSq(1:find(cSq(:,1)==0,1,'first')-1,:))-1; sP(1) sQ(1)];
end
 
 
% debug
% assignin('base','CAw',CA)
 
function CAij = c(i,j)
    % coupling search function
    if CA(i,j)>-1
        % don't update CA in this case
        CAij = CA(i,j);
    elseif i==1 && j==1
        CA(i,j) = dfcn(P(1,:),Q(1,:));     % update the CA permanent
        CAij = CA(i,j);                    % set the current relevant value
    elseif i>1 && j==1
        CA(i,j) = max( c(i-1,1), dfcn(P(i,:),Q(1,:)) );
        CAij = CA(i,j);
    elseif i==1 && j>1
        CA(i,j) = max( c(1,j-1), dfcn(P(1,:),Q(j,:)) );
        CAij = CA(i,j);
    elseif i>1 && j>1
        CA(i,j) = max( min([c(i-1,j), c(i-1,j-1), c(i,j-1)]),...
            dfcn(P(i,:),Q(j,:)) );
        CAij = CA(i,j);
    else
        CA(i,j) = inf;
    end
end     % end function, c
 
end     % end main function