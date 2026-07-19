CREATE DATABASE HR;
RENAME TABLE `hr_attrition_raw (1)` TO HR_Attr;
ALTER TABLE HR_Attr
RENAME COLUMN ï»¿Age TO Age;
-- Creating view
CREATE OR REPLACE VIEW employee_profile AS
SELECT
    EmployeeNumber,
    Attrition,
    Department,
    JobRole,
    Gender,
    Age,
    MonthlyIncome,
    OverTime,
    BusinessTravel,
    DistanceFromHome,
    YearsAtCompany,
    MaritalStatus,
    WorkLifeBalance,
    RelationshipSatisfaction,
    CASE
        WHEN Age < 25 THEN '<25'
        WHEN Age < 35 THEN '25-34'
        WHEN Age < 45 THEN '35-44'
        WHEN Age < 55 THEN '45-54'
        ELSE '55+'
    END AS Age_Band,
    CASE
        WHEN MonthlyIncome < 5000 THEN '<5000'
        WHEN MonthlyIncome < 10000 THEN '5000-9999'
        WHEN MonthlyIncome < 15000 THEN '10000-14999'
        ELSE '15000+'
    END AS Salary_Slab,
    CASE
        WHEN YearsAtCompany < 10 THEN '<10'
        WHEN YearsAtCompany < 20 THEN '10-19'
        ELSE '20+'
    END AS Years_Band,
    CASE 
		WHEN DistanceFromHome < 10 THEN "<10"
		WHEN DistanceFromHome BETWEEN 10 AND 20 THEN '10-20'
		ELSE '20-30'
	 END AS Distance_Band,
CASE
		WHEN YearsAtCompany < 10 THEN "<10"
		WHEN YearsAtCompany BETWEEN 10 AND 20 THEN '10-20'
		ELSE '30+'
	END AS YAC_band
