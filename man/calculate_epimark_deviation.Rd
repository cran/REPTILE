\name{calculate_epimark_deviation}
\alias{calculate_epimark_deviation}

\title{
  Internal - calculating intensity deviation feature
}
\description{
  Internal function used to calculate the intensity deviation features.
  It is based on the epigenomic signatures of a given region in target sample,
  where prediction will be generated, and reference samples. Intensity
  deviation is defined as the intensity in target sample subtracted
  by the mean intensity in reference samples (i.e. reference
  epigenome) and it captures the tissue-specificity of each epigenetic
  mark.
}
\usage{
calculate_epimark_deviation(data_info, x, query_sample,
                            ref_sample = NULL)
}
\arguments{
  \item{data_info}{
    data.frame instance generated by reading data information file
    specifying the samples and marks used in the analysis. The
    data.frame includes at least two columns named "sample" and "mark",
    corresponding to the samples and marks included.
  }
  \item{x}{
    data.frame instance generated by reading epimark file. The first
    four columns of the data.frame are "chr", "start", "end" and "id" of
    each region in the epimark file. The rest columns contain values of
    epigenetic marks in samples as specified in data_info and column
    names are under MARK_SAMPLE format, such as "H3K4me1_mESC".    
  }
  \item{query_sample}{
    name of the target sample
  }
  \item{ref_sample}{
    a vector of names of the reference sample(s)
  }
}
\value{
  data.frame instance containing intensity deviation values of each mark
}
\seealso{
  \code{\link{read_epigenomic_data}}
}
\author{
  Yupeng He \email{yupeng.he.bioinfo@gmail.com}
}

