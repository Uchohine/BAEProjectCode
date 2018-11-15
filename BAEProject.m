
X   = load('Signal.dat');
X   = X(:)'; 
SNR = 0.0001;
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
Xd = awgn(X, SNR);
Yd = fft(Xd,n,dim);
P4 = abs(Yd/L);
P3 = P4(:,1:n/2+1);
P3(:,2:end-1) = 2*P3(:,2:end-1);
Xf = bandpass(Xd, [1490 1510], Fs) * L;
Yf = fft(Xf,n,dim);
P6 = abs(Yf/L);
P5 = P6(:,1:n/2+1);
P5(:,2:end-1) = 2*P5(:,2:end-1);
Xf2 = bandpass(Xd, [1990 2010], Fs) * L;
Yf2 = fft(Xf2,n,dim);
P8 = abs(Yf2/L);
P7 = P8(:,1:n/2+1);
P7(:,2:end-1) = 2*P7(:,2:end-1);
figure;
subplot (8, 1, 1), plot(t(1:L),X(1:L));
subplot (8, 1, 2), plot(0:(Fs/n):(Fs/2-Fs/n),P1(1:n/2));
xlabel('Original');
subplot (8, 1, 3), plot(t(1:L),Xd(1:L));
subplot (8, 1, 4), plot(0:(Fs/n):(Fs/2-Fs/n),P3(1:n/2));
xlabel('Distorted');
subplot (8, 1, 5), plot(t(1:L),Xf(1:L));
subplot (8, 1, 6), plot(0:(Fs/n):(Fs/2-Fs/n),P5(1:n/2));
xlabel('Filtered 1500 (bit 1)');
subplot (8, 1, 7), plot(t(1:L),Xf2(1:L));
subplot (8, 1, 8), plot(0:(Fs/n):(Fs/2-Fs/n),P7(1:n/2));
xlabel('Filtered 2000 (bit 0)');
