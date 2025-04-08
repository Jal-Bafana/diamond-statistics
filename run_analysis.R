# Diamond Dataset Analysis - Main Run Script
# This script coordinates the execution of all analysis components

# Record start time to measure execution time
start_time <- Sys.time()

# Print header
cat("\n")
cat("=====================================================\n")
cat("         DIAMOND DATASET STATISTICAL ANALYSIS        \n")
cat("=====================================================\n\n")

# Install required packages if not already installed
required_packages <- c(
  "tidyverse", "ggplot2", "dplyr", "corrplot", "car", "stats", 
  "moments", "rpart", "rpart.plot", "randomForest", "caret", "e1071", 
  "ggthemes", "GGally", "viridis", "plotly", "reshape2", "ggridges"
)

# Function to install missing packages
install_missing_packages <- function(packages) {
  new_packages <- packages[!(packages %in% installed.packages()[,"Package"])]
  if(length(new_packages) > 0) {
    cat("Installing required packages:", paste(new_packages, collapse = ", "), "\n")
    install.packages(new_packages, dependencies = TRUE, repos = "https://cran.r-project.org")
  }
  
  # Load all required packages
  for(pkg in packages) {
    library(pkg, character.only = TRUE)
  }
}

# Install and load all required packages
cat("Setting up environment and loading packages...\n")
install_missing_packages(required_packages)
cat("All required packages loaded successfully.\n\n")

# Create necessary directories if they don't exist
dir.create("plots", showWarnings = FALSE)
dir.create("plots/high_quality", recursive = TRUE, showWarnings = FALSE)

# Function to safely run analysis scripts with error handling
run_script <- function(script_path, script_name) {
  cat("-----------------------------------------------------\n")
  cat("Running", script_name, "...\n")
  cat("-----------------------------------------------------\n")
  
  tryCatch({
    source(script_path)
    cat(script_name, "completed successfully.\n\n")
    return(TRUE)
  }, error = function(e) {
    cat("ERROR in", script_name, ":", e$message, "\n\n")
    return(FALSE)
  })
}

# Run the main analysis script
cat("Starting basic analysis...\n")
run_script("analysis/main_analysis.R", "Main Analysis")

# Run the advanced modeling script
cat("Starting advanced modeling...\n")
run_script("analysis/advanced_modeling.R", "Advanced Modeling")

# Run the visualization and insights script
cat("Starting visualization and insights generation...\n")
run_script("analysis/visualization_insights.R", "Visualization and Insights")

# Calculate and print execution time
end_time <- Sys.time()
execution_time <- end_time - start_time
cat("Total execution time:", format(execution_time), "\n")

# Print summary of outputs
cat("\n=====================================================\n")
cat("                  ANALYSIS SUMMARY                   \n")
cat("=====================================================\n\n")

# Count the number of created plots
num_plots <- length(list.files("plots", recursive = TRUE, pattern = "\\.(png|jpg|html)$"))
cat("- Generated", num_plots, "visualization plots\n")

# Count analysis files
num_analysis_files <- length(list.files("analysis", pattern = "\\.csv$"))
cat("- Created", num_analysis_files, "analysis output files\n")

cat("\nAnalysis results can be found in the following locations:\n")
cat("- Plots: ./plots/ directory\n")
cat("- High-quality visualizations: ./plots/high_quality/ directory\n")
cat("- Analysis outputs: ./analysis/ directory\n\n")

cat("To view the full analysis report, open the R scripts in the analysis folder:\n")
cat("1. main_analysis.R - Basic statistical analysis\n")
cat("2. advanced_modeling.R - Advanced modeling and prediction\n")
cat("3. visualization_insights.R - Visualizations and key insights\n\n")

cat("=====================================================\n")
cat("                 ANALYSIS COMPLETE                  \n")
cat("=====================================================\n") 