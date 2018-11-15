
X   = load('Signal.dat');
X   = X(:)'; 
SNR = 0.00001;
Fs = X(end); % Sampling frequency (samples per second) 
X(end)=[];
T = 1/Fs; % seconds per sample 
StopTime = T * length(X) - 1; % seconds 
L = length(X);                     % Length of signal
t = (0:L-1)*T;
n = 2^nextpow2(L);
dim = 2;
Y = fft(X,n,dim);
P2 = abs(Y/L);
P1 = P2(:,1:n/2+1);
P1(:,2:end-1) = 2*P1(:,2:end-1);
Xd = awgn(X, SNR, 'measured');
Yd = fft(Xd,n,dim);
P4 = abs(Yd/L);
P3 = P4(:,1:n/2+1);
P3(:,2:end-1) = 2*P3(:,2:end-1);
%filter start
filter500BMCoe = load('filter500BM.dat');
filter1500BMCoe = load('filter1500BM.dat');
filter2500BMCoe = load('filter2500BM.dat');
filter3500BMCoe = load('filter3500BM.dat');
filter500BM = dfilt.dfsymfir(filter500BMCoe);
fvtool(filter500BM);
filter1500BM = dfilt.dfsymfir(filter1500BMCoe);
fvtool(filter1500BM);
filter2500BM = dfilt.dfsymfir(filter2500BMCoe);
fvtool(filter2500BM);
filter3500BM = dfilt.dfsymfir(filter3500BMCoe);
fvtool(filter3500BM);
%1500Hz bandpass filter
Xf = filter(filter1500BM, Xd);
Yf = fft(Xf,n,dim);
P6 = abs(Yf/L);
P5 = P6(:,1:n/2+1);
P5(:,2:end-1) = 2*P5(:,2:end-1);
%500Hz bandpass filter
Xf2 = filter(filter500BM, Xd);
Yf2 = fft(Xf2,n,dim);
P8 = abs(Yf2/L);
P7 = P8(:,1:n/2+1);
P7(:,2:end-1) = 2*P7(:,2:end-1);
%2500Hz bandpass filter
Xf3 = filter(filter2500BM, Xd);
Yf3 = fft(Xf3,n,dim);
P10 = abs(Yf3/L);
P9 = P10(:,1:n/2+1);
P9(:,2:end-1) = 2*P9(:,2:end-1);
%3500Hz bandpass filter
Xf4 = filter(filter3500BM, Xd);
Yf4 = fft(Xf4,n,dim);
P12 = abs(Yf4/L);
P11 = P12(:,1:n/2+1);
P11(:,2:end-1) = 2*P11(:,2:end-1);
%plot 
figure;
subplot (12, 1, 1), plot(t(1:L),X(1:L));
subplot (12, 1, 2), plot(0:(Fs/n):(Fs/2-Fs/n),P1(1:n/2));
xlabel('Original');
subplot (12, 1, 3), plot(t(1:L),Xd(1:L));
subplot (12, 1, 4), plot(0:(Fs/n):(Fs/2-Fs/n),P3(1:n/2));
xlabel('Distorted');
subplot (12, 1, 5), plot(t(1:L),Xf2(1:L));
subplot (12, 1, 6), plot(0:(Fs/n):(Fs/2-Fs/n),P7(1:n/2));
xlabel('Filtered 500 (bit 00)');
subplot (12, 1, 7), plot(t(1:L),Xf(1:L));
subplot (12, 1, 8), plot(0:(Fs/n):(Fs/2-Fs/n),P5(1:n/2));
xlabel('Filtered 1500 (bit 01)');
subplot (12, 1, 9), plot(t(1:L),Xf3(1:L));
subplot (12, 1, 10), plot(0:(Fs/n):(Fs/2-Fs/n),P9(1:n/2));
xlabel('Filtered 2500 (bit 10)');
subplot (12, 1, 11), plot(t(1:L),Xf4(1:L));
subplot (12, 1, 12), plot(0:(Fs/n):(Fs/2-Fs/n),P11(1:n/2));
xlabel('Filtered 3500 (bit 11)');
