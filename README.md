[!cover](https://github.com/Kohkitos/sql-data-base-building/blob/main/img/cover.jpg)

# Database Building with SQL

Iron Hack's week 3 project.

## Introduction 🎞

A delusional man, in 2023 A.D., has decided to re-open Blockbuster. This is not a great idea, but he's paying us, so we have to obey.

He says that he has recover some Blockbuster's data from back in the day and he wants us to clean the data and export it into a database. He's no programmer so he's trusting our criteria as long as it is a SQL database (his brother-in-law told him about it and he believes is the next big thing).


## 0-Contents

+ `src`: a hidden


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

### a. Actor

The `actor` table is really simple: it has the name and last name of the actors, their id and the `last_update` column which will probably be the last day that particular actor was updated for whatever reason.

All ids are unique so there's probably not much cleaning to be done. My first thought is that `last_update` will not be that useful so I may have to drop it, but we'll see.

### b. Categoty

`Category` is really clean, probably some column names might be changed but that's it.

### c. Film

Opposite to the previous two, `film` has `original_language_id` full of nulls and `language_id` full of repeated values, we may have to drop them later.

I think `last_update` refers to the last time that movie was rented, thus `rental_duration` for how many (days? Months?) that movie was rented; could also mean for how much time it can be rented. I also wanted to check if `rental_duration` is correlated to `rental_rating` but with a 0.03 correlation value it seems that they are not.

### d. Inventory

No nulls, no repeated ids, clean. This has the ids of the store it was and the film, as wells as another `last_update` column. I have a theory but I will share it in the conclussions part of the data exploration, when I finish exploring every dataframe.

### e. Language

This section seems to have the ids of the languages we saw in the `film` table, but in the other table the values were all repeated. Probably we'll drop this table.

### f. old_HDD

This has the relationships of each actor with each film. I have to check later when cleaning and transforming the data if every actor is linked with every movie but this looks like a good anchor table between the two.

### g. Rental

No nulls, no repeated ids. There is `staff_id` column with just two values, 1 and 2, like the store ids in invengory, they may be related.