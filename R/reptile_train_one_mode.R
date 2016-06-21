reptile_train_one_mode <-
function (epimark, label, family, ntree, nodesize) 
{
    if (family == "Logistic") {
        df <- data.frame(label = as.numeric(as.character(label)), 
            epimark)
        mod <- glm(label ~ ., data = df, family = binomial)
    }
    else {
        suppressPackageStartupMessages(requireNamespace("randomForest", 
            quietly = TRUE))
        mod <- randomForest::randomForest(epimark, label, nodesize = nodesize, 
            ntree = ntree, importance = T)
    }
    return(mod)
}
