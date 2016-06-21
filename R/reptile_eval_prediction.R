reptile_eval_prediction <-
function (predictions, annotations) 
{
    annotations = annotations[names(predictions)]
    num_positives = sum(annotations == 1)
    num_negatives = sum(annotations == 0)
    curve_ROC = NULL
    curve_PR = NULL
    s = sort(predictions, decreasing = T, index.return = T)
    for (i in 1:length(predictions)) {
        cutoff = s$x[i]
        num_true_positives = sum(predictions >= cutoff & annotations == 
            1)
        num_false_positives = sum(predictions >= cutoff & annotations == 
            0)
        FPR = num_false_positives/num_negatives
        TPR = num_true_positives/num_positives
        PR = num_true_positives/sum(predictions >= cutoff)
        curve_ROC <- cbind(curve_ROC, c(FPR, TPR))
        curve_PR <- cbind(curve_PR, c(TPR, PR))
    }
    curve_ROC = t(cbind(c(0, 0), curve_ROC, c(1, 1)))
    curve_PR = t(cbind(c(0, 1), curve_PR[, !is.nan(curve_PR[1, 
        ])]))
    suppressPackageStartupMessages(requireNamespace("flux", quietly = TRUE))
    AUROC = flux::auc(curve_ROC[, 1], curve_ROC[, 2])
    AUPR = flux::auc(curve_PR[, 1], curve_PR[, 2])
    return(list(AUROC = AUROC, AUPR = AUPR))
}
