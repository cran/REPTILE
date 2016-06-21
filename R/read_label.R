read_label <-
function (label_file, query_sample) 
{
    activity <- read.table(label_file, sep = "\t", header = T, 
        stringsAsFactors = F)
    if (sum(query_sample %in% colnames(activity)[-1]) != length(query_sample)) {
        avail_samples <- paste0(paste0("    ", colnames(activity[, 
            -1])), sep = "\n")
        stop(paste0(paste0(query_sample, collapse = ","), " has no data in label file!\n", 
            "  Label file contains data of:\n"), avail_samples)
    }
    res = activity[, query_sample]
    names(res) = activity[, 1]
    return(res)
}
