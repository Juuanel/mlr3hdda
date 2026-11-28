# mlr3hdda
An mlr3 classification Learner wrapping HDclassif::hdda() (High Dimensional Discriminant Analysis)

## Installation
```r
remotes::install_github("Juuanel/mlr3hdda")
```

## Usage
```r
task = mlr3::tsk("iris")
learner = mlr3hdda::LearnerClassifHDDA$new()
learner$train(task)
pred = learner$predict(task)
pred$score()
```

## Related work
* [Course project wiki](https://github.com/tdhock/2026-08-aa-grande-echelle/wiki/projets)
* [HDclassif on CRAN](https://cran.r-project.org/package=HDclassif)
