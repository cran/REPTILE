\name{reptile_train_one_mode}
\alias{reptile_train_one_mode}
\title{
  Internal - Learn single random forest classifier
}
\description{
  Internal function to learn a random forest classifier
}
\usage{
reptile_train_one_mode(epimark, label,
                       family, ntree, nodesize)
}
\arguments{
  \item{epimark}{
    \code{data.frame} instance from read_epigenomic_data, which containing
    intensity and intensity deviation values of each mark for each DMR
    or query region.    
  }
  \item{label}{
    \code{factor} instance from read_label, containing the label of each
    query region. The possible values and their meanings of a label
    are: \code{0} (not enhancer), \code{1} (enhancer) and \code{NA}
    (unknwon and will be ignored).
  }
  \item{family}{
    Classifier family used in the enhancer model
    Default: RandomForest
    Classifiers available:
    - RandomForest: random forest
    - Logistic: logistic regression
  }
  \item{ntree}{
    Number of tree to be constructed in the random forest model. See the
    function randomForest() in "randomForest" package for more
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
  An \code{randomForest} object or \code{glm} object when \code{family}
  is set to be "Logistic".
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
  \code{\link{reptile_train}}
}

