#! /usr/bin/env bash

export PYTHONPATH=$PYTHONPATH:$(pwd)

DATASET=iwildcam

# ===================================

LEVEL=5

if [ "$#" -lt 2 ]; then
	CORRUPT=snow
	# CORRUPT=cifar_new

	METHOD=tent
	NSAMPLE=1000
else
	CORRUPT=$1
	METHOD=$2
	NSAMPLE=$3
fi

# ===================================


LR=0.001
BS_TENT=64
RESUME=./save/iwildcam_models/Joint_iwildcam_resnet50_lr_0.1_decay_0.0001_bsz_256_temp_0.5_trial_1_balance_0.5

echo 'DATASET: '${DATASET}
echo 'CORRUPT: '${CORRUPT}
echo 'METHOD:' ${METHOD}
echo 'LR:' ${LR}
echo 'BS_TENT:' ${BS_TENT}
echo 'NSAMPLE:' ${NSAMPLE}

# ===================================

printf '\n---------------------\n\n'

python tent.py \
	--dataroot ${DATADIR} \
#	--resume results/${DATASET}_joint_resnet50 \
	--resume ${RESUME}
	--outf results/${DATASET}_tent_joint_resnet50 \
	--corruption ${CORRUPT} \
	--level ${LEVEL} \
	--workers 36 \
	--batch_size ${BS_TENT} \
	--lr ${LR} \
	--num_sample ${NSAMPLE} \
	# --tsne
	--ckpt 20
