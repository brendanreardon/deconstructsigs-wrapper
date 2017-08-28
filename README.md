# deconstructSigs
A simple wrapper around the R package deconstructSigs (https://github.com/raerose01/deconstructSigs) for ease of use and implementation in FireCloud.

## Run deconstructSigs
run_deconstructSigs.R can be run by either editing the wrapper.sh or directly from R. Please edit deconstructSigs_wrapper.sh or run to include the following details for your given sample
- `patient_id`: An individual ID for the sample being considered
- `maf_handle`: Path to a MAF file containing single nucleotide variants
- `refsignatures`: Reference signatures to perform the NMR against. Acceptable values: signatures.cosmic or signatures.nature2013
- `normalization`: Normalization of contexts. Acceptable values: "exome" for exome normalization, "genome" for genome normalization, or "default" for no normalization.

Example:
`Rscript run_deconstructSigs.R --patient_id "HCC1143" --maf_handle /path/to/maf.txt --refsignatures "signatures.cosmic" --normalization "exome"`
