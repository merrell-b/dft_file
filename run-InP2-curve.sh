#!/bin/bash
#SBATCH --job-name=InP_2
#SBATCH --account=ic_phys190
#SBATCH --partition=savio2
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=15
#SBATCH --time=00:30:00
#SBATCH --output=array_job.out
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=mbrzeczek@berkeley.edu

module load quantumespresso/6.3

for i in 0.03 0.05 0.06 0.07 0.08 0.09 0.10 0.11 0.13 0.15 0.17 0.25 0.30 0.35; do

cat <<! > InP2.$i.in
 &control
    calculation = 'scf'
    verbosity='high'
    restart_mode='from_scratch',
    prefix='InP',
    tstress = .true.
    tprnfor = .true.
    pseudo_dir = '.',
    outdir='.'
 /
&system
   ecutwfc = 135.0
   ibrav = 0
   nat = 2
   ntyp = 2
   input_dft = 'pbe'
/
&electrons
   electron_maxstep = 100
   conv_thr = 1e-08
   mixing_mode = 'plain'
   mixing_beta = 0.7
   mixing_ndim = 8
   diagonalization = 'david'
   diago_david_ndim = 4
   diago_full_acc = .true.
/
CELL_PARAMETERS angstrom
   0.0 2.93435 2.93435
   2.93435 0.0 2.93435
   2.93435 2.93435 0.0
ATOMIC_SPECIES 
   In 114.818 'In2.upf'
   P 30.973762 'P2.upf'
ATOMIC_POSITIONS crystal
   P -$i -$i -$i
   In $i $i $i
K_POINTS crystal
   22
   0.0 0.0 0.0 1.0
   0.0 0.0 0.166666667 4.0
   0.0 0.0 0.333333333 4.0
   0.0 0.0 0.5 4.0
   0.0 0.0 0.666666667 4.0
   0.0 0.0 0.833333333 4.0
   0.0 0.166666667 0.166666667 6.0
   0.0 0.166666667 0.333333333 12.0
   0.0 0.166666667 0.5 12.0
   0.0 0.166666667 0.666666667 12.0
   0.0 0.166666667 0.833333333 12.0
   0.0 0.333333333 0.333333333 6.0
   0.0 0.333333333 0.5 12.0
   0.0 0.333333333 0.666666667 12.0
   0.0 0.333333333 0.833333333 12.0
   0.0 0.5 0.5 3.0
   0.0 0.5 0.666666667 12.0
   0.0 0.5 0.833333333 12.0
   0.0 0.666666667 0.833333333 12.0
   0.166666667 0.333333333 0.5 24.0
   0.166666667 0.333333333 0.666666667 24.0
   0.166666667 0.5 0.666666667 12.0
   0.0 0.333333333 0.666666667 12.0
   0.0 0.333333333 0.833333333 12.0
   0.0 0.5 0.5 3.0
   0.0 0.5 0.666666667 12.0
   0.0 0.5 0.833333333 12.0
   0.0 0.666666667 0.833333333 12.0
   0.166666667 0.333333333 0.5 24.0
   0.166666667 0.333333333 0.666666667 24.0
   0.166666667 0.5 0.666666667 12.0
!

pw.x < InP1.$i.in > InP1.$i.out

done
