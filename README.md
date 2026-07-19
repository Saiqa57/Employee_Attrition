# HR Employee Attrition Analysis

## Overview

This project analyzes the IBM HR Analytics dataset using SQL and Power BI to identify the key factors associated with employee attrition and determine high-risk employee segments.

**Dataset:** https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset

---

## Problem Statement

Employee attrition increases recruitment costs, reduces productivity, and leads to the loss of experienced employees. The objective of this project is to identify the major factors influencing attrition and the employee groups with the highest risk of leaving.

---

## Approach

- Imported and cleaned the dataset using SQL.
- Created derived fields including **Age Band**, **Salary Slab**, **Distance Band**, and **Years at Company Band**.
- Built a reusable SQL view (`employee_profile`) for reporting.
- Performed **single-factor analysis** to measure attrition across department, job role, salary, age, overtime, travel, work-life balance, relationship satisfaction, and tenure.
- Selected the four most influential factors (**Department, Salary, Age, and Overtime**) that together accounted for **70%+ of the observed attrition**.
- Performed **multi-factor analysis** by combining these factors to identify high-risk employee segments.
- Built an interactive Power BI dashboard to visualize the results.

---

## Key Insights

- Overall employee attrition is approximately **16%**.
- Sales Representatives and Laboratory Technicians have the highest attrition among job roles.
- Employees under **25 years** and those with **0–3 years** at the company are more likely to leave.
- Lower salary, overtime, business travel, and longer commuting distance are associated with higher attrition.
- Poor work-life balance and low relationship satisfaction are linked to increased employee turnover.
- Multi-factor analysis identified **young Sales employees earning less than ₹5,000 and working overtime** as the highest-risk segment, with an attrition rate of **72.7%**.

---

## Tools Used

- SQL
- Power BI
- MS Word

---

## Repository Structure

```text
├── Dataset/
├── SQL/
├── Power BI Dashboard/
├── Report/
└── README.md
```
