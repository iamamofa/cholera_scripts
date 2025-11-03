#!/bin/bash
# STEP 5: Genome Annotation with Prokka

ASM_DIR=~/Anita/cholera/results/assembly
OUT_DIR=~/Anita/cholera/results/annotation
THREADS=8

mkdir -p $OUT_DIR

echo "===== Running Prokka Annotation ====="

for ASM in $ASM_DIR/*/assembly.fasta; do
    SAMPLE=$(basename $(dirname $ASM))
    echo "Annotating $SAMPLE..."
    prokka --outdir $OUT_DIR/$SAMPLE \
           --prefix $SAMPLE \
           --cpus $THREADS \
           --genus Vibrio --species cholerae \
           --usegenus $ASM
done

echo "Prokka annotations saved to: $OUT_DIR"
