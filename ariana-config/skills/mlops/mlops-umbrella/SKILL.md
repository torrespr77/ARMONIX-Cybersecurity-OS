---
name: mlops
description: "Machine Learning Operations — model training, evaluation, inference, and experiment tracking. Use when working with ML models, benchmarks, inference serving, or experiment management."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [mlops, machine-learning, inference, evaluation, training, experiments, models]
    related_skills: [evaluating-llms-harness, huggingface-hub, llama-cpp, segment-anything-model, serving-llms-vllm, weights-and-biases, audiocraft-audio-generation]
---

# MLOps — Umbrella Skill

Covers the full ML operations lifecycle: model discovery, evaluation, inference, training tracking, and specialized models.

## Decision Tree

| Task | Sub-Skill | Trigger Keywords |
|---|---|---|
| Benchmark LLMs (MMLU, GSM8K, etc.) | `evaluating-llms-harness` | benchmark, evaluate LLM, MMLU, GSM8K, lm-eval |
| Search/download HF models/datasets | `huggingface-hub` | huggingface, hf, download model, upload model, hf CLI |
| Local GGUF inference (CPU/GPU) | `llama-cpp` | llama.cpp, GGUF, local model, CPU inference, quantize |
| Image segmentation (zero-shot) | `segment-anything-model` | SAM, image segmentation, mask, segment, zero-shot vision |
| High-throughput LLM serving | `serving-llms-vllm` | vLLM, serve model, inference server, production API |
| Experiment tracking | `weights-and-biases` | wandb, experiment tracking, log metrics, sweeps, model registry |
| Text-to-music/audio generation | `audiocraft-audio-generation` | audiocraft, musicgen, audiogen, text-to-music, generate audio |

## Model Discovery & Download (from huggingface-hub)

Use the `hf` CLI to interact with Hugging Face Hub.

```bash
# Install
curl -LsSf https://hf.co/cli/install.sh | bash -

# Download
hf download REPO_ID
hf upload REPO_ID

# Auth
hf auth login
hf auth whoami

# Repos
hf repos create/delete/duplicate/move
```

Full command reference: `skill_view(name="huggingface-hub")`

## LLM Evaluation (from evaluating-llms-harness)

Benchmark LLMs with lm-evaluation-harness across 60+ academic benchmarks.

```bash
# Install
pip install lm-eval

# Evaluate
lm_eval --model hf \
  --model_args pretrained=meta-llama/Llama-2-7b-hf \
  --tasks mmlu,gsm8k,hellaswag \
  --num_fewshot 5 --device cuda:0
```

Full workflow: `skill_view(name="evaluating-llms-harness")`

## Local Inference (from llama.cpp)

Run GGUF models locally on CPU, Apple Silicon, or GPU.

```bash
# Install
brew install llama.cpp

# Run from Hub
llama-cli -hf bartowski/Llama-3.2-3B-Instruct-GGUF:Q8_0
llama-server -hf bartowski/Llama-3.2-3B-Instruct-GGUF:Q8_0
```

Full guide: `skill_view(name="llama-cpp")`

## Production Serving (from serving-llms-vllm)

Deploy high-throughput LLM APIs with vLLM.

```bash
pip install vllm

# Offline inference
python -c "from vllm import LLM; llm = LLM('meta-llama/Llama-3-8B-Instruct'); print(llm.generate(['Hello']))"

# OpenAI-compatible server
vllm serve meta-llama/Llama-3-8B-Instruct
```

Full deployment guide: `skill_view(name="serving-llms-vllm")`

## Experiment Tracking (from weights-and-biases)

```bash
pip install wandb
wandb login

# In training code
import wandb
wandb.init(project="my-project", config={"lr": 0.001})
wandb.log({"loss": 0.5, "accuracy": 0.92})
wandb.finish()
```

Full tracking guide: `skill_view(name="weights-and-biases")`

## Image Segmentation (from segment-anything-model)

```bash
pip install git+https://github.com/facebookresearch/segment-anything.git

# Download checkpoint
wget https://dl.fbaipublicfiles.com/segment_anything/sam_vit_h_4b8939.pth
```

Full segmentation guide: `skill_view(name="segment-anything-model")`

## Audio Generation (from audiocraft-audio-generation)

```bash
pip install audiocraft

# Text-to-music
python -c "
import torchaudio
from audiocraft.models import MusicGen
model = MusicGen.get_pretrained('facebook/musicgen-small')
model.set_generation_params(duration=8)
wav = model.generate(['happy upbeat electronic dance music'])
torchaudio.save('output.wav', wav[0].cpu(), sample_rate=32000)
"
```

Full audio guide: `skill_view(name="audiocraft-audio-generation")`
