# cholera_scripts

A reproducible whole-genome sequencing (WGS) analysis pipeline for *Vibrio cholerae* isolates. This repository provides modular Bash scripts covering the complete workflow — from raw read quality control to genome assembly, annotation, comparative genomics, phylogenetic analysis, and reference-based mapping.

---

## Project Overview

`cholera_scripts` is designed to streamline bacterial genomics analysis, particularly for *Vibrio cholerae*, using widely adopted bioinformatics tools.

The workflow covers:

1. Raw read quality control
2. Genome assembly
3. Assembly quality assessment
4. Genome annotation
5. AMR and virulence gene screening
6. Core-genome phylogeny
7. Reference-based read mapping

Each step is implemented as an individual shell script, allowing independent execution or full pipeline automation via `run_all.sh`.

---

## Repository Structure

```
cholera_scripts/
│
├── 01_fastqc.sh
├── 03_assembly_unicycler.sh
├── 04_quast.sh
├── 05_annotation_prokka.sh
├── 06_comparative_abricate.sh
├── 07_phylogeny_parsnp.sh
├── 08_mapping_bwa.sh
├── run_all.sh
└── README.md
```

---

## Workflow Description

### 1. Quality Control — `01_fastqc.sh`

Performs quality assessment of raw paired-end FASTQ files using **FastQC**.

**Outputs:**
- Per-sample HTML quality reports
- Summary QC statistics

**Purpose:**
- Assess base quality
- Identify adapter contamination
- Detect GC bias or sequence duplication

---

### 2. Genome Assembly — `03_assembly_unicycler.sh`

Performs de novo genome assembly using **Unicycler**.

**Inputs:**
- Paired-end reads (`*_R1.fastq.gz` and `*_R2.fastq.gz`)

**Outputs:**
- Assembled contigs (FASTA format)
- Assembly graphs (if enabled)

**Purpose:**
- Generate draft genome assemblies from short-read sequencing data

---

### 3. Assembly Quality Assessment — `04_quast.sh`

Evaluates genome assemblies using **QUAST**.

**Outputs:**
- N50 statistics
- Total assembly length
- GC content
- Number of contigs
- HTML summary report

**Purpose:**
- Assess assembly completeness and fragmentation

---

### 4. Genome Annotation — `05_annotation_prokka.sh`

Annotates assembled genomes using **Prokka**.

**Outputs:**
- `.gff` — genome feature format
- `.gbk` — GenBank flat file
- `.faa` — protein sequences
- `.ffn` — nucleotide sequences
- Functional annotation reports

**Purpose:**
- Identify coding sequences (CDS)
- Predict tRNAs and rRNAs
- Assign gene annotations

---

### 5. Comparative Genomics — `06_comparative_abricate.sh`

Screens genomes for antimicrobial resistance (AMR) and virulence genes using **ABRicate**.

**Supported databases:**
- CARD
- ResFinder
- VFDB

**Outputs:**
- Tab-separated gene presence/absence reports
- Summary tables

**Purpose:**
- Detect resistance genes
- Identify virulence-associated factors
- Compare gene profiles across isolates

---

### 6. Phylogenetic Analysis — `07_phylogeny_parsnp.sh`

Performs core-genome alignment and phylogenetic reconstruction using **Parsnp**.

**Outputs:**
- Core-genome multiple sequence alignment
- Newick tree file
- Alignment statistics

**Purpose:**
- Determine evolutionary relationships
- Identify SNP differences among isolates

---

### 7. Reference-Based Mapping — `08_mapping_bwa.sh`

Maps raw reads to a reference genome using **BWA** and **SAMtools**.

**Outputs:**
- Sorted BAM files
- Index files
- Mapping statistics

**Purpose:**
- Assess coverage
- Detect SNPs relative to a reference genome
- Validate assemblies

---

### 8. Full Pipeline Execution — `run_all.sh`

Runs all analysis steps sequentially.

```bash
bash run_all.sh
```

---

## Requirements

Ensure the following tools are installed and available in your `$PATH`:

| Tool | Purpose |
|------|---------|
| FastQC | Quality control |
| Unicycler | Genome assembly |
| QUAST | Assembly quality assessment |
| Prokka | Genome annotation |
| ABRicate | AMR/virulence screening |
| Parsnp | Phylogenetic analysis |
| BWA | Reference-based mapping |
| SAMtools | BAM file processing |

**System requirements:**
- Bash v4+
- Linux (Ubuntu, Debian, CentOS, or similar)
- HPC cluster or workstation with ≥ 16 GB RAM
- Conda or Mamba for dependency management (recommended)

---

## Input Requirements

| File | Description |
|------|-------------|
| `sample1_R1.fastq.gz` | Forward paired-end reads |
| `sample1_R2.fastq.gz` | Reverse paired-end reads |
| `reference.fasta` | Reference genome (for mapping and phylogeny) |

---

## Output Structure

```
fastqc_results/
assembly/
quast_results/
annotation/
abricate_results/
phylogeny/
mapping/
```

---

## Usage

Run individual steps:

```bash
bash 01_fastqc.sh
bash 03_assembly_unicycler.sh
bash 05_annotation_prokka.sh
```

Run the complete pipeline:

```bash
bash run_all.sh
```
