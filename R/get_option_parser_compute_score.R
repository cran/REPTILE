get_option_parser_compute_score <-
function () 
{
    suppressPackageStartupMessages(requireNamespace("optparse", 
        quietly = TRUE))
    option_list <- list(optparse::make_option(c("-i", "--data-info-file"), 
        type = "character", metavar = "data_info_file", dest = "data_info_file", 
        help = paste0("Tab-separated file providing information about samples,\n", 
            "\t\tepigenetic marks and paths to corresponding bigwig files.\n", 
            "\t\tNo duplicated mark name is allowed for each sample and\n", 
            "\t\tno duplicated sample name is allowed for each mark. \"samples\"\n", 
            "\t\tcan be different cell/tissue types or different conditions.\n", 
            "\t\tformat:\n", "\t\t  <sample name><\\t><mark name><\\t><path to bigwig file>\n", 
            "\t\texample (header is required):\n", "\t\t  sample mark bw_file\n", 
            "\t\t  heart H3K4me1 bigwig/heart_H3K4me1.bw\n", 
            "\t\t  ...\n", "\t\t  brain H3K27ac bigwig/brain_H3K27ac.bw\n", 
            "\t    **Please use the same data info file as the one used in\n", 
            "\t      data preprocessing (generation of input file).\n")), 
        optparse::make_option(c("-m", "--model-file"), type = "character", 
            metavar = "model_file", dest = "model_file", help = paste0("Enhancer model learned from known enhancers and known negative\n", 
                "\t\tregions. It is the output file from \"REPTILE_train.R\".\n", 
                "\t\texample:\n", "\t\t  enhancer_model.reptile\n")), 
        optparse::make_option(c("-s", "--sample-for-prediction"), 
            type = "character", metavar = "sample_for_prediction", 
            dest = "sample_for_prediction", help = paste0("Sample in which the activities of query regions are to be predicted.\n", 
                "\t\tformat:\n", "\t\t  Sampl name\n", "\t\texample:\n", 
                "\t\t  E11_5_FB\n")), optparse::make_option(c("-r", 
            "--reference-samples"), type = "character", metavar = "ref_sample", 
            dest = "ref_sample", default = NULL, help = paste0("Samples used as reference to calculate intensity deviation\n", 
                "\t\tformat:\n", "\t\t  Sample names separated by comma.\n", 
                "\t\texample:\n", "\t\t  E11_5_FB,E11_5_HT,E11_5_MB\n")), 
        optparse::make_option(c("-a", "--query-region-epimark-file"), 
            type = "character", metavar = "query_region_epimark_file", 
            dest = "query_region_epimark_file", help = paste0("Tab-separated file of epigenetic profiles of regions to be predicted.\n", 
                "\t\tIf \"-n\" option is used and the number is greater than 1, this option\n", 
                "\t\tshould be set as the prefix of query region files. For example, \n", 
                "\t\tif this option is \"mm10_genome.region_epimark\" and \"-n\" is 8,\n", 
                "\t\tREPTILE expects input files:\n", "\t\t  mm10_genome.region_epimark.0.tsv\n", 
                "\t\t  mm10_genome.region_epimark.1.tsv\n", "\t\t  ...\n", 
                "\t\t  mm10_genome.region_epimark.6.tsv\n", "\t\t  mm10_genome.region_epimark.7.tsv\n", 
                "\t\tThe format of the file(s) is:\n", "\t\t  First line is a header indicating the content of each\n", 
                "\t\t  column. First four columns are chromosome, start, end and\n", 
                "\t\t  region id. Following columns are the scores/enrichment of\n", 
                "\t\t  epigenetic marks for annotated regions.\n", 
                "\t\texample:\n", "\t\t  chr start end id H3K4me1_H1 H3K4me1_H9 H3K4me1_IMR90 ...\n", 
                "\t\t  chr1 3172000 3173000 reg_0 1.43 1.50 0.03 ...\n", 
                "\t\t  ...\n", "\t\t  chr9 124412000 124413000 reg_302031 0.34 0.44 2.42 ...\n", 
                "\t    **Highly recommend to to use \"REPTILE_preprocess.py\" script to generate\n", 
                "\t      this file. Run \"./REPTILE_preprocess.py -h\" for more information.\n", 
                "\t      Make sure the same data info file is used.\n")), 
        optparse::make_option(c("-d", "--DMR-epimark-file"), 
            type = "character", metavar = "DMR_epimark_file", 
            dest = "DMR_epimark_file", help = paste0("Tab-separated file of epigenetic profiles of differentially\n", 
                "\t\tmethyated regions (DMRs). Format is same as that of \n", 
                "\t\tannotated_region_epimark_file. DMRs are used as high-resolution\n", 
                "\t\tenhancer candidates to increase the resolution of training and\n", 
                "\t\tprediction. The candidate loci can also come from assays like\n", 
                "\t\tDNase-seq or ATAC-seq or analysis on motifs.\n", 
                "\t\tSame as \"-a\": If \"-n\" option is used and the number is\n", 
                "\t\tgreater than 1, this option should be set as the prefix of files.\n", 
                "\t\tFor example, if this option is \"mm10_genome.DMR_epimark\" and \"-n\" is 8\n", 
                "\t\tREPTILE expects input files:\n", "\t\t  mm10_genome.DMR_epimark.0.tsv\n", 
                "\t\t  mm10_genome.DMR_epimark.1.tsv\n", "\t\t  ...\n", 
                "\t\t  mm10_genome.DMR_epimark.6.tsv\n", "\t\t  mm10_genome.DMR_epimark.7.tsv\n", 
                "\t\tThe format of the file(s) is:\n", "\t\t  First line is a header indicating the content of each\n", 
                "\t\t  column. First four columns are chromosome, start, end and\n", 
                "\t\t  region id. Following columns are the scores/enrichment of\n", 
                "\t\t  epigenetic marks for annotated regions.\n", 
                "\t\texample:\n", "\t\t  chr start end id H3K4me1_H1 H3K4me1_H9 H3K4me1_IMR90 ...\n", 
                "\t\t  chr1 3172266 3172488 dmr_0 1.43 1.50 0.03 ...\n", 
                "\t\t  ...\n", "\t\t  chr19 61316546 61316778 dmr_513260 0.34 0.44 2.42 ...\n", 
                "\t    **Highly recommend to to use \"REPTILE_preprocess.py\" script to generate\n", 
                "\t      this file. Run \"./REPTILE_preprocess.py -h\" for more information.\n", 
                "\t      Make sure the same data info file is used.\n")), 
        optparse::make_option(c("-o", "--output-prefix"), type = "character", 
            metavar = "output_prefix", dest = "output_prefix", 
            default = "REPTILE_output", help = paste0("Prefix of the output file storing the predictions.\n", 
                "\t\tThe output file is \"<OUTPUT_PREFIX>.DMR.bed\"\n", 
                "\t\tand \"<OUTPUT_PREFIX>.R.bed\" corresponding to the predictions\n", 
                "\t\tfrom the classifier for DMRs on DMRs and classifier for query\n", 
                "\t\tregions on query regions, respectively. If \"-w\" option is used,\n", 
                "\t\tREPTILE will also generate \"<OUTPUT_PREFIX>.D.bed\" file as the\n", 
                "\t\tcombined prediction. This file will store the enhancer score of\n", 
                "\t\teach query region,which is defined as the maximum of scores of\n", 
                "\t\tthe whole region and the overlapping DMRs. Also, when \"-w\" is enabled,\n", 
                "\t\t\"<OUTPUT_PREFIX>.DMR.bed\" will only report the scores of DMRs that\n", 
                "\t\toverlap with any query regions.\n", "\t\texample:\n", 
                "\t\t  With \"--output-prefix E11_5_FB_enhancer\", two output files\n", 
                "\t\t  are:\n", "\t\t  - E11_5_FB_enhancer.DMR.bed\n", 
                "\t\t  - E11_5_FB_enhancer.R.bed\n", "\t\t  - E11_5_FB_enhancer.D.bed (if \"-w\" is used)\n", 
                "\t    **output format:\n", "\t      BED format with 5th column as the enhancer confidence score.\n")), 
        optparse::make_option(c("-c", "--classifier-family"), 
            type = "character", default = "RandomForest", metavar = "classifier_family", 
            dest = "classifier_family", help = paste0("Classifier family to use in prediction model. \"Logistic\" is\n", 
                "\t\tfaster but slightly less accurate compared to \"RandomForest\".\n", 
                "\t\tIt is useful in generating quick and good results.\n", 
                "\t\t  default: RandomForest\n", "\t\tClassifiers available:\n", 
                "\t\t - RandomForest: random forest\n", "\t\t - Logistic: logistic regression\n")), 
        optparse::make_option(c("-x", "--no-intensity-deviation"), 
            type = "logical", action = "store_false", default = TRUE, 
            metavar = "incl_dev", dest = "incl_dev", help = paste0("If this option is used, REPTILE will not compute the intensity\n", 
                "\t\tdeviation feature, which captures the tissue-specificity of\n", 
                "\t\tenhancers.\n")), optparse::make_option(c("-w", 
            "--not-genome-wide-prediction"), action = "store_true", 
            default = FALSE, type = "logical", metavar = "not_genome_wide", 
            dest = "not_genome_wide", help = paste0("This option is used to generate enhancer scores for given regions\n", 
                "\t\tby combining the results from two classifiers (one for DMRs and.\n", 
                "\t\tone for query regions). If this option is used, REPTILE will\n", 
                "\t\tgenerate one additional file, \"<OUTPUT_PREFIX>.D.bed\", to show\n", 
                "\t\tthe combined scores of each query region. The combined score is\n", 
                "\t\tdefined as the maximum of scores of the whole region and the\n", 
                "\t\toverlapping DMRs.\n", "\t\t  To use this option, the input files should be generated without\n", 
                "\t\tthe \"-g\" option during preprocessing step (\"REPTILE_preprocess.py\").\n", 
                "\t\tThat is, the ids in DMR_epimark_file (\"-d\") should contain the ids of\n", 
                "\t\toverlapping query regions. For example, \"dmr_304:reg_1750\".\n")), 
        optparse::make_option(c("-p", "--number-of-processors"), 
            type = "integer", default = 1, metavar = "num_procs", 
            dest = "num_procs", help = paste0("Number of processors to use. REPTILE supports multiprocessing\n")), 
        optparse::make_option(c("-n", "--number-of-splits"), 
            type = "integer", default = 1, metavar = "num_splits", 
            dest = "num_splits", help = paste0("REPTILE accepts splitted input files and this option\n", 
                "\t\tspecifies the the number of DMR epimark files (or\n", 
                "\t\tquery region epimark files after the split). For\n", 
                "\t\texample, if \"-a\" is \"mm10_genome.region_epimark\" and\n", 
                "\t\t\"-d\" is \"mm10_genome.DMR_epimark and this option is 8,\n", 
                "\t\tREPTILE will search for below input files:\n", 
                "\t\t  mm10_genome.DMR_epimark.0.tsv\n", "\t\t  ...\n", 
                "\t\t  mm10_genome.DMR_epimark.7.tsv\n", "\t\tand\n", 
                "\t\t  mm10_genome.region_epimark.0.tsv\n", "\t\t  ...\n", 
                "\t\t  mm10_genome.region_epimark.7.tsv\n\n", 
                "\t\tIf this option is 1, there is no split and REPTILE will\n", 
                "\t\tassume \"-a\" and \"-d\" options give the exact names of\n", 
                "\t\tof input files. Thus, it will search for two files:\n", 
                "\t\t  mm10_genome.DMR_epimark\n", "\t\tand\n", 
                "\t\t  mm10_genome.region_epimark\n")))
    description <- paste0("\tPredicting enhancer activities of query regions in target sample. This script will\n", 
        "\tcalculate enhancer confidence score for each query region and each DMR.\n", 
        "\tPlease email Yupeng He (yupeng.he.bioinfo at gmail) for feedbacks, questions or bugs.")
    usage <- paste0("Usage: ./REPTILE_compute_score.R \\\n", 
        "\t\t -i data_info_file \\\n", "\t\t -m model_file \\\n", 
        "\t\t -a query_region_epimark_file \\\n", "\t\t -d DMR_epimark_file \\\n", 
        "\t\t -s sample_for_prediction \\\n", "\t\t -o output_prefix\n")
    option_parser <- optparse::OptionParser(usage = usage, description = description, 
        option_list = option_list)
    return(option_parser)
}
