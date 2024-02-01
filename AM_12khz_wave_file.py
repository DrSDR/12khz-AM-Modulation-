import numpy as np
from scipy.io import wavfile
from scipy.signal import fir_filter_design as ffd
from scipy.signal import lfilter, resample
import fractions

# read in audio signal, audio file needs to have 48khz sample rate!!!!
# wave file needs to be mono, not 2 ch stereo  
aFs , asig = wavfile.read('c:/temp/audiosignal.wav')

asig = asig.astype(np.float64)
asig = asig / np.max(asig)



# audio low pass filter, fc = 5khz
fs = 48000
fc = 5000
fc = fc / (fs / 2)
N = 1023
hlpf = ffd.firwin(N, fc)



asig = asig.T
asig = asig / np.max(asig)

asig = lfilter(hlpf, 1, asig)
N = len(asig)
t = np.arange(1, N + 1) / fs
amsig = (1 + 1.2 * asig) * np.cos(2 * np.pi * 12000 * t)
amsig = amsig / np.max(amsig)
amsigwave = amsig.T

wavfile.write('c:/temp/AMSignal_12khz.wav', fs, amsigwave.astype(np.float32))

