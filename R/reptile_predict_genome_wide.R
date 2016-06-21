reptile_predict_genome_wide <-
function (reptile_model, epimark_region, epimark_DMR = NULL, 
    family = "randomForest") 
{
    pred = list(R = NULL, DMR = NULL)
    pred$R = reptile_predict_one_mode(reptile_model$R, epimark_region, 
        family)
    if (!is.null(epimark_DMR)) {
        pred$DMR = reptile_predict_one_mode(reptile_model$D, 
            epimark_DMR, family)
    }
    return(pred)
}
