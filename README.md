# Yelp_reviews_analysis
In this project, I built an end-to-end data analysis workflow using Python, Amazon S3, and Snowflake to simulate the role of a data analyst working at Yelp.

The goal was to process and analyze a large dataset (7M+ user reviews file with a size greater than 5 GB) to uncover actionable business insights by mapping user sentiments to specific businesses. The process includes the following steps:

1) Partitioning and uploading large review datasets to Amazon S3.
2) Loading and merging data into Snowflake tables.
3) Applying sentiment analysis using a Python UDF (positive, negative, neutral).
4) Running SQL queries to answer key business questions.

I have also mentioned a few findings that I learned from this project. This simulates how a data analyst works in real life.

**1) What business categories have the most listings on Yelp?**

Helps identify high-competition markets and popular business verticals (e.g., restaurants and salons).

**2) Which users review the most distinct restaurants?**

Identifies highly active and engaged reviewers in the "Restaurants" category, which can be useful for loyalty programs or influencer outreach.

**3) Which business categories receive the most reviews overall?**

Shows which categories drive the most user engagement.

**4) Which cities have the most popular businesses, and which are the top ones in each?**

Reveals popular local business and regional engagement trends, which can be helpful during location-based marketing strategies.

**5) Which businesses receive the most positive reviews?**

Displays high-performing businesses based on sentiment, not just star ratings, which is very valuable when we feature top-rated companies.


The flow chart below shows the full pipeline, step by step, to help others understand and replicate the workflow.

<img width="2158" height="752" alt="image" src="https://github.com/user-attachments/assets/2963fcac-363f-40f8-9834-b5a7d89b54a6" />
