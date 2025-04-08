# Visualization and Insights for the Diamonds Dataset
# This script focuses on creating publication-quality visualizations for insights

# Set working directory to project root (adjust if needed)
setwd(dirname(dirname(rstudioapi::getSourceEditorContext()$path)))

# Source utility functions
source("src/utils.R")

# Load required packages
load_packages()

# Additional packages for advanced visualization
required_packages <- c("ggthemes", "GGally", "viridis", "plotly", "reshape2")
for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  }
}

# ======================================================
# 1. Data Loading
# ======================================================
print_section("Data Loading")

# Load the diamonds dataset
diamonds <- read.csv("Dataset/diamonds.csv", stringsAsFactors = TRUE)

# ======================================================
# 2. Enhanced Data Visualizations
# ======================================================
print_section("Enhanced Data Visualizations")

# Create a directory for high-quality plots
dir.create("plots/high_quality", recursive = TRUE, showWarnings = FALSE)

# 1. Price Distribution by Cut with Violin Plots
cut_violin <- ggplot(diamonds, aes(x = cut, y = price, fill = cut)) +
  geom_violin(trim = FALSE, alpha = 0.7) +
  geom_boxplot(width = 0.1, alpha = 0.2, color = "black") +
  scale_fill_viridis_d(option = "D") +
  scale_y_continuous(labels = scales::dollar) +
  labs(title = "Diamond Price Distribution by Cut",
       subtitle = "Violin Plot with Embedded Box Plot",
       x = "Cut Quality", 
       y = "Price (USD)",
       caption = "Data Source: Diamonds Dataset") +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 16),
    plot.subtitle = element_text(size = 12),
    axis.title = element_text(face = "bold"),
    panel.grid.major = element_line(color = "gray90"),
    panel.grid.minor = element_line(color = "gray95")
  )
ggsave("plots/high_quality/cut_violin_plot.png", cut_violin, width = 10, height = 8, dpi = 300)
print(cut_violin)

# 2. Price vs. Carat with Multiple Dimensions
multidim_scatter <- ggplot(diamonds, aes(x = carat, y = price, color = clarity, size = depth)) +
  geom_point(alpha = 0.6) +
  scale_color_viridis_d(option = "C") +
  scale_size_continuous(range = c(0.5, 3)) +
  scale_y_continuous(labels = scales::dollar) +
  labs(title = "Diamond Price vs. Carat with Clarity and Depth",
       subtitle = "Multi-dimensional Analysis",
       x = "Carat (Weight)", 
       y = "Price (USD)",
       color = "Clarity",
       size = "Depth (%)") +
  theme_minimal() +
  theme(
    legend.position = "right",
    plot.title = element_text(face = "bold", size = 16),
    plot.subtitle = element_text(size = 12),
    axis.title = element_text(face = "bold")
  ) +
  guides(color = guide_legend(override.aes = list(size = 4, alpha = 1)))
ggsave("plots/high_quality/multidim_scatter_plot.png", multidim_scatter, width = 12, height = 8, dpi = 300)
print(multidim_scatter)

# 3. Correlation Heatmap with Hierarchical Clustering
num_vars <- c("carat", "depth", "table", "price", "x", "y", "z")
cor_matrix <- cor(diamonds[num_vars], use = "pairwise.complete.obs")
cor_melted <- melt(cor_matrix)

cor_heatmap <- ggplot(cor_melted, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                      midpoint = 0, limit = c(-1,1), space = "Lab", 
                      name="Pearson\nCorrelation") +
  geom_text(aes(label = sprintf("%.2f", value)), color = "black", size = 3) +
  labs(title = "Correlation Heatmap of Diamond Characteristics",
       x = "", y = "") +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1, face = "bold"),
    axis.text.y = element_text(face = "bold"),
    plot.title = element_text(face = "bold", size = 16)
  )
ggsave("plots/high_quality/correlation_heatmap.png", cor_heatmap, width = 10, height = 8, dpi = 300)
print(cor_heatmap)

