#!/bin/bash
# STEP 7: Phylogenetic Analysis using Parsnp

ASM_DIR=~/Anita/cholera/results/assembly
REF=~/Anita/cholera/reference/Vibrio_cholerae_N16961.fna
OUT_DIR=~/Anita/cholera/results/comparative/parsnp_tree
THREADS=8

mkdir -p $OUT_DIR

echo "===== Running Parsnp Phylogeny ====="
parsnp -r $REF -d $ASM_DIR -p $THREADS -o $OUT_DIR
echo "Parsnp results saved to: $OUT_DIR"
