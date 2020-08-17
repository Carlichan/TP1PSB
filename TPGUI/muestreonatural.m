clearvars; close all; clc
fs= 1e6;
paso = 1/1e6;
t = 0:paso:1-paso;
square = zeros(1, length(t));
i =1;
dc = 50;
while i<length(t)*(dc/100)
    square(i) = 1;
    i = i+ cast(1/(fs*paso), 'uint32');
end   
% con = conv(square,signal1, 'same');
plot(t,square)