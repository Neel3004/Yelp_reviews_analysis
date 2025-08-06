-- Code to categorize user review text into one
-- of the 3 categories (Positive, Negative, or Neutral)

CREATE OR REPLACE FUNCTION analyze_sentiment(text STRING)
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.9'
PACKAGES = ('textblob') 
HANDLER = 'sentiment_analyzer'
AS $$
from textblob import TextBlob
def sentiment_analyzer(text):
    analysis = TextBlob(text)
    if analysis.sentiment.polarity > 0:
        return 'Positive'
    elif analysis.sentiment.polarity == 0:
        return 'Neutral'
    else:
        return 'Negative'
$$;


-- Yelp reviews table 

create or replace table yelp_reviews (review_text variant)

copy into yelp_reviews
from 's3://yelpreviewsdataset/yelp_user_review_files/'
credentials = (
    aws_key_id = '***********'
    aws_secret_key = '***********'
)

file_format = (type = json);

select count(*) from yelp_reviews

create or replace table tbl_yelp_reviews as
select review_text:business_id::string as business_id,
review_text:date::date as review_date,
review_text:user_id::string as user_id,
review_text:stars::number as review_stars,
review_text:text::string as review_text,
analyze_sentiment(review_text) as sentiments
from yelp_reviews

select * from tbl_yelp_reviews limit 10

  
-- Yelp Businesses
create or replace table yelp_business (business_text variant)

copy into yelp_business
from 's3://yelpreviewsdataset/yelp_user_review_files/yelp_academic_dataset_business.json'
credentials = (
    aws_key_id = '************'
    aws_secret_key = '***************'
)

file_format = (type = json);

select * from yelp_business limit 5

create or replace table tbl_yelp_business as
select business_text:business_id::string as business_id,
business_text:city::string as city,
business_text:review_count::number as review_count,
business_text:name::string as name,
business_text:stars::number as stars,
business_text:state::string as state,
business_text:categories::string as categories
from yelp_business 
