\name{reptile_predict_genome_wide}
\alias{reptile_predict_genome_wide}
\title{
  Predicting enhancer activity
}
\description{
  Predicting enhancer activities of query regions based on the enhancer
  model from \code{reptile_train} in training step. This function
  calculates the enhancer scores of DMRs and query regions. It does not
  try to generate combined enhancer scores.
}
\usage{
reptile_predict_genome_wide(reptile_model,
                            epimark_region,
                            epimark_DMR = NULL,
                            family = "randomForest")
}
\arguments{
  \item{reptile_model}{
    Enhancer model from \code{reptile_train}. It is a list containing
    two objects of class \code{randomForest} or \code{glm} when
    \code{family} is set to be "Logistic"
  }
  \item{epimark_region}{
    data.frame instance from read_epigenomic_data, which containing
    intensity and intensity deviation values of each mark for each query
    region
  }
  \item{epimark_DMR}{
    data.frame instance from read_epigenomic_data, which containing
    intensity and intensity deviation values of each mark for each DMR
  }
  \item{family}{
    classifier family used in the enhancer model
	
    Default: RandomForest

    Classifiers available:

    - RandomForest: random forest

    - Logistic: logistic regression
  }
}
\value{
  A list containing two vectors
  \item{R}{Enhancer score of each query region}
  \item{DMR}{Enhancer score of each DMR}
}
\author{
  Yupeng He \email{yupeng.he.bioinfo@gmail.com}
}

\seealso{
  \code{\link{reptile_predict}}

  \code{\link{reptile_train}}

  \code{\link{read_epigenomic_data}}

  \code{\link{read_label}}
}
\examples{
library("REPTILE")
data("rsd")

## Training
rsd_model <- reptile_train(rsd$training_data$region_epimark,
                           rsd$training_data$region_label,
                           rsd$training_data$DMR_epimark,
                           rsd$training_data$DMR_label,
                           ntree=50)

## Prediction
## - REPTILE
pred <- reptile_predict(rsd_model,
                        rsd$test_data$region_epimark,
                        rsd$test_data$DMR_epimark)
## - Random guessing
pred_guess = runif(length(pred$D))
names(pred_guess) = names(pred$D)

## Evaluation
res_reptile <- reptile_eval_prediction(pred$D,
                                       rsd$test_data$region_label)
res_guess <- reptile_eval_prediction(pred_guess,
                                     rsd$test_data$region_label)
## - Print AUROC and AUPR
cat(paste0("REPTILE\n",
           "  AUROC = ",round(res_reptile$AUROC,digit=3),
           "\n",
           "  AUPR  = ",round(res_reptile$AUPR,digit=3))
    ,"\n")
cat(paste0("Random guessing\n",
           "  AUROC = ",round(res_guess$AUROC,digit=3),
           "\n",
           "  AUPR  = ",round(res_guess$AUPR,digit=3))
   ,"\n")
}
\keyword{ prediction }
