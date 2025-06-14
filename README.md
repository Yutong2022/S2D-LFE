# <p align=center> :fire: `S2D-LFE: Sparse-to-Dense Light Field Event Generation`</p>
## 🚩 **Todo List**
- [ ] Real and Synthetic LFE Datasets  
- [x] System Setup and ROS Scripts for Data Collection  
- [x] Source Code of LFE-VAE  
- [x] Source Code of the Diffusion Pipeline  
- [ ] Pretrained Weights of LFE-VAE  
- [ ] Pretrained Weights of the Diffusion Pipeline

---

## 🚀 Getting Started

### Prerequisites

- Python ≥ 3.9
- CUDA‑capable GPU with driver ≥ 11.8
- **DAVIS** camera drivers *(only if you plan to capture real data)*
- **CARLA Simulator** ≥ 0.9.15 *(optional, for synthetic data generation)*

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/<your‑org>/<project>.git
cd <project>

# 2. Create an isolated environment (recommended)
conda env create -f environment.yml            # or use venv / poetry
conda activate <env‑name>

# 3. Install the package in editable mode
pip install -e .
```

---


## 📦 Datasets

| Dataset                            | Source                          | Download Script             |
| ---------------------------------- | ------------------------------- | --------------------------- |
| **Real-world Dataset (DAVIS‑LFE)** | Captured by Davis array | —  |
| **Synthetic Dataset (CARLA‑LFE)** | Generated locally via CARLA     | —                           |

> By default, datasets are placed under `datasets/`. Use `--dest <path>` to override.

---

## 📥 Data Acquisition

### 1. DAVIS Camera Array

```bash
# Capture raw light‑field sequences
python dv-ros-master\script\run.sh

# Calibrate the captured dataset
python -
```

### 2. CARLA Synthetic Data

```bash
# Launch CARLA (server mode)
./CarlaUE4.sh -opengl &

# Generate a synthetic light‑field dataset
python Data_capturing_and_synthesis/carla_sim/generate_dataset.py \
       --cfg configs/carla/town05.yaml --out datasets/carla_raw
```
---

## 🧩 Model Usage (LFE‑Diffusion ✕ VAE)

### Training

```bash
python LFE_model/train.py --cfg configs/train/lfd_default.yaml
```

### Inference

```bash
python LFE_model/infer.py \
       --weights checkpoints/lfd_best.pth \
       --input datasets/davis_calib/sample.lf \
       --output out/recon/
```

<!-- ---



## 📝 Citation

```bibtex
@misc{<project>,
  author       = {<Your Name>},
  title        = {<Project Name>: A Unified DAVIS/CARLA Light‑Field Benchmark},
  year         = {2025},
  howpublished = {\url{https://github.com/<your‑org>/<project>}}
}
```

--- -->

## 🙏 Acknowledgements

- **DAVIS Project** – [https://drive.google.com/davis](https://drive.google.com/davis)
- **CARLA** – [https://carla.org](https://carla.org)
