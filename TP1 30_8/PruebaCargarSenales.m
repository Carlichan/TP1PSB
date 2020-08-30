load('señalDistintaFrec1.mat');
x = data.x;
fs = data.fs;
t = 0:1/fs:length(x)/fs-1/fs;
fsn = 100000;
tn = 0:1/fsn:length(x)/fs-1/fs;
xn = interp1(t,x,tn);
plot(t,x,tn,xn);
