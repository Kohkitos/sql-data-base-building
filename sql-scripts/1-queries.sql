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