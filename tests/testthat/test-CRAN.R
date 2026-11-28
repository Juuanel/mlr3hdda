library(testthat)

test_that("hdda predicts a factor w/ one value per row and task class levels", {
  task <- mlr3::tsk("iris")
  learner <- mlr3hdda::LearnerClassifHDDA$new()
  learner$train(task)
  pred <- learner$predict(task)
  expect_s3_class(pred$response, "factor")
  expect_identical(levels(pred$response), task$class_names)
  expect_equal(length(pred$response), task$nrow)
})

test_that("hdda predicts a probs matrix w/ consistent dims and values", {
  task <- mlr3::tsk("iris")
  learner <- mlr3hdda::LearnerClassifHDDA$new()
  learner$predict_type <- "prob"
  learner$train(task)
  pred <- learner$predict(task)
  expect_true(is.matrix(pred$prob))
  expect_identical(colnames(pred$prob), task$class_names)
  expect_equal(nrow(pred$prob), task$nrow)
  expect_equal(unname(rowSums(pred$prob)), rep(1, task$nrow))
})

test_that("hdda learner checks hyperparameters values", {
  learner <- mlr3hdda::LearnerClassifHDDA$new()
  learner$param_set$values$threshold <- 0.1
  learner$param_set$values$scaling <- TRUE
  expect_error(learner$param_set$values$threshold <- 1)
  expect_error(learner$param_set$values$model <- "this_is_not_a_correct_model")
})
