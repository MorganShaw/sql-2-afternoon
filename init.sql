-- 1. 
SELECT * FROM invoice_line il
JOIN invoice i
ON il.invoice_id = i.invoice_id
WHERE unit_price > 0.99;

-- 2.
SELECT invoice_date, first_name, last_name, total
FROM invoice i
JOIN customer c
ON i.customer_id = c.customer_id;

-- 3.
SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e
ON c.support_rep_id = e.employee_id;

-- 4.
SELECT al.title, ar.name 
FROM album al
JOIN artist ar
ON al.artist_id = ar.artist_id;

-- 5.
SELECT plt.track_id FROM playlist_track plt
JOIN playlist pl
ON plt.playlist_id = pl.playlist_id
WHERE pl.name = 'Music';

-- 6. 
SELECT t.name FROM track t
JOIN playlist_track plt
ON t.track_id = plt.track_id
WHERE playlist_id = 5;

-- 7.
SELECT t.name, pl.name FROM track t
JOIN playlist_track plt
ON t.track_id = plt.track_id
JOIN playlist pl
ON plt.playlist_id = pl.playlist_id;

-- 8.
SELECT t.name, al.title FROM album al
JOIN track t
ON al.album_id = t.album_id
JOIN genre g
ON t.genre_id = g.genre_id;

-- Black Diamond
