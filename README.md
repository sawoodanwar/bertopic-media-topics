# BERTopic for Media & Communication Research

[![Language: Python](https://img.shields.io/badge/Language-Python-3776AB?style=flat&logo=python&logoColor=white)](https://www.python.org/)
[![Language: R](https://img.shields.io/badge/R-Post--hoc%20Analysis-276DC3?style=flat&logo=r&logoColor=white)](https://www.r-project.org/)
[![Method: BERTopic](https://img.shields.io/badge/Method-BERTopic-8A2BE2?style=flat)](https://maartengr.github.io/BERTopic/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A reproducible pipeline for **embedding-based topic modeling of media corpora** using [BERTopic](https://maartengr.github.io/BERTopic/). Designed for computational communication researchers working with news articles, social media posts, or other short-text corpora. Outputs feed directly into R for post-hoc analysis, visualization, and integration with engagement or reaction metrics.

---

## 🔗 Related Projects

| Repository | Description |
|---|---|
| 🦠 [facebook-reactions-covid19-india](https://github.com/sawoodanwar/facebook-reactions-covid19-india) | PhD thesis — embedding-based topics applied to COVID-19 news |
| 🧠 [stm-social-media-r](https://github.com/sawoodanwar/stm-social-media-r) | STM topic modeling alternative (R) |
| 💬 [sentiment-lexicon-comparison](https://github.com/sawoodanwar/sentiment-lexicon-comparison) | Sentiment analysis companion |

---

## 📌 Overview

BERTopic uses **sentence-level embeddings** and **HDBSCAN clustering** to discover coherent topics from a corpus without requiring a fixed number of topics in advance. This repo extends the core BERTopic workflow with:

- Pre-processing tailored to short, noisy social media text
- Support for LLM-based semantic cluster labeling (GPT-4 / local LLMs)
- Export of topic assignments and probabilities as CSV/JSON for downstream R analysis
- Post-hoc R scripts that link topic distributions to engagement metrics, reactions, or metadata covariates

---

## 🔬 Methodology

### Step 1 — Text Preprocessing

Raw texts are cleaned before embedding:
- Remove URLs, HTML tags, and platform boilerplate
- Normalize Unicode and whitespace
- Optionally remove stopwords (BERTopic is generally robust to them)

See `python/bertopic_fit.py` for the preprocessing pipeline.

### Step 2 — Sentence Embeddings

Documents are embedded using a pre-trained sentence transformer. The default model is `all-MiniLM-L6-v2` (fast, 384-dim). For longer or domain-specific texts, consider `all-mpnet-base-v2` or a domain-adapted model.

```python
from sentence_transformers import SentenceTransformer
model = SentenceTransformer("all-MiniLM-L6-v2")
embeddings = model.encode(docs, show_progress_bar=True)
```

### Step 3 — Dimensionality Reduction (UMAP)

High-dimensional embeddings are reduced to a lower-dimensional space before clustering, which improves HDBSCAN performance and enables 2-D visualization.

```python
from umap import UMAP
umap_model = UMAP(n_neighbors=15, n_components=5, min_dist=0.0, metric="cosine")
```

### Step 4 — Clustering (HDBSCAN)

HDBSCAN assigns each document to a topic cluster or marks it as noise (Topic -1). Key hyperparameters:
- `min_cluster_size`: minimum documents per topic — increase for fewer, larger topics
- `min_samples`: controls cluster density

### Step 5 — Topic Representation (c-TF-IDF)

BERTopic uses a class-based TF-IDF (c-TF-IDF) to extract the most representative terms per cluster. Terms reflect what is unique to each topic relative to the full corpus.

### Step 6 — LLM-Based Cluster Labeling *(optional)*

Top terms and representative documents per topic are passed to an LLM (GPT-4 or local model) to generate human-readable semantic labels. This approach was used in the [doctoral thesis](https://github.com/sawoodanwar/facebook-reactions-covid19-india) to label 25 COVID-19 news themes.

```python
# Pseudocode — see python/llm_labeling.py
prompt = f"Top terms: {top_terms}\nDocuments: {sample_docs}\nLabel this topic:"
label = call_llm(prompt)
```

### Step 7 — Export and R Integration

Outputs are saved as CSV files for post-hoc analysis in R:
- `bertopic_doc_topics.csv` — per-document topic ID and probability
- `bertopic_topic_info.csv` — topic ID, label, size, top terms

---

## 📂 Repository Structure

```
bertopic-media-topics/
├── python/
│   ├── bertopic_fit.py              # Main pipeline: preprocess → embed → cluster → export
│   └── bertopic_visualizations.py  # Interactive HTML topic visualizations
├── R/
│   └── bertopic_posthoc_analysis.R # Link topics to engagement, reactions, metadata
├── data/
│   ├── README_data.md              # Data schema and privacy notes
│   └── example_docs.csv           # Synthetic COVID-19 texts for quick testing
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🚀 Usage

### Prerequisites

```bash
pip install bertopic sentence-transformers umap-learn hdbscan pandas
```

For LLM labeling (optional):
```bash
pip install openai
```

For R post-hoc analysis:
```r
install.packages(c("tidyverse", "ggplot2", "readr", "dplyr"))
```

### Quick Start

**1. Clone the repository**
```bash
git clone https://github.com/sawoodanwar/bertopic-media-topics.git
cd bertopic-media-topics
```

**2. Prepare your input data**

Create a CSV with at minimum:
```
doc_id, text, source, created_at
```
Or use the provided `data/example_docs.csv` for testing.

**3. Fit BERTopic and export topics**
```bash
python python/bertopic_fit.py --input data/example_docs.csv --output data/
```

This produces:
- `data/bertopic_doc_topics.csv`
- `data/bertopic_topic_info.csv`

**4. Analyse in R**
```r
source("R/bertopic_posthoc_analysis.R")
# Joins topic assignments with engagement metadata
# Produces topic frequency plots and reaction-by-topic summaries
```

**5. (Optional) Generate interactive visualizations**
```bash
python python/bertopic_visualizations.py
# Outputs: topic_map.html, topic_barchart.html
```

---

## 📊 Expected Outputs

| File | Description |
|---|---|
| `bertopic_doc_topics.csv` | Each document with its assigned topic ID and probability |
| `bertopic_topic_info.csv` | Topic ID, size, top terms, and LLM-generated label (if used) |
| `topic_map.html` | Interactive UMAP 2-D scatter of documents coloured by topic |
| `topic_barchart.html` | Top-term bar charts per topic |

---

## 📖 Citation

If you use this workflow in your research, please cite the associated doctoral thesis:

```bibtex
@phdthesis{anwar2025facebook,
  title  = {``Facebook Reactions'' as Emotional Indicators: A Multi-Method Approach
             to Analyzing User Engagement with COVID-19 News on Indian Media Platforms},
  author = {Anwar, Sawood},
  year   = {2025},
  school = {University of Urbino Carlo Bo},
  type   = {PhD Thesis},
  note   = {Supervisor: Prof. Fabio Giglietto; Co-Supervisor: Prof. Giovanni Boccia Artieri}
}
```

---

## 📬 Author

**Sawood Anwar** — PhD in Humanities (Text and Communication Sciences)
University of Urbino Carlo Bo, Italy

[![GitHub](https://img.shields.io/badge/GitHub-sawoodanwar-181717?style=flat&logo=github)](https://github.com/sawoodanwar)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-sawood--anwar-0A66C2?style=flat&logo=linkedin)](https://www.linkedin.com/in/sawood-anwar/)
[![Google Scholar](https://img.shields.io/badge/Google%20Scholar-Sawood%20Anwar-4285F4?style=flat&logo=googlescholar&logoColor=white)](https://scholar.google.com/citations?user=Z2kACpkAAAAJ&hl=en)
[![ORCID](https://img.shields.io/badge/ORCID-0009--0000--2819--9179-A6CE39?style=flat&logo=orcid&logoColor=white)](https://orcid.org/0009-0000-2819-9179)

---

## 📝 License

MIT License. See [LICENSE](LICENSE).

---

*Keywords: BERTopic, topic modeling, sentence embeddings, HDBSCAN, UMAP, NLP, social media, media analysis, COVID-19, computational communication, LLM cluster labeling*
