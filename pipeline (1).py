#!/usr/bin/env python
# coding: utf-8

# In[21]:


import pandas as pd

df = pd.read_csv('https://s3.amazonaws.com/shelterdata/shelter1000.csv')
df.head()


# In[22]:


df[['month', 'year']] = df.MonthYear.str.split(' ', expand=True)


# In[23]:


df.head()


# In[24]:


import numpy as np
df['sex'] = df['Sex upon Outcome'].replace('Unknown', np.nan)
df.head()


# In[25]:


df.drop(columns = ['MonthYear', 'Sex upon Outcome'], inplace=True)


# In[26]:


df.to_csv('processed_data.csv')


# In[27]:


column_names = df.columns.tolist()
print(column_names)


# In[28]:


# Rename the columns in the DataFrame
df.rename(columns={
    'Animal ID': 'animal_id',
    'Name': 'animal_name',
    'DateTime': 'ts',
    'Date of Birth': 'dob',
    'Outcome Type': 'outcome_type',
    'Outcome Subtype': 'outcome_subtype',
    'Animal Type': 'animal_type',
    'Age upon Outcome': 'age',
    'Breed': 'breed',
    'Color': 'color'
}, inplace=True)

# Print the updated column names
print(df.columns.tolist())


# In[29]:


# Sort the DataFrame by the 'ts' column in ascending order
sorted_df = df.sort_values(by='ts')


# In[30]:


# Group the data by 'outcome_type' and calculate the count of each outcome type
outcome_counts = df.groupby('outcome_type')['animal_id'].count()


# In[31]:


# Drop rows with missing values
df.dropna(inplace=True)

# Fill missing values in 'outcome_subtype' with 'Unknown'
df['outcome_subtype'].fillna('no_record', inplace=True)


# In[32]:


# Convert the 'breed' column to lowercase
df['breed'] = df['breed'].str.lower()


# In[ ]:





# In[33]:


# Check for duplicate rows
duplicates = df[df.duplicated()]

# Display duplicate rows
print(duplicates)


# In[34]:


# Function to load data into the dimension tables
from sqlalchemy import create_engine
def load_data_into_dimensions(dataframe, database_url):
    engine = create_engine(database_url)

    # Load data into DimAnimal
    dataframe[['animal_id', 'animal_name', 'animal_type', 'breed', 'color']].to_sql('DimAnimal', engine, if_exists='append', index=False)

    # Load data into DimOutcome
    dataframe[['outcome_type', 'outcome_subtype']].to_sql('DimOutcome', engine, if_exists='append', index=False)

    # Load data into DimDate
    dataframe[['ts', 'dob', 'age']].to_sql('DimDate', engine, if_exists='append', index=False)

# Function to load data into the fact table
def load_data_into_fact(dataframe, database_url):
    engine = create_engine(database_url)

    dataframe[['animal_id', 'outcome_type', 'ts']].to_sql('FactOutcomes', engine, if_exists='append', index=False)

# Usage
if __name__ == '__main__':
    db_url = "postgresql+psycopg2://vaishu:password@db:5432/shelter"
    input_data = 'https://s3.amazonaws.com/shelterdata/shelter1000.csv'

    # Load data into dimension tables
    data = pd.read_csv(input_data)
    load_data_into_dimensions(data, db_url)

    # Load data into the fact table
    load_data_into_fact(data, db_url)

