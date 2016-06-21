read_epigenomic_data <-
function (data_info, epimark_file, query_sample, ref_sample = NULL, 
    incl_dev = T) 
{
    if (!(query_sample %in% unique(data_info$sample))) {
        avail_samples <- paste0(paste0("    ", unique(data_info$sample)), 
            sep = "\n")
        stop(paste0(query_sample, " is not in data_info file!\n", 
            "  Available samples are:\n"), avail_samples)
    }
    if (!is.null(ref_sample) & sum(ref_sample %in% unique(data_info$sample)) != 
        length(ref_sample)) {
        avail_samples <- paste0(paste0("    ", unique(data_info$sample)), 
            sep = "\n")
        stop(paste0(paste0(ref_sample[!(ref_sample %in% unique(data_info$sample))], 
            collapse = ","), " is not in data_info file!\n", 
            "  Available samples are:\n"), avail_samples)
    }
    epimark <- read.table(epimark_file, sep = "\t", header = T, 
        stringsAsFactors = F)
    if (nrow(epimark) == 0) {
        return(NULL)
    }
    rownames(epimark) = epimark$id
    epimark = data.matrix(epimark[, 5:ncol(epimark)])
    if ((nrow(data_info) != ncol(epimark))) {
        stop(paste0("Sample information and the header of \"", 
            epimark_file, "\" are not compatible!\n", "  Please check whether the same data_info file was used for generating \"", 
            epimark_file, "\""))
    }
    else if (sum(paste0(data_info$mark, "_", data_info$sample) != 
        colnames(epimark)) > 0) {
        stop(paste0("Sample information and the header of \"", 
            epimark_file, "\" are not compatible!\n", "  Please check whether the same data_info file was used for generating \"", 
            epimark_file, "\""))
    }
    if (incl_dev) {
        epimark_dev <- calculate_epimark_deviation(data_info, 
            epimark, query_sample, ref_sample)
    }
    epimark = epimark[, data_info$sample == query_sample]
    colnames(epimark) = data_info$mark[data_info$sample == query_sample]
    if (incl_dev) {
        epimark = cbind(epimark, epimark_dev)
    }
    return(epimark)
}
