format compact
clc; clear;%#ok<*NO4LP>

n= 10;
x;
y;
xmin=-1;
xmax=1;

x=xmin+rand(1,n)*(xmax-xmin);

ymin=-1;
ymax=1;

x=ymin+rand(1,n)*(ymax-ymin);

for i = 1:n
    x(i) = rand;
    y(i) = rand;
end

plot(x,y)