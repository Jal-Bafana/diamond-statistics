# Advanced Modeling for the Diamonds Dataset
# This script focuses on more advanced statistical methods and predictive modeling

# Set working directory to project root (adjust if needed)
setwd(dirname(dirname(rstudioapi::getSourceEditorContext()$path)))

# Source utility functions
source("src/utils.R")

# Load required packages
load_packages()

# Additional packages for advanced modeling
required_packages <- c("rpart", "rpart.plot", "randomForest", "caret", "e1071")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  }
}

# ======================================================
# 1. Data Loading and Preparation
# ======================================================
print_section("Data Loading and Preparation")

# Load the diamonds dataset
diamonds <- read.csv("Dataset/diamonds.csv", stringsAsFactors = TRUE)

# Create log transformed price variable
diamonds$log_price <- log(diamonds$price)

# Split the dataset into training and testing sets
set.seed(123)  # For reproducibility
train_indices <- sample(1:nrow(diamonds), 0.7 * nrow(diamonds))
train_data <- diamonds[train_indices, ]
test_data <- diamonds[-train_indices, ]

cat("Training data dimensions:", dim(train_data)[1], "rows and", dim(train_data)[2], "columns\n")
cat("Testing data dimensions:", dim(test_data)[1], "rows and", dim(test_data)[2], "columns\n")

# ======================================================
# 2. Advanced Regression Analysis
# ======================================================
print_section("Advanced Regression Analysis")

# Non-linear transformation models
# Polynomial regression
poly_model <- lm(price ~ poly(carat, 2) + cut + color + clarity, data = train_data)
summary(poly_model)

# Log-transformed model (often better for price data)
log_model <- lm(log_price ~ carat + cut + color + clarity, data = train_data)
summary(log_model)

# Interaction effects
interaction_model <- lm(price ~ carat * cut + color + clarity, data = train_data)
summary(interaction_model)

# Model comparison using AIC
models <- list(
  "Linear" = lm(price ~ carat + cut + color + clarity, data = train_data),
  "Polynomial" = poly_model,
  "Log-transformed" = log_model,
  "Interaction" = interaction_model
)

aic_values <- sapply(models, AIC)
cat("\nAIC values for different models:\n")
print(aic_values)
cat("\nBest model based on AIC:", names(aic_values)[which.min(aic_values)], "\n")

# ======================================================
# 3. Decision Tree Analysis
# ======================================================
print_section("Decision Tree Analysis")

# Train decision tree for price prediction
tree_model <- rpart(price ~ carat + cut + color + clarity, 
                   data = train_data, 
                   method = "anova",
                   control = rpart.control(minsplit = 20, cp = 0.01))

# Plot decision tree
png("plots/decision_tree.png", width = 12, height = 10, units = "in", res = 300)
rpart.plot(tree_model, extra = 101, under = TRUE, box.palette = "RdBu", 
          fallen.leaves = TRUE, main = "Decision Tree for Diamond Price Prediction")
dev.off()
cat("Decision tree plot saved to plots/decision_tree.png\n")

# Evaluate tree model on test data
tree_predictions <- predict(tree_model, test_data)
tree_rmse <- sqrt(mean((tree_predictions - test_data$price)^2))
tree_r2 <- cor(tree_predictions, test_data$price)^2

cat("\nDecision Tree Model Performance:\n")
cat("RMSE:", tree_rmse, "\n")
cat("R-squared:", tree_r2, "\n")

# ======================================================
# 4. Random Forest Analysis
# ======================================================
print_section("Random Forest Analysis")

# Train a random forest model on a smaller subset for efficiency
set.seed(456)
sample_indices <- sample(1:nrow(train_data), min(10000, nrow(train_data)))
sample_train <- train_data[sample_indices, ]

rf_model <- randomForest(price ~ carat + cut + color + clarity + depth + table + x + y + z,
                        data = sample_train,
                        ntree = 100,
                        importance = TRUE)
print(rf_model)

# Variable importance
importance_values <- importance(rf_model)
cat("\nVariable Importance:\n")
print(importance_values)

# Plot variable importance
png("plots/variable_importance.png", width = 10, height = 8, units = "in", res = 300)
varImpPlot(rf_model, main = "Variable Importance for Diamond Price Prediction")
dev.off()
cat("Variable importance plot saved to plots/variable_importance.png\n")

# Evaluate random forest on test data
rf_predictions <- predict(rf_model, test_data)
rf_rmse <- sqrt(mean((rf_predictions - test_data$price)^2))
rf_r2 <- cor(rf_predictions, test_data$price)^2

cat("\nRandom Forest Model Performance:\n")
cat("RMSE:", rf_rmse, "\n")
cat("R-squared:", rf_r2, "\n")

# ======================================================
# 5. Price Prediction by Features Combination
# ======================================================
print_section("Price Prediction by Features Combination")

# Predict average prices for combinations of cut, color, and clarity
prediction_df <- expand.grid(
  cut = levels(diamonds$cut),
  color = levels(diamonds$color),
  clarity = levels(diamonds$clarity),
  carat = c(0.5, 1.0, 1.5, 2.0)  # Common carat values
)

# Add other average values for remaining numeric features
avg_depth <- mean(diamonds$depth)
avg_table <- mean(diamonds$table)
avg_x <- mean(diamonds$x)
avg_y <- mean(diamonds$y)
avg_z <- mean(diamonds$z)

prediction_df$depth <- avg_depth
prediction_df$table <- avg_table
prediction_df$x <- avg_x
prediction_df$y <- avg_y
prediction_df$z <- avg_z

# Make predictions using the random forest model
prediction_df$predicted_price <- predict(rf_model, prediction_df)

