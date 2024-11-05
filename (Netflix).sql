-- create database
create database netflix;
use netflix;
select * from titles;


-- count total number of records
select count(*) as total_records
from titles;


-- unique values in each column
select
count(distinct show_ID) as unique_show_IDs,
count(distinct type) as unique_types,
count(distinct title) as unique_titles,
count(distinct director) as unique_directors,
count(distinct cast) as unique_casts,
count(distinct country) as unique_countries,
count(distinct date_added) as unique_dates_added,
count(distinct release_year) as unique_release_years,
count(distinct rating) as unique_ratings,
count(distinct duration) as unique_durations,
count(distinct listed_in) as unique_listed_in,
count(distinct description) as unique_descriptions
from titles;


-- count missing values in each columns
select
sum(case when director is NULL then 1 else 0 end) as missing_directors,
sum(case when cast is NULL then 1 else 0 end) as missing_cast,
sum(case when country is NULL then 1 else 0 end) as missing_country,
sum(case when date_added is NULL then 1 else 0 end) as missing_dates_added,
sum(case when rating is NULL then 1 else 0 end) as missing_ratings,
sum(case when duration is NULL then 1 else 0 end) as missing_durations
from titles;


-- Distribution of type
select type, count(*) as count
from titles
group by type
order by count DESC;


-- Distribution of ratings
select rating, count(*) as count
from titles
group by rating
order by count DESC;


-- Distribution of release year
select release_year, count(*) as count
from titles
group by release_year
order by release_year;


-- Top 10 most common Directors
select director, count(*) as count
from titles
group by director
order by count DESC
limit 10;


-- Top 10 countries
select country, count(*) as count
from titles
group by country
order by count DESC
limit 10;


-- Records added per month
select date_format(STR_TO_DATE(date_added, '%b %d, %Y'), '%Y-%m') as month,
count(*) as count
from titles
group by month
order by month;


-- Records added per year
select year(STR_TO_DATE(date_added, '%b %d, %Y')) as year, count(*) as count
from titles
group by year
order by year;


-- Count dramas records
select count(*) as count
from titles
where listed_in LIKE '%dramas%';


-- Average duration of movies/shows
select AVG(CAST(SUBSTRING_INDEX(duration, ' ',1) as UNSIGNED)) as average_duration
from titles
where duration REGEXP '^[0-9]+ min$';


-- Find records with NO director info
select count(*) as count
from titles
where director = "";


-- Records released in last 5 years
select*
from titles
where release_year>= Year(CURDATE())-5;


-- Records for India Country
select type, title
from titles
where country = 'India';


-- Find records which have seasons
select*
from titles
where duration LIKE '%seasons%';


-- Records which have more than 2 seasons
select*
from titles
where duration LIKE '%season%'
and CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(duration,' ',1), ' ',-1) as UNSIGNED)>2;