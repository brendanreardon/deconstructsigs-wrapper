#!/bin/bash

patient_id="MEL-IPI_Pat02"
maf_handle="test/MEL-IPI_Pat02-TP-NB-SM-4DJZX-SM-4NFU4.pon_annotated.pass.maf"
refsignatures="signatures.cosmic"
normalization="exome"

Rscript run_deconstructSigs.R --patient_id $patient_id --maf_handle $maf_handle --refsignatures $refsignatures --normalization $normalization
