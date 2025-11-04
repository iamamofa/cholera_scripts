#!/bin/bash
# STEP 8: Map raw reads to reference genome using BWA + SAMtools

DATA_DIR=~/Anita/cholera/data
REF=~/Anita/cholera/reference/Vibrio_cholerae_N16961.fna
OUT_DIR=~/Anita/cholera/results/mapping
THREADS=8

mkdir -p $OUT_DIR

echo "===== Mapping reads to reference genome with BWA ====="

# Index reference if needed
if [ ! -e ${REF}.bwt ]; then
    echo "Indexing reference..."
    bwa index $REF
fi

for R1 in $DATA_DIR/*_R1.fastq.gz; do
    SAMPLE=$(basename $R1 _R1.fastq.gz)
    R2=${DATA_DIR}/${SAMPLE}_R2.fastq.gz

    echo "Processing sample: $SAMPLE"

    bwa mem -t $THREADS $REF $R1 $R2 | samtools view -@ $THREADS -bS - > $OUT_DIR/${SAMPLE}.bam
    samtools sort -@ $THREADS -o $OUT_DIR/${SAMPLE}_sorted.bam $OUT_DIR/${SAMPLE}.bam
    samtools index $OUT_DIR/${SAMPLE}_sorted.bam
    samtools flagstat $OUT_DIR/${SAMPLE}_sorted.bam > $OUT_DIR/${SAMPLE}_flagstat.txt

    # Optional variant calling
    bcftools mpileup -Ou -f $REF $OUT_DIR/${SAMPLE}_sorted.bam | bcftools call -mv -Ob -o $OUT_DIR/${SAMPLE}.bcf
    bcftools view $OUT_DIR/${SAMPLE}.bcf > $OUT_DIR/${SAMPLE}.vcf

    rm $OUT_DIR/${SAMPLE}.bam
done

echo "Mapping and variant calling complete."
echo "Results stored in: $OUT_DIR"
