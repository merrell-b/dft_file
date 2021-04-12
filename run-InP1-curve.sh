#!/bin/bash
#SBATCH --job-name=molecular_h2
#SBATCH --account=ic_phys190
#SBATCH --partition=savio2
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=15
#SBATCH --time=05:00:00
#SBATCH --output=array_job.out
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=jbneaton@berkeley.edu

module load quantumespresso/6.3

for i in 0.03 0.05 0.06 0.07 0.08 0.09 0.10 0.11 0.13 0.15 0.17 0.25 0.30 0.35; do

cat <<! > H2.$i.in
 &control
    calculation = 'scf'
    verbosity='high'
    restart_mode='from_scratch',
    prefix='H2',
    tstress = .true.
    tprnfor = .true.
    pseudo_dir = '/global/home/users/jbneaton/H2_LDA',
    outdir='/global/home/users/jbneaton/test_H2_LDA'
 /
 &system
    ibrav=  1,
	celldm(1) =20,
	nat=  2,
	ntyp= 1,
    ecutwfc = 50
 /
 &electrons
    mixing_beta = 0.7
    conv_thr =  1.0d-8
 /
ATOMIC_SPECIES
 H  1.00794  H.pz-rrkjus_psl.1.0.0.UPF
ATOMIC_POSITIONS crystal
 H 0.00 0.00 0.00
 H $i 0.00 0.00
K_POINTS automatic
1 1 1 0 0 0
EOF
!

pw.x < H2.$i.in > H2.$i.out

done