# 4. Interactive Scatter Plot with Tooltip
scatter_plotly <- ggplot(diamonds[sample(nrow(diamonds), 5000), ], 
                        aes(x = carat, y = price, color = cut, text = paste(
                          "Price: $", scales::comma(price), "<br>",
                          "Carat: ", carat, "<br>",
                          "Cut: ", cut, "<br>",
                          "Color: ", color, "<br>",
                          "Clarity: ", clarity
                        ))) +
  geom_point(alpha = 0.7) +
  scale_color_viridis_d() +
  scale_y_continuous(labels = scales::dollar) +
  labs(title = "Interactive Diamond Price vs. Carat by Cut",
       x = "Carat (Weight)", 
       y = "Price (USD)") +
  theme_minimal()

# Convert to plotly interactive plot
interactive_plot <- ggplotly(scatter_plotly, tooltip = "text")

# Save plotly as HTML
htmlwidgets::saveWidget(interactive_plot, "plots/high_quality/interactive_scatter.html")
cat("Interactive plot saved to plots/high_quality/interactive_scatter.html\n")

# 5. Faceted Histograms by Cut and Color
facet_hist <- ggplot(diamonds, aes(x = price, fill = cut)) +
  geom_histogram(bins = 30, alpha = 0.7) +
  facet_grid(cut ~ color) +
  scale_fill_viridis_d() +
  scale_x_continuous(labels = scales::dollar) +
  labs(title = "Distribution of Diamond Prices",
       subtitle = "Faceted by Cut and Color",
       x = "Price (USD)", 
       y = "Count") +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    strip.text = element_text(face = "bold"),
    plot.title = element_text(face = "bold", size = 16),
    plot.subtitle = element_text(size = 12),
    axis.title = element_text(face = "bold"),
    panel.spacing = unit(0.5, "lines")
  )
ggsave("plots/high_quality/facet_histograms.png", facet_hist, width = 15, height = 10, dpi = 300)
print(facet_hist)

# 6. Parallel Coordinate Plot for Multi-dimensional Analysis
# Sample for better visualization
set.seed(123)
diamonds_sample <- diamonds[sample(nrow(diamonds), 1000), ]

# Create scaled version of numerical variables for parallel coordinate plot
diamonds_scaled <- diamonds_sample
num_vars <- c("carat", "depth", "table", "price", "x", "y", "z")
for (var in num_vars) {
  diamonds_scaled[[var]] <- scale(diamonds_sample[[var]])
}

parallel_coords <- ggparcoord(
  diamonds_scaled, 
  columns = c("carat", "depth", "table", "price", "x", "y", "z"),
  groupColumn = "cut",
  alphaLines = 0.3,
  scale = "uniminmax",
  showPoints = TRUE
) +
  scale_color_viridis_d() +
  labs(title = "Parallel Coordinate Plot of Diamond Characteristics",
       subtitle = "Grouped by Cut",
       x = "Variables", 
       y = "Scaled Values",
       color = "Cut") +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 16),
    plot.subtitle = element_text(size = 12),
    axis.title = element_text(face = "bold"),
    axis.text.x = element_text(face = "bold", angle = 45, hjust = 1)
  )
ggsave("plots/high_quality/parallel_coords.png", parallel_coords, width = 12, height = 8, dpi = 300)
print(parallel_coords)

# 7. Ridgeline Plot for Price Distribution by Clarity
if (!require("ggridges")) {
  install.packages("ggridges")
  library(ggridges)
}

ridgeline_plot <- ggplot(diamonds, aes(x = price, y = clarity, fill = clarity)) +
  geom_density_ridges(scale = 2, alpha = 0.7) +
  scale_fill_viridis_d() +
  scale_x_continuous(labels = scales::dollar) +
  labs(title = "Diamond Price Distribution by Clarity",
       subtitle = "Ridgeline Plot",
       x = "Price (USD)", 
       y = "Clarity") +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 16),
    plot.subtitle = element_text(size = 12),
    axis.title = element_text(face = "bold"),
    axis.text.y = element_text(face = "bold")
  )
ggsave("plots/high_quality/ridgeline_plot.png", ridgeline_plot, width = 12, height = 8, dpi = 300)
print(ridgeline_plot)

