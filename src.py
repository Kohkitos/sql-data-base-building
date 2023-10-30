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
def add_table(name):
    
    '''
    This function adds a dataframe to the database the variable `CURSOR` is pointing as a table, setting the {name}_id as the primary key.
    
    Args:
        table(pd.DataFrame): a dataframe with a {name}_id which will be the primary key.

    Returns:
        0: No errors during execution.
        1: There is not a .csv with the name `name`.
        2: there is not a {name}_id column in the dataframe.
        3: unexpected error.
    '''
    try:
        try:
            df = pd.read_csv(f'../data/{name}.csv')

        except:
            print(f"Error: couldn't find {name}.csv in ../data/")
            return (1)

        if f'{name}_id' not in df.columns:
            print(f"Error: {name}_id not in dataframe")
            return (2)

        # Downcasting so that we have smallint and floats instead of bigint and doubles

        for c in df.select_dtypes(include='float'):
            df[c] = pd.to_numeric(df[c], downcast='float')

        for c in df.select_dtypes('integer'):
            df[c] = pd.to_numeric(df[c], downcast='integer')

        df.to_sql(name=f'{name}',
                con=CURSOR,
                if_exists='append',
                index=False
               )

        with CURSOR.connect() as con:
            con.execute(f'ALTER TABLE `{name}` ADD PRIMARY KEY (`{name}_id`);')

        print("Table created succesfully")
        print('-'*15)
        return (0)
    
    except:
        print ('Unexpected error. Use help(add_table) for usage.')
        return (3)


# Formatting functions
def format_phone_number(phone):
    
    '''
    Returns the phone number introduced to the standar Spanish format "+34 XXX XXX XXX".
    
    Args:
        phone: a string of a phone number with or without '+' and with or without 34 at the beggining (it will be added if it doesn't have it).
        
    Returns:
        formatted_phone: a string with the formatted phone like this "+34 XXX XXX XXX"
        1: string too short.
        2: unexpected error:
    '''
    try:

        phone = ''.join(filter(str.isdigit, phone))

        if not phone.startswith('34'):
            phone = '34' + phone

        if len(phone) < 11:
            print ('Phone number too short')
            return (1)


        formatted_phone = f'+34 {phone[3:6]} {phone[6:9]} {phone[9:13]}'

        return formatted_phone
    
    except:
        print ('Unexpected error. Use help(format_phone_number) for usage.')
        return (2)