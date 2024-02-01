% script makes an am signal at 12khz carrier 
% output is a wave file 
% made by Thegmr140 on youtube  


close all
clear all


% read in audio signal 
[asig, aFs]  = audioread('c:\temp\audiosignal.wav');



%audio low pass filter, fc = 5khz 
fs = 48e3;
fc = 5e3;
fc = fc / (fs/2);
N = 1023;
hlpf = fir1(N,fc);


% get audio signal to 48khz sample rate 
if aFs ~= fs
    a = gcd(fs,aFs);
    p = fs / a;
    q = aFs / a;
    asig = resample(asig,p,q);
end


[nS,nch] = size(asig);


if nch == 2
    asig = asig(:,1) + asig(:,2);
    asig = asig.';
    asig = asig / max(asig);
else
    asig = asig(:,1);
    asig = asig.';
    asig = asig / max(asig);
end



asig = filter(hlpf,1,asig);



N = length(asig);
t = [1:N]/fs;
amsig = [1 + 1.2*asig] .* cos(2*pi*12e3*t);
amsig = amsig / max(amsig);




amsigwave = [    (amsig).'   ];         %  
audiowrite('c:\temp\AMSignal_12khz.wav' , amsigwave,  fs);















    
    
    
    
    
    
    








