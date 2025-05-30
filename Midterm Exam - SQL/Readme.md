# MADT4001 SQL Midterm Portfolio

This project contains SQL query solutions for the midterm exam of the course **MADT4001 - Fundamentals of Data Analysis** at NIDA.

## 📘 Overview

The objective of this repository is to showcase the ability to write efficient SQL queries to solve real-world business problems based on a set of given datasets. It demonstrates concepts such as filtering, sorting, grouping, subqueries, and joins using MySQL.

The queries solve 13 problems ranging from simple `SELECT` statements to more complex aggregations and window functions using real business datasets related to:

- Financials
- Inventory
- Marketing
- Operating Expenses
- Procurement
- Sales
- Team Information

---

## 🗂️ File Structure

MADT4001-Introduction-to-Data-Analytics/Midterm Exam - SQL
├── Surapat_SQL_MIDTERM.sql
├── README.md

---

🛠️ How to Use

1. Prerequisites
MySQL Workbench or any MySQL-compatible client
Internet connection to access the provided database host

2. Database Connection
Please connect using the following credentials in MySQL Workbench or any other SQL client:

📝 Problem Summary

Each question is based on specific business requirements. Below are examples:

1. Financial Summary by Day

Show day, teamid, net_profit, sales, cash_on_hand from CT_financials, starting from day 1.📌 Expected: 240 rows

2. Retail Inventory Allocation

Show date, teamid, location, product, loctype, allocated from CT_inventory where loctype = 'RTL', ordered by date, teamid.📌 Expected: 85 rows

3. Marketing Spend Over 1,000 THB

Show day, teamid, product, media, marketing_amount from CT_marketing for media B or C with amount > 1000.📌 Expected: 322 rows

4. Max Overflow Expense

Show the highest Overflow from CT_operating_expense.📌 Expected: 1 row

5. Conditional Procurement Filter

Show purchases from CT_procurement meeting one of the following:

Buy Apple Juice from vendor 'VFG1' in exactly 30,000 units

Buy Orange Juice from 'VFG2' priced under 12 THB

Buy Melon Juice online with total over 20,000 THB in Bangkok📌 Expected: 4 rows

6. B2B Sales in Price Range

Show date, teamid, product, client, price, sales_amount from CT_sales where type is B2B and price between 20–30 THB.📌 Expected: 39 rows

7. Max Profit per Team

Show the maximum profit per team from CT_financials. Use GROUP BY.📌 Expected: 8 rows

8. Avg Retail Allocation > 30,000

Show average inventory from CT_inventory by province and product on retail shelves (loctype = 'RTL') with average > 30,000.📌 Expected: 3 rows

9. Total Expense per Team

Summarize team expenses from CT_operating_expense, grouped and ordered by teamid.📌 Expected: 8 rows

10. Marketing Without Same-Day Sales

Find teams that did marketing but had no sales on the same day using CT_marketing, CT_sales, and COM_team.📌 Expected: 5 rows

11. Product with Minimum Order Volume

Use nested subqueries to find the product with the fewest boxes ordered from CT_procurement.📌 Expected: 1 row

12. Sales-to-Cost Ratio

Calculate the ratio between total sales and total cost of goods from CT_sales. Use subqueries.📌 Expected: 1 row

13. Sales with Previous-Day Marketing

Show total daily sales and marketing spend from the previous day using LAG() or JOIN and subqueries.📌 Expected: 183 rows
