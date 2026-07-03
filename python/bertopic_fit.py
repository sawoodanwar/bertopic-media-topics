# BERTopic fitting script

import pandas as pd
from bertopic import BERTopic


def main():
    # Load input data
    df = pd.read_csv("data/example_docs.csv")
    texts = df["text"].tolist()

    # Fit BERTopic
    topic_model = BERTopic()
    topics, probs = topic_model.fit_transform(texts)

    # Attach outputs to dataframe
    df["topic"] = topics
    df["probability"] = probs

    # Save document-level outputs
    df.to_csv("data/bertopic_doc_topics.csv", index=False)

    # Save topic representations
    topic_info = topic_model.get_topic_info()
    topic_info.to_csv("data/bertopic_topic_info.csv", index=False)


if __name__ == "__main__":
    main()
