#!/bin/bash
# ============================================================
# MASTER SCRIPT — Vibrio cholerae Genomic Analysis Pipeline
# Using Unicycler + ABRicate
# ============================================================

BASE_DIR=~/Anita/cholera
SCRIPT_DIR=$BASE_DIR/scripts
LOG_DIR=$BASE_DIR/results/logs

mkdir -p $LOG_DIR

echo "============================================================"
echo " 🧬 Starting Vibrio cholerae Genomic Analysis Pipeline"
echo " Base directory : $BASE_DIR"
echo " Logs directory : $LOG_DIR"
echo " Start time     : $(date)"
echo "============================================================"
echo

run_step () {
    STEP_NAME=$1
    SCRIPT=$2
    echo ">>> Running step: $STEP_NAME"
    bash $SCRIPT &> $LOG_DIR/${STEP_NAME}.log
    if [[ $? -eq 0 ]]; then
        echo "✅ $STEP_NAME completed successfully!"
    else
        echo "❌ $STEP_NAME failed! Check: $LOG_DIR/${STEP_NAME}.log"
        echo "⚠️  ChatGPT can make mistakes. Verify important info manually."
        exit 1
    fi
    echo
}

# Run steps sequentially
run_step "01_FastQC"          $SCRIPT_DIR/01_fastqc.sh
run_step "03_Unicycler"       $SCRIPT_DIR/03_assembly_unicycler.sh
run_step "04_QUAST"           $SCRIPT_DIR/04_quast.sh
run_step "05_Prokka"          $SCRIPT_DIR/05_annotation_prokka.sh
run_step "06_ABRicate"        $SCRIPT_DIR/06_comparative_abricate.sh
run_step "07_Phylogeny"       $SCRIPT_DIR/07_phylogeny_parsnp.sh

echo "============================================================"
echo "🎉 ALL STEPS COMPLETED SUCCESSFULLY!"
echo "Results stored in: $BASE_DIR/results"
echo "Logs stored in: $LOG_DIR"
echo "Completed on: $(date)"
echo "============================================================"
echo
echo "⚠️  Reminder: ChatGPT can make mistakes. Always review QC, assembly, and annotation reports."
echo
