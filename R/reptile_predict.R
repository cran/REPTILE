reptile_predict <-
function (reptile_model, epimark_region, epimark_DMR = NULL, 
    family = "randomForest") 
{
    pred = list(D = NULL, R = NULL, DMR = NULL)
    pred$R = reptile_predict_one_mode(reptile_model$R, epimark_region, 
        family)
    if (!is.null(epimark_DMR)) {
        pred$D = reptile_predict_one_mode(reptile_model$D, epimark_DMR, 
            family)
        pred$DMR = pred$D
        ind = !((names(pred$R) %in% sapply(strsplit(names(pred$D), 
            ":"), function(x) return(x[2]))))
        pred$D = c(pred$D, pred$R[ind])
        names(pred$D) <- sapply(strsplit(names(pred$D), ":"), 
            function(x) {
                if (length(x) == 1) {
                  return(x)
                }
                else {
                  return(x[2])
                }
            })
        pred$D = aggregate(pred$D, list(names(pred$D)), max)
        region_id = pred$D[, 1]
        pred$D = pred$D[, 2]
        names(pred$D) = region_id
    }
    else {
        pred$D = pred$R
    }
    return(pred)
}
