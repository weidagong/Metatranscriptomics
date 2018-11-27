library(DESeq2)
library(readr)

###differential expression analysis with DESeq2 for Salmon output

setwd("/proj/marchlab/projects/EXPORTS/metatranscriptomics/Tara-test/assembly/bowtie/bowtie")

quant_filename <- list.files(pattern = "*counts.tab")
srr <- sub(".counts.tab", "", quant_filename)


samples <- read.csv("../samples.csv", stringsAsFactors = F)
rownames(samples) <- samples$Run

###1. import with tximport

#tx2gene is necessary to group transcript into genes, not using here because of \
#lack of functional annotation


# txi <- tximport(files = quant_files, type = "salmon", txOut = T)
# txi <- tximport(files = quant_files, type = "salmon", tx2gene = tx2gene)
quant_files <- lapply(quant_filename, read_table2, col_names = F)
cts <- Reduce(function(df1, df2) merge(df1, df2, by = "X2", all = T), quant_files)
names(cts) <- c("contig", srr)
cts[is.na(cts)] <- 0
rownames(cts) <- cts$contig
cts <- cts[, -1]
#divide read abundance by 2 because counting both ends
cts <- cts/2
#check naming and order are consistent
(rownames(samples) == colnames(cts))
cts <- cts[, rownames(samples)]

(rownames(samples) == colnames(cts))


###2. construct a DESeq object


dds <- DESeqDataSetFromMatrix(countData = cts,
                              colData = samples,
                              design = ~ Depth)


#prefiltering
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep, ]

#first factor is the control
dds$Depth <- factor(dds$Depth, levels = c("SRF", "DCM"))



###3. differential expression analysis
###requires a lot of memory, run on cluster
dds <- DESeq(dds)
res <- results(dds)

#log fold change shrikage to remove low count noise
resLFC <- lfcShrink(dds, 2, type = "apeglm")

save(cts, res, dds, resLFC, file = "DESeq-bowtie.RData")



###To be continued 
###Independent hypothesis weighting

###MA-plot
#plotMA(res, ylim = c(-2, 2))
