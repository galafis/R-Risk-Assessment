
library(testthat)
library(ggplot2)

source("../src/main.R")

# Test for calculate_risk_score function
test_that("calculate_risk_score returns correct value", {
  expect_equal(calculate_risk_score(2, 3), 6)
  expect_equal(calculate_risk_score(5, 1), 5)
  expect_equal(calculate_risk_score(0, 0), 0)
})

test_that("calculate_risk_score handles invalid input", {
  expect_error(calculate_risk_score(-1, 3), "Likelihood and impact must be non-negative numeric values.")
  expect_error(calculate_risk_score(2, -3), "Likelihood and impact must be non-negative numeric values.")
  expect_error(calculate_risk_score("a", 3), "Likelihood and impact must be non-negative numeric values.")
})

# Test for generate_risk_matrix_plot function
test_that("generate_risk_matrix_plot returns a ggplot object", {
  test_data <- data.frame(
    likelihood = c(1, 2),
    impact = c(3, 4),
    risk_score = c(3, 8)
  )
  plot_obj <- generate_risk_matrix_plot(test_data)
  expect_s3_class(plot_obj, "ggplot")
})

test_that("generate_risk_matrix_plot handles invalid input", {
  invalid_data_missing_col <- data.frame(
    likelihood = c(1, 2),
    impact = c(3, 4)
  )
  expect_error(generate_risk_matrix_plot(invalid_data_missing_col), "risk_data must be a data frame with 'likelihood', 'impact', and 'risk_score' columns.")
  
  invalid_data_not_df <- list(likelihood = c(1,2), impact = c(3,4), risk_score = c(3,8))
  expect_error(generate_risk_matrix_plot(invalid_data_not_df), "risk_data must be a data frame with 'likelihood', 'impact', and 'risk_score' columns.")
})

