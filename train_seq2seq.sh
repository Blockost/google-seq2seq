#!/usr/bin/zsh

export DIR=${HOME}/Dev/MovieIdeasGenerator/data
export VOCAB_SOURCE=${DIR}/vocab
export VOCAB_TARGET=${DIR}/vocab
export TRAIN_SOURCES=${DIR}/overviews
export TRAIN_TARGETS=${DIR}/titles
#export DEV_SOURCES=${HOME}/nmt_data/toy_reverse/dev/sources.txt
#export DEV_TARGETS=${HOME}/nmt_data/toy_reverse/dev/targets.txt

#export DEV_TARGETS_REF=${HOME}/nmt_data/toy_reverse/dev/targets.txt
export TRAIN_STEPS=1000

export MODEL_DIR=${DIR}/nmt
mkdir -p $MODEL_DIR

python -m bin.train \
  --config_paths="
      ./example_configs/nmt_small.yml,
      ./example_configs/train_seq2seq.yml,
      ./example_configs/text_metrics_bpe.yml" \
  --model_params "
      vocab_source: $VOCAB_SOURCE
      vocab_target: $VOCAB_TARGET" \
  --input_pipeline_train "
    class: ParallelTextInputPipeline
    params:
      source_files:
        - $TRAIN_SOURCES
      target_files:
        - $TRAIN_TARGETS" \
  --input_pipeline_dev "
    class: ParallelTextInputPipeline
    params:
       source_files:
        - $DEV_SOURCES
       target_files:
        - $DEV_TARGETS" \
  --batch_size 32 \
  --train_steps $TRAIN_STEPS \
  --output_dir $MODEL_DIR