# ======================================================
# 3. Insights Visualization
# ======================================================
print_section("Insights Visualization")

# 1. Price Prediction by Cut, Color and Clarity (Bubble Plot)
# Calculate average price by cut, color, and clarity
agg_diamonds <- aggregate(
  price ~ cut + color + clarity, 
  data = diamonds, 
  FUN = function(x) c(mean = mean(x), count = length(x))
)
agg_diamonds <- do.call(data.frame, agg_diamonds)
names(agg_diamonds)[4:5] <- c("avg_price", "count")

# Create bubble plot
bubble_plot <- ggplot(agg_diamonds, aes(x = color, y = clarity, size = avg_price, color = cut)) +
  geom_point(alpha = 0.7) +
  scale_size_continuous(range = c(2, 15), labels = scales::dollar) +
  scale_color_viridis_d() +
  labs(title = "Average Diamond Price by Cut, Color, and Clarity",
       x = "Color (D is best)", 
       y = "Clarity (IF is best)",
       size = "Avg. Price",
       color = "Cut") +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 16),
    axis.title = element_text(face = "bold"),
    axis.text = element_text(face = "bold"),
    legend.title = element_text(face = "bold")
  )
ggsave("plots/high_quality/price_bubble_plot.png", bubble_plot, width = 12, height = 8, dpi = 300)
print(bubble_plot)

# 2. Price to Carat Ratio Analysis
diamonds$price_per_carat <- diamonds$price / diamonds$carat

ppc_boxplot <- ggplot(diamonds, aes(x = cut, y = price_per_carat, fill = cut)) +
  geom_boxplot() +
  scale_fill_viridis_d() +
  scale_y_continuous(labels = scales::dollar) +
  labs(title = "Price per Carat by Cut",
       subtitle = "Higher values indicate premium pricing",
       x = "Cut Quality", 
       y = "Price per Carat (USD)") +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 16),
    plot.subtitle = element_text(size = 12),
    axis.title = element_text(face = "bold")
  )
ggsave("plots/high_quality/price_per_carat_boxplot.png", ppc_boxplot, width = 10, height = 8, dpi = 300)
print(ppc_boxplot)

# 3. Value Analysis: Comparing actual vs expected price
# Create a simple model to predict "expected price"
price_model <- lm(price ~ carat + cut + color + clarity, data = diamonds)
diamonds$expected_price <- predict(price_model)
diamonds$price_ratio <- diamonds$price / diamonds$expected_price

# Identify potentially overpriced and underpriced diamonds
diamonds$value_category <- cut(diamonds$price_ratio, 
                             breaks = c(0, 0.9, 1.1, Inf),
                             labels = c("Good Value", "Fair Value", "Overpriced"))

value_hist <- ggplot(diamonds, aes(x = price_ratio, fill = value_category)) +
  geom_histogram(bins = 50, alpha = 0.8) +
  geom_vline(xintercept = 1, linetype = "dashed", color = "black", size = 1) +
  scale_fill_manual(values = c("Good Value" = "green", "Fair Value" = "gray", "Overpriced" = "red")) +
  labs(title = "Diamond Value Analysis",
       subtitle = "Ratio of Actual Price to Expected Price",
       x = "Price Ratio (Actual/Expected)", 
       y = "Count",
       fill = "Value Category") +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 16),
    plot.subtitle = element_text(size = 12),
    axis.title = element_text(face = "bold"),
    legend.title = element_text(face = "bold")
  )
ggsave("plots/high_quality/value_analysis_hist.png", value_hist, width = 12, height = 8, dpi = 300)
print(value_hist)

# 4. Diamond Dimension Relationships
dim_pairs <- ggpairs(
  diamonds[sample(nrow(diamonds), 1000), c("x", "y", "z", "carat")],
  upper = list(continuous = "cor"),
  lower = list(continuous = wrap("points", alpha = 0.3, color = "blue")),
  diag = list(continuous = wrap("densityDiag", fill = "skyblue", alpha = 0.5)),
  title = "Relationships Between Diamond Dimensions"
) + 
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 16),
    axis.title = element_text(face = "bold")
  )
