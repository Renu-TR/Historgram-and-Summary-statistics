#Load necessary libraries
library(dplyr)
library(ggplot2)

# Load the dataset
data <- read.csv("All_health_indicators_India.csv")
data$Numeric <- as.numeric(data$Numeric) # Converting Numeric column to numeric datatype

data <- data %>%
distinct()

# Create a subdataset for the histogram of cholesterol levels
cholesterol_subset <- data %>%
  select(`GHO..CODE.`, Numeric) %>%  # Select relevant columns
  filter(`GHO..CODE.` == 'NCD_CHOL_MEANNONHDL_C') %>%
  filter(!is.na(Numeric))  # Remove rows with NA in Numeric

# Plot the histogram using ggplot's internal binning
histogram_plot <- ggplot(cholesterol_subset, aes(x = Numeric)) +
  geom_histogram(binwidth = 0.1, fill = "blue", color = "black") +  # Adjust binwidth as needed
  labs(title = "Histogram for Cholesterol Levels",
       x = "Mean Cholesterol Level",
       y = "Frequency") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10)) 
print(histogram_plot)

# Save the histogram plot to a file
ggsave(filename = "cholesterol_histogram.jpeg", plot = histogram_plot, width = 10, height = 6)

# Summary statistics

# Using summarise() to calculate the summary statistics
summary_stats <- cholesterol_subset %>%
  summarise(
    Mean = mean(Numeric, na.rm = TRUE),
    Median = median(Numeric, na.rm = TRUE),
    Standard_Deviation = sd(Numeric, na.rm = TRUE),
    IQR = IQR(Numeric, na.rm = TRUE),
    Min = min(Numeric, na.rm = TRUE),
    Max = max(Numeric, na.rm = TRUE),
    Q1_25th_Percentile = quantile(Numeric, 0.25, na.rm = TRUE),
    Q3_75th_Percentile = quantile(Numeric, 0.75, na.rm = TRUE)
  )

# Print  summary statistics
cat("Mean:", summary_stats$Mean, "\n")
cat("Median:", summary_stats$Median, "\n")
cat("Standard Deviation:", summary_stats$Standard_Deviation, "\n")
cat("IQR:", summary_stats$IQR, "\n")
cat("Min:", summary_stats$Min, "\n")
cat("Max:", summary_stats$Max, "\n")
cat("Q1 (25th Percentile):", summary_stats$Q1_25th_Percentile, "\n")
cat("Q3 (75th Percentile):", summary_stats$Q3_75th_Percentile, "\n")

# Create a subset of the dataframe for the boxplot for Adolescent Mortality Rate
Adolescent_death_subset <- data %>%
  select(`DIMENSION..CODE.`, `GHO..CODE.`, `Numeric`) %>%  # Select relevant columns
  filter(`GHO..CODE.` == 'MORTADO' & `DIMENSION..CODE.` != "SEX_BTSX") %>%  # Create a subset for boxplot
  filter(!is.na(Numeric))  # Remove NA values

# Plotting the boxplot
new_labels <- c(
  "SEX_FMLE" = "Female",
  "SEX_MLE" = "Male"
)

boxplot_plot <- ggplot(Adolescent_death_subset, aes(x = `DIMENSION..CODE.`, y = Numeric)) +
  geom_boxplot(outlier.color = "red", outlier.shape = 16, outlier.size = 2) +  # Customize outliers
  stat_summary(fun = median, geom = "point", shape = 20, size = 3, color = "darkred") + # Highlight median
  stat_summary(fun.data = function(y) {
    return(data.frame(
      y = median(y),
      label = paste("Median:", round(median(y), 2))
    ))
  }, geom = "text", vjust = -0.5, color = "blue") +  # Add median text
  stat_summary(fun.data = function(y) {
    return(data.frame(
      y = quantile(y, 0.25),
      label = paste("Q1:", round(quantile(y, 0.25), 2))
    ))
  }, geom = "text", vjust = 1.5, hjust = 0.5, color = "darkgreen") +  # Add lower quartile (Q1) text
  stat_summary(fun.data = function(y) {
    return(data.frame(
      y = quantile(y, 0.75),
      label = paste("Q3:", round(quantile(y, 0.75), 2))
    ))
  }, geom = "text", vjust = -1, hjust = 0.5, color = "purple") +  # Add upper quartile (Q3) text
  labs(
    title = "Boxplots for Adolescent Mortality Rate Among Gender Categories",
    x = "Gender",
    y = "Adolescent Mortality Rate"
  ) +
  scale_x_discrete(labels = new_labels) +  # Rename gender categories
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1)  # Rotate x-axis labels
  )+
  # Label minimum and maximum (excluding outliers)
  stat_summary(
    fun = min, geom = "text", aes(label = paste("Min:", round(after_stat(y), 1))), 
    vjust = 1.5, hjust = -0.5, size = 3, color = "purple"
  ) +
  stat_summary(
    fun = max, geom = "text", aes(label = paste("Max:", round(after_stat(y), 1))), 
    vjust = -1.5, hjust = -0.5, size = 3, color = "orange"
  )
print(boxplot_plot)

# Save the box plot to a file
ggsave(filename = "adolescent_mortality_boxplot.jpeg", plot = boxplot_plot, width = 10, height = 6)
