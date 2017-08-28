#!/usr/bin/Rscript
library("deconstructSigs")
require(optparse)

option_list <- list(
	make_option("--patient_id", action="store", type="character", help="Patient ID"),
	make_option("--maf_handle", action="store", type="character", help="handle to input MAF for single patient"),
	make_option("--refsignatures", action="store", type="character", help="signatures.nature2013 or signatures.cosmic"),
	make_option("--normalization", action="store", type="character", help="Normalize context counts relative to exome, genome, or not at all", default="default")
)

args <- parse_args(OptionParser(option_list=option_list, usage="Rscript %prog [options]"), print_help_and_exit=FALSE)
patient_id = args$patient_id
maf = read.csv(args$maf_handle, sep = '\t', comment.char = '#')
if (tolower(args$refsignatures) %in% c("signatures.cosmic", "signatures.nature2013")) {refsignatures = tolower(args$refsignatures)} else {refsignatures = "signatures.cosmic"}
if (tolower(args$normalization) %in% c("exome", "genome")) {norml = tolower(args$normalization)} else {norml = "default"}

unique.samples = unique(maf$Tumor_Sample_Barcode)
sigs.input <- mut.to.sigs.input(mut.ref = maf,
	sample.id = "Tumor_Sample_Barcode", chr = "Chromosome",
	pos = "Start_position", ref = "Reference_Allele", 
	alt = "Tumor_Seq_Allele2")

temp.filename <- paste(patient_id, ".sigs.context.txt", sep = "")
write.table(sigs.input, file = temp.filename, sep = '\t', row.names = FALSE)

for (sample_ in unique.samples) {
	if (refsignatures == "signatures.cosmic") {
		output.sigs <- whichSignatures(tumor.ref = sigs.input,
			signatures.ref = signatures.cosmic, sample.id = sample_, 
			context = TRUE, tri.counts.method = norml)
		temp.filename = paste(sample_, ".sigs.cosmic.", norml, ".txt", sep = "")
	} else {
		output.sigs <- whichSignatures(tumor.ref = sigs.input,
			signatures.ref = signatures.nature2013, sample.id = sample_,
			context = TRUE, tri.counts.method = nomrl)
		temp.filename = paste(sample_, ".sigs.nature.", norml, ".txt", sep = "")
	}
	
	write.table(output.sigs, file = temp.filename, sep = '\t', row.names = FALSE)
}
