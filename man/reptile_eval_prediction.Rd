\name{reptile_eval_prediction}
\alias{reptile_eval_prediction}
\title{
  Evaluating the prediction results
}
\description{
  Function used to evaluate the predictions by comparing
  enhancer scores from \code{reptile_predict} or
  \code{reptile_predict_genome_wide} and the correct labels. Area under
  the Receiver Operating Characteristic (ROC) curve (AUROC) and Area
  under the Precision-Recall curve (AUPR) will be calculated.
}
\usage{
reptile_eval_prediction(predictions,annotations)
}
\arguments{
  \item{predictions}{
    vector of enhancer scores for regions. The name of each value
    (score) corresponds to the id of the region.
  }
  \item{annotations}{
    vector of labels for regions with the same length as predictions.
    The name of each value (label) corresponds to the id of the
    region. Only two values are allowed in \code{annotations}: 0
    (negative) and 1 (positive). No \code{NA} is allowed.
  }
}
\value{
  A list containing two numbers
  \item{AUROC}{Area under the Receiver Operating Characteristic (ROC) curve}
  \item{AUPR}{Area under the Precision-Recall curve}
}
\author{
  Yupeng He \email{yupeng.he.bioinfo@gmail.com}
}

\seealso{
  \code{\link{reptile_predict}},
  \code{\link{reptile_predict_genome_wide}}
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
\keyword{ result evaluation }
