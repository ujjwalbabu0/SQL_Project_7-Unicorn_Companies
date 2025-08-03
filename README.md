# 🦄 SQL_Project_7--Unicorn_Companies  
**Author - Ujjwal Babu** 

![unicorn-companies2](https://github.com/user-attachments/assets/c81df2c7-8703-4146-8851-0d3a684befb3)
 
## Unicorn Companies Analytics
A data analytics project using SQL focused on analyzing unicorn startup companies. This project dives into investment patterns, valuation trends, time-to-unicorn metrics, and geographical/industrial distributions using cleaned data and advanced SQL techniques.

------------------------------------------------------------------------------------------------

## Project Overview  
- **Level:** Intermediate to Advanced  
- **Database:** `unicorn_info`  
- **Dataset:** `Unicorn_Companies.csv`  
- **Skills Covered:**  
  - SQL joins, CTEs, Window Functions  
  - Currency parsing and conversion  
  - Date formatting and breakdown  
  - Aggregation and filtering  
  - Recursive queries for investor expansion  
  - ROI and LTV computations  
  - Industry and country share breakdowns  

------------------------------------------------------------------------------------------------

## Objectives

### 1. **Database Setup & Cleaning**  
- Create `unicorn_info` database  
- Rename columns for SQL compatibility (`date joined`, `year founded`, etc.)  
- Convert date columns into standardized formats  
- Remove rows with missing/invalid funding data  
- Convert `valuation` and `funding` from string to numeric (handling `$M`, `$B`)

### 2. **Exploratory Data Analysis**  
- Total number of unicorn companies and countries  
- Top unicorns by **ROI** (valuation vs. funding)  
- Time taken (in years) to reach unicorn status  
- Distribution by industry and country  
- Share (%) of unicorns by region and vertical  

### 3. **Investor Analytics**  
- Find all unicorns backed by a specific investor (e.g., Sequoia)  
- Use recursive SQL to break out investor lists  
- Identify top investors by unique companies backed  

------------------------------------------------------------------------------------------------

## File Descriptions

- `Unicorn_Companies.csv` – Raw data of unicorn startups: valuations, industries, investors, locations, and founding/joining dates  
- `P8- unicorn_companies.sql` –  
  - Creates the database and imports data  
  - Performs cleaning, column renaming, and transformation  
  - Executes 20+ insightful analytical queries  
- `README.md` – This markdown documentation

------------------------------------------------------------------------------------------------

## Key Questions Answered

### General & Descriptive
- How many unicorn companies exist in the dataset?  
- Which countries and industries dominate the unicorn space?  
- What’s the average time (in years) to reach unicorn status?  

### Financial Metrics
- Which companies offer the best return on investment (ROI)?  
- What are the funding and valuation distributions?  
- Top 10 highest ROI startups  

### Investor Insights
- Which investors have backed the most unicorns?  
- How many companies has Sequoia backed?  
- Breakdown of investor-company relationships using recursive SQL  

------------------------------------------------------------------------------------------------

## Advanced Insights
- Industry & country share % of unicorn distribution  
- Recursive parsing of comma-separated investor lists  
- Time-to-unicorn heatmaps (via grouped data)  
- Outlier detection in ROI and funding  

------------------------------------------------------------------------------------------------

## Conclusion

This project showcases the power of SQL in analyzing startup ecosystem data. From investor mapping to ROI and regional dominance, the queries deliver a 360° view of the unicorn landscape. It demonstrates how structured querying and data transformation can support deeper insights into venture capital, entrepreneurship, and global tech trends.

------------------------------------------------------------------------------------------------

## 🔗 Repository  


https://github.com/ujjwalbabu0/SQL_Project_7-Unicorn_Companies.git
