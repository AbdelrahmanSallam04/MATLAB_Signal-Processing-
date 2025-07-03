fs = 20000; % Sampling frequency in Hz
ts = 1/fs; % Sampling period
t = 0:ts:10;


% Step 1: Signal generation
% 1 Frequencies
f1 = 500;
f2 = 1000;
f3 = 1500;
f4 = 2000;

x = cos(2 * pi * f1 * t) + cos(2 * pi * f2 * t) + cos(2 * pi * f3 * t) + cos(2 * pi * f4 * t);

% Step 2: Store the signal as an audio file
audiowrite('x_signal.wav', x, fs);
disp('Audio file saved as x_signal.wav');

% Step 3: Plot the signal
figure;
plot(t(1:100), x(1:100)); % Plot the signal
xlabel('Time (s)');
ylabel('Amplitude');
title('Signal x(t)');
grid on;

% Step 4: % Calculate energy using summation
energy_sum = sum(abs(x).^2) / length(x);
disp(['Summation Energy of the signal: ', num2str(energy_sum)]);

% Step 5: Extract one period of the fundamental frequency
T_fundamental = 1 / f1; % Fundamental period (s)
num_samples = round(T_fundamental * fs); % Number of samples for one period
x_one_period = x(1:num_samples); % Signal for one period
t_one_period = t(1:num_samples); % Time vector for one period

% Step 6: Convert to frequency domain using FFT
Xf = fft(x_one_period);
X_shifted = fftshift(Xf) / num_samples; % Normalize and center FFT


% Frequency vector for centered spectrum
frequencies = (-num_samples/2 : num_samples/2 - 1) * (fs / num_samples);

% Plot the magnitude spectrum
figure;
stem(frequencies, abs(X_shifted), 'filled');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Spectrum of One Period (Centered)');
xlim([-fs / 2, fs / 2]);
grid on;

% Step 7: Calculate energy from the frequency spectrum
energy_frequency = sum(abs(X_shifted).^2);
disp(['Frequency-Domain Energy of the signal: ', num2str(energy_frequency)]);

% Step 8: Verify Parseval's theorem
parseval_difference = energy_sum - energy_frequency;
disp(['Difference between time-domain and frequency-domain energy: ', num2str(parseval_difference)]);


% Specifications
n = 20; % Filter order
fc = 1250; % Cutoff frequency in Hz

% Normalize the cutoff frequency
Wn = fc / (fs / 2);

% Design the Butterworth filter
[b, a] = butter(n, Wn, 'low');

% Compute frequency response
[H, W] = freqz(b, a, 1024, fs);


figure;
subplot(2, 1, 1);
plot(W, abs(H));
grid on;
title('Magnitude Response of Butterworth Low-Pass Filter');
xlabel('Frequency (Hz)');
ylabel('|H(f)|');

subplot(2, 1, 2);
plot(W, unwrap(angle(H)));
grid on;
title('Phase Response of Butterworth Low-Pass Filter');
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');

y1_t=filter(b,a,x);
audiowrite('y1_t_lowpass_filtered_signal.wav', y1_t, fs);

%step 12: plot y1_t
figure;
plot(t(1:200), y1_t(1:200)); % Plot the signal
xlabel('Time (s)');
ylabel('Amplitude');
title('Signal y_1(t) (Low-Pass Filtered)');
grid on;


% Step 13: Calculate energy of y1(t) using summation
energy_y1_sum = sum(abs(y1_t).^2)/length(y1_t);
disp(['Summation Energy of the filtered signal y_1(t): ', num2str(energy_y1_sum)]);

% Step 14: Extract one period of the fundamental frequency from y1(t)
T_fundamental_y1 = 1 / f1; % Fundamental period (s) remains the same
num_samples_y1 = round(T_fundamental_y1 * fs); % Number of samples for one period
y1_one_period = y1_t(10*num_samples_y1:11*num_samples_y1-1); % Extract one period of y1(t)
t_one_period_y1 = t(10*num_samples_y1:11*num_samples_y1-1); % Corresponding time vector

