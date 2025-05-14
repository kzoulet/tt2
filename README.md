# 🐦 TT2 – Tits Tracker 2

**Shitty AI made Unsupervised Individual Bird Identification System that is not working**

TT2 identifies **distinct birds** (not just species) using timestamped image bursts, deep metric learning, and unsupervised clustering. It requires **no manual labeling** and improves as you collect more data.

---

## 📁 Directory Structure

```
tt2/
├── tt2/                      # Python package with core scripts
│   ├── __init__.py
│   ├── crop_bird.py
│   ├── tt2.py
│   ├── train_reid_from_clusters.py
│   ├── discover_individuals_003.py
│   ├── self_supervised_training.py
│   └── ...
├── data/                     # Contains raw_images/, cropped_birds/, discovered_individuals/
├── scripts/                  # Optional CLI launchers
├── README.md
├── requirements.txt          # Dependencies
├── setup.sh / install.bat    # Optional auto-setup helpers
└── .venv/                     # Local virtual environment (not committed)
```

---

## 🧠 Pipeline Scripts (Recommended)

### 🔧 `tt2.py`

Main pipeline:

* Runs `crop_bird.py`
* Runs `discover_individuals_003.py`
* Moves processed raw images to archive

Run this to process new data.

> ⚠️ Paths should be relative, e.g. `Path("data/raw_images")` 

---

### 🤖 `crop_bird.py`

* Detects birds using YOLOv11x
* Extracts EXIF timestamps
* Supports subfolders inside `raw_images/`

---

### 🔄 `train_reid_from_clusters.py`

* Uses timestamp-based grouping (15s window)
* Trains a re-ID model (ResNet18 + triplet loss)
* Embedding dim: 256 or 512

Retrain periodically to improve individual separation.

> ✅ Update paths to relative, e.g. `Path("data/cropped_birds")`

---

### 🧠 `discover_individuals_003.py`

* Embeds all bird crops using `reid_model.pth`
* Clusters identities using HDBSCAN
* Saves to `discovered_individuals/`

Use after training to regenerate clusters.

---

### 🤓 `self_supervised_training.py`

* Contrastive learning (MoCo-style)
* Multi-positive, hard-negative sampling
* Strong augmentations + ResNet50

Best suited for scaling up with 1k+ sessions.

---

## 📊 Optional Tools

### 🔢 `plot_bird_timeline.py`

* Plots bird appearance timeline using `discovered_individuals/`
* Optionally uses species predictions

---

## ❌ Legacy / Experimental

### ❌ `train_species_classifier.py`

Supervised training based on discovered clusters. **Not reliable** for re-ID.

### ❌ `classify_species_clip.py`

Predicts species only. Not used for identity.

### ❌ `crop_bird_for_classifier.py`

Special square cropper for classification. Not used in TT2.

### ❌ `discover_individuals.py`, `_002.py`

Older clustering versions. Use `discover_individuals_003.py`.

---

## 🚀 Recommended Workflow

1. Drop new folders into `data/raw_images/YYYY-MM-DD/`
2. Run `tt2.py`
3. (Optional) Retrain with `train_reid_from_clusters.py` every few days
4. (Optional) Run `discover_individuals_003.py` after retraining
5. (Optional) Visualize with `plot_bird_timeline.py`

---

## 🛋️ Installation on a new computer

### 1. Clone or copy the project folder

```bash
git clone ...   # or copy files manually
cd tt2
```

### 2. Create a virtual environment

```bash
python -m venv .venv
source .venv/bin/activate       # On Windows: .venv\Scripts\activate
```

### 3. Install dependencies

```bash
pip install -r requirements.txt
```

### 4. Run the main pipeline

```bash
python tt2/tt2.py
```

---

## 📄 Example `requirements.txt`

```txt
torch
torchvision
ultralytics
opencv-python
numpy
Pillow
tqdm
hdbscan
matplotlib
```

---

TT2 is self-improving. As you collect more birds, the system refines its ability to recognize them across lighting, pose, and time.

> ✉️ Tip: use `Path("data/...")` inside all scripts to keep paths relative and repo-portable.
