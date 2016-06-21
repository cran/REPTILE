calculate_epimark_deviation <-
function (data_info, x, query_sample, ref_sample = NULL) 
{
    res = NULL
    dev_names = NULL
    if (is.null(ref_sample)) {
        for (query_mark in data_info$mark[data_info$sample == 
            query_sample]) {
            ind = (data_info$mark == query_mark)
            if (sum(ind) == 1) {
                next
            }
            else if (sum(ind) == 2) {
                d = x[, ind & (data_info$sample == query_sample)]
                d = d - x[, ind & (data_info$sample != query_sample)]
            }
            else {
                d = x[, ind & (data_info$sample == query_sample)]
                d = d - rowMeans(x[, ind & (data_info$sample != 
                  query_sample)])
            }
            dev_names = c(dev_names, paste0(query_mark, "_dev"))
            res = cbind(res, d)
        }
    }
    else {
        for (query_mark in data_info$mark[data_info$sample == 
            query_sample]) {
            ind = (data_info$mark == query_mark)
            if (sum(ind & data_info$sample == query_sample) == 
                0) {
                next
            }
            if (sum(ind) == 1) {
                next
            }
            else if (sum(ind & (data_info$sample %in% ref_sample)) == 
                1) {
                d = x[, ind & (data_info$sample == query_sample)]
                d = d - x[, ind & (data_info$sample %in% ref_sample)]
            }
            else {
                d = x[, ind & (data_info$sample == query_sample)]
                d = d - rowMeans(x[, ind & (data_info$sample %in% 
                  ref_sample)])
            }
            dev_names = c(dev_names, paste0(query_mark, "_dev"))
            res = cbind(res, d)
        }
    }
    colnames(res) = dev_names
    return(res)
}
