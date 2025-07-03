## 🧠 Project Summary

This MATLAB-based project simulates a multi-sinusoidal signal, applies signal processing techniques, and explores both time and frequency domain analysis using FFT. The project also includes the design and application of **Butterworth Low-Pass** and **High-Pass Filters**, energy calculations, and Parseval’s theorem verification.

---

## ⚙️ Key Features & Steps

### 🎵 Signal Generation
- Multi-tone signal composed of four cosine waves at 500 Hz, 1000 Hz, 1500 Hz, and 2000 Hz.
- Sampling frequency set to 20 kHz.

### 💾 Saving and Plotting
- Signal saved as `.wav` file.
- First 100 samples plotted for visualization.

### ⚡ Energy Calculation
- Energy computed in both time and frequency domains.
- Parseval’s theorem verified.

### 🔍 Frequency Analysis
- Fast Fourier Transform (FFT) used to analyze signal components.
- Frequency spectra visualized using stem plots.

### 🧰 Filter Design and Application
- **Butterworth Low-Pass Filter** (cutoff 1250 Hz, order 20)
- **Butterworth High-Pass Filter** (same parameters)
- Filter responses plotted (magnitude & phase)
- Filtered signals saved as audio files

### 📊 Comparative Analysis
- Filtered signals' energy and spectra calculated.
- Time-domain segments extracted and transformed for deeper frequency analysis.

---

## 🖼️ Screenshots
 
![x(t)](https://github.com/user-attachments/assets/7e676581-78a3-413f-9210-7d175270fe09)
![x(t) spectrum](https://github.com/user-attachments/assets/db4d10f6-ab41-4cf5-ae7c-36735f48ee04)
![high pass filter](https://github.com/user-attachments/assets/4f1654c7-00cb-4615-a9d6-c918378c64c7)
![low pass filter](https://github.com/user-attachments/assets/8f110bca-e608-496c-8d1d-f2b22fe5474c)


## 📁 Project Structure

📂 matlab-signals-project/
├── main_script.m
├── x_signal.wav
├── y1_lowpass.wav
├── y2_highpass.wav
├── screenshots/
│ ├── lowpass_response.png
│ └── highpass_output.png
├── README.md
└── report.pdf

---


## 📌 How to Run

1. Open MATLAB.
2. Navigate to the project directory.
3. Run `main_script.m` (or your main file name).
4. View plots, listen to generated audio, or inspect saved `.wav` files.
