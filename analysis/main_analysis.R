# Diamonds Dataset Analysis
# Main analysis script that combines all aspects of the statistical analysis

# Set working directory to project root (adjust if needed)
setwd(dirname(dirname(rstudioapi::getSourceEditorContext()$path)))

# Source utility functions
source("src/utils.R")

# Load required packages
load_packages()

# Additional packages for this analysis
if (!require("moments")) {
  install.packages("moments")
  library(moments)
}

# ======================================================
# 1. Data Import and Initial Exploration (Lab P1, P2)
# ======================================================
print_section("Data Import and Initial Exploration")

# Read the diamonds dataset
diamonds <- read.csv("Dataset/diamonds.csv", stringsAsFactors = TRUE)

# Display basic information
cat("Dataset dimensions:", dim(diamonds)[1], "rows and", dim(diamonds)[2], "columns\n")
cat("Column names:", colnames(diamonds), "\n\n")

# Structure of the dataset
str(diamonds)

# Check for missing values
missing_values <- colSums(is.na(diamonds))
cat("\nMissing values per column:\n")
print(missing_values)

# First few rows of the dataset
head(diamonds)

# ======================================================
# 2. Descriptive Statistics (Lab P5)
# ======================================================
print_section("Descriptive Statistics")

# Summary statistics for numerical variables
num_vars <- c("carat", "depth", "table", "price", "x", "y", "z")
summary_stats <- summarize_numeric(diamonds, num_vars)
print(summary_stats)

# Frequency tables for categorical variables
cat_vars <- c("cut", "color", "clarity")

for (var in cat_vars) {
  cat("\nFrequency table for", var, ":\n")
  freq_table <- table(diamonds[[var]])
  print(freq_table)
  
  cat("\nRelative frequency for", var, ":\n")
  rel_freq <- prop.table(freq_table) * 100
  print(round(rel_freq, 2))
}

# ======================================================
# 3. Data Visualization (Lab P3)
# ======================================================
print_section("Data Visualization")

# Histogram of price
price_hist <- ggplot(diamonds, aes(x = price)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Diamond Prices",
       x = "Price (USD)",
       y = "Frequency") +
  theme_minimal()
print(price_hist)
save_plot(price_hist, "price_histogram")

# Distribution of carat
carat_hist <- ggplot(diamonds, aes(x = carat)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Diamond Carats",
       x = "Carat",
       y = "Frequency") +
  theme_minimal()
print(carat_hist)
save_plot(carat_hist, "carat_histogram")

# Box plots of price by cut
price_by_cut <- ggplot(diamonds, aes(x = cut, y = price, fill = cut)) +
  geom_boxplot() +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Diamond Prices by Cut",
       x = "Cut",
       y = "Price (USD)") +
  theme_minimal() +
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 45, hjust = 1))
print(price_by_cut)
save_plot(price_by_cut, "price_by_cut_boxplot")

# Box plots of price by clarity
price_by_clarity <- ggplot(diamonds, aes(x = clarity, y = price, fill = clarity)) +
  geom_boxplot() +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Diamond Prices by Clarity",
       x = "Clarity",
       y = "Price (USD)") +
  theme_minimal() +
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 45, hjust = 1))
print(price_by_clarity)
save_plot(price_by_clarity, "price_by_clarity_boxplot")

# Scatterplot of price vs. carat
price_vs_carat <- ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(alpha = 0.3, color = "blue") +
  geom_smooth(method = "lm", color = "red") +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Diamond Price vs. Carat",
       x = "Carat",
       y = "Price (USD)") +
  theme_minimal()
print(price_vs_carat)
save_plot(price_vs_carat, "price_vs_carat_scatter")

# Facet plots of price vs. carat by cut
price_vs_carat_by_cut <- ggplot(diamonds, aes(x = carat, y = price, color = cut)) +
  geom_point(alpha = 0.3) +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~ cut) +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Diamond Price vs. Carat by Cut",
       x = "Carat",
       y = "Price (USD)") +
  theme_minimal() +
  theme(legend.position = "none")
print(price_vs_carat_by_cut)
save_plot(price_vs_carat_by_cut, "price_vs_carat_by_cut", width = 12, height = 8)

# ======================================================
# 4. Continuous Probability Distribution (Lab P6)
# ======================================================
print_section("Continuous Probability Distributions")

# Check normality of price
price_normality <- check_normality(diamonds, "price")
print(price_normality$shapiro_test)
print(price_normality$qq_plot)
save_plot(price_normality$qq_plot, "price_qq_plot")
print(price_normality$hist_plot)
save_plot(price_normality$hist_plot, "price_normality_hist")

# Check normality of log-transformed price
diamonds$log_price <- log(diamonds$price)
log_price_normality <- check_normality(diamonds, "log_price")
print(log_price_normality$shapiro_test)
print(log_price_normality$qq_plot)
save_plot(log_price_normality$qq_plot, "log_price_qq_plot")
print(log_price_normality$hist_plot)
save_plot(log_price_normality$hist_plot, "log_price_normality_hist")

# ======================================================
# 5. Correlation Analysis (Lab P7)
# ======================================================
print_section("Correlation Analysis")

# Create correlation matrix for numerical variables
num_vars <- c("carat", "depth", "table", "price", "x", "y", "z")
cor_matrix <- create_correlation_plot(diamonds, num_vars)

