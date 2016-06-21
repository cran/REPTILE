\name{reptile_predict_one_mode}
\alias{reptile_predict_one_mode}
\title{
  Internal - predicting enhancer activity of DMRs or query regions
}
\description{
  Internal function used to predict the enhancer activity of either DMRs
  or query regions.
}
\usage{
reptile_predict_one_mode(reptile_classifier,
                         epimark,
                         family)
}
\arguments{
  \item{reptile_classifier}{
    An object of class \code{randomForest} or \code{glm} when
    \code{family} is set to be "Logistic".
  }
  \item{epimark}{
    data.frame instance from read_epigenomic_data, which containing
    intensity and intensity deviation values of each mark for each query
    region    
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
  A vecotr of enhancer score of each query region or DMR
}
\author{
  Yupeng He \email{yupeng.he.bioinfo@gmail.com}
}

\seealso{
  \code{\link{reptile_predict}},
  \code{\link{reptile_predict_genome_wide}}
}
