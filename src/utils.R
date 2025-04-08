# Utility functions for diamond dataset analysis

# Load required packages with error handling
load_packages <- function() {
  packages <- c("tidyverse", "ggplot2", "dplyr", "corrplot", "car", "stats")
  
  for (package in packages) {
    if (!require(package, character.only = TRUE, quietly = TRUE)) {
      cat(paste("Installing package:", package, "\n"))
      install.packages(package, dependencies = TRUE, repos = "https://cran.r-project.org")
      library(package, character.only = TRUE)
    }
  }
  cat("All required packages loaded successfully.\n")
}

# Function to summarize numerical variables
summarize_numeric <- function(df, columns) {
  result <- data.frame()
  for (col in columns) {
    if (is.numeric(df[[col]])) {
      stats <- data.frame(
        Variable = col,
        Mean = mean(df[[col]], na.rm = TRUE),
        Median = median(df[[col]], na.rm = TRUE),
        SD = sd(df[[col]], na.rm = TRUE),
        Min = min(df[[col]], na.rm = TRUE),
        Max = max(df[[col]], na.rm = TRUE),
        Q1 = quantile(df[[col]], 0.25, na.rm = TRUE),
        Q3 = quantile(df[[col]], 0.75, na.rm = TRUE),
        IQR = IQR(df[[col]], na.rm = TRUE),
        Skewness = moments::skewness(df[[col]], na.rm = TRUE),
        Kurtosis = moments::kurtosis(df[[col]], na.rm = TRUE)
      )
      result <- rbind(result, stats)
    }
  }
  return(result)
}

# Function to check for normality
check_normality <- function(df, column) {
  # Shapiro-Wilk test for normality
  shapiro_test <- shapiro.test(df[[column]])
  
  # Q-Q plot
  qq_plot <- ggplot(df, aes(sample = .data[[column]])) +
    stat_qq() +
    stat_qq_line() +
    labs(title = paste("Q-Q Plot for", column),
         x = "Theoretical Quantiles", 
         y = "Sample Quantiles") +
    theme_minimal()
  
  # Histogram with normal curve
  hist_plot <- ggplot(df, aes(x = .data[[column]])) +
    geom_histogram(aes(y = ..density..), bins = 30, fill = "skyblue", color = "black") +
    geom_density(color = "red") +
    stat_function(fun = dnorm, 
                 args = list(mean = mean(df[[column]], na.rm = TRUE), 
                             sd = sd(df[[column]], na.rm = TRUE)),
                 color = "blue", linewidth = 1) +
    labs(title = paste("Histogram with Normal Curve for", column),
         x = column, y = "Density") +
    theme_minimal()
  
  return(list(shapiro_test = shapiro_test, qq_plot = qq_plot, hist_plot = hist_plot))
}

# Function to save plots
save_plot <- function(plot, filename, width = 10, height = 6) {
  dir.create("plots", showWarnings = FALSE)
  ggsave(paste0("plots/", filename, ".png"), plot, width = width, height = height, dpi = 300)
  cat(paste("Plot saved to plots/", filename, ".png\n", sep=""))
}

# Function to print section headers
print_section <- function(section_name) {
  cat("\n", paste(rep("=", 50), collapse = ""), "\n")
  cat(paste0("  ", section_name, "\n"))
  cat(paste(rep("=", 50), collapse = ""), "\n\n")
}

# Function to create correlation matrix plot
create_correlation_plot <- function(df, columns, method = "pearson") {
  cor_matrix <- cor(df[columns], use = "pairwise.complete.obs", method = method)
  corrplot(cor_matrix, method = "color", type = "upper", order = "hclust", 
           tl.col = "black", tl.srt = 45, addCoef.col = "black", 
           number.cex = 0.7, diag = FALSE)
  return(cor_matrix)
}

# Function to bin continuous variables for exploration
bin_variable <- function(df, column, bins = 5) {
  df[[paste0(column, "_binned")]] <- cut(df[[column]], breaks = bins)
  return(df)
} 