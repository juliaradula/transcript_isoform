#tx2gene <- read_csv(file.path(dir, "tx2gene.gencode.v27.csv"))

#carregar gencode
library(readr)
gencode_v43_transcripts <- read_csv("/home/ace/Documentos/julia/gencode.v43.transcripts.fa.gz", col_names = FALSE)

# (str_extract(gencode_v32_transcripts$X1[1:1000], "ENST.*?\\.."))

library(stringr)

#' Teste
#'
#' \code{teste}
#'
#' @param gencode_transcripts_path The pathway to and the file name of the gencode transcripsts fasta file.
#'
#' @return A table with transcripts and genes identification:
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
#'
teste =  function(gencode_transcripts_path){
    system("grep '>' gencode_transcripts_path >> gencode_header.txt")
    gencode_header = read_csv("gencode_header.txt", sep="|", col_names = c("transcript_id", "gene_id", "col3", "col4","transcript_name","gene_name","col7", "trnascript_biotype"))
    gencode_header = select(gencode_header, transcript_id, gene_id, transcript_name, gene_name, transcript_biotype) %>%
        str_remove(">")
    write.csv(gencode_header, gencode_header)
}


#usar um vetor para filtrar uma tabela
tabela_fasta_header <- gencode_v43_transcripts[vetor_fasta_header, ]
tabela_fasta_header


#pacote para formatar tabela
library(tidyr)

headerfastaseparado <- separate(tabela_fasta_header, X1, into = paste0("col_",1:8)  ,sep = "\\|")

headerfastaseparado$col_1 <- str_remove(headerfastaseparado$col_1, ">")

names(headerfastaseparado) = c("transcript_id", "gene_id", "col3", "col4","transcript_name","gene_name","col7", "trnascript_biotype")
library(dplyr)
txtogenes<- select(headerfastaseparado, col_1, col_6)



# no final agnt precisa das colunas: gene_name, gene_id, transcirpt_name, transcript_id transcript_biotype
