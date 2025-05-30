
#  Health Indicators Analysis in R

![R](https://img.shields.io/badge/R-276DC3?style=flat-square&logo=r&logoColor=white)
![ggplot2](https://img.shields.io/badge/ggplot2-Data%20Viz-0099cc?style=flat-square)
![dplyr](https://img.shields.io/badge/dplyr-Data%20Wrangling-4CAF50?style=flat-square)

This project performs **descriptive statistics and visualizations** on health indicators from India using R.

---

##  Files

- `e4f51298-d6e1-4e67-879b-91e2a31edb30.R`: Main R script for processing, visualizing, and summarizing health data
- `All_health_indicators_India.csv`: Required CSV dataset (not included)
- `cholesterol_histogram.jpeg`: Output histogram of cholesterol levels
- `adolescent_mortality_boxplot.jpeg`: Output boxplot comparing adolescent mortality rates by gender

---

##  Features

- **Histogram for Cholesterol Levels**
  - Filters `NCD_CHOL_MEANNONHDL_C` records
  - Removes NAs
  - Saves histogram as `cholesterol_histogram.jpeg`

- **Summary Statistics**
  - Calculates mean, median, SD, IQR, Q1, Q3, min, and max

- **Boxplot for Adolescent Mortality**
  - Filters `MORTADO` records, split by gender
  - Visualizes outliers, median, Q1, Q3
  - Labels key statistics
  - Saves boxplot as `adolescent_mortality_boxplot.jpeg`

---

##  How to Run

1. Ensure R and required packages are installed:
   ```r
   install.packages(c("dplyr", "ggplot2"))
   ```

2. Load the dataset:
   - Place `All_health_indicators_India.csv` in your working directory

3. Run the script:
   ```r
   source("e4f51298-d6e1-4e67-879b-91e2a31edb30.R")
   ```

4. Check the working directory for image outputs.

---

##  License

This project is for educational/research purposes only.
