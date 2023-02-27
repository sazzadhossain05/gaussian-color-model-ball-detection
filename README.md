# Gaussian Color Model for Ball Detection

**Course:** Introduction to Robotics (CSE543)  
**Semester:** Spring 2023  
**Institution:** North South University  
**Department:** Electrical and Computer Engineering  

---

## Overview

This project implements a **Gaussian color model** to detect a target ball in images using HSV color space. The approach involves two phases:

1. **Color Model Learning** — Estimate the mean (μ) and covariance (Σ) of the ball's color distribution from training images
2. **Ball Detection** — Use the learned Gaussian model to segment ball-colored pixels and locate the ball center in new images

---

## Methodology

### Phase 1: Color Model Learning

- Loaded 15 training images from the `train/` directory
- Converted images from RGB to **HSV color space** for better color discrimination
- Used `roipoly` to manually select ball pixels from each image
- Computed the **single Gaussian model** parameters:
  - Mean vector **μ** (1×3)
  - Covariance matrix **Σ** (3×3)
- Visualized the pixel color distribution in 3D scatter plot
- Plotted Gaussian contours to validate the model fit

### Phase 2: Ball Detection

- Converted input image to HSV color space
- For each pixel, computed the **Mahalanobis distance-based probability**:

```
p = exp(-0.5 * (x - μ)' * Σ⁻¹ * (x - μ))
```

- Applied a probability threshold to generate a binary segmentation mask
- Used `bwconncomp` to find connected components
- Selected the largest connected component as the ball region
- Used `regionprops` to compute the **centroid** as the ball location

---

## Learned Model Parameters

```matlab
mu = [0.1559  0.6097  0.5967]';

sig = [ 0.0003  -0.0000  -0.0002;
       -0.0000   0.0172   0.0050;
       -0.0002   0.0050   0.0020];

threshold = 0.3;
```

---

## Repository Structure

```
gaussian-color-model-ball-detection/
│
├── detectBall.m              # Main ball detection function
├── example_rgb.m             # Color model learning script
├── plot_test_gaussian.m      # Gaussian contour visualization
├── example_test.m            # Testing script
├── example_bw.m              # Binary image example
├── runeval.m                 # Evaluation runner
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
Open MATLAB, navigate to the project folder and run:
```matlab
example_rgb
```
This will prompt you to select ball pixels from each training image using `roipoly`.

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
This generates `SubmissionBallSegmentation.mat` and `SubmissionBallLocation.mat`.

---

## Results

The learned Gaussian model successfully segments the ball from background pixels across all test images. The non-zero off-diagonal terms in the covariance matrix indicate correlated color channels, producing a skewed Gaussian distribution that better fits the ball's color profile in HSV space.

| Output | Description |
|---|---|
| `segI` | 120×160 binary segmentation mask |
| `loc` | 1×2 centroid coordinates of detected ball |

---

## Dependencies

- MATLAB R2022b
- Image Processing Toolbox (`bwconncomp`, `regionprops`, `roipoly`)
- Statistics and Machine Learning Toolbox (`mvnpdf`)

---

## Authors

- **Sazzad Hossain** — ID: 2135184050  
- **Abrar Hossain** — ID: 2315121650  

**Instructor:** Dr. Tahsina Farah Sanam
