#!/bin/bash
#SBATCH --job-name=InP_1
#SBATCH --account=ic_phys190
#SBATCH --partition=savio2
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=15
#SBATCH --time=05:00:00
#SBATCH --output=array_job.out
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=mbrzeczek@berkeley.edu

module load quantumespresso/6.3

pw.x < InP1.in > InP1.out

