#!/bin/bash
# STEP 3: Genome assembly using Unicycler (raw reads)

DATA_DIR=~/Anita/cholera/data
OUT_DIR=~/Anita/cholera/results/assembly
THREADS=8

mkdir -p $OUT_DIR

echo "===== Running Unicycler Assemblies ====="

for R1 in $DATA_DIR/*_R1.fastq.gz; do
    SAMPLE=$(basename $R1 _R1.fastq.gz)
    R2=$DATA_DIR/${SAMPLE}_R2.fastq.gz

    echo "Assembling genome for: $SAMPLE"
    unicycler -1 $R1 -2 $R2 -o $OUT_DIR/$SAMPLE -t $THREADS
done

echo "Assemblies stored in: $OUT_DIR"
