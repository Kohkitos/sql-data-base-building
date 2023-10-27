# Import libraries

import pandas as pd
pd.set_option('display.max_columns', None)

import numpy as np

import mysql.connector
from sqlalchemy import create_engine

import warnings
warnings.filterwarnings('ignore')

import sys
sys.path.insert(1, 'notebooks/')

from passwords import CURSOR
from passwords import ENGINE


# SQL functions
def add_table(table):
    '''
    This function adds a dataframe to the database the cursor is pointing as a table, setting the {name}_id as the primary key.
    
    Argument:
        table(pd.DataFrame): a dataframe with a {name}_id which will be the primary key.

    Returns:
        0: No errors during execution.
        1: There is not a .csv with the table name.
        2: there is not a {name}_id column in the dataframe.
    '''
    
    try:
        df = pd.read_csv(f'../data/{table}.csv')

    except:
        print(f"Error: couldn't find {table}.csv in ../data/")
        return (1)
    
    if f'{table}_id' not in df.columns:
        print(f"Error: {table}_id not in dataframe")
        return (2)

    df.to_sql(name=f'{table}',
            con=CURSOR,
            if_exists='append',
            index=False
           )

    with CURSOR.connect() as con:
        con.execute(f'ALTER TABLE `{table}` ADD PRIMARY KEY (`{table}_id`);')

    print("Table created succesfully")
    print('-'*15)
    return (0)
