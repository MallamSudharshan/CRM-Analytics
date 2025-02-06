create database CRM_project;
use CRM_Project;
-- Opportunity
select * from oppertunity_table;
-- 1.Expected amount
SELECT sum(Expected_amount) as Total_Expected_Amount from oppertunity_table;

-- 2.Open active opportunities
select count(`has open activity`) as Total_Open_Activity  from oppertunity_table where `has open activity`= "True";
select count(opportunity_id) from oppertunity_table;
select concat(round(((select count(`has open activity`) as Total_Open_Activity  from oppertunity_table where `has open activity`= "True")
 / count(opportunity_id))*100,2),"%") from oppertunity_table;
 
-- 3.conversion Rate
SELECT concat(round(((SELECT COUNT(stage) FROM oppertunity_table 
WHERE stage = 'closed won') / COUNT(opportunity_id))*100,2),"%") AS Conversion_rate
FROM oppertunity_table;

-- 4.won Rate
SELECT concat(round(((SELECT COUNT(stage) FROM oppertunity_table 
WHERE stage = 'closed won') / COUNT(opportunity_id))*100,2),"%") AS won_rate
FROM oppertunity_table;

-- 5.Loss Rate
SELECT concat(round(((SELECT COUNT(stage) FROM oppertunity_table 
WHERE stage = 'closed lost') / COUNT(opportunity_id))*100,2),"%") AS Loss_rate
FROM oppertunity_table;

-- 6.expected vs forecast
select * from oppertunity_table;
select 'created date',sum(expected_amount) as expected_amount,sum(amount) as forecast from oppertunity_table order by 'created date';
SELECT 
   `created date` ,
    SUM(expected_amount) OVER (ORDER BY `created date`) AS running_expected_revenue,
    SUM(CASE WHEN `Forecast Q Commit` = 'true' THEN amount ELSE 0 END) 
        OVER (ORDER BY `created date`) AS running_forecast_commit,
    (SUM(expected_amount) OVER (ORDER BY `created date`) - 
     SUM(CASE WHEN `Forecast Q Commit` = 'true' THEN amount ELSE 0 END) 
        OVER (ORDER BY `created date`)) AS difference
FROM 
    oppertunity_table
ORDER BY 
    `created date`;
    
-- 7.Active vs total opportunities
select (select count(`has open activity`) as Total_Open_Activity  from oppertunity_table where `has open activity`= "True") as Active_Opportunities,
count(opportunity_id) as Total_opportunities from oppertunity_table;

-- 8.closed won vs total opportunities
select(select count(stage) from oppertunity_table where stage = "closed won") as Closed_Won_Opportunities,
count(opportunity_id) as Total_Opportunities from oppertunity_table;

-- 9.Closed won vs Total Closed
select(select count(stage) from oppertunity_table where stage = "closed won") as Closed_Won_Opportunities,
count(closed) as Closed_Opportunities from oppertunity_table where closed = "true";

-- 10.Expected amount by Opportunity type
select opportunity_type,sum(expected_amount) from oppertunity_table group by opportunity_type order by opportunity_type;

-- 11.opportunities by industry
select industry,count(opportunity_id) as oppertunities from oppertunity_table group by industry order by oppertunities desc;

