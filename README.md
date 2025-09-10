# 🌬️ **Lung Cancer Data Analysis using SQL** 🩺

## 📖 **Project Overview**
This project analyzes a **lung cancer dataset** using SQL. It explores patient demographics, age groups, gender, lifestyle habits, environmental exposures, and medical conditions. The goal is to **identify risk factors**, calculate totals & percentages, and provide **dashboard-ready insights**. 📊

---

## 🗂️ **Dataset Description**
The dataset contains information about patients to study lung cancer risk factors, including:

- **🆔 patient_id**: Unique identifier  
- **🎂 age**: Patient's age  
- **🚻 gender**: Male or Female  
- **☢️ radon_exposure**: Exposure to radon gas (Yes/No)  
- **🏭 asbestos_exposure**: Exposure to asbestos (0/1)  
- **🚬 secondhand_smoke_exposure**: Exposure to secondhand smoke (0/1)  
- **🫁 copd_diagnosis**: COPD diagnosis (0/1)  
- **🍷 alcohol_consumption**: Alcohol consumption level  
- **👪 family_history**: Family history of lung cancer (0/1)  
- **🫀 lung_cancer**: Lung cancer diagnosis (0/1)

---

## 🌐 **Data Source**
The dataset used in this project was obtained from **[https://www.kaggle.com/datasets/mikeytracegod/lung-cancer-risk-dataset**] 📥.

---

## 💡 **Key SQL Analyses**

1. **🔍 Data Exploration**: View tables, columns, and records  
2. **📊 Aggregated Metrics**: Count patients, smokers by gender/age, total lung cancer cases  
3. **⚠️ Risk Factor Analysis**: Percentages of exposure to asbestos, secondhand smoke, COPD, family history, alcohol trends  
4. **🚀 Advanced SQL Techniques**: Dynamic percentages, age group categorization, dashboard-ready insights  

---
## 📝 **Example Queries**

```sql
-- Total patients
SELECT COUNT(patient_id) AS total_patients
FROM lung_cancer_dataset;

-- Smokers by gender with percentage
SELECT 
    gender,
    COUNT(patient_id) AS total_smokers,
    CONCAT(ROUND(COUNT(patient_id) * 100 / SUM(COUNT(patient_id)) OVER(), 2), '%') AS percentage_of_total
FROM lung_cancer_dataset
GROUP BY gender;

-- Percentage of patients exposed to asbestos by age group
SELECT
    CASE 
        WHEN age BETWEEN 18 AND 44 THEN '18-44 Young'
        WHEN age BETWEEN 45 AND 64 THEN '45-64 Middle'
        WHEN age BETWEEN 65 AND 100 THEN '65-100 Old'
    END AS age_group,
    CONCAT(ROUND(SUM(CAST(asbestos_exposure AS int)) * 100 / COUNT(patient_id), 2), '%') AS asbestos_percentage
FROM lung_cancer_dataset
GROUP BY age_group;
.
-----
## 🌟 Insights

- **Identify high-risk groups** by age and gender
- **Explore correlations** between lifestyle habits and lung cancer
- **Provide data** for dashboards & visualizations
- Useful for **healthcare analytics, research, and education**

## 📝 License

This project is open-source under the MIT License 💻


