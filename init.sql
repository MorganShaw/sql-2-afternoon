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


---------- Practice Updating Rows ----------

-- 1.