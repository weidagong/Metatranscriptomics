library(tximport)
library(DESeq2)
library(readr)

###differential expression analysis with DESeq2 for Salmon output

setwd("/proj/marchlab/projects/EXPORTS/metatranscriptomics/Tara-test/assembly/salmon")

quant_files <- file.path(dir(pattern = "ERR.*"), "quant.sf")

samples <- read.csv("samples.csv", stringsAsFactors = F)
rownames(samples) <- samples$Run

###1. import with tximport

#tx2gene is necessary to group transcript into genes, not using here because of \
#lack of functional annotation


txi <- tximport(files = quant_files, type = "salmon", txOut = T)
# txi <- tximport(files = quant_files, type = "salmon", tx2gene = tx2gene)
cts <- as.matrix(txi$counts)
colnames(cts) <- sub("_quant", "", dir(pattern = "ERR.*"))

#check naming and order are consistent
(rownames(samples) == colnames(cts))
cts <- cts[, rownames(samples)]

(rownames(samples) == colnames(cts))

cts <- apply(cts, 2, as.integer)

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

save(cts, res, dds, resLFC, file = "DESeq-salmon.RData")



###To be continued 
###Independent hypothesis weighting

###MA-plot
#plotMA(res, ylim = c(-2, 2))
