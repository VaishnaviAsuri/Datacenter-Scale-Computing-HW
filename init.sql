CREATE TABLE IF NOT EXISTS DimAnimal (
            animal_id VARCHAR PRIMARY KEY,
            animal_name VARCHAR,
            animal_type VARCHAR,
            breed VARCHAR,
            color VARCHAR
);

CREATE TABLE IF NOT EXISTS DimOutcome (
            outcome_type VARCHAR PRIMARY KEY,
            outcome_subtype VARCHAR
        );


CREATE TABLE IF NOT EXISTS DimDate (
    ts TIMESTAMP PRIMARY KEY,
    dob DATE,
    age VARCHAR
);

CREATE TABLE IF NOT EXISTS FactOutcomes (
            animal_id VARCHAR REFERENCES DimAnimal (animal_id),
            outcome_type VARCHAR REFERENCES DimOutcome (outcome_type),
            ts TIMESTAMP REFERENCES DimDate (ts),
            -- Add your measures here if applicable
        );

