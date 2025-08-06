--Using this setup, we will answer a few business questions through SQL

-- 1) How many total businesses are there in each category - also tells us the category 
--    that has the most registered businesses on Yelp

with cte as (
select business_id, trim(A.value) as category 
from tbl_yelp_business, lateral split_to_table(categories, ',') A
)
select category, count(*) as no_of_business from cte
group by 1 order by 2 desc



-- 2) Top 10 users who have reviewed the most businesses in "Restaurants" category - make note that one user could 
--    have reviewed multiple restaurants, but we want users who have reviewed the distinct businesses that fall
--    in the restaurant category.

select r.user_id as unique_users, count(distinct r.business_id) as total_distinct_reviews 
from tbl_yelp_reviews r inner join tbl_yelp_business b
on r.business_id = b.business_id
where b.categories ilike '%restaurant%'
group by unique_users 
order by total_distinct_reviews desc



-- 3) Find most popular categories of businesses (based on number of reviews) - need to use cte from 1st query

with cte as (
select business_id, trim(A.value) as category 
from tbl_yelp_business, lateral split_to_table(categories, ',') A
)
select category, count(*) as no_of_reviews
from cte inner join tbl_yelp_business b
on cte.business_id = b.business_id
group by 1
order by 2 desc



-- 4) Find the top 3 most recent reviews for each business

with cte as
(
select r.*, b.name,
row_number() over (partition by r.business_id order by review_date desc) as rn
from tbl_yelp_reviews r
inner join tbl_yelp_business b on r.BUSINESS_ID = b.BUSINESS_ID
)
select * from cte where rn <= 3


-- 5) Find the month with the highest number of reviews

select month(review_date) as review_month, count(*) as no_of_reviews
from tbl_yelp_reviews
group by 1
order by 2 desc


-- 6) Find the percentage of 5-star reviews for each business

select b.business_id, b.name, count(*) as total_reviews,
sum(case when r.review_stars = 5 then 1 else 0 end) as five_star_reviews,
five_star_reviews * 100 / total_reviews as percent_5_star
from tbl_yelp_reviews r
inner join tbl_yelp_business b on r.BUSINESS_ID = b.BUSINESS_ID
group by b.business_id, b.name


-- 7) Find the top 5 most reviewed businesses in each city

with cte as
(
select b.city, b.business_id, b.name, count(*) as total_reviews,
from tbl_yelp_reviews r
inner join tbl_yelp_business b on r.BUSINESS_ID = b.BUSINESS_ID
group by 1, 2, 3
)

select *
from cte qualify row_number() over (partition by city order by total_reviews desc) <= 5


-- 8) Find the average rating of businesses that have at least 1000 reviews

select b.business_id, b.name, count(*) as total_reviews, avg(review_stars) as avg_rating
from tbl_yelp_reviews r
inner join tbl_yelp_business b on r.BUSINESS_ID = b.BUSINESS_ID
group by 1,2
having count(*) >= 100


-- 9) List the top 10 users who have written the most reviews, along with the businesses they reviewed

with cte as (
select r.user_id, count(*) as total_reviews
from tbl_yelp_reviews r
inner join tbl_yelp_business b on r.BUSINESS_ID = b.BUSINESS_ID
group by 1
order by 2 desc limit 10
)

select user_id, business_id
from tbl_yelp_reviews where user_id in (select user_id from cte)
group by 1,2
order by user_id


-- 10) Find the top 10 businesses with the highest positive sentiment reviews

select r.business_id, b.name, count(*) as total_reviews
from tbl_yelp_reviews r
inner join tbl_yelp_business b on r.BUSINESS_ID = b.BUSINESS_ID
where sentiments = 'Positive'
group by 1,2
order by 3 desc limit 10
