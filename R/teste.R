#' Teste
#'
#' \code{teste} is used to generate a file with the header information of a fasta gencode file
#'
#' @param gencode_transcripts_path The pathway of the gencode transcripts fasta file in quotes.
#'
#' @return A table with transcripts and genes identification named "gencode_header.csv" with the follow columns:
#' \item transcript_id
#' \item gene_id
#' \item transcript_name
#' \item gene_name
#' \item transcript_biotype
#'
#' @export
#' @import readr
#' @import stringr
#' @import tidyr
#' @import dplyr
#'
#' @examples
#'teste("example.fasta")
teste <- function(gencode_transcripts_path){
    system(sprintf("grep '>' %s > gencode_header.csv", gencode_transcripts_path))
    gencode_header <- read_csv("gencode_header.csv", col_names = FALSE, show_col_types = FALSE)
    gencode_header$X1 <- str_remove(gencode_header$X1, ">")
    gencode_header <- separate(gencode_header, X1, into = paste0(c("transcript_id", "gene_id", "X3", "X4","transcript_name","gene_name","X7", "transcript_biotype", "X9")), sep="\\|") %>%
        select(-c("X3", "X4", "X7", "X9"))
    write_csv(gencode_header, "gencode_header.csv")
}
