---------- Practice Joins ----------

----- 1. 
SELECT * FROM invoice_line il
JOIN invoice i
ON il.invoice_id = i.invoice_id
WHERE unit_price > 0.99;

-- Solution code below: (I think it presents the same data, but in a different layout, since I selected from invoice_line for some reason. And the il. in 'WHERE il.unit_price > 0.99'; doesn't seem to make a difference when I tested it.)
-- SELECT * FROM invoice i
-- JOIN invoice_line il 
-- ON il.invoice_id = i.invoice_id
-- WHERE il.unit_price > 0.99;


----- 2.
SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice i
JOIN customer c
ON i.customer_id = c.customer_id;

-- Solution code had i.invoice_date, etc, so I added it, but it didn't make any difference in the results.


----- 3.
SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e
ON c.support_rep_id = e.employee_id;


----- 4.
SELECT al.title, ar.name 
FROM album al
JOIN artist ar
ON al.artist_id = ar.artist_id;


-- 5.
SELECT pt.track_id FROM playlist_track pt
JOIN playlist p
ON pt.playlist_id = p.playlist_id
WHERE p.name = 'Music';


-- 6. 
SELECT t.name FROM track t
JOIN playlist_track pt
ON t.track_id = pt.track_id
WHERE playlist_id = 5;


-- 7.
SELECT t.name, p.name FROM track t
JOIN playlist_track pt
ON t.track_id = pt.track_id
JOIN playlist p
ON pt.playlist_id = p.playlist_id;


-- 8.
SELECT t.name, al.title FROM album al
JOIN track t
ON al.album_id = t.album_id
JOIN genre g
ON t.genre_id = g.genre_id;


---------- Practice Nested Queries ----------

-- 1. 
SELECT * FROM invoice
WHERE invoice_id IN(
    SELECT invoice_id FROM invoice_line
    WHERE unit_price > 0.99
);


-- 2.
SELECT * FROM playlist_track
WHERE playlist_id IN(
    SELECT playlist_id FROM playlist
    WHERE name = 'Music'
);


-- 3.
SELECT name FROM track
WHERE track_id IN(
    SELECT track_id FROM playlist_track
    WHERE playlist_id = 5
);

-- track - name - track_id
-- playlist_track - track_id playlist_id


-- 4. 
SELECT * FROM track
WHERE genre_id IN(
    SELECT genre_id FROM genre
    WHERE name = 'Comedy'
);


-- 5.
SELECT * FROM track
WHERE album_id IN (
    SELECT album_id FROM album
    WHERE title = 'Fireball'
);


-- 6.
SELECT * FROM track
WHERE album_id IN (
    SELECT album_id FROM album
    WHERE artist_id IN (
        SELECT artist_id FROM artist
        WHERE name = 'Queen'
    )
);

-- artist: artist_id, name
-- album: album_id, artist_id
-- track: album_id



---------- Practice Updating Rows ----------

-- 1. 
UPDATE customer
SET fax = null
WHERE fax IS NOT null;

SELECT * FROM customer;

-- Solution code added the third line - IS NOT null. I imagine it saves time?


-- 2.
UPDATE customer
SET company = 'Self'
WHERE company IS null;


-- 3.
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia'
AND last_name = 'Barnett';


-- 4.
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';


-- 5.
-- genre: genre_id, name
-- track: genre_id

UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id IN (
    SELECT genre_id FROM genre
    WHERE name = 'Metal'
)
AND composer IS null;


---------- Group By ----------

-- 1.
SELECT COUNT(g.name), g.name 
FROM track t
JOIN genre g 
ON g.genre_id = t.genre_id
GROUP BY g.name; 

-- Solution code below was slightly different, but same results (I guess the splat is better practice).
SELECT COUNT(*), g.name
FROM track t
JOIN genre g 
ON t.genre_id = g.genre_id
GROUP BY g.name;


-- 2.
SELECT COUNT(*), g.name
FROM track t
JOIN genre g
ON t.genre_id = g.genre_id
WHERE g.name = 'Pop' AND g.name = 'Rock'
GROUP BY g.name;


-- 3.
SELECT a.name, COUNT(*)
FROM artist a
JOIN album al
ON a.artist_id = al.artist_id
GROUP BY a.name;


---------- Use Distinct ----------

-- 1.
SELECT DISTINCT composer
FROM track;


-- 2.
SELECT DISTINCT billing_postal_code
FROM invoice;


-- 3.
SELECT DISTINCT company
FROM customer;


---------- Delete Rows ----------

-- 2.
DELETE FROM practice_table
WHERE type = 'bronze';


-- 3.
DELETE FROM practice_table
WHERE type = 'silver';

-- 4.
DELETE FROM practice_table
WHERE value = 150;


---------- eCommerce Simulation ----------
-- CREATE TABLES: users, products, orders

-- users: user_id, name, email
-- products: product_id, name, price
-- orders: order_id, product_id

CREATE TABLE users(
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(200)
);

INSERT INTO users
(name, email)
VALUES
('Lucille Ball', 'ilovelucy@lucy.com'),
('Andy Griffith', 'bestsheriff@mayberry.com'),
('Henry Winkler', 'thefonz@leather.com');


CREATE TABLE products(
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price FLOAT(2)
);

INSERT INTO products
(name, price)
VALUES
('Chocolates', 32.50),
('Holster', 54.95),
('Leather Jacket', 150.00);


CREATE TABLE orders(
    order_id SERIAL PRIMARY KEY,
    quantity INT,
    product_id INT REFERENCES products (product_id)
);

INSERT INTO orders
(quantity, product_id)
VALUES
(5, 1),
(2, 2),
(1, 3),
(3, 1);

-- RUN QUERIES

-- Get all products for the first order.
SELECT * FROM orders
WHERE order_id = 1;

-- Get all orders.
SELECT * FROM orders;

-- Get total cost of an order.
SELECT SUM(p.price * o.quantity) 
FROM orders o
JOIN products p
ON o.product_id = p.product_id
WHERE order_id = 1;

-- Add foreign key reference from orders to users.
ALTER TABLE orders
ADD user_id INT REFERENCES users (user_id);

-- Update orders table to link a user to each order.
UPDATE orders
SET user_id = 1
WHERE order_id = 1;

UPDATE orders
SET user_id = 2
WHERE order_id = 2;

UPDATE orders
SET user_id = 3
WHERE order_id = 3 OR order_id = 4;

-- Run more queries.

-- Get all orders for a user. (The Fonz!)
SELECT * FROM orders o
JOIN users u
ON o.user_id = u.user_id
WHERE user_id = 3;

-- Get how many orders each user has.
SELECT COUNT(*), u.name
FROM orders o
JOIN users u
ON o.user_id = u.user_id
GROUP BY u.name;

SELECT COUNT(*), u.name, o.price
FROM orders o
JOIN users u
ON o.user_id = u.user_id
GROUP BY u.name;


SELECT SUM(o.quantity * p.price)