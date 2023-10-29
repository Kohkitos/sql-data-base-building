![cover](https://github.com/Kohkitos/sql-data-base-building/blob/main/img/cover.jpg)

# Database Building with SQL

Iron Hack's week 3 project.

## Index
1. [Introduction 🎞](#introduction-)
1. [Contents](#contents)
1. [Problem Instructions 📝](#problem-instructions-)
1. [Data Exploration 🔍](#data-exploration-)
1. [Data Cleaning 🧹](#data-cleaning-)
1. [Building a Database 👷‍♂️](#building-a-database-)
1. [Filling with dummy values 🤖](#filling-with-dummy-values-)


## [Introduction 🎞](#introduction-)

A man named Deli Ushion, in 2023 A.D., has decided to re-open Blockbuster as a self-service automatic movie rental store without staff. This is not a great idea, but he's paying us, so we have to obey.

Deli says that he has recover some Blockbuster's data from back in the day and he wants us to clean the data and export it into a database. He's no programmer so he's trusting our criteria as long as it is a SQL database (his brother-in-law, Manuel, told him about it and he believes is the next big thing).


## [Contents](#contents)

+ `data`: all the .csv cleaned.
+ `img`: folder with the images used in the readme.
+ `notebooks`: all the notebooks used in the project.
+ `sql-csvs`: csvs with dummy data for `customer` and `rental` table.
+ `sql-scripts`: all the .sql scripts.

**This readme only contains the conclussions, the process is explained in the notebooks**

## [Problem Instructions 📝](#problem-instructions-)

The problem is divided into 4 parts and a bonus:

1. Explore the data and write down what you have found
   - you can use: `df.describe()`, `df["column"]`, etc.
1. Clean the data (you can get rid of columns that doesn't give information)
1. Build your database
1. Write at least 10 queries including: join, groupby, orderby, where, subqueries….that you think will be useful to get interesting insights from the data.**(SELECT* FROM TABLE_NAME doesn't count...)**
+ Bonus: Get creative!!! Create totally new tables or enrich the csv files with new data (found on the internet or even made up) that makes your database more valuable.

Let's get into it!

## [Data Exploration 🔍](#data-exploration-)

The tables that are worth keeping for the SQL database are: `actor`, `film`, `inventory` and `rental`. `old_HDD`, when transformed, will help us relate `film`, `category` and `actor`.

On the other side, `language` would have been useful if `film` had no repeated values in the `language_id` column. I don't believe there's something that can be done about it with just data cleaning and transformation, so I'm going to drop it.

## [Data Cleaning 🧹](#data-cleaning-)

I did a general cleaning of all of the tables mentioned before and then I modified the old_HDD to be the `actor_film` table, serving as a many-to-many table for the two of them. I also used the `category` of that table to include it into the `film` table and have each film with its category.

## [Building a Database 👷‍♂️](#building-a-database-)

The database created was the following:

![database](https://github.com/Kohkitos/sql-data-base-building/blob/main/img/better_database.png)

## [Filling with dummy values 🤖](#filling-with-dummy-values-)

In order to make queries more interesting, I filled `customer` with fake data using the `Faker` library, and I modified the original `rental.csv` so that the dates are from 2023 and the ids match with the tables created in the previous section and with the newly created `customer` table.