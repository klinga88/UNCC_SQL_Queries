USE sakila;
-- 1a
SELECT first_name, last_name FROM actor;
-- 1b
SELECT CONCAT(UPPER(first_name),' ', UPPER(last_name))
AS 'Actor Name'
FROM actor;

-- 2a
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';
-- 2b
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%GEN%';
-- 2c
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name ASC, first_name ASC;
-- 2d
SELECT country_id, country
FROM country
WHERE country
IN ('Afghanistan', 'Bangladesh','China');

-- 3a
ALTER TABLE actor
ADD COLUMN middle_name VARCHAR(20) AFTER first_name;
-- 3b
ALTER TABLE actor
MODIFY COLUMN middle_name BLOB;
-- 3c
ALTER TABLE actor
DROP COLUMN middle_name;

-- 4a
SELECT last_name, COUNT(last_name) 
FROM actor
GROUP BY last_name;
-- 4b
SELECT last_name, COUNT(last_name) 
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;
-- 4c
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO';
-- 4d
UPDATE actor
SET first_name = CASE
	WHEN first_name = 'HARPO' THEN 'GROUCHO'
    ELSE 'MUCHO GROUCHO' END
WHERE actor_id = 172;

-- 5a
SHOW CREATE TABLE actor;

-- 6a
SELECT s.first_name, s.last_name, a.address
FROM staff s
LEFT JOIN address a ON s.address_id = a.address_id;
-- 6b
SELECT s.first_name, s.last_name, SUM(p.amount)
FROM staff s 
LEFT JOIN payment p ON s.staff_id = p.staff_id
GROUP BY s.first_name;
-- 6c
SELECT f.title, count(fa.actor_id)
FROM film f
INNER JOIN film_actor fa on f.film_id = fa.film_id
GROUP BY f.title;
-- 6d
SELECT count(i.inventory_id)
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'HUNCHBACK IMPOSSIBLE';
-- 6e
SELECT c.first_name,c.last_name,sum(p.amount)
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.first_name,c.last_name
ORDER BY c.last_name;

-- 7a
SELECT f.title
FROM film f
INNER JOIN language l ON f.language_id = l.language_id
WHERE f.title IN(
SELECT f.title
FROM film f
WHERE (f.title LIKE 'K%' OR f.title LIKE 'Q%'));