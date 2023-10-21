CREATE TABLE outcomes(
    animal_id VARCHAR,
    animal_name VARCHAR,
    ts TIMESTAMP,
    dob DATE,
    outcome_type VARCHAR,
    outcome_subtype VARCHAR,
    animal_type VARCHAR,
    age VARCHAR,
    breed VARCHAR,
    color VARCHAR,
    month VARCHAR,
    year INT,
    sex VARCHAR
);

--Time Dimension Table (DimTime)

CREATE TABLE DimTime (
    TimeKey INT PRIMARY KEY,
    Timestamp TIMESTAMP,
    DateOfBirth DATE,
    Month VARCHAR,
    Year INT
);

--Animal Dimension Table (DimAnimal)

CREATE TABLE DimAnimal (
    AnimalKey INT PRIMARY KEY,
    AnimalID VARCHAR,
    AnimalName VARCHAR,
    AnimalType VARCHAR,
    Age VARCHAR,
    Breed VARCHAR,
    Color VARCHAR,
    Sex VARCHAR
);

--Outcome Type Dimension Table (DimOutcomeType):

CREATE TABLE DimOutcomeType (
    OutcomeTypeKey INT PRIMARY KEY,
    OutcomeType VARCHAR,
    OutcomeSubtype VARCHAR
);

--Fact Table (FactOutcomes)

CREATE TABLE FactOutcomes (
    FactKey INT PRIMARY KEY,
    TimeKey INT,
    AnimalKey INT,
    OutcomeTypeKey INT,
    
);


