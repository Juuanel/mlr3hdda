LearnerClassifHDDA = R6Class("LearnerClassifHDDA",
  inherit = mlr3::LearnerClassif,

  public = list(
    initialize = function() {
      param_set = ps(
        model = p_fct(
          levels = c("AkjBkQkDk", "AkBkQkDk", "ABkQkDk", "AkjBQkDk", "AkBQkDk", "ABQkDk", "AkjBkQkD", "AkBkQkD", "ABkQkD", "AkjBQkD", "AkBQkD", "ABQkD", "AjBQD", "ABQD", "ALL"),
          default = "AkjBkQkDk", tags = "train"),
        d_select = p_fct(
          levels = c("Cattell", "BIC", "CV"),
          default = "Cattell",
          tags = "train"),
        threshold = p_dbl(
          lower = .Machine$double.xmin,
          upper = 1 - .Machine$double.eps / 2,
          tolerance = 0,
          default = 0.2,
          tags = "train"),
        scaling = p_lgl(
          default = FALSE,
          tags = "train")
      )

      super$initialize(
        id = "classif.hdda",
        param_set = param_set,
        predict_types = c("response", "prob"),
        feature_types = c("integer", "numeric"),
        properties = c("twoclass", "multiclass"),
        packages = "HDclassif",
        label = "High Dimensional Discriminant Analysis",
        man = "mlr3hdda::LearnerClassifHDDA"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      data = as.data.frame(task$data(cols = task$feature_names))
      target = task$truth()

      invoke(HDclassif::hdda, data = data, cls = target, show = FALSE, .args = pv)
    },

    .predict = function(task) {
      feats = self$state$train_task$feature_names
      newdata = as.data.frame(task$data(cols = feats))

      pred = predict(self$model, newdata)

      levs = task$class_names
      response = factor(as.character(pred$class), levels = levs)
      if (self$predict_type == "prob") {
        prob = unclass(pred$posterior)
        rownames(prob) = NULL
        list(prob = prob[, levs, drop = FALSE], response = response)
      } else {
        list(response = response)
      }
    }
  )
)
