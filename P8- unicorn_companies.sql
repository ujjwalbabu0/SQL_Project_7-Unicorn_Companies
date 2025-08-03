-- -----------------------------------------------
-- ## Database creation
-- -----------------------------------------------
-- Database setup
create database unicorn_info;

-- Table import
-- -----------------------------------------------
-- ## Data cleaning
-- check duplicate company name
select	company
from unicorn_companies
group by company
having count(company) > 1; -- Bolt and Fabric appear twice in both data sets.

select
	*
from unicorn_companies
where company in ('fabric', 'bolt');  -- They are in different cities / countries. Therefore, we will keep those data.

-- change column names
alter table unicorn_companies rename column `date joined` to date_joined;
alter table unicorn_companies rename column `year founded` to year_founded;
alter table unicorn_companies rename column `select investors` to select_investors;

-- Standardize date joined format & break out date joined into individual columns (Year, Month, Day)
alter table unicorn_companies add date_joined_converted date;
UPDATE unicorn_companies SET date_joined_converted = CAST(date_joined AS DATE);

alter table unicorn_companies add `year` int;
update unicorn_companies set year = year(date_joined_converted);

alter table unicorn_companies add `month` int;
update unicorn_companies set month = month(date_joined_converted);

alter table unicorn_companies add `date` int;
update unicorn_companies set date = day(date_joined_converted);

-- Drop rows where funding column contain 0 or unknown
select *
from unicorn_companies
where funding in ('$0B', '$0M', 'unknown');

delete from unicorn_companies
where funding in ('$0B', '$0M', 'unknown');

-- Reformat currency values
update unicorn_companies set valuation = replace(valuation,"$","");
update unicorn_companies set funding = replace(funding,"$","");

UPDATE unicorn_companies
SET valuation = 
  CASE
    WHEN RIGHT(valuation, 1) = 'B'
      THEN CAST(LEFT(valuation, CHAR_LENGTH(valuation) - 1) AS DECIMAL(15,2)) * 1000000000
    WHEN RIGHT(valuation, 1) = 'M'
      THEN CAST(LEFT(valuation, CHAR_LENGTH(valuation) - 1) AS DECIMAL(15,2)) * 1000000
    ELSE CAST(valuation AS DECIMAL(15,2))
  END;
  
UPDATE unicorn_companies
SET funding = 
  CASE
    WHEN RIGHT(funding, 1) = 'B'
      THEN CAST(LEFT(funding, CHAR_LENGTH(valuation) - 1) AS DECIMAL(15,2)) * 1000000000
    WHEN RIGHT(funding, 1) = 'M'
      THEN CAST(LEFT(funding, CHAR_LENGTH(funding) - 1) AS DECIMAL(15,2)) * 1000000
    ELSE CAST(funding AS DECIMAL(15,2)) END;
    
-- Delete unwanted columns
alter table unicorn_companies drop column date_joined;
ALTER TABLE unicorn_companies RENAME COLUMN date_joined_converted TO date_joined;


-- -----------------------------------------------
-- ## Data Exploration for Unicorn Companies Analytics
-- -----------------------------------------------

-- #Research questions
-- total unicorn companies
select count(distinct company) as ttl_companies_cnt from unicorn_companies;

-- total countries
select count(distinct country) as total_country_cnt from unicorn_companies;

-- Which unicorn companies have had the biggest return on investment?
select
	company, city, country,
    round(valuation/funding,2) as ROI
from unicorn_companies
order by ROI desc
limit 10;

-- How long does it usually take for a company to become a unicorn?
create table year_to_unicorn as (
select
	company,
    round(year(date_joined)-year_founded,0) as years_to_unicorn
from unicorn_companies);

select round(avg(years_to_unicorn),0) from year_to_unicorn; -- average years to become unicorn

select
	years_to_unicorn,
    count(*) as frequency
from year_to_unicorn
group by years_to_unicorn
order by frequency desc, years_to_unicorn; -- Mostly take from 4 to 7 years to become a unicorn

-- Details on how long it takes for the companies to become a unicorn


-- Which industries have the most unicorns? 
select
	industry,
    count(*) as ttl_unicorn_com_cnt
from unicorn_companies
group by industry
order by ttl_unicorn_com_cnt desc
limit 5;

-- Number of unicorn companies within each industry and their shares
select
	industry,
    count(*) as unicorn_com_cnt,
    round(count(*) * 100 / (select count(*) from unicorn_companies),2) as share_perc
from unicorn_companies
group by industry
order by share_perc desc;

-- Which countries have the most unicorns?
select
	country,
    count(*) as ttl_unicorn_com_cnt
from unicorn_companies
group by country
order by ttl_unicorn_com_cnt desc
limit 5;

-- Number of unicorn companies within each country and their shares
select
	country,
    count(*) as unicorn_com_cnt,
    round(count(*) * 100 / (select count(*) from unicorn_companies),2) as share_perc
from unicorn_companies
group by country
order by share_perc desc;

-- Find All Unicorns Backed by a Specific Investor (e.g., Sequoia)
SELECT Company, Select_Investors
FROM Unicorn_Companies
WHERE Select_Investors LIKE '%Sequoia%';


WITH RECURSIVE investor_expansion AS (
    SELECT
        company,
        TRIM(SUBSTRING_INDEX(select_investors, ',', 1)) AS investor,
        SUBSTRING(select_investors, LENGTH(SUBSTRING_INDEX(select_investors, ',', 1)) + 2) AS remaining
    FROM
        unicorn_companies

    UNION ALL

    SELECT
        company,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS investor,
        SUBSTRING(remaining, LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2)
    FROM
        investor_expansion
    WHERE
        remaining != ''
)
SELECT investor, COUNT(DISTINCT company) AS companies_invested
FROM investor_expansion
GROUP BY investor
ORDER BY companies_invested DESC
LIMIT 1;
