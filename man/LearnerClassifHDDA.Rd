\name{LearnerClassifHDDA}
\alias{LearnerClassifHDDA}
\title{High Dimensional Discriminant Analysis Classification Learner}
\description{
  Classification learner for mlr3 that calls HDclassif::hdda().

  Hyperparameters, passed to HDclassif::hdda():
  \describe{
    \item{model}{
      One of the 14 models of hdda() (default "AkjBkQkDk"), or "ALL" to estimate all
      models and keep the one with the highest BIC.}
    \item{d_select}{"Cattell" (default), "BIC" or "CV".}
    \item{threshold}{Strictly within 0 and 1 (default 0.2).}
    \item{scaling}{TRUE or FALSE (default).}
  }
  Other arguments of hdda() (such as com_dim, cv.dim, cv.threshold, cv.vfold or noise.ctrl) are not supported by this learner, and thus always take their default values.
  Please refer to HDclassif::hdda for more details.      
}
\author{Juanel WALOP}
\examples{
task = mlr3::tsk("iris")
learner = LearnerClassifHDDA$new()
learner$train(task)
pred = learner$predict(task)
pred$score()
}