# Create a sample price prediction table for one carat
one_carat_predictions <- prediction_df[prediction_df$carat == 1.0, ]
one_carat_table <- reshape2::dcast(one_carat_predictions, 
                                  cut ~ clarity + color, 
                                  value.var = "predicted_price")

# Save prediction table to CSV
write.csv(prediction_df, "analysis/price_predictions.csv", row.names = FALSE)
cat("Price predictions saved to analysis/price_predictions.csv\n")

# Create a heatmap for price predictions (1 carat diamonds)
one_carat_df <- prediction_df[prediction_df$carat == 1.0, ]
one_carat_df$cut_clarity <- paste(one_carat_df$cut, one_carat_df$clarity, sep = "-")

price_heatmap <- ggplot(one_carat_df, aes(x = color, y = cut_clarity, fill = predicted_price)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "steelblue", labels = scales::dollar) +
  labs(title = "Predicted Prices for 1 Carat Diamonds",
       x = "Color", 
       y = "Cut-Clarity Combination",
       fill = "Predicted Price") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 0),
        axis.text.y = element_text(size = 7))
print(price_heatmap)
save_plot(price_heatmap, "price_prediction_heatmap", width = 12, height = 10)

# ======================================================
# 6. Bootstrap Analysis for Price Confidence Intervals
# ======================================================
print_section("Bootstrap Analysis for Price Confidence Intervals")

# Function to perform bootstrap analysis
bootstrap_ci <- function(data, var, n_boots = 1000, conf_level = 0.95) {
  set.seed(789)
  boot_means <- numeric(n_boots)
  
  for (i in 1:n_boots) {
    boot_sample <- sample(data[[var]], size = length(data[[var]]), replace = TRUE)
    boot_means[i] <- mean(boot_sample)
  }
  
  # Calculate confidence interval
  alpha <- 1 - conf_level
  ci_lower <- quantile(boot_means, alpha/2)
  ci_upper <- quantile(boot_means, 1 - alpha/2)
  
  return(list(
    mean = mean(data[[var]]),
    lower = ci_lower,
    upper = ci_upper,
    boot_means = boot_means
  ))
}

# Bootstrap analysis for diamond prices by cut
cut_levels <- levels(diamonds$cut)
cut_ci_results <- data.frame(
  cut = cut_levels,
  mean_price = numeric(length(cut_levels)),
  lower_ci = numeric(length(cut_levels)),
  upper_ci = numeric(length(cut_levels))
)

for (i in 1:length(cut_levels)) {
  cut_data <- diamonds[diamonds$cut == cut_levels[i], ]
  boot_result <- bootstrap_ci(cut_data, "price", n_boots = 1000)
  
  cut_ci_results$mean_price[i] <- boot_result$mean
  cut_ci_results$lower_ci[i] <- boot_result$lower
  cut_ci_results$upper_ci[i] <- boot_result$upper
}

print(cut_ci_results)

# Create bootstrap CI plot
bootstrap_plot <- ggplot(cut_ci_results, aes(x = cut, y = mean_price, color = cut)) +
  geom_point(size = 3) +
  geom_errorbar(aes(ymin = lower_ci, ymax = upper_ci), width = 0.2) +
  scale_y_continuous(labels = scales::dollar) +
  labs(title = "Bootstrap 95% Confidence Intervals for Mean Diamond Price by Cut",
       x = "Cut", 
       y = "Mean Price (USD)") +
  theme_minimal() +
  theme(legend.position = "none")
print(bootstrap_plot)
save_plot(bootstrap_plot, "bootstrap_ci_plot")

# ======================================================
# 7. Final Model Comparison
# ======================================================
print_section("Final Model Comparison")

# Compare performance of different models
# Function to calculate performance metrics
calculate_metrics <- function(actual, predicted) {
  rmse <- sqrt(mean((actual - predicted)^2))
  mae <- mean(abs(actual - predicted))
  r2 <- cor(actual, predicted)^2
  
  return(c(RMSE = rmse, MAE = mae, R2 = r2))
}

# Simple linear model
lm_simple <- lm(price ~ carat, data = train_data)
lm_predictions <- predict(lm_simple, test_data)

# Multiple linear model
lm_multi <- lm(price ~ carat + cut + color + clarity, data = train_data)
lm_multi_predictions <- predict(lm_multi, test_data)

# Advanced linear model
lm_advanced <- lm(price ~ carat + cut + color + clarity + depth + table + x + y + z, 
                 data = train_data)
lm_advanced_predictions <- predict(lm_advanced, test_data)

# Create performance comparison dataframe
model_names <- c("Simple Linear", "Multiple Linear", "Advanced Linear", 
                "Decision Tree", "Random Forest")
predictions_list <- list(
  lm_predictions, 
  lm_multi_predictions, 
  lm_advanced_predictions,
  tree_predictions,
  rf_predictions
)

performance_matrix <- sapply(predictions_list, calculate_metrics, 
                            actual = test_data$price)
colnames(performance_matrix) <- model_names

# Print performance comparison
print(performance_matrix)

# Save performance comparison
write.csv(performance_matrix, "analysis/model_performance.csv")
cat("Model performance comparison saved to analysis/model_performance.csv\n")

# Create bar plot of model performance (R-squared)
performance_df <- data.frame(
  Model = model_names,
  R2 = performance_matrix["R2", ]
)

r2_plot <- ggplot(performance_df, aes(x = Model, y = R2, fill = Model)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = sprintf("%.3f", R2)), vjust = -0.5) +
  labs(title = "Model Performance Comparison (R-squared)",
       x = "Model", 
       y = "R-squared") +
  theme_minimal() +
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 45, hjust = 1))
print(r2_plot)
save_plot(r2_plot, "model_comparison_r2") 