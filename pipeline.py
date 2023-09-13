#!/usr/bin/env python
# coding: utf-8




import pip


#pip install pandas



import pandas as pd
from argparse import ArgumentParser


parser = ArgumentParser()
parser.add_argument('source',help='source.csv')
parser.add_argument('target', help='target.csv')
args = parser.parse_args()

my_data = pd.read_csv(args.source)

#find missing values
my_missing=my_data.isna().sum()
my_missing #gives 283 missing values in 'name' column, 78 in 'sex' and 1 in 'age'



#finding duplicate values
my_duplicates=my_data.duplicated().sum()
my_duplicates #gives zero duplicates




#delete rows corresponding to missing values
my_data=my_data.dropna()
my_data





#find missing values again
my_missing1=my_data.isna().sum()
my_missing1 #gives 0 values 





#drop 'dob' and 'ts' columns because they are unnecessary for me
my_data=my_data.drop(['dob','ts'], axis=1)
my_data





#splitting 'month_year' column into month and year 
my_data[['birth_month','birth_year']] = my_data.month_year.str.split(expand=True)

#dropping 'month_year' column
my_data=my_data.drop('month_year', axis=1)
my_data





#saving and exporting dataframe to csv 
my_data.to_csv(args.target, index=False)

