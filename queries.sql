-- Question 1: How many animals of each type have outcomes?
SELECT animal_type, COUNT(DISTINCT animal_id) AS num_animals
FROM FactOutcomes
INNER JOIN DimAnimal ON FactOutcomes.animal_id = DimAnimal.animal_id
GROUP BY animal_type;

-- Question 2: How many animals are there with more than 1 outcome?
WITH AnimalOutcomeCounts AS (
    SELECT animal_id, COUNT(*) AS outcome_count
    FROM FactOutcomes
    GROUP BY animal_id
)
SELECT COUNT(*) AS num_animals
FROM AnimalOutcomeCounts
WHERE outcome_count > 1;

-- Question 3: What are the top 5 months for outcomes?
SELECT EXTRACT(MONTH FROM ts) AS month, COUNT(*) AS outcome_count
FROM FactOutcomes
GROUP BY EXTRACT(MONTH FROM ts)
ORDER BY outcome_count DESC
LIMIT 5;

-- Question 4: What is the total number percentage of kittens, adults, and seniors, whose outcome is "Adopted"?
WITH AgeCategories AS (
    SELECT
        CASE
            WHEN AGE <= 1 THEN 'Kitten'
            WHEN AGE > 10 THEN 'Senior'
            ELSE 'Adult'
        END AS age_category,
        outcome_type
    FROM FactOutcomes
    INNER JOIN DimDate ON FactOutcomes.ts = DimDate.ts
    WHERE animal_type = 'Cat'
)
SELECT age_category, outcome_type, COUNT(*) AS num_outcomes
FROM AgeCategories
WHERE outcome_type = 'Adopted'
GROUP BY age_category, outcome_type;

-- Question 5: Among all the cats who were "Adopted," what is the total number percentage of kittens, adults, and seniors?
WITH AgeCategories AS (
    SELECT
        CASE
            WHEN AGE <= 1 THEN 'Kitten'
            WHEN AGE > 10 THEN 'Senior'
            ELSE 'Adult'
        END AS age_category,
        outcome_type
    FROM FactOutcomes
    INNER JOIN DimDate ON FactOutcomes.ts = DimDate.ts
    WHERE animal_type = 'Cat'
)
SELECT age_category, outcome_type, COUNT(*) AS num_outcomes
FROM AgeCategories
WHERE outcome_type = 'Adopted'
GROUP BY age_category, outcome_type;

-- Question 6: For each date, what is the cumulative total of outcomes up to and including this date?
SELECT
    ts,
    SUM(COUNT(*)) OVER (ORDER BY ts) AS cumulative_outcomes
FROM FactOutcomes
GROUP BY ts
ORDER BY ts;
