# Diamond Dataset Analysis

This project provides a comprehensive statistical analysis of the diamonds dataset using R programming language. It covers a wide range of statistical techniques from basic descriptive statistics to advanced modeling and predictive analysis.

## Project Overview

The analysis is structured to match the topics covered in the university's Probability and Statistics course, including:

- Data exploration and summary statistics
- Data visualization techniques
- Probability distributions
- Correlation analysis
- Regression modeling
- Hypothesis testing
- ANOVA

## Project Structure

- `Dataset/diamonds.csv`: The dataset containing diamond characteristics and prices
- `src/utils.R`: Utility functions used across the analysis scripts
- `analysis/`: Main R analysis scripts
  - `main_analysis.R`: Fundamental statistical analysis
  - `advanced_modeling.R`: Advanced statistical modeling and prediction
  - `visualization_insights.R`: Detailed visualizations and insights
- `plots/`: Generated visualizations
  - `high_quality/`: Publication-quality visualizations
- `run_analysis.R`: Main script to run the entire analysis
- `Lab Files/`: Reference materials from practical labs

## System Requirements

- R (version 4.0 or higher)
- RStudio (recommended for viewing and running the scripts)

## Required R Packages

The following packages are required to run all analyses. The scripts will attempt to install missing packages automatically:

### Basic Analysis (main_analysis.R)
- tidyverse
- ggplot2
- dplyr
- corrplot
- car
- stats
- moments
- scales

### Advanced Modeling (advanced_modeling.R)
- rpart
- rpart.plot
- randomForest
- caret
- e1071
- reshape2

### Visualization (visualization_insights.R)
- ggthemes
- GGally
- viridis
- plotly
- reshape2
- ggridges
- htmlwidgets

### Package Installation
If you prefer to install all required packages in advance:

```R
packages <- c(
  "tidyverse", "ggplot2", "dplyr", "corrplot", "car", "stats", 
  "moments", "rpart", "rpart.plot", "randomForest", "caret", "e1071", 
  "ggthemes", "GGally", "viridis", "plotly", "reshape2", "ggridges",
  "scales", "htmlwidgets"
)

install.packages(packages, dependencies = TRUE, repos = "https://cran.r-project.org")
```

## Running the Analysis

### Method 1: Using the main run script (recommended)

1. Open RStudio
2. Open the `run_analysis.R` file
3. Click "Run" or press Ctrl+Shift+Enter to run the entire script

This will execute all analyses in sequence and generate all plots and output files.

### Method 2: Running individual analysis scripts

You can also run each analysis script separately for more focused analysis:

1. Open RStudio
2. First run `source("src/utils.R")` to load utility functions
3. Then run any of the analysis scripts:
   - `source("analysis/main_analysis.R")` - Basic statistical analysis
   - `source("analysis/advanced_modeling.R")` - Advanced modeling
   - `source("analysis/visualization_insights.R")` - Visualizations

## Expected Outputs

- **Plots**: Various statistical visualizations will be saved in the `plots/` directory
- **Analysis Results**: CSV files with analysis results will be saved in the `analysis/` directory
- **Console Output**: Detailed statistical results will be printed to the R console

## Common Issues and Solutions

- **Package Installation Errors**: If you encounter package installation errors, try running:
  ```R
  install.packages("package_name", dependencies=TRUE, repos="https://cran.r-project.org")
  ```

- **Working Directory Issues**: If files aren't found, ensure your working directory is set to the project root:
  ```R
  setwd("/path/to/project_directory")
  ```

- **Memory Issues**: If you encounter memory issues with large dataset operations, restart R with:
  ```R
  .rs.restartR()
  ```

## Further Exploration

After running the basic analysis, you can:

1. Modify the scripts to explore different aspects of the diamond dataset
2. Change visualization parameters to highlight different patterns
3. Experiment with different modeling techniques in the advanced_modeling.R script
4. Export the high-quality visualizations for use in reports or presentations
