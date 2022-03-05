function [J] = Growing(I)
% 区域分割子函数
% 网上找到的对灰度图像的区域分割
if isinteger(I)
    I=im2double(I);
end
[~,n]=size(I);
if (n==3)
    I = rgb2gray(I);
end
f = figure;
imshow(I)
[M,N]=size(I);
[y,x]=getpts; %单击取点后，按enter结束
x1=round(x);
y1=round(y);
seed=I(x1,y1); %获取中心像素灰度值

J=zeros(M,N);
J(x1,y1)=1;

count=1; %待处理点个数
threshold=0.30;
while count>0
    count=0;
    for i=1:M %遍历整幅图像
    for j=1:N
        if J(i,j)==1 %点在“栈”内
        if (i-1)>1&(i+1)<M&(j-1)>1&(j+1)<N %3*3邻域在图像范围内
            for u=-1:1 %8-邻域生长
            for v=-1:1
                if J(i+u,j+v)==0&abs(I(i+u,j+v)-seed)<=threshold
                    J(i+u,j+v)=1;
                    count=count+1;  %记录此次新生长的点个数
                end
            end
            end
        end
        end
    end
    end
end
close(f);
end

