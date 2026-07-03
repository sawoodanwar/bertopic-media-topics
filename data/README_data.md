# Data README for BERTopic Media & Communication Topics

This directory documents expected data formats and privacy considerations for BERTopic workflows.

## Input Data Schema

BERTopic scripts assume CSV files with at least:

- `doc_id`: Unique identifier for each document.
- `text`: Main textual content.
- Optional metadata:
  - `source`: Outlet/platform name.
  - `created_at`: Timestamp.
  - engagement metrics (e.g., reaction counts, shares, comments).

## Output Data Schema

Typical BERTopic outputs exported for R post-hoc analysis include:

- `doc_id`: Identifier matching the input.
- `topic`: Assigned topic label or numeric ID.
- `probability`: Topic probability for the document.
- Topic-level representations (e.g., top words per topic) stored in separate CSV/JSON.

## Privacy and Ethics

- Do not commit raw sensitive datasets to the public repository.
- Anonymize or aggregate data where necessary.
- Follow institutional and platform-specific ethics guidelines.

## Related Repositories

- LLM API integration with R: [llm-api-research-r](https://github.com/sawoodanwar/llm-api-research-r)
- LLM-based text analysis and evaluation with R: [llm-text-analysis-r](https://github.com/sawoodanwar/llm-text-analysis-r)
