function binarized_data = stepminer(data, isdisplay)
 
if ~exist('isdisplay')
    isdisplay  = 0;
end
 
binarized_data = zeros(1,length(data))+ NaN; 
 
[sorted_data,I] = sort(data,'ascend');
I(isnan(sorted_data))=[];
sorted_data(isnan(sorted_data))=[];
 
if isempty(sorted_data)
    return
end
 
%sorted_data = log2(sorted_data);
%%
 
for i=0:length(sorted_data)
    if i==0
        m1 = 0;
        m2 = mean(sorted_data);
        e = sorted_data - m2;
        %SSTOT = sum(e.^2);
    elseif i==length(sorted_data)
        m1 = mean(sorted_data);
        m2 = 0;
        e = sorted_data - m1;
    else
        m1 = mean(sorted_data(1:i));
        m2 = mean(sorted_data(i+1:end));
        e = [sorted_data(1:i)-m1,  sorted_data(i+1:end)-m2];
    end
    SSE(i+1) = sum((e).^2);
end
 
 
[~,t] = min(SSE);
t = t - 1;
 
if t == 0
    binarized_data(I) = ones(1,length(data));
elseif t==length(sorted_data)
    binarized_data(I) = zeros(1,length(data));
else
    binarized_data(I) = [zeros(1,t), ones(1,length(sorted_data)-t)];
end
 
 
if isdisplay==1
    hold off; 
    plot(data(I),'o')
    hold on;
    plot(binarized_data(I) * (mean(data(binarized_data==1))-mean(data(binarized_data==0))) + mean(data(binarized_data==0)))
end
