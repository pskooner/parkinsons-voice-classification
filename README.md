# Predicting Parkinson's Disease Using Voice Recordings

A supervised machine-learning project for classifying Parkinson's disease (PD) status from quantitative features extracted from voice recordings.

## Project overview

Parkinson's disease can affect vocal characteristics, making speech-derived features a potential source of information for non-invasive classification. This project evaluates several statistical-learning and machine-learning approaches for distinguishing PD from non-PD participants using high-dimensional voice features.

The original dataset contains **252 subjects**, each with **three voice recordings**. The analysis averages the three recordings to create one subject-level feature vector. In the course split used for modeling, this yielded **201 training subjects** and **51 test subjects** after aggregation.

## Analysis workflow

1. Aggregate three recordings per subject by taking the mean of each feature.
2. Explore class balance, feature distributions, and correlations.
3. Remove near-zero-variance predictors.
4. Create a correlation-filtered feature set for penalized logistic regression.
5. Standardize predictors using parameters estimated from the training set only.
6. Use PCA for visualization and for dimensionality reduction before the neural network.
7. Train models with **5-fold cross-validation** and **up-sampling** to address class imbalance.
8. Compare models using AUC, accuracy, sensitivity, specificity, precision, and F1-score.
9. Generate subject-level predictions for the held-out test set.

## Models evaluated

- Penalized logistic regression (ridge/lasso via `glmnet`)
- Random forest
- Support vector machine with radial kernel
- Multilayer perceptron (MLP) after PCA

## Cross-validated results

| Model | AUC | Accuracy | Sensitivity | Specificity | Precision | F1 |
|---|---:|---:|---:|---:|---:|---:|
| Logistic regression | **0.859** | 0.811 | 0.840 | **0.725** | 0.900 | **0.869** |
| Random forest | 0.842 | **0.816** | 0.940 | 0.451 | 0.834 | 0.884 |
| SVM | 0.797 | 0.810 | **0.967** | 0.314 | 0.806 | 0.879 |
| MLP | 0.816 | 0.756 | 0.800 | 0.627 | 0.863 | 0.830 |

Penalized logistic regression achieved the highest AUC and the most balanced sensitivity/specificity profile. Random forest and SVM were more sensitive to PD cases but produced substantially lower specificity.

> **Important implementation note:** The original course code generated the final held-out test predictions using the random forest model, even though logistic regression had the highest cross-validated AUC. This repository preserves that modeling decision rather than silently changing the submitted analysis.

## Repository structure

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
└── .gitignore
```

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
