\name{read_label}
\alias{read_label}
\title{
  Reading labels of regions from label file
}
\description{
  Function to read epimark file from disk and generate data.frame
  instance. It is used to read epigenomic data from file on disk and
  generate the input data.frame instance to fuel the model training,
  prediction and other following steps. Label file is a tab-separated
  file with a header. The first column contains the id of each
  region. The second or more columns specify whether a certain region
  is enhancer (1) or not (0) in a specific sample. Each of these columns
  corresponds to one sample and the name of the column is the sample name.
}
\usage{
read_label(label_file, query_sample)
}
\arguments{
  \item{label_file}{
    name of label file on disk
  }
  \item{query_sample}{
    name(s) of sample(s), in which you would like to have label
    information
  }
}
\value{
  an data.frame instance containing label of each region in query
  samples The possible values and their meanings of a label are:
  
  \code{NA} - unknwon (will be ignored)

  \code{0} - not enhancer

  \code{1} - enhancer
}
\author{
  Yupeng He \email{yupeng.he.bioinfo@gmail.com}
}

\seealso{
  \code{\link{read_epigenomic_data}}
}
\keyword{read input file}