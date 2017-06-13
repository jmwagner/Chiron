#!/usr/bin/env cwl-runner
cwlVersion: v1.0
label: Metacompass utility for comparative assembly of metagenomic reads
class: CommandLineTool

requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: umigs/chiron-metacompass

inputs:
  paired_reads:
    label: Path to paired reads.  Must provide 'unpaired_reads' or 'paired_reads' option
    type: File[]?
    inputBinding:
      prefix: --paired
      itemSeparator: ','
      shellQuote: false
  unpaired_reads:
    label: Path to unpaired or singleton reads.  Must provide 'unpaired_reads' or 'paired_reads' option
    type: File[]?
    inputBinding:
      prefix: --unpaired
      itemSeparator: ','
      shellQuote: false
  reference_genomes:
    label: Path to reference genome fasta files. Optional
    type: File[]?
    inputBinding:
      prefix: --ref
      itemSeparator: ','
      shellQuote: false
  max_read_length:
    label: Maximum read length. Optional
    type: int
    inputBinding:
      prefix: --readlen
    default: 100
  num_threads:
    label: Number of CPU threads to utilize. Optional
    type: int
    inputBinding:
      prefix: --threads
    default: 1
  output_directory:
    label: Directory path to write output to
    type: string
    inputBinding:
      prefix: --outdir
    default: './'
outputs:
    out_dir:
      type: Directory
      outputBinding:
        glob: $(inputs.output_directory)

baseCommand: ["/opt/MetaCompass/go_metacompass.py"]
