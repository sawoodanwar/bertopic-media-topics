# BERTopic post-hoc analysis in R

#' Read BERTopic outputs and summarize topics
#'
#' This script assumes you have run python/bertopic_fit.py and exported:
#' - data/bertopic_doc_topics.csv
#' - data/bertopic_topic_info.csv

library(readr)
library(dplyr)

# Document-level topics
bertopic_docs <- read_csv("data/bertopic_doc_topics.csv")

# Topic-level info
bertopic_info <- read_csv("data/bertopic_topic_info.csv")

# Example: count documents per topic
topic_counts <- bertopic_docs %>%
  count(topic, sort = TRUE)

print(topic_counts)

# Example: join topic labels (if present in topic_info)
if ("Name" %in% names(bertopic_info)) {
  topic_counts <- topic_counts %>%
    left_join(bertopic_info %>% select(Topic, Name), by = c("topic" = "Topic"))
}

print(topic_counts)
