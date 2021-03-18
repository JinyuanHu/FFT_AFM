clear
close all
a=xlsread('line2.xlsx');
t=a(:,1);
y=a(:,2);

nfft = length(y);
deltat = t(2)-t(1);
fs = 1/deltat;
f = 0:fs/nfft:fs-fs/nfft;
figure
subplot(211)

plot(t,y)
y = y-mean(y);
Y = abs(fft(y))/length(y);
subplot(212)
plot(f(1:nfft/2),Y(1:nfft/2))
xlabel('FFT');
%%  EMD
figure
[IMF, RESIDUAL] = emd(y);
IMF=IMF';
subplot(size(IMF,2)+1,1,1)
plot(t,y)
xlabel('original')
for i = 1:size(IMF,2)
    subplot(size(IMF,2)+1,1,i+1)
    plot(t,IMF(:,i))
    xlabel(['IMF',num2str(i)])
end

%% IMF and FFT
figure
for i = 1:size(IMF,2)
    subplot(size(IMF,2),2,2*i-1)
    plot(t,IMF(:,i))
    yy = IMF(:,i);
    Y = 2*abs(fft(yy))/length(yy);
    subplot(size(IMF,2),2,2*i)
    plot(f(1:nfft/2),Y(1:nfft/2))
end
    