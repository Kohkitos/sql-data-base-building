-- QUERIES --

-- 1. What are the top 3 most rented movies?

SELECT 
    f.title AS film,
    COUNT(*) AS rentals
FROM
    rental AS r
        INNER JOIN
    inventory AS i ON r.inventory_id = i.inventory_id
        INNER JOIN
    film AS f ON f.film_id = i.film_id
GROUP BY film
ORDER BY rentals DESC
LIMIT 3;

-- 2. Following the previous request, can you search which authors are the ones with the most amount of rented movies?

SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS actor,
    COUNT(*) AS rentals
FROM
    rental AS r
        INNER JOIN
    inventory AS i ON r.inventory_id = i.inventory_id
        INNER JOIN
    film AS f ON f.film_id = i.film_id
        INNER JOIN
    actor_film AS af ON af.film_id = f.film_id
        INNER JOIN
    actor AS a ON a.actor_id = af.actor_id
GROUP BY actor
ORDER BY rentals DESC
LIMIT 3;

-- 3. I'm really interested in customer 5, can you show a table with his full name, address and the movie rating and category he rents the most? Omit the movies yet to categorize its genre.

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS Customer,
    c.location AS Address,
    f.rating AS 'Favourite Rating',
    f.category AS 'Favourite Category'
FROM
    (SELECT 
        f.film_id, f.title AS Film_Title, COUNT(*) AS Rental_Count
    FROM
        rental AS r
    INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id
    INNER JOIN film AS f ON i.film_id = f.film_id
    WHERE
        r.customer_id = 5
    GROUP BY f.film_id , f.title
    ORDER BY Rental_Count DESC
    LIMIT 1) AS most_watched
        INNER JOIN
    film AS f ON f.film_id = most_watched.film_id
        INNER JOIN
    inventory AS i ON i.film_id = most_watched.film_id
        INNER JOIN
    rental AS r ON r.inventory_id = i.inventory_id
        INNER JOIN
    customer AS c ON c.customer_id = r.customer_id
WHERE
    c.customer_id = 5
LIMIT 1;

-- 4. I need a table with the most rented categories during the 26th.

SELECT 
    f.category, COUNT(*) AS Rental
FROM
    rental AS r
        INNER JOIN
    inventory AS i ON i.inventory_id = r.inventory_id
        INNER JOIN
    film AS f ON f.film_id = i.film_id
WHERE
    DAY(r.rental_date) = 26
GROUP BY f.category
ORDER BY Rental DESC;

-- 5. In which day did Carlito rent the most amount of movies? Display only his beautiful name, the day and the number of movies he rented.

SELECT 
	concat(c.first_name, ' ', c.last_name) as Costumer, 
    COUNT(*) AS Rentals,
    DAY(r.rental_date) AS 'Rental Day'
FROM
	rental AS r
INNER JOIN customer AS c ON c.customer_id = r.customer_id
WHERE
	c.customer_id = 5
GROUP BY `Rental Day`
ORDER BY rentals DESC
LIMIT 1;

-- 6.I'm planning to add a new store in Ávila. It would be called Blockbuster Love, it will be in Ávila, Ávila, the contact phone would be +34 654 486 124, we don't have a mail yet and the warehouse can only have 500 movies as well, so we can take the overbooking inventory from my house to the new store, so assgin new values to the inventory so that half of the films go to the new store.

INSERT INTO store (store_id, name, location, contact_phone, warehouse_capacity)
VALUES (
    2,
    'Blockbuster Love',
    'Ávila, Ávila',
    '+34 654 486 124',
    '500'
);

CREATE TEMPORARY TABLE temp_inventory AS
SELECT inventory_id
FROM inventory
ORDER BY RAND();

UPDATE inventory AS i
        JOIN
    temp_inventory AS t ON i.inventory_id = t.inventory_id 
SET 
    i.store_id = CASE
        WHEN t.inventory_id % 2 = 0 THEN 1
        ELSE 2
    END;


DROP TEMPORARY TABLE temp_inventory;

-- 7. Carlito is such a good client I was planning on gifting him his favourite drama movie, can you look for the top 5 drama movies he has rented the most?

SELECT 
    f.title AS Film, COUNT(*) AS 'Rental Count'
FROM
    customer AS c
        INNER JOIN
    rental AS r ON c.customer_id = r.customer_id
        INNER JOIN
    inventory AS i ON r.inventory_id = i.inventory_id
        INNER JOIN
    film AS f ON i.film_id = f.film_id
WHERE
    c.first_name = 'Carlito'
        AND f.category = 'Drama'
GROUP BY f.film_id , f.title
ORDER BY 'Rental Count' DESC
LIMIT 5;

-- 8. I think only gifting something to Carlito might be weird, can you show our top 3 clients who have rented the most amount of movies and their location so that I can send a 'thank you' basket to their houses?

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS Customer,
    c.location AS Address,
    COUNT(r.rental_id) AS Rentals
FROM
    customer AS c
        INNER JOIN
    rental AS r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY Rentals DESC
LIMIT 3;

-- 9. I tried to call Carlito but he doesn't pick up the phone. Remove his phone from the database, he should have had time to answer me, so he might have changed his number, right?

UPDATE customer 
SET 
    phone_number = NULL
WHERE
    customer_id = 5;
    
-- 10. I recently had to pay a fine because they thought I was stalking one of our clients. Weird, right? I need to sell some of our inventory, so make a list of our 20 less rented movies and how many copies of them we have in our inventory. Also group them by store so that I know how many of them I can remove from each store without leaving none to them.

SELECT 
    f.title AS movie_title,
    i.store_id,
    COUNT(i.inventory_id) AS inventory_count
FROM
    film AS f
        INNER JOIN
    inventory AS i ON f.film_id = i.film_id
        LEFT JOIN
    rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.title , i.store_id
ORDER BY COUNT(r.inventory_id) ASC
LIMIT 20;
