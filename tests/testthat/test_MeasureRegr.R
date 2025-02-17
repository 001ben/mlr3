context("MeasureRegr")

test_that("Regression measures", {
  keys = mlr_measures$keys()
  task = tsk("boston_housing")
  learner = lrn("regr.featureless")
  learner$train(task)
  p = learner$predict(task)

  for (key in keys) {
    m = mlr_measures$get(key)
    if (is.na(m$task_type) || m$task_type == "regr") {
      perf = m$score(prediction = p, task = task, learner = learner)
      expect_number(perf, na.ok = "na_score" %in% m$properties, lower = m$range[1], upper = m$range[2])
    }
  }
})
