# Walmart Sales Analysis – SQL Project

## 📌 Project Overview
This project analyzes a **Walmart retail sales dataset** using **MySQL Workbench**.  
The focus is on deriving business insights from transactional data, applying SQL for feature engineering, and answering business-related queries.

## 🛠️ Tools & Skills
- MySQL Workbench
- SQL Concepts: Joins, Subqueries, Aggregate Functions, CASE Statements, GROUP BY, HAVING, CTEs
- Data Cleaning & Feature Engineering

## 📂 Dataset
- Table: `sales`
- Key Attributes:  
  - Invoice ID, Branch, City, Customer Type, Gender  
  - Product Line, Unit Price, Quantity, VAT, Total, Date, Time  
  - Payment Method, Gross Income, Rating  

## 🔍 Feature Engineering
- Created new columns for **Time of Day (Morning, Afternoon, Evening)**.  
- Extracted **Day Name** and **Month Name** from transaction dates.  
- Enhanced dataset to enable time-based and seasonal analysis.  

## 🔍 Key Analysis Performed
### 🛒 Product Insights
- Identified most common **payment methods**.  
- Found the **best-selling product line**.  
- Calculated **revenue by month** and **largest COGS month**.  
- Compared product line performance against average sales.  

### 💰 Sales & Revenue Insights
- Total revenue by **branch** and **city**.  
- Product lines with **highest revenue & VAT contribution**.  
- Average product ratings per product line.  
- Sales distribution by **time of day** and **weekday**.  

### 👥 Customer Insights
- Revenue contribution by **customer type**.  
- Customer type with the **highest VAT paid**.  
- Gender distribution of customers per branch.  
- Weekdays & times with the **highest customer ratings**.  

## 📊 Key Findings
- **Electronic Accessories** generated the highest revenue.  
- **Branch C (in Naypyitaw)** recorded the highest overall sales.  
- Evening hours saw the most transactions.  
- **E-Wallet** was the most preferred payment method.  
- **Female customers** were more frequent shoppers across most branches.  

## 📎 Files
- `Walmart_project.sql` → Complete SQL queries (feature engineering + business questions).  
- `results/` → (Optional) screenshots of SQL outputs.  

---