# Save correlation matrix
png("plots/correlation_matrix.png", width = 10, height = 8, units = "in", res = 300)
create_correlation_plot(diamonds, num_vars)
dev.off()
cat("Correlation matrix plot saved to plots/correlation_matrix.png\n")

# Examine strongest correlations
cat("\nCorrelation between carat and price:", cor(diamonds$carat, diamonds$price), "\n")
cat("Correlation between x and price:", cor(diamonds$x, diamonds$price), "\n")

# ======================================================
# 6. Regression Analysis (Lab P8)
# ======================================================
print_section("Regression Analysis")

# Simple linear regression: Price vs. Carat
simple_model <- lm(price ~ carat, data = diamonds)
summary(simple_model)

# Multiple linear regression
multi_model <- lm(price ~ carat + cut + color + clarity, data = diamonds)
summary(multi_model)

# Advanced multiple regression
advanced_model <- lm(price ~ carat + cut + color + clarity + depth + table + x + y + z, 
                   data = diamonds)
summary(advanced_model)

# Plot residuals for advanced model
par(mfrow = c(2, 2))
plot(advanced_model)
par(mfrow = c(1, 1))

# Create residual plot
residual_plot <- ggplot(data.frame(fitted = fitted(advanced_model), 
                                  residuals = residuals(advanced_model)), 
                       aes(x = fitted, y = residuals)) +
  geom_point(alpha = 0.3) +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  labs(title = "Residual Plot for Advanced Regression Model",
       x = "Fitted Values", 
       y = "Residuals") +
  theme_minimal()
print(residual_plot)
save_plot(residual_plot, "advanced_model_residuals")

# ======================================================
# 7. Hypothesis Testing (Lab P9, P10)
# ======================================================
print_section("Hypothesis Testing")

# Two-sample t-test: Price difference between "Ideal" and "Premium" cuts
ideal_diamonds <- diamonds[diamonds$cut == "Ideal", ]
premium_diamonds <- diamonds[diamonds$cut == "Premium", ]

t_test_result <- t.test(ideal_diamonds$price, premium_diamonds$price)
print(t_test_result)

# Visualization of the test
cut_comparison <- ggplot() +
  geom_density(data = ideal_diamonds, aes(x = price, fill = "Ideal"), alpha = 0.5) +
  geom_density(data = premium_diamonds, aes(x = price, fill = "Premium"), alpha = 0.5) +
  scale_fill_manual(values = c("Ideal" = "blue", "Premium" = "red")) +
  labs(title = "Price Distribution by Cut: Ideal vs Premium",
       x = "Price", 
       y = "Density",
       fill = "Cut") +
  theme_minimal()
print(cut_comparison)
save_plot(cut_comparison, "cut_price_comparison")

# One-sample t-test: Is the mean diamond price different from $4000?
one_sample_test <- t.test(diamonds$price, mu = 4000)
print(one_sample_test)

# Chi-square test: Association between cut and color
chi_sq_test <- chisq.test(table(diamonds$cut, diamonds$color))
print(chi_sq_test)

# Visualize the relationship
cut_color_heatmap <- ggplot(diamonds, aes(x = color, y = cut)) +
  geom_count() +
  scale_size_area() +
  labs(title = "Association between Cut and Color",
       x = "Color", 
       y = "Cut") +
  theme_minimal()
print(cut_color_heatmap)
save_plot(cut_color_heatmap, "cut_color_heatmap")

# ======================================================
# 8. ANOVA Analysis (Lab P11)
# ======================================================
print_section("ANOVA Analysis")

# One-way ANOVA: Price differences among different cuts
anova_model <- aov(price ~ cut, data = diamonds)
summary(anova_model)

# Tukey's HSD post-hoc test
tukey_result <- TukeyHSD(anova_model)
print(tukey_result)

# Visualize ANOVA results
anova_plot <- ggplot(diamonds, aes(x = cut, y = price, fill = cut)) +
  geom_violin(trim = FALSE, alpha = 0.8) +
  geom_boxplot(width = 0.1, alpha = 0.2) +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Price Distribution by Cut (ANOVA Analysis)",
       x = "Cut", 
       y = "Price (USD)") +
  theme_minimal() +
  theme(legend.position = "none")
print(anova_plot)
save_plot(anova_plot, "anova_cut_price")

# Two-way ANOVA: Price differences by cut and color
two_way_anova <- aov(price ~ cut * color, data = diamonds)
summary(two_way_anova)

# ======================================================
# 9. Final Insights and Conclusions
# ======================================================
print_section("Final Insights and Conclusions")

cat("Key findings from the diamond dataset analysis:\n\n")
cat("1. The price of diamonds is most strongly correlated with carat (weight).\n")
cat("2. There are significant price differences among different cuts of diamonds.\n")
cat("3. The distribution of prices is positively skewed, but log-transformation helps normalize it.\n")
cat("4. Multiple regression analysis shows that carat, cut, color, and clarity together\n   explain a significant portion of the price variance.\n")
cat("5. ANOVA confirms statistically significant differences in prices across diamond qualities.\n")
cat("6. Linear models provide good predictive capability for diamond pricing.\n\n")

cat("The analysis demonstrates the practical application of statistical concepts\n")
cat("from probability distributions to hypothesis testing and regression analysis.\n") 