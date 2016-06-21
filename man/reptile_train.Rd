\name{reptile_train}
\alias{reptile_train}
\title{
  Learn a REPTILE enhancer model
}
\description{
  Learn a REPTILE enhancer model based on epigenomic signature of
  known enhancers.
}
\usage{
reptile_train(epimark_region, label_region,
              epimark_DMR = NULL, label_DMR = NULL,
              family = "randomForest", ntree = 2000,
              nodesize = 1)
}
\arguments{
  \item{epimark_region}{
    data.frame instance from read_epigenomic_data, which containing
    intensity and intensity deviation values of each mark for each query
    region.
  }
  \item{label_region}{
    factor instance from read_label, containing the label of each
    query region. The possible values and their meanings of a label
    are: 0 (not enhancer), 1 (enhancer) and NA (unknwon and it will be
    ignored).
  }
  \item{epimark_DMR}{
    data.frame instance from read_epigenomic_data, which containing
    intensity and intensity deviation values of each mark for each DMR.
    If either this value or label_DMR is NULL, the output enhancer model
    will not inlclude a classifier for predicting the enhancer
    activities of DMRs.  
    Default: NULL 
  }
  \item{label_DMR}{
    factor instance from read_label, containing the label of each
    DMR. The possible values and their meanings of a label
    are: 0 (not enhancer), 1 (enhancer) and NA (unknwon and it will be
    ignored).
    If either this value or label_DMR is NULL, the output
    enhancer model will not inlclude a classifier for predicting the
    enhancer activities of DMRs.
    Default: NULL 
  }
  \item{family}{
    classifier family used in the enhancer model

    Default: RandomForest

    Classifiers available:

    - RandomForest: random forest

    - Logistic: logistic regression
  }
  \item{ntree}{
    Number of tree to be constructed in the random forest model. See
    the function randomForest() in "randomForest" package for more
    information. 
    Default: 2000
  }
  \item{nodesize}{
    Minimum size of terminal nodes. See the function randomForest()
    in "randomForest" package for more information.
    Default: 1
  }
}
\value{
  A list containing two objects of class \code{randomForest}.
  \item{D}{Classifier for DMRs. It is an \code{randomForest} object or
    \code{glm} object when \code{family} is set to be "Logistic".}
  
  \item{R}{Classifier for query regions. It is an \code{randomForest}
    object or \code{glm} object when \code{family} is set to be
    "Logistic".}
}
\references{
  Breiman, L. (2001), \emph{Random Forests}, Machine Learning 45(1),
  5-32.

  A. Liaw and M. Wiener (2002), \emph{Classification and Regression by
  randomForest}, R News 2(3), 18--22.  
}
\author{
  Yupeng He \email{yupeng.he.bioinfo@gmail.com}
}

\seealso{
  \code{\link{read_epigenomic_data}},
  \code{\link{read_label}},
  \code{\link{reptile_predict}}
}
\examples{
library("REPTILE")
data("rsd")

## Training
rsd_model <- reptile_train(rsd$training_data$region_epimark,
                           rsd$training_data$region_label,
                           rsd$training_data$DMR_epimark,
                           rsd$training_data$DMR_label,
                           ntree=5)

print(rsd_model$D)
print(rsd_model$R)
}
\keyword{ model training }

