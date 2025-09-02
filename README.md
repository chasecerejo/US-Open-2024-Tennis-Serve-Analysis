# 🎾 US Open 2024 Serve Analysis & Prediction

## 📌 Overview
This project analyzes **serve performance at the 2024 US Open** using point-level match data.  
The goal is to:
- Clean and prepare point-level tennis data  
- Build predictive models (Decision Tree & Random Forest)  
- Evaluate model performance using accuracy and Brier score  
- Identify the **Top 15 servers** based on serve win percentage  

By analyzing serve dominance, the project provides insights into **which players may have the strongest chance of success in the 2025 US Open**.

---

## 📂 Files
- `USOpen2024TennisServeAnalysisProject.R` → Main R script with all steps (data prep, modeling, evaluation, and visualization).  
- `2024-usopen-points.csv` → Point-level dataset (serve details).  
- `2024-usopen-matches.csv` → Match-level dataset (player names, IDs, etc.).  
- `README.md` → Project documentation (this file).
- `Results.md` → Full results from the R analysis (data cleaning summary, performance metrics, model evaluation, leaderboard, etc.).  
- `Conclusion.md` → Final summary and interpretation of results.  
- `Charts, Tables, and Visuals US Open 2024 Serve Analysis.pdf` → Contains all charts, tables, and visual outputs (leaderboard plot, variable importance, confusion matrix, etc.).


---

## 📊 Data Source
The datasets come from **Jeff Sackmann’s Tennis Slam Point by Point Data Repository**:  
👉 https://github.com/JeffSackmann/tennis_slam_pointbypoint 

- `2024-usopen-points.csv` → Contains serve-level and point-level information.  
- `2024-usopen-matches.csv` → Contains player and match-level information.  

This dataset is widely used in tennis analytics research and provides granular detail on player performance.

---

## ⚙️ Requirements
Before running, install the following R packages:

```r
install.packages(c("dplyr", "ggplot2", "randomForest", "rpart", "rpart.plot", "caTools", "readr"))

