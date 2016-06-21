get_option_parser_evaluation <-
function () 
{
    suppressPackageStartupMessages(requireNamespace("optparse", 
        quietly = TRUE))
    option_list <- list(optparse::make_option(c("-s", "--sample-for-prediction"), 
        type = "character", metavar = "sample_for_prediction", 
        dest = "sample_for_prediction", help = paste0("Sample where the enhancer confidence scores are generated for query\n", 
            "\t\tregions.\n", "\t\tformat:\n", "\t\t  Sampl name\n", 
            "\t\texample:\n", "\t\t  E11_5_FB\n")), optparse::make_option(c("-l", 
        "--label-file"), type = "character", metavar = "label_file", 
        dest = "label_file", help = paste0("Tab-separated file labeling what query (annotated) regions are active\n", 
            "\t\tactive enhancers in which sample(s).\n", "\t\tformat:\n", 
            "\t\t  The file has multiple columns. First column is region id.\n", 
            "\t\t  Each following column corresponds to one sample and the values\n", 
            "\t\t  indicate whether the region is active in the sample:\n", 
            "\t\t    - 1: active,\n", "\t\t    - 0: no activity\n", 
            "\t\t    - NA: unknown\n", "\t\t  First line is a header indicating the content of each column.\n", 
            "\t\t  Name of first column is \"id\" and others are sample names.\n", 
            "\t\texample:\n", "\t\t  id E11_5_FB E11_5_MB E11_5_HB ...\n", 
            "\t\t  reg_0 1 1 0 ...\n", "\t\t  ...\n", "\t\t  reg_302031 0 0 1 ....\n")), 
        optparse::make_option(c("-p", "--prediction-result-file"), 
            type = "character", metavar = "prediction_result_file", 
            dest = "prediction_result_file", help = paste0("bed file of query regions with enhancer scores (5th column) such as the\n", 
                "\t\t\"*.R.bed\" files and \"*.D.bed\" files from REPTILE_compute_score.R.\n", 
                "\t\tformat:\n", "\t\t  BED file with five columns, chromosome, start, end, region id\n", 
                "\t\t  and score of enhancer activity.\n", "\t\texample:\n", 
                "\t\t  chr1 3172000 3173000 reg_0 0.7 ...\n", 
                "\t\t  ...\n", "\t\t  chr9 124412000 124413000 reg_302031 0.1 ...\n", 
                "\t    **Output files from \"REPTILE_compute_score.R\" are in this format\n", 
                "\t      and can be directly used as input for this script\n")), 
        optparse::make_option(c("-q", "--suppress-warnings"), 
            action = "store_true", default = FALSE, type = "logical", 
            dest = "suppress_warnings", help = paste0("Showing warnings is default. If this option is enabled, warnings will\n", 
                "\t\tnot be shown.")))
    description <- paste0("\tEvaluating the prediction accuracy by calculating the Area Under Receiver Operating.\n", 
        "\tCharacteristic (AUROC) and the Area Under Precision-Recall curve (AUPR). It will also\n", 
        "\tcalculate the percent of true positives in the top 5, 10 and 20 predictions\n", 
        "\tPlease email Yupeng He (yupeng.he.bioinfo at gmail) for feedbacks, questions or bugs.")
    usage <- paste0("Usage: ./REPTILE_evaluate_prediction.R \\\n", 
        "\t\t -s sample_for_prediction \\\n", "\t\t -l label_file \\\n", 
        "\t\t -p query_region_file_with_score\n")
    option_parser <- optparse::OptionParser(usage = usage, description = description, 
        option_list = option_list)
    return(option_parser)
}
