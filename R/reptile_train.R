reptile_train <-
function (epimark_region, label_region, epimark_DMR = NULL, label_DMR = NULL, 
    family = "randomForest", ntree = 2000, nodesize = 1) 
{
    reptile = list(D = NULL, R = NULL)
    reptile$R <- reptile_train_one_mode(epimark_region, label_region, 
        family, nodesize = nodesize, ntree = ntree)
    if (!is.null(epimark_DMR) & !is.null(label_DMR)) {
        reptile$D <- reptile_train_one_mode(epimark_DMR, label_DMR, 
            family, nodesize = nodesize, ntree = ntree)
    }
    return(reptile)
}
