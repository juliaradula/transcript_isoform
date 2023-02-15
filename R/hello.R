#tx2gene <- read_csv(file.path(dir, "tx2gene.gencode.v27.csv"))

#carregar gencode
library(readr)
gencode_v43_transcripts <- read_csv("/home/ace/Documentos/julia/gencode.v43.transcripts.fa.gz",
            col_names = FALSE)

# (str_extract(gencode_v32_transcripts$X1[1:1000], "ENST.*?\\.."))

library(stringr)

#detectar o maior no começo da frase
vetor_fasta_header <- str_detect(gencode_v43_transcripts$X1, "^>.")

#usar um vetor para filtrar uma tabela
tabela_fasta_header <- gencode_v43_transcripts[vetor_fasta_header, ]
tabela_fasta_header

#pacote para formatar tabela
library(tidyr)

headerfastaseparado <- separate(tabela_fasta_header, X1, into = paste0("col_",1:8)  ,sep = "\\|")

headerfastaseparado$col_1 <- str_remove(headerfastaseparado$col_1, ">")

library(dplyr)
txtogenes<- select(headerfastaseparado, col_1, col_6)



# no final agnt precisa das colunas: gene_name, gene_id, transcirpt_name, transcript_id transcript_biotype
