-- ---------------------------------------------
-- Explore all tables in the database
SELECT * FROM INFORMATION_SCHEMA.TABLES;

-- Explore all columns in all tables
SELECT * FROM INFORMATION_SCHEMA.COLUMNS;

-- Explore all data in the lung_cancer_dataset table
SELECT * FROM lung_cancer_dataset;

-- ---------------------------------------------
-- Count total patients (Total Smokers)
SELECT
    COUNT(patient_id) AS total_smokers
FROM lung_cancer_dataset;

-- ---------------------------------------------
-- Count total smokers by gender with percentage
SELECT 
    GENDER AS gender,
    Total_Smokers AS total_smokers,
    CONCAT(ROUND(Total_Smokers * 100 / SUM(Total_Smokers) OVER(), 2), '%') AS percentage_of_total
FROM (
    SELECT
        gender AS GENDER,
        COUNT(patient_id) AS Total_Smokers
    FROM lung_cancer_dataset
    GROUP BY gender
) T
ORDER BY total_smokers DESC;

-- ---------------------------------------------
-- Count total smokers by age groups
SELECT
    age AS patient_age,
    CASE 
        WHEN age BETWEEN 18 AND 44 THEN '18-44 Young'
        WHEN age BETWEEN 45 AND 64 THEN '45-64 Middle'
        WHEN age BETWEEN 65 AND 100 THEN '65-100 Old'
    END AS age_group,
    COUNT(patient_id) AS total_smokers
FROM lung_cancer_dataset
GROUP BY age
ORDER BY patient_age;

-- ---------------------------------------------
-- Count total smokers by radon exposure and alcohol consumption
SELECT
    radon_exposure AS radon_exposure_status,
    alcohol_consumption AS alcohol_status,
    COUNT(patient_id) AS total_smokers
FROM lung_cancer_dataset
GROUP BY radon_exposure, alcohol_consumption
ORDER BY radon_exposure_status, alcohol_status;

-- ---------------------------------------------
-- Count total smokers and total lung cancer cases by gender and age group
SELECT 
    GENDER AS gender,
    CASE 
        WHEN age BETWEEN 18 AND 44 THEN '18-44 Young'
        WHEN age BETWEEN 45 AND 64 THEN '45-64 Middle'
        WHEN age BETWEEN 65 AND 100 THEN '65-100 Old'
    END AS age_group,
    COUNT(patient_id) AS total_smokers,
    SUM(CAST(lung_cancer AS int)) AS total_lung_cancer_cases
FROM lung_cancer_dataset
GROUP BY 
    GENDER,
    CASE 
        WHEN age BETWEEN 18 AND 44 THEN '18-44 Young'
        WHEN age BETWEEN 45 AND 64 THEN '45-64 Middle'
        WHEN age BETWEEN 65 AND 100 THEN '65-100 Old'
    END
ORDER BY gender, age_group;

-- Optional: you can also sum other risk factors like COPD, family history, secondhand smoke
-- SUM(copd_diagnosis), SUM(family_history), SUM(secondhand_smoke_exposure)

-- ---------------------------------------------
-- Calculate percentage of patients exposed to risk factors by gender and age group
SELECT
    GENDER AS gender,
    CASE 
        WHEN age BETWEEN 18 AND 44 THEN '18-44 Young'
        WHEN age BETWEEN 45 AND 64 THEN '45-64 Middle'
        WHEN age BETWEEN 65 AND 100 THEN '65-100 Old'
    END AS age_group,
    CONCAT(ROUND(SUM(CAST(asbestos_exposure AS int)) * 100 / COUNT(patient_id), 2), '%') AS asbestos_exposure_pct,
    CONCAT(ROUND(SUM(CAST(family_history AS int)) * 100 / COUNT(patient_id), 2), '%') AS family_history_pct,
    CONCAT(ROUND(SUM(CAST(secondhand_smoke_exposure AS int)) * 100 / COUNT(patient_id), 2), '%') AS secondhand_smoke_pct,
    CONCAT(ROUND(SUM(CAST(copd_diagnosis AS int)) * 100 / COUNT(patient_id), 2), '%') AS copd_pct,
    CONCAT(ROUND(SUM(CAST(lung_cancer AS int)) * 100 / COUNT(patient_id), 2), '%') AS lung_cancer_pct
FROM lung_cancer_dataset
GROUP BY 
    GENDER,
    CASE 
        WHEN age BETWEEN 18 AND 44 THEN '18-44 Young'
        WHEN age BETWEEN 45 AND 64 THEN '45-64 Middle'
        WHEN age BETWEEN 65 AND 100 THEN '65-100 Old'
    END
ORDER BY age_group, gender;

-- ---------------------------------------------
-- Count patients by gender who do NOT consume alcohol and calculate percentage
SELECT
    gender AS gender,
    COUNT(CASE WHEN alcohol_consumption = 'None' THEN 1 END) AS no_alcohol_count,
    ROUND(COUNT(CASE WHEN alcohol_consumption = 'None' THEN 1 END) * 100.0 / COUNT(patient_id), 0) AS no_alcohol_pct
FROM lung_cancer_dataset
GROUP BY gender;
