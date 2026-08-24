# Data Directory

This directory contains the datasets used for the Parkinson's disease voice-classification analysis.

## Source Data

The primary datasets used in the analysis are:

- `pd_speech_features_trainPh1976.csv` — training dataset containing voice-derived features and Parkinson's disease classification labels
- `pd_speech_features_test_with-no-label_Ph1976.csv` — held-out test dataset containing voice-derived features without outcome labels

Each participant contributed three voice recordings. During preprocessing, the recordings are aggregated to the subject level by averaging each voice feature across the three recordings for each participant.

## Processed Data

The analysis pipeline generates the following intermediate processed datasets:

- `pd_train_v1.csv`
- `pd_test_v1.csv`
- `pd_train_v2.csv`
- `pd_test_v2.csv`
- `pd_preprocessed.RData`

These files represent different stages of preprocessing and feature selection used in the modeling workflow.

## Outcome

For the labeled training data, Parkinson's disease status is coded as:

- `0` = Non-PD
- `1` = PD

## Reproducibility

The files in this directory are used by `analysis/parkinsons_voice_classification.Rmd` to reproduce the data preprocessing, exploratory analysis, model development, model evaluation, and prediction workflow.