% Step 15: Convert y1(t) to the frequency domain using FFT
Yf = fft(y1_one_period);
Y_shifted = fftshift(Yf) / num_samples_y1; % Normalize and center FFT

% Frequency vector for the centered spectrum
frequencies_y1 = (-num_samples_y1/2 : num_samples_y1/2 - 1) * (fs / num_samples_y1);

% Plot the magnitude spectrum of y1(t)
figure;
stem(frequencies_y1, abs(Y_shifted), 'filled');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Spectrum of Filtered Signal y_1(t) (Centered)');
xlim([-fs / 2, fs / 2]);
grid on;

% Step 16: Calculate energy of y1(t) in the frequency domain
energy_y1_frequency = sum(abs(Y_shifted).^2); % Energy in the frequency domain
disp(['Frequency-Domain Energy of the filtered signal y1(t): ', num2str(energy_y1_frequency)]);

% Verify Parseval's theorem for y1(t)
parseval_difference_y1 = abs(energy_y1_sum - energy_y1_frequency);
disp(['Difference between time-domain and frequency-domain energy (y1): ', num2str(parseval_difference_y1)]);


% Step 17: Design Butterworth High-Pass Filter
[b, a] = butter(n, Wn, 'high');

% Compute frequency response of the filter
[H, W] = freqz(b, a, 1024, fs);

% Step 18: Plot the magnitude and phase response of the high-pass filter
figure;

% Magnitude response
subplot(2, 1, 1);
plot(W, abs(H));
title('Magnitude Response of Butterworth High-Pass Filter');
xlabel('Frequency (Hz)');
ylabel('|H(f)|');
grid on;

% Phase response
subplot(2, 1, 2);
plot(W, unwrap(angle(H)));
title('Phase Response of Butterworth High-Pass Filter');
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
grid on;

% Step 19: Apply Butterworth High-Pass Filter to x(t)
y2_t = filter(b, a, x);

% Step 20: store the signal y2_t as audio file 
audiowrite('y2_t_highpass_filtered_signal.wav', y2_t, fs);

% Step 21: Plot y2(t)
figure;
plot(t(1:200), y2_t(1:200));
xlabel('Time (s)');
ylabel('Amplitude');
title('Signal y_2(t) (High-Pass Filtered)');
grid on;

% Step 22: Calculate energy of y2(t) using summation
energy_y2_sum = sum(abs(y2_t).^2) /length(y2_t); % Energy of y2(t) in the time domain
disp(['Summation Energy of the high-pass filtered signal y_2(t): ', num2str(energy_y2_sum)]);


% Step 23: Compute the frequency spectrum Y2(f) of this signal.
T_fundamental_y2 = 1 / f1; % Fundamental period (s) remains the same
num_samples_y2 = round(T_fundamental_y2 * fs); % Number of samples for one period
y2_one_period = y2_t(10*num_samples_y2:11*num_samples_y2-1); % Extract one period of y2(t)
t_one_period_y2 = t(10*num_samples_y2:11*num_samples_y2-1); % Corresponding time vector

Y2f = fft(y2_one_period); % FFT of the one-period signal
Y2_shifted = fftshift(Y2f) / num_samples_y2; % Normalize and center FFT

% Frequency vector for the centered spectrum
frequencies_y2 = (-num_samples_y2/2 : num_samples_y2/2 - 1) * (fs / num_samples_y2);

% Step 24: Plot the magnitude spectrum of y2(t)
figure;
stem(frequencies_y2, abs(Y2_shifted), 'filled');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Spectrum of Filtered Signal y_2(t) (Centered)');
xlim([-fs / 2, fs / 2]);
grid on;

% Step 25: Calculate energy of y2(t) in the frequency domain
energy_y2_frequency = sum(abs(Y2_shifted).^2);
disp(['Frequency-Domain Energy of the high-pass filtered signal y2(t): ', num2str(energy_y2_frequency)]);

% Verify Parseval's theorem for y2(t)
parseval_difference_y2 = abs(energy_y2_sum - energy_y2_frequency);
disp(['Difference between time-domain and frequency-domain energy (y2): ', num2str(parseval_difference_y2)]);