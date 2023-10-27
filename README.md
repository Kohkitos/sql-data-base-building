[!cover](https://github.com/Kohkitos/sql-data-base-building/blob/main/img/cover.jpg)

# Database Building with SQL

Iron Hack's week 3 project.

## Introduction 🎞

A delusional man, in 2023 A.D., has decided to re-open Blockbuster. This is not a great idea, but he's paying us, so we have to obey.

He says that he has recover some Blockbuster's data from back in the day and he wants us to clean the data and export it into a database. He's no programmer so he's trusting our criteria as long as it is a SQL database (his brother-in-law told him about it and he believes is the next big thing).


## 0-Contents

+ `src`: a hidden directory with the source database.
+ `img`: folder with the images used in the readme.
+ `notebooks`: all the notebooks used in the project.

**All the explanations in this readme will be more developed on the notebooks**

## 1-Problem Instructions 🗒

The problem is divided into 4 parts and a bonus:

1. Explore the data and write down what you have found
   - you can use: `df.describe()`, `df["column"]`, etc.
1. Clean the data (you can get rid of columns that doesn't give information)
1. Build your databse
1. Write at least 10 queries including: join, groupby, orderby, where, subqueries….that you think will be useful to get interesting insights from the data.**(SELECT* FROM TABLE_NAME doesn't count...)**
+ Bonus: Get creative!!! Create totally new tables or enrich the csv files with new data (found on the internet or even made up) that makes your database more valuable.

Let's get into it!

## 2-Data Exploration 🔍

The tables that are worth keeping for the SQL database are: `actor`, `film`, `inventory` and `rental`. `old_HDD`, when transformed, will help us relate `film`, `category` and `actor`.

On the other side, `language` will be useful if `film` had no repeated values in the `language_id` column. I don't believe there's something that can be done about it with just data cleaning and transformation, so I'm going to drop it.

## 3-Data Cleaning 🧹