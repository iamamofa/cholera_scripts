#!/bin/bash
# ============================================================
# STEP 1: Quality Control using FastQC + MultiQC
# ============================================================

DATA_DIR=~/Anita/cholera/data
OUT_DIR=~/Anita/cholera/results/fastqc
THREADS=8

mkdir -p $OUT_DIR

echo "===== Running FastQC ====="
for R1 in $DATA_DIR/*_R1.fastq.gz; do
    SAMPLE=$(basename $R1 _R1.fastq.gz)
    R2=${DATA_DIR}/${SAMPLE}_R2.fastq.gz
    echo "Processing sample: $SAMPLE"
    fastqc -t $THREADS -o $OUT_DIR $R1 $R2
done

echo
echo "===== Summarizing QC reports with MultiQC ====="
multiqc $OUT_DIR -o $OUT_DIR

echo
echo "✅ FastQC and MultiQC completed successfully!"
echo "FastQC individual reports saved to: $OUT_DIR"
echo "MultiQC summary report: $OUT_DIR/multiqc_report.html"
echo
echo "⚠️  Reminder: ChatGPT can make mistakes. Always check your MultiQC summary carefully."
