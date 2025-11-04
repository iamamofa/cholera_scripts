#!/bin/bash
# STEP 4: Assembly Quality Assessment using QUAST

ASM_DIR=~/Anita/cholera/results/assembly
OUT_DIR=~/Anita/cholera/results/quast
THREADS=8

mkdir -p $OUT_DIR

echo "===== Running QUAST ====="
quast.py $ASM_DIR/*/assembly.fasta -o $OUT_DIR -t $THREADS
echo "QUAST results saved to: $OUT_DIR"
