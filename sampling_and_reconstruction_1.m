clc;
clear all;
mysinc = @(x) sin(pi*x)./(pi*x);
%Analog signal
Am=1;
fm=5;
t=0:0.001:1;
x= Am*sin(2*pi*fm*t);
sigma=0.2;
x_noise = x+sigma*randn(size(t));
figure;
subplot (2,1,1);
plot(t,x);
title("Original signal");
grid on;
subplot(2,1,2);
plot(t,x_noise);
title("Signal with noise");
grid on;
%%
%Nyquist criteria fs=2*fm
fs1= 6;
fs2=10;
fs3=14;
ts1 = 0:1/fs1:1;
x1= Am*sin(2*pi*fm*ts1)+ sigma*randn(size(ts1));
ts2 = 0:1/fs2:1;
x2= Am*sin(2*pi*fm*ts2)+ sigma*randn(size(ts2));
ts3 = 0:1/fs3:1;
x3= Am*sin(2*pi*fm*ts3)+ sigma*randn(size(ts3));
figure;
subplot(3,1,1);
stem(ts1,x1, "filled");
title("Undersampling");
grid on;

subplot(3,1,2);
stem(ts2,x2, "filled");
title("Nyquist criteria");
grid on;

subplot(3,1,3);
stem(ts3, x3, "filled");
title("Oversampling");
grid on;

%%
tr=t;
xr1= zeros(size(tr));
xr2= zeros(size(tr));
xr3= zeros(size(tr));
for i = 1:length(ts1)
    xr1 = xr1 + x1(i) * mysinc(fs1*(tr - ts1(i)));
end

for i = 1:length(ts2)
    xr2 = xr2 + x2(i) * mysinc(fs2*(tr - ts2(i)));
end

for i = 1:length(ts3)
    xr3 = xr3 + x3(i) * mysinc(fs3*(tr - ts3(i)));
end
%%
figure;
subplot(3,1,1);
plot(tr,x,'k',tr,xr1,'r', tr, x_noise, 'b');
title("Reconstruction from the undersampled signal");
legend("Original", "Reconstructed", "With the noise");
grid on;

subplot(3,1,2);
plot(tr,x,'k',tr,xr2,'r', tr, x_noise, 'b');
title("Reconstruction from the Nyquist signal", "With noise");
legend("Original", "Reconstructed");
grid on;

subplot(3,1,3);
plot(tr,x,'k',tr,xr3,'r', tr, x_noise, 'b');
title("Reconstruction from the oversampled signal");
legend("Original", "Reconstructed", "With noise");
grid on;


