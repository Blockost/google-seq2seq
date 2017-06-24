#!/usr/bin/bash

export DIR=${HOME}/dev/MovieIdeasGenerator
export DATA_DIR=${DIR}/data
export SOURCES=${DATA_DIR}/predict_sources.txt

export MODEL_DIR=${DATA_DIR}/logs
export PRED_DIR=${DATA_DIR}/preds
mkdir -p ${PRED_DIR}


export TRAIN_STEPS=1000


python -m bin.infer \
  --tasks "
    - class: DecodeText" \
  --model_dir $MODEL_DIR \
  --input_pipeline "
    class: ParallelTextInputPipeline
    params:
      source_files:
        - $SOURCES" \
  >  ${PRED_DIR}/predictions.txt