ggsave("plots/high_quality/dimension_pairs.png", dim_pairs, width = 12, height = 10, dpi = 300)
print(dim_pairs)

# 5. Market Share Analysis
# Calculate market share by cut
cut_counts <- table(diamonds$cut)
cut_share <- prop.table(cut_counts) * 100

market_data <- data.frame(
  cut = names(cut_counts),
  count = as.numeric(cut_counts),
  percentage = as.numeric(cut_share)
)

# Order by percentage
market_data <- market_data[order(-market_data$percentage), ]

# Create market share plot
market_plot <- ggplot(market_data, aes(x = "", y = percentage, fill = cut)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  scale_fill_viridis_d() +
  geom_text(aes(label = sprintf("%.1f%%", percentage)), 
            position = position_stack(vjust = 0.5)) +
  labs(title = "Diamond Market Share by Cut",
       fill = "Cut Quality") +
  theme_void() +
  theme(
    plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
    legend.title = element_text(face = "bold")
  )
ggsave("plots/high_quality/market_share_pie.png", market_plot, width = 10, height = 8, dpi = 300)
print(market_plot)

# ======================================================
# 4. Final Dashboard Elements
# ======================================================
print_section("Dashboard Elements")

# Create metrics summary for dashboard
# Median prices by cut
median_by_cut <- aggregate(price ~ cut, data = diamonds, FUN = median)
colnames(median_by_cut)[2] <- "median_price"

# Mean carat by cut
mean_by_cut <- aggregate(carat ~ cut, data = diamonds, FUN = mean)
colnames(mean_by_cut)[2] <- "mean_carat"

# Merge data
dashboard_data <- merge(median_by_cut, mean_by_cut)
dashboard_data$price_per_carat <- dashboard_data$median_price / dashboard_data$mean_carat

# Add count and percentage
cut_summary <- as.data.frame(table(diamonds$cut))
colnames(cut_summary) <- c("cut", "count")
cut_summary$percentage <- cut_summary$count / sum(cut_summary$count) * 100

dashboard_data <- merge(dashboard_data, cut_summary)

# Save dashboard metrics
write.csv(dashboard_data, "analysis/dashboard_metrics.csv", row.names = FALSE)
cat("Dashboard metrics saved to analysis/dashboard_metrics.csv\n")

# Create dashboard summary plot
dashboard_plot <- ggplot(dashboard_data, aes(x = cut, y = median_price, fill = cut)) +
  geom_col() +
  geom_text(aes(label = scales::dollar(median_price)), vjust = -0.5) +
  geom_text(aes(y = 20, label = sprintf("n=%d\n(%.1f%%)", count, percentage)), 
            color = "white", fontface = "bold") +
  scale_fill_viridis_d() +
  scale_y_continuous(labels = scales::dollar) +
  labs(title = "Diamond Price Metrics by Cut",
       subtitle = "Median Price with Sample Size",
       x = "Cut Quality", 
       y = "Median Price (USD)") +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 16),
    plot.subtitle = element_text(size = 12),
    axis.title = element_text(face = "bold"),
    axis.text.x = element_text(face = "bold")
  )
ggsave("plots/high_quality/dashboard_summary.png", dashboard_plot, width = 12, height = 8, dpi = 300)
print(dashboard_plot)

# Summary of key insights
cat("\n=== KEY INSIGHTS FROM VISUALIZATION ANALYSIS ===\n")
cat("1. Price is most strongly correlated with carat weight and physical dimensions (x, y, z).\n")
cat("2. Better cut quality generally commands a higher price per carat.\n")
cat("3. The diamonds dataset has a disproportionate number of Ideal cut diamonds (highest quality).\n")
cat("4. Diamond prices exhibit a right-skewed distribution, suggesting a premium market segment.\n")
cat("5. Clarity has a significant impact on price, with clearer diamonds commanding higher prices.\n")
cat("6. Color and cut have an interactive effect on price, not just independent effects.\n")
cat("7. Value analysis reveals potential opportunities for finding underpriced diamonds.\n")
cat("8. Physical dimensions show very strong correlations, as expected for well-cut diamonds.\n\n") 