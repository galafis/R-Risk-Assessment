
# Risk Assessment and Management Tools
# Author: Gabriel Demetrios Lafis

library(ggplot2)
library(dplyr)

# Function to calculate a simple risk score
calculate_risk_score <- function(likelihood, impact) {
  if (!is.numeric(likelihood) || !is.numeric(impact) || likelihood < 0 || impact < 0) {
    stop("Likelihood and impact must be non-negative numeric values.")
  }
  return(likelihood * impact)
}

# Function to generate a risk matrix plot
generate_risk_matrix_plot <- function(risk_data) {
  if (!is.data.frame(risk_data) || !("likelihood" %in% names(risk_data)) || !("impact" %in% names(risk_data)) || !("risk_score" %in% names(risk_data))) {
    stop("risk_data must be a data frame with 'likelihood', 'impact', and 'risk_score' columns.")
  }
  
  plot <- ggplot(risk_data, aes(x = likelihood, y = impact, size = risk_score, color = risk_score)) +
    geom_point(alpha = 0.7) +
    scale_color_gradient(low = "blue", high = "red") +
    labs(title = "Risk Matrix",
         x = "Likelihood",
         y = "Impact",
         size = "Risk Score",
         color = "Risk Score") +
    theme_minimal()
  
  return(plot)
}

# Main function to run the assessment
main <- function() {
  cat("🚀 Risk Assessment and Management Tools\n")
  cat("👨‍💻 Created by Gabriel Demetrios Lafis\n\n")
  
  # Sample risk data
  sample_risks <- data.frame(
    likelihood = c(1, 2, 3, 4, 5, 2, 3, 4, 1, 5),
    impact = c(5, 4, 3, 2, 1, 3, 5, 1, 4, 2)
  )
  
  # Calculate risk scores
  sample_risks$risk_score <- mapply(calculate_risk_score, sample_risks$likelihood, sample_risks$impact)
  
  # Generate and save plot
  risk_plot <- generate_risk_matrix_plot(sample_risks)
  ggsave("R-Risk-Assessment/assets/risk_matrix.png", risk_plot, width = 8, height = 6, dpi = 300)
  
  cat("✅ Risk analysis complete! Plot saved to assets/risk_matrix.png\n")
}

# Run main function if script is executed directly
if (sys.nframe() == 0) {
  main()
}

