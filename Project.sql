use Music;

SELECT * FROM dbo.Employee;

--Q1: Select most senior employee based on job title.

SELECT TOP 1 * FROM EMPLOYEE
ORDER BY LEVELS DESC;

--Q2: Which countries have the most Invoices?

SELECT * FROM [dbo].[invoice]

SELECT TOP 1 COUNT(invoice_id), billing_country from invoice
GROUP BY billing_country
ORDER BY COUNT(invoice_id) DESC

--Q3: What are top 3 values of total invoice? *

SELECT TOP 3 TOTAL FROM invoice
ORDER BY TOTAL DESC

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */


SELECT TOP 1 billing_city , sum(total) AS Total_Invoice FROM invoice
GROUP BY billing_city
ORDER BY sum(total) DESC

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/

SELECT TOP 1 C.First_name,c.Last_name, i.Customer_id , sum(total) AS Total_Invoice FROM invoice i
INNER JOIN Customer C ON i.Customer_id = c.Customer_id
GROUP BY C.First_name,c.Last_name,i.Customer_id
ORDER BY sum(total) DESC

SELECT * FROM Customer WHERE Customer_id=5

/* Question Set 2 - Moderate */

/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */
SELECT * FROM [dbo].[genre]
SELECT DISTINCT c.Email, c.first_name, c.Last_name FROM invoice i
INNER JOIN Customer C ON i.Customer_id = c.Customer_id
INNER JOIN Invoice_Line il on i.invoice_ID = il.invoice_ID
INNER JOIN Track t ON t.track_id = il.track_id
INNER JOIN Genre g ON G.Genre_ID = t.Genre_ID
WHERE G.Genre_ID = 1
ORDER BY C.Email 

/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

SELECT TOP 10 A.name,COUNT(al.artist_id) from Artist A
INNER JOIN Album al ON A.artist_id = al.artist_id
INNER JOIN Track t ON t.Album_id = al.Album_id
INNER JOIN Genre g ON G.Genre_ID = t.Genre_ID
WHERE G.Genre_ID = 1
GROUP BY A.name,al.artist_id
ORDER BY COUNT(al.artist_id) DESC

/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

SELECT t.Name, milliseconds from Track t
WHERE milliseconds >
(SELECT AVG(milliseconds) FROM TRACK)
ORDER BY milliseconds DESC

/* Question Set 3 - Advance */

/* Q1: Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent */

SELECT TOP 10 C.first_name, A.name, SUM(IL.unit_price*IL.quantity) AS Total_Spend FROM customer C
INNER JOIN invoice i ON i.Customer_id = c.Customer_id
INNER JOIN Invoice_Line il on i.invoice_ID = il.invoice_ID
INNER JOIN Track t ON t.track_id = il.track_id
INNER JOIN Album al ON t.Album_id = al.Album_id
INNER JOIN artist A ON A.artist_id = al.artist_id
GROUP BY C.first_name, A.name
ORDER BY Total_Spend DESC
