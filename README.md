# BERTopic Media & Communication Topics

This repository hosts embedding-based topic modeling workflows using **BERTopic** for media and communication datasets (e.g., news articles, social media posts, comments).

## Goals

- Provide reproducible pipelines for BERTopic on CSV-based corpora.
- Show how to integrate BERTopic outputs with R (via exported CSVs) for visualization and further analysis.
- Offer examples aligned with computational communication research (COVID-19 news, misinformation, health communication, etc.).

## Repository Structure

- `python/`
  - `bertopic_fit.py`: Script to load data, fit BERTopic, and save topic assignments and representations.
  - `bertopic_visualizations.py`: Optional script for generating interactive HTML visualizations.
- `R/`
  - `bertopic_posthoc_analysis.R`: R scripts for reading BERTopic outputs (topics, probabilities) and linking them to reactions, engagement, or other metadata.
- `data/`
  - `README_data.md`: Data schema and privacy notes.

## Data Notes

Input data is expected as CSV files with at least:

- `doc_id`: Unique identifier.
- `text`: Document text.
- Optional metadata: `source`, `created_at`, engagement metrics.

BERTopic outputs (topics, probabilities, representations) can be exported as CSV/JSON and then analyzed in R using standard tidyverse workflows.

## Cross-links

- LLM API integration with R: [llm-api-research-r](https://github.com/sawoodanwar/llm-api-research-r)
- LLM-based text analysis and evaluation with R: [llm-text-analysis-r](https://github.com/sawoodanwar/llm-text-analysis-r)
- Profile and other repositories: [GitHub profile](https://github.com/sawoodanwar)

You can later add explicit links to specific COVID-19 / Facebook reaction datasets or related projects as they are stabilized.

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/sawoodanwar/bertopic-media-topics.git
   ```
2. Set up Python environment with BERTopic:
   ```bash
   pip install bertopic
   ```
3. Run `python/bertopic_fit.py` on a sample CSV.
4. Use `R/bertopic_posthoc_analysis.R` to analyze exported topics and link them to engagement or reactions.
