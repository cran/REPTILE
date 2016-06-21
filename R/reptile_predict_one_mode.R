reptile_predict_one_mode <-
function (reptile_classifier, epimark, family) 
{
    if (family == "Logistic") {
        pred = predict(reptile_classifier, data.frame(epimark))
        names(pred) = rownames(epimark)
    }
    else {
        suppressPackageStartupMessages(requireNamespace("randomForest", 
            quietly = T))
        pred = predict(reptile_classifier, epimark, type = "prob")[, 
            2]
    }
    return(pred)
}
