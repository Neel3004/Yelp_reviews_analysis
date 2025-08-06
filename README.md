# Yelp_reviews_analysis
In this project, I built an end-to-end data analysis workflow using Python, Amazon S3, and Snowflake to simulate the role of a data analyst working at Yelp.

The goal was to process and analyze a large dataset (7M+ user reviews file with the size greater than 5 GB) to uncover actionable business insights by mapping user sentiments to specific businesses. The process includes the following steps:

1) Partitioning and uploading large review datasets to Amazon S3
2) Loading and merging data into Snowflake tables
3) Applying sentiment analysis using a Python UDF (positive, negative, neutral)
4) Running SQL queries to answer key business questions

The flow chart below shows the full pipeline, step by step, to help others understand and replicate the workflow.

<img width="2158" height="752" alt="image" src="https://github.com/user-attachments/assets/2963fcac-363f-40f8-9834-b5a7d89b54a6" />
