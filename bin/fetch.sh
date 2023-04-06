#!/bin/bash


file="$1"


mkdir -p rawFastq
cat "$file" | parallel -j 8 "fastq-dump --gzip --split-files {} --outdir rawFastq"