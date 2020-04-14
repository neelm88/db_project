CREATE VIEW [Wishes] AS
SELECT B.email, COUNT(W.wish_number) AS "Number of Wishes"
FROM BUYER AS B LEFT OUTER JOIN WISH AS W ON B.email = W.email
GROUP BY B.email
ORDER BY B.email ASC;

CREATE VIEW [Average Ratings] AS
SELECT I.product_id, I.title, AVG(F.rating) AS "Average Rating"
FROM INVENTORY AS I INNER JOIN FEEDBACK AS F ON I.product_id = F.product_id
GROUP BY I.product_id
ORDER BY AVG(F.rating) DESC;
