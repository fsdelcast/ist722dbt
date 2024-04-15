# Project Document

## Project Charter and team members

For our business case study, we will use the company FudgeCompanies which is the consolidation of 2 companies named FudgeMart and FudgeFlix. 

FudgeMart is a fictional brick-and-mortar company. The database is used to track sales orders, customers, and products.

FudgeFlix is a company based on the Netflix DVD-by-mail rental service. The database is used to track customers, movies, movie rentals, and billing.


### Team Members

Our team is conformed by the following professionals:
- Francisco del Castillo
- Divyanshu Srivastava
- Bhavika Mauli Karale
- Mrunal Ashok Nikam

## Project Plan

## Functional requirements
After much collaboration data profiling, we have established the following 4 functional business requirements:

1. FudgeMart Sales Order:
   
Senior management would like to be able to track sales by customer, product, department, and supplier, with the goal of establishing which products are the top sellers, which department has the most sales, and who are the best suppliers. 

2. FudgeFlix Revenue:

Senior management would like to be able to track income by account, plan, city, and state, with the goal of establishing which plans are the top sellers, which cities and states have the most revenue 

3. FudgeMart Order Delivery:

There is a need to analyze the order fulfillment process to see if the time between when the order is placed and when it is shipped can be improved. Senior Management wants to analyze by shipper.

4. FudgeFlix Reviews:
   
Management wants to create an analysis of ratings by account, state, city, movie title, release year, Blu-ray available, and title rating.

## Business Processes

We will model the following business processes 
1. FudgeMart Sales Order:

FudgeMart sells products to customers, these products have a department which is the combination of similar products, and each product also has a provider or vendor. Finally, one sale will be represented as one order and each order can have several lines or products with their respective quantity. 

2. FudgeFlix Revenue:

In this process we have accounts that are subscribed to different types of plans so they can get their movies, each plan has a different tier price and on the first day of each month, the company bills the accounts for the amount of their respective plan. 

# High-level dimensional modeling
## Bus matrix

The bus matrix for the project is in the following Excel file in the "bus matrix" tab.

[Bus Matrix](Dimensional-Modeling-Workbook.xlsx)

## Issues, questions or doubts

We encountered the following issues:
- How to combine the 2 databases into 1?
- What happens if the information is not the same?

Thankfully, with research, we could find the correct approach. 

# Detail-level dimensional modeling
## detail-level modeling
The detail-level modeling for the project is in the following Excel file under each dimension or fact tab. 

[Detail-level Modeling](Dimensional-Modeling-Workbook.xlsx)

Furthermore, this is the star schema of the detailed modeling. 

![Detail-modeling](./Detail_data_modeling-2024-04-06_16-21.png)


## Naming conventions and project standards

Our naming conventions are the following:
- Name the dimension tables in plural and our fact table in singular.
- Use snake_case project-wise.


# Initial loads Data Pipeline (ETL/ELT)
## Source code for the initial load

## Source code for data pipeline

## Documentation for data pipelines
## Other documentatiion
Data quality, master data or survivorship rules

# Business Intelligence
## BI Documentation
Briefly explain the goal of your analytics and what type of BI it is.
## Application
Link of PowerBI dasboard
