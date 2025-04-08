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

## Plot Descriptions and Interpretations

The analysis generates a comprehensive set of visualizations to help understand the diamonds dataset. Below is a description of the key plots and what insights they provide:

### Basic Statistical Plots

1. **price_histogram.png**: Histogram showing the distribution of diamond prices. The right-skewed pattern indicates that most diamonds are in the lower price range, with fewer very expensive diamonds.

2. **carat_histogram.png**: Distribution of diamond carat weights. Shows common weight thresholds that may reflect market preferences.

3. **price_by_cut_boxplot.png**: Box plots comparing diamond prices across different cut qualities. Helps identify if better cuts command higher prices.

4. **price_by_clarity_boxplot.png**: Box plots showing how clarity affects diamond pricing. Clearer diamonds (higher clarity grades) generally have higher median prices.

5. **price_vs_carat_scatter.png**: Scatter plot of price against carat with a trend line. Shows the strong positive relationship between a diamond's weight and its price.

6. **price_vs_carat_by_cut.png**: Faceted scatter plots showing how the price-carat relationship varies across different cut qualities.

### Probability Distribution Analysis

7. **price_qq_plot.png**: Quantile-Quantile plot for diamond prices, evaluating if prices follow a normal distribution.

8. **price_normality_hist.png**: Histogram with normal curve overlay, showing how price distribution deviates from normality.

9. **log_price_qq_plot.png** and **log_price_normality_hist.png**: Similar plots for log-transformed prices, typically showing better normality.

### Correlation Analysis

10. **correlation_matrix.png**: Heat map displaying correlations between numerical variables. Intense colors indicate stronger relationships (positive or negative).

### Regression and Predictive Analysis

11. **advanced_model_residuals.png**: Residual plot from the regression model. Patterns may indicate model limitations or suggest transformations.

12. **decision_tree.png**: Visualization of the decision tree model for predicting diamond prices, showing key decision points based on features.

13. **variable_importance.png**: Bar chart from the random forest model showing which variables are most important in predicting diamond prices.

### Hypothesis Testing Visualizations

14. **cut_price_comparison.png**: Density plots comparing price distributions between different cuts, often used in t-tests.

15. **cut_color_heatmap.png**: Visualization of the association between cut and color, related to chi-square test results.

16. **anova_cut_price.png**: Violin plots comparing price distributions across cuts, visualizing ANOVA results.

### High-Quality Visualizations

The `plots/high_quality/` directory contains more refined versions of key visualizations:

17. **cut_violin_plot.png**: Enhanced violin plots showing the distribution of prices across different cut qualities.

18. **multidim_scatter_plot.png**: Multi-dimensional scatter plot showing relationships between price, carat, clarity, and depth.

19. **correlation_heatmap.png**: Detailed correlation matrix with hierarchical clustering to group related variables.

20. **interactive_scatter.html**: Interactive plot allowing exploration of the relationship between price, carat, and other variables.

21. **facet_histograms.png**: Grid of histograms showing price distributions across different combinations of cut and color.

22. **parallel_coords.png**: Parallel coordinate plot for multi-dimensional analysis of numerical variables.

23. **ridgeline_plot.png**: Overlapping density curves showing price distribution by clarity.

24. **price_bubble_plot.png**: Bubble chart displaying average prices by cut, color, and clarity combinations.

25. **price_per_carat_boxplot.png**: Box plots comparing the price-per-carat ratio across different cuts.

26. **value_analysis_hist.png**: Histogram identifying potentially overpriced and underpriced diamonds.

27. **dimension_pairs.png**: Scatter plot matrix showing relationships between diamond dimensions.

28. **market_share_pie.png**: Pie chart showing the market share by cut.

29. **dashboard_summary.png**: Summary dashboard with key metrics about the diamond dataset.

## Key Visual Insights

The visualizations collectively reveal several important patterns:

1. **Price Determinants**: The plots show that carat weight is the strongest predictor of price, followed by clarity and cut quality.

2. **Non-linear Relationship**: The price-carat relationship is non-linear, with larger diamonds commanding disproportionately higher prices.

3. **Quality Premium**: Better cut quality generally commands a higher price-per-carat, visible in the box plots.

4. **Market Distribution**: The distribution plots reveal market concentrations at specific carat thresholds (0.5, 1.0, etc.).

5. **Feature Interactions**: Multiple plots demonstrate how cut, color, and clarity interact to influence pricing beyond their individual effects.

6. **Statistical Validation**: The QQ-plots and residual analysis confirm that log-transformation improves the normality of price data.

7. **Predictive Models**: The decision tree and random forest visualizations explain which factors matter most when predicting diamond prices.

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
