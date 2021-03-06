%% Written by Ivan Camponogara 25/02/2018

clear all
clc

% Create an serial port object where you specify the USB port (look in
% Arduino->tools -> port) and the baud rate (9600)
ar = serial('/dev/cu.usbmodem1411','BaudRate',9600);

try
    fopen(ar);
catch err
    fclose(instrfind);
    error('Make sure you select the correct COM Port where the Arduino is connected.');
end
Tmax = 10; % Total time for data collection (s)
Ts = 0.01; % Sampling time (s), it correspond to 100Hz
i = 0;
data = 0;
t = 0;
tic % Start time
while toc <= Tmax
    i = i + 1;
   % Fill the data matrix with the data read from arduino
    data(i) = fscanf(ar,'%d');
    % If matlab read the data faster than the sampling rate set in arduino, force sampling to be the same as the
    % sampling time set in matpab code, If matlab is reading slower, nothing can be done.
    t(i) = toc;
    if i > 1
        T = toc - t(i-1);
        while T < Ts
            T = toc - t(i-1);
        end
    end
    t(i) = toc;
end


fclose(ar);