#!/bin/bash
# STEP 6: Comparative Genomics with ABRicate

ASM_DIR=~/Anita/cholera/results/assembly
OUT_DIR=~/Anita/cholera/results/comparative
THREADS=8

mkdir -p $OUT_DIR/{amr,virulence,mlst}

echo "===== Running ABRicate for AMR and Virulence Genes ====="

for ASM in $ASM_DIR/*/assembly.fasta; do
    SAMPLE=$(basename $(dirname $ASM))

    echo "Running ABRicate for $SAMPLE..."

    # AMR genes (ResFinder DB)
    abricate --db resfinder $ASM > $OUT_DIR/amr/${SAMPLE}_amr.txt

    # Virulence genes (VFDB DB)
    abricate --db vfdb $ASM > $OUT_DIR/virulence/${SAMPLE}_vfdb.txt

    # MLST typing
    mlst $ASM > $OUT_DIR/mlst/${SAMPLE}_mlst.txt
done

echo "ABRicate results saved in: $OUT_DIR"
