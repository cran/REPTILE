\name{REPTILE-package}
\alias{REPTILE-package}
\alias{REPTILE}
\docType{package}
\title{
  Regulatory Element Prediction
}
\description{
  Predicting DNA regulatory elements based on epigenomic
  signatures. This package is more of a set of building blocks than a
  direct solution. REPTILE regulatory prediction pipeline is built on
  this R package. Please check the url below for details:

  \url{https://github.com/yupenghe/REPTILE}
}
\details{
  Accurate enhancer identification is critical for understanding the
  spatiotemporal transcriptional regulation during development as well as
  the functional impact of disease-related non-coding genetic
  variants. REPTILE is a algorithm to identify the precise location of
  enhancers by integrating histone modification data and base-resolution
  DNA methylation profiles.
  
  REPTILE was designed based on three observations: 1) regions that are
  differentially methylated (or differentially methylated regions, DMRs)
  across diverse cell and tissue types strongly overlap with
  enhancers. 2) With base-resolution DNA methylation data, the
  boundaries of DMRs can be accurately defined, circumventing the
  difficulty of determining enhancer boundaries. 3) DMR size is often
  smaller (~500bp) than known enhancers, known negative regions (regions
  with no observable enhancer activity) and genomic windows used in
  enhancer prediction (~2kb), all of which we termed as "query
  regions". Together with the association between transcription factor
  binding and DNA methylation level, DMRs may serve as high-resolution
  enhancer candidates and capture the local epigenomic patterns that
  would otherwise be averaged/washed out in analysis focusing on the
  query regions.
  
  Running REPTILE involves four major steps. First, to identify DMRs, we
  compared the methylomes of target sample (where putative enhancers
  will be generated) and several other samples with different
  cell/tissue types (as reference). In the next step, input 
  files for REPTILE are prepared, which store the information of query
  regions, DMRs and the epigenomic data. Taking these inputs, REPTILE
  represents each DMR or query region as a feature vector, where each
  element corresponds to either intensity or intensity deviation of one
  epigenetic mark. Intensity deviation is defined as the intensity in
  target sample subtracted by the mean intensity in reference samples
  (i.e. reference epigenome) and it captures the tissue-specificity of
  each epigenetic mark. In the third step, based on the feature vectors
  of known enhancers and  negative regions as well as the feature
  vectors of the DMRs within them, we trained an enhancer model,
  containing two random forest classifiers, which respectively predict
  enhancer activities of query regions and DMRs. In the last step,
  REPTILE uses the enhancer model to calculate enhancer confidence
  scores for DMRs and query regions, based on which the final
  predictions are made.
  
  The two key concepts on REPTILE are:
  \itemize{
    \item Query regions - known enhancers, known negative regions and
    genomic windows used for enhancer prediction
    \item DMRs - differentially methylated regions
  }
  In REPTILE, DMRs are used as high-resolution candidates to capture the
  fine epigenomic signatures in query regions.
}

\references{
  He, Yupeng et al., \emph{REPTILE: Regulatory Element Prediction based on TIssue-specific Local
    Epigenetic marks}, in preparation
}

\author{
  Yupeng He

  Maintainer: Yupeng He <yupeng.he.bioinfo@gmail.com>
}
\examples{
library("REPTILE")
data("rsd")

## Training (needs a few minutes and ~1.8 Gb memory)
reptile.model <- reptile_train(rsd$training_data$region_epimark,
                               rsd$training_data$region_label,
                               rsd$training_data$DMR_epimark,
                               rsd$training_data$DMR_label,
                               ntree=50)

## Prediction
## - REPTILE
pred <- reptile_predict(reptile.model,
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
