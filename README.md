# Predicting Parkinson's Disease Using Voice Recordings

A supervised machine-learning project for predicting and classifying **Parkinson's disease (PD) status** using quantitative features extracted from voice recordings.

## Project Overview

Parkinson's disease can affect vocal characteristics, making speech-derived features a potential source of information for non-invasive classification. This project evaluates several statistical-learning and machine-learning approaches for distinguishing individuals with PD from those without PD using high-dimensional voice features.

The original dataset contains **252 subjects**, each with **three voice recordings**, resulting in 756 recording-level observations. The three recordings were aggregated by averaging each feature within subject, producing **201 training subjects** and **51 held-out test subjects** for modeling.

The analysis focuses on preprocessing high-dimensional speech data, addressing class imbalance and multicollinearity, comparing multiple classification algorithms, and evaluating their ability to discriminate between PD and non-PD participants.

## Objectives

The primary objectives of this project were to:

- Preprocess repeated voice recordings into subject-level observations
- Explore class balance, feature distributions, and correlations
- Reduce redundancy among high-dimensional speech features
- Compare statistical and machine-learning classification approaches
- Address class imbalance during model training
- Evaluate predictive performance using multiple classification metrics
- Generate predictions for a held-out test dataset

## Analysis Workflow

1. **Aggregate repeated recordings**  
   Average the three voice recordings for each participant to create one subject-level feature vector.

2. **Conduct exploratory data analysis**  
   Examine class distribution, selected feature distributions, and correlations among speech features.

3. **Remove near-zero-variance predictors**  
   Screen predictors for features containing little or no variability.

4. **Address multicollinearity**  
   Apply correlation-based feature filtering using a cutoff of **|r| > 0.90**, reducing the feature space from **753 to 353 predictors** for penalized logistic regression.

5. **Standardize predictors**  
   Apply z-score normalization using parameters estimated from the training data only to prevent data leakage.

6. **Perform principal component analysis (PCA)**  
   Use PCA to visualize the high-dimensional feature space and for dimensionality reduction before neural-network modeling.

7. **Train classification models**  
   Use **5-fold cross-validation** for model training and hyperparameter tuning, with **up-sampling within training folds** to address class imbalance.

8. **Evaluate model performance**  
   Compare models using AUC, accuracy, sensitivity, specificity, precision, and F1-score.

9. **Generate held-out predictions**  
   Apply the trained modeling pipeline to the unlabeled test dataset to generate subject-level PD predictions.

## Models Evaluated

Four supervised classification approaches were compared:

- **Penalized Logistic Regression** — ridge/lasso regularization using `glmnet`
- **Random Forest** — ensemble tree-based classification
- **Support Vector Machine (SVM)** — radial basis function kernel
- **Multilayer Perceptron (MLP)** — feedforward neural network following PCA-based dimensionality reduction

## Cross-Validated Results

| Model | AUC | Accuracy | Sensitivity | Specificity | Precision | F1 |
|---|---:|---:|---:|---:|---:|---:|
| **Logistic Regression** | **0.859** | 0.811 | 0.840 | **0.725** | 0.900 | 0.869 |
| Random Forest | 0.842 | **0.816** | 0.940 | 0.451 | 0.834 | **0.884** |
| SVM | 0.797 | 0.810 | **0.967** | 0.314 | 0.806 | 0.879 |
| MLP | 0.816 | 0.756 | 0.800 | 0.627 | 0.863 | 0.830 |

## Key Findings

- **Penalized logistic regression achieved the highest AUC (0.859)** and provided the strongest overall balance between sensitivity and specificity.
- **Random Forest and SVM achieved higher sensitivity** for identifying PD cases but at the cost of substantially lower specificity.
- The training dataset was imbalanced, with approximately **74.6% PD and 25.4% non-PD subjects**, reinforcing the importance of evaluating sensitivity, specificity, and AUC rather than relying on accuracy alone.
- Correlation filtering reduced the predictor set from **753 to 353 features**, demonstrating substantial redundancy within the high-dimensional speech feature space.
- PCA showed that approximately **36 principal components were required to explain 80% of the variance**, highlighting the multidimensional structure of the voice-feature data.
- Random Forest feature-importance analysis identified several **delta-energy and TQWT-based features** among the strongest predictors of PD classification.
- Overall, the results demonstrated that a relatively interpretable, regularized statistical model could perform as well as or better than more flexible machine-learning approaches for this dataset.

Final held-out test predictions were generated using the **Random Forest model**, consistent with the implementation used in the original course analysis.

## Repository Structure

```text
parkinsons-voice-classification/
├── README.md
├── analysis/
│   └── parkinsons_voice_classification.Rmd
├── data/
│   └── README.md
├── outputs/
│   └── predictions.csv
├── docs/
│   └── final_project_report.pdf
├── install_packages.R
└── .gitignore

## Data

The analysis uses speech features spanning baseline measures, intensity, bandwidth/formant measures, vocal-fold measures, MFCCs, wavelet-transform features, and TQWT features. The outcome is binary: `0 = non-PD`, `1 = PD`.

The course-provided train/test data are intentionally omitted from this public-ready repository. If you have permission to redistribute them, place the files in `data/` as:

```text
data/pd_speech_features_trainPh1976.csv
data/pd_speech_features_test_with-no-label_Ph1976.csv
```

## Running the analysis

Open `analysis/parkinsons_voice_classification.Rmd` in RStudio and knit/run from the repository root. The analysis uses these R packages:

```r
install.packages(c(
  "tidyverse", "corrplot", "caret", "pROC", "randomForest",
  "e1071", "glmnet", "kernlab", "nnet"
))
```

The pipeline writes processed datasets to `data/` and final predictions to `outputs/predictions.csv`.

## Key methods demonstrated

R, R Markdown, exploratory data analysis, feature engineering, multicollinearity filtering, standardization, PCA, cross-validation, class-imbalance handling, penalized logistic regression, random forest, SVM, neural networks, ROC/AUC analysis, confusion matrices, threshold analysis, and variable importance.

## Authors

- Parminder Singh Kooner
- Huiying Hu
- Syeda Akter

Graduate course project, UTHealth Houston School of Public Health, Department of Biostatistics and Data Science (2026).

## Academic-use note

This repository is a cleaned, portfolio-oriented version of a collaborative course project. Verify dataset redistribution permissions and obtain collaborator approval before making any course-provided data or jointly authored materials public.