FROM hr_attr;
SELECT * FROM employee_profile;
-- Total Number of Employees
SELECT COUNT(EmployeeNumber) AS EmpCount
FROM hr.employee_profile;
-- Overall Attrition Rate
SELECT CONCAT(ROUND(SUM(Attrition='Yes')/COUNT(EmployeeNumber)*100, 1),'%') AS Attrition_rate
FROM employee_profile;
-- Departmen wise Attrition
SELECT Department,SUM(Attrition='Yes') as Attr_cnt,COUNT(EmployeeNumber) as tot_emp, 
CONCAT(ROUND(SUM(Attrition='Yes')/COUNT(EmployeeNumber)*100, 1),'%') AS Attrition_rate
FROM employee_profile
GROUP BY Department;
-- Attrition by Job Role
SELECT JobRole,SUM(Attrition='Yes') as Attr_cnt,COUNT(EmployeeNumber) as tot_emp, 
CONCAT(ROUND(SUM(Attrition='Yes')/COUNT(EmployeeNumber)*100, 1),'%') AS Attrition_rate
FROM employee_profile
GROUP BY JobRole;
-- Attrition by Gender
SELECT Gender,SUM(Attrition='Yes') as Attr_cnt,COUNT(EmployeeNumber) as tot_emp, 
CONCAT(ROUND(SUM(Attrition='Yes')/COUNT(EmployeeNumber)*100, 1), '%') AS Attrition_rate
FROM employee_profile
GROUP BY Gender;
-- Age Group wise Attrition
SELECT Age_band, SUM(Attrition = 'Yes') AS Attr_cnt, COUNT(EmployeeNumber) AS total_cnt,
CONCAT(ROUND(SUM(Attrition = 'Yes')/COUNT(EmployeeNumber)*100,1), '%') AS Attr_Rate
FROM employee_profile 
GROUP BY Age_band;
-- Attrition by Overtime
SELECT OverTime,SUM(Attrition='Yes') as Attr_cnt,COUNT(EmployeeNumber) as tot_emp, 
CONCAT(ROUND(SUM(Attrition='Yes')/COUNT(EmployeeNumber)*100, 1), '%') AS Attrition_rate
FROM employee_profile
GROUP BY OverTime;
-- Attrition by travel frequency
SELECT BusinessTravel,SUM(Attrition='Yes') as Attr_cnt,COUNT(EmployeeNumber) as tot_emp, 
CONCAT(ROUND(SUM(Attrition='Yes')/COUNT(EmployeeNumber)*100, 1), '%') AS Attrition_rate
FROM employee_profile
GROUP BY BusinessTravel;
-- Attrition by distance 
SELECT Distance_band, SUM(Attrition = 'Yes') AS Attr_cnt, COUNT(EmployeeNumber) AS total_cnt,
CONCAT(ROUND(SUM(Attrition = 'Yes')/COUNT(EmployeeNumber)*100,1), '%') AS Attr_Rate
FROM employee_profile 
GROUP BY Distance_band
ORDER BY Distance_band;
-- Attrition by years at company
SELECT YAC_band, SUM(Attrition = 'Yes') AS Attr_cnt, COUNT(EmployeeNumber) AS total_cnt,
CONCAT(ROUND(SUM(Attrition = 'Yes')/COUNT(EmployeeNumber)*100,1), '%') AS Attr_Rate
FROM employee_profile
GROUP BY YAC_band
ORDER BY YAC_band;
-- Attrition by Marital status
SELECT MaritalStatus,SUM(Attrition='Yes') as Attr_cnt,COUNT(EmployeeNumber) as tot_emp, 
CONCAT(ROUND(SUM(Attrition='Yes')/COUNT(EmployeeNumber)*100, 1), '%') AS Attrition_rate
FROM employee_profile
GROUP BY MaritalStatus;
-- Attrition by work life balance
SELECT WorkLifeBalance,SUM(Attrition='Yes') as Attr_cnt,COUNT(EmployeeNumber) as tot_emp, 
CONCAT(SUM(Attrition='Yes')/COUNT(EmployeeNumber)*100, '%') AS Attrition_rate
FROM employee_profile
GROUP BY WorkLifeBalance;
-- Attrition by Realationship satisfaction
SELECT RelationshipSatisfaction,SUM(Attrition='Yes') as Attr_cnt,COUNT(EmployeeNumber) as tot_emp, 
CONCAT(SUM(Attrition='Yes')/COUNT(EmployeeNumber)*100, '%') AS Attrition_rate
FROM employee_profile
GROUP BY RelationshipSatisfaction;
-- Attrition by Salary
SELECT Salary_slab, SUM(Attrition = 'Yes') AS Attr_cnt, COUNT(EmployeeNumber) AS total_cnt,
CONCAT(ROUND(SUM(Attrition = 'Yes')/COUNT(EmployeeNumber)*100,1), '%') AS Attr_Rate
FROM employee_profile
GROUP BY Salary_slab
ORDER BY 
	CASE
            WHEN Salary_slab = '<5000' THEN 1
            WHEN Salary_slab = '5000-9999' THEN 2
            WHEN Salary_slab = '10000-14999' THEN 3
            WHEN Salary_slab = '15000+' THEN 4
         END;
-- Multi Factor Analysis         
SELECT COUNT(EmployeeNumber), sum(Attrition = 'Yes'), CONCAT(ROUND(sum(Attrition = 'Yes')/COUNT(EmployeeNumber)*100,1), '%') AS Attrition_Rate
FROM employee_profile
WHERE MonthlyIncome < 5000 AND
OverTime = 'Yes' AND
Age < 25 AND
Department = 'Sales';


SELECT
    Department,
    Salary_Slab,
    OverTime,
    Age_band,
    COUNT(*) AS Total_Employees,
    SUM(Attrition = 'Yes') AS Attrition_Count,
    ROUND(SUM(Attrition = 'Yes') * 100.0 / COUNT(*), 1) AS Attrition_Rate
FROM employee_profile
GROUP BY Department, Salary_Slab, OverTime, Age_band
HAVING COUNT(*) >= 10
ORDER BY Attrition_Rate DESC;