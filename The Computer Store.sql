CREATE DATABASE TheComputerStore;
USE TheComputerStore;
/*Manufacturers*/
CREATE TABLE MANUFACTURERS(
CODE INT NOT NULL,
NAME VARCHAR(255) NOT NULL,
PRIMARY KEY (CODE)
);
/*Products*/
CREATE TABLE PRODUCTS(
CODE INT NOT NULL,
NAME VARCHAR(255) NOT NULL,
PRICE DECIMAL NOT NULL,
MANUFACTURER INT NOT NULL,
PRIMARY KEY (CODE),
FOREIGN KEY (MANUFACTURER) REFERENCES MANUFACTURERS (CODE)
);
/*ADDING ROWS TO MANUFACTURERS*/
INSERT INTO MANUFACTURERS (CODE, NAME) VALUES
(1, 'SONY'),
(2, 'CREATIVE LABS'),
(3, 'HEWLETT-PACKARD'),
(4, 'IOMEGA'),
(5, 'FUJITSU'),
(6, 'WINCHESTER');
SELECT * FROM MANUFACTURERS;
/*ADDING ROWS TO PRODUCTS*/
INSERT INTO PRODUCTS (CODE, NAME, PRICE, MANUFACTURER) VALUES
(1, 'HARD DRIVE', 240, 5),
(2, 'MEMORY', 120, 6),
(3, 'ZIP DRIVE', 150, 4),
(4, 'FLOPPY DISK', 5, 6),
(5, 'MONITOR', 240, 1),
(6, 'DVD DRIVE', 180, 2),
(7, 'CD DRIVE', 90, 2),
(8, 'PRINTER', 270, 3),
(9, 'TONER CARTRIDGE', 66, 3),
(10, 'DVD BURNER', 180, 2);
SELECT * FROM PRODUCTS;
/*Question 1 - Select the names of all the products in the store.*/
SELECT NAME
FROM PRODUCTS;
/*Question 2 - Select the names and the prices of all the products in the store.*/
SELECT NAME, PRICE
FROM PRODUCTS;
/*Question 3 - Select the name of the products with a price less than or equal to $200.*/
SELECT NAME, PRICE
FROM PRODUCTS
WHERE PRICE <= 200;
/*Question 4 - Select all the products with a price between $60 and $120.*/
SELECT *
FROM PRODUCTS 
WHERE PRICE BETWEEN 60 AND 120;
/*VERSION 2*/
SELECT *
FROM PRODUCTS 
WHERE PRICE >= 60 AND PRICE >= 120;
/*Question 5 - Select the name and price in cents (i.e., the price must be multiplied by 100).*/
SELECT NAME, CONCAT(PRICE * 100, ' cents') AS PRICE
FROM PRODUCTS;
/*Question 6 - Compute the average price of all the products.*/
SELECT AVG(PRICE) AS AvgPrice
FROM PRODUCTS;
/*Question 7 - Compute the average price of all products with manufacturer code equal to 2.*/
SELECT AVG(PRICE) AS AvgPrice
FROM PRODUCTS
WHERE MANUFACTURER = 2;
/*Question 8 - Compute the number of products with a price larger than or equal to $180.*/
SELECT COUNT(*) AS ProductCount
FROM PRODUCTS
WHERE PRICE >= 180;
/*Question 9 - Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).*/
SELECT NAME, PRICE
FROM PRODUCTS
WHERE PRICE >= 180
ORDER BY PRICE DESC, NAME ASC;
/*Question 10 - Select all the data from the products, including all the data for each product's manufacturer.*/
SELECT a.*, b.NAME AS ManufacturerName
FROM PRODUCTS a, MANUFACTURERS b
WHERE a.MANUFACTURER = b.CODE;
/*Version 2*/
SELECT a.*, b.NAME AS ManufacturerName
FROM PRODUCTS a
JOIN MANUFACTURERS b
ON a.MANUFACTURER = b.CODE;
/*Question 11 - Select the product name, price, and manufacturer name of all the products.*/
SELECT a.NAME, a.PRICE, b.NAME AS ManufacturerName
FROM PRODUCTS a, MANUFACTURERS b
WHERE a.MANUFACTURER = b.CODE;
/*Question 12 - Select the average price of each manufacturer's products, showing only the manufacturer's code.*/
SELECT AVG(PRICE) AS AvgPrice, MANUFACTURER
FROM PRODUCTS 
GROUP BY MANUFACTURER;
/*Question 13 - Select the average price of each manufacturer's products, showing the manufacturer's name.*/
SELECT AVG(a.PRICE) AS AvgPrice, b.NAME
FROM PRODUCTS a, MANUFACTURERS b
WHERE a.MANUFACTURER = b.CODE
GROUP BY b.NAME;
/*Question 14 - Select the names of manufacturer whose products have an average price larger than or equal to $150.*/
SELECT a.NAME, AVG(b.PRICE) AS AvgPrice
FROM MANUFACTURERS a
JOIN PRODUCTS b
ON a.CODE = b.MANUFACTURER
GROUP BY a.NAME
HAVING AvgPrice >= 150;
/*Version 2*/
SELECT c.NAME, c.AvgPrice
FROM(
SELECT a.NAME, AVG(b.PRICE) AS AvgPrice
FROM MANUFACTURERS a
JOIN PRODUCTS b
ON a.CODE = b.MANUFACTURER
GROUP BY a.NAME) c
WHERE c.AvgPrice >= 150;
/*Question 15 - Select the name and price of the cheapest product.*/
SELECT NAME, PRICE
FROM PRODUCTS
ORDER BY PRICE
LIMIT 1;
/*Question 16 - Select the name of each manufacturer along with the name and price of its most expensive product.*/
select max_price_mapping.name as manu_name, max_price_mapping.price, products_with_manu_name.name as product_name
from 
    (SELECT Manufacturers.Name, MAX(Price) price
     FROM Products, Manufacturers
     WHERE Manufacturer = Manufacturers.Code
     GROUP BY Manufacturers.Name)
     as max_price_mapping
   left join
     (select products.*, manufacturers.name manu_name
      from products join manufacturers
      on (products.manufacturer = manufacturers.code))
      as products_with_manu_name
 on
   (max_price_mapping.name = products_with_manu_name.manu_name
    and
    max_price_mapping.price = products_with_manu_name.price); 
/*Question 17 - Add a new product: Loudspeakers, $70, manufacturer 2.*/
INSERT INTO PRODUCTS (CODE, NAME, PRICE, MANUFACTURER) VALUES 
(11, 'LOUDSPEAKERS', 70, 2);
/*Question 18 - Update the name of product 8 to "Laser Printer".*/
UPDATE PRODUCTS
SET NAME = 'LASER PRINTER'
WHERE CODE = 8;
/*Qusetion 19 - Apply a 10% discount to all products.*/
UPDATE PRODUCTS
SET PRICE = PRICE * 0.9;
/*QUESTION 20 - Apply a 10% discount to all products with a price larger than or equal to $120.*/
UPDATE PRODUCTS
SET PRICE = PRICE * 0.9
WHERE PRICE >= 120;