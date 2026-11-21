# Gaussian Color Model for Ball Detection

CSE543 Introduction to Robotics project at North South University, Spring 2023.

---

## Overview

This project detects a yellow ball in images with a **Gaussian color model**. It has two phases:

1. **Color model learning**: estimate the mean (μ) and covariance (Σ) of the ball's color from training images
2. **Ball detection**: use the learned model to find ball-colored pixels and locate the ball center in new images

The model was built in two color spaces:

- **RGB**: a single Gaussian with a separate variance for each channel (the code in this repository)
- **HSV**: a single Gaussian with a full 3×3 covariance matrix (described in the report)

---

## Methodology

### Phase 1: Color Model Learning

- Loaded 15 training images from the `train/` folder
- Used `roipoly` to select the ball pixels in each image by hand
- Computed the Gaussian model parameters from the selected pixels:
  - Mean vector **μ** (1×3)
  - Variance of each color channel (RGB model) or full covariance matrix **Σ** (HSV model)
- Plotted the pixel color distribution in 3D and drew Gaussian contours to check the fit

### Phase 2: Ball Detection

- Computed the probability of each pixel under the learned Gaussian model (`mvnpdf`)
- Kept the pixels above a probability threshold to get a binary mask
- Used `bwconncomp` to find connected regions and kept the largest one as the ball
- Used `regionprops` to compute its **centroid** as the ball location

---

## Learned Model Parameters (RGB)

From `detectBall.m`:

```matlab
mu   = [148.4140 144.0171 62.4389];     % mean of R, G, B
sig  = [208.4049 133.1187 3754.4475];   % variance of R, G, B
thre = 0.2e-5;                          % probability threshold
```

---

## Repository Structure

```
gaussian-color-model-ball-detection/
│
├── detectBall.m              # Ball detection function
├── example_rgb.m             # Color model learning script
├── plot_test_gaussian.m      # Gaussian contour plot
├── example_test.m            # Runs detectBall on the training images
├── example_bw.m              # Binary image example
├── runeval.m                 # Evaluation runner
│
├── train/                    # 19 training images (001.png – 019.png)
│
├── images/                   # Output images from training and testing
│   ├── example_rgb1.png – example_rgb15.png
│   ├── example_rgb_mu.png
│   ├── example_rgb_sigma.png
│   ├── example_rgb_devi.png
│   ├── example_rgb_pixel color distribution.png
│   ├── example_test1.png
│   ├── example_test2.png
│   └── plot test gaussian.png
│
├── report/                   # Assignment report
│   ├── Assignment 2.pdf
│   ├── Assignment 2.docx
│   └── Ball color detection problem_Sp23.pdf
│
└── test/                     # Encrypted test data
    ├── test001.mat
    ├── test002.mat
    ├── test003.mat
    └── test004.mat
```

---

## How to Run

### Step 1: Learn the Color Model
Open MATLAB, go to the project folder and run:
```matlab
example_rgb
```
It asks you to select the ball pixels in each training image with `roipoly`.

### Step 2: Visualize the Gaussian Model
```matlab
plot_test_gaussian
```

### Step 3: Test Ball Detection
```matlab
example_test
```

### Step 4: Run Evaluation
```matlab
runeval
```
This needs the evaluation file `eval_progW1.p`, which is not included in this repository. It generates `SubmissionBallSegmentation.mat` and `SubmissionBallLocation.mat`.

---

## Results

Example segmentation masks and detected ball centers are in `images/` and in the report.

| Output | Description |
|---|---|
| `segI` | 120×160 binary segmentation mask |
| `loc` | 1×2 centroid coordinates of the detected ball |

---

## Dependencies

- MATLAB R2022b
- Image Processing Toolbox (`bwconncomp`, `regionprops`, `roipoly`)
- Statistics and Machine Learning Toolbox (`mvnpdf`)

---

## Authors

- **Sazzad Hossain**
- **Abrar Hossain**

**Instructor:** Dr. Tahsina Farah Sanam
