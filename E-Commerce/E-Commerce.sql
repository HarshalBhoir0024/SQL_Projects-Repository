create database ecommerce;


use ecommerce;

#create category 

create table Categories (
       Category_ID int Primary key,
       Category_Name varchar(50) not null unique
 );
 
 
 
 # insert Categories
       
insert into Categories values
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Shoes'),
(4, 'Home'),
(5, 'Books');
 
 
 
 select * from Categories;
 
 
 #create Products Table 
 
 
Create Table Products (
	 Product_ID int primary key,
     Product_Name varchar(100) not null,
     Price Decimal(10,2),
     Stock int,
     Category_ID int,
     Foreign key (Category_ID) References Categories(Category_ID)
     );
     
     
 
 insert into Products values
 (101, 'Laptop',55000,10,1),
 (102, 'Mobile Phone', 25000, 20, 1),
 (103, 'T-Shirt', 800, 50, 2),
 (104, 'Jeans', 1800, 30, 2),
 (105, 'Running Shoes', 2500, 25, 3),
 (106, 'Sofa', 30000,5,4),
 (107, 'Table lamp', 1500, 15, 4),
 (108, 'SQL Book', 700, 40, 5),
 (109, 'Python Book', 900, 35, 5),
 (110, 'Smart Watch ',5000, 18, 1);
 
 
Select * from Products;

 
 
 
 ## Create Customers table 
 
 
 create table Customers (
     Customer_ID int primary key,
     Customer_Name varchar(50) Not null,
     City varchar(50),
     Email varchar(100) unique
);



insert into Customers Values
(1, 'Amit', 'Pune', 'amit@gmail.com'),
(2, 'Rahul', 'Mumbai', 'rahul@gmail.com'),
(3, 'Sneha', 'Pune', 'sneha@gmail.com'),
(4, 'Priya', 'Delhi', 'Priya@gmail.com'),
(5, 'Karan', 'nashik', 'karan@mail.com'),
(6, 'Neha', 'Pune', 'neha@gmail.com'),
(7, 'Vikas', 'Mumbai','Vikas@gmail.com'),
(8, 'Pooja', 'Pune', 'Pooja@gmail.com'),
(9, 'Rohit', 'Delhi', 'Rohit@gmail.com'),
(10, 'Anita', 'Nashik', 'anita@gmail.com');



select * from Customers;




# Create Orders Table 

Create Table Orders (
    Order_ID int primary Key,
    Customer_ID int,
    Product_ID int,
    Quantity int,
    Order_Date Date,
    Status Varchar(30),
    Foreign Key (Customer_ID) References Customers(Customer_ID),
    Foreign key(Product_ID) References Products(Product_ID)
    );
    
    
    
insert into Orders values
(1001, 1, 101, 1, '2024-01-10','Delivered'),
(1002, 2, 102, 2, '2024-01-12','Delivered'),
(1003, 3, 103, 3, '2024-01-15','Delivered'),
(1004, 4, 106, 1, '2024-01-18', 'Pending'),
(1005, 5, 105, 2, '2024-01-20', 'Delivered'),
(1006, 6, 110, 1, '2024-02-01', 'Shipped'),
(1007, 7, 108, 2, '2024-02-05', 'Delivered'),
(1008, 8, 109, 1, '2024-02-10', 'Cancelled'),
(1009, 9, 104, 2, '2024-02-15', 'Delivered'),
(1010, 10, 107, 3, '2024-02-20', 'Pending');



select * from Orders;




# q1 display all products

select * from Products;

#q2 Display products costing more than $5000


select * 
from Products
where Price > 5000;



#q3 display Products between 1000 and 10,000

select * 
from Products
where Price Between 1000 and 10000;



#q4 Display customers from Pune

select *
from Customers
where City = 'Pune';



#q5  products from category 1 or 3 

select * 
from products
where Category_ID in (1,3);



#q6 product starting with s

select * 
from Products
where Product_Name like 'S%';




#q7 Products with stock less than 20 

select * 
from Products
where Stock < 20;




#q8 Customers from Pune Or mumbai


select *
from Customers 
Where City = 'Pune'
Or City = 'Mumbai';


#q9 count total products

select Count(*) as total_Products 
from Products;




# Find Maximum Product price 



select Max(Price) as Maximum_price 
from products;


# min products


select min(price ) as minimum_price
from Products;





# find averae Product price 

select Avg(Price) as Average_Price 
from Products;




# Find total stock 

select Sum(stock) as total_stock
from Products;





# q14 group by  count products in each category

select Category_ID, Count(*) as Total_Products
from Products 
group by Category_ID;




#q15 Average Price by category

select Category_ID, Avg(price) as Average_Price 
from Products 
Group By Category_ID;





#q16 Categories having more than 2 products

select Category_ID, Count(*) As Total_Products
from Products
Group by Category_ID
Having Count(*) > 2;




# join show Product name and category name

select 
   p.Product_Name,
   c.Category_Name
from Products as p
inner join Categories as c
on p.Category_ID = c.Category_ID;





#q18 show customer and order details

select 
    c.Customer_Name,
	o.Order_ID,
    o.Order_Date,
    o.status
From Customers as c
inner join Orders as o
on c.Customer_ID = o.Customer_ID;





#q19 show complete order information 

select 
  o.Order_ID,
  c.Customer_Name,
  p.Product_Name,
  o.Quantity,
  p.Price,
  o.Status
From Orders as o
join Customers as c
on o.Customer_ID = c.Customer_ID
join Products as p
on o.Product_ID = p.Product_ID;









# Calculate sales

#Q20 Calculate Order amount 


select 
o.Order_ID,
p.Product_Name,
o.Quantity,
p.Price,
o.Quantity * p.Price as Total_Amount
from Orders as o
join Products as p
on o.Product_ID = p.Product_ID;





# Total Sales

Select 
   sum(o.Quantity * p.Price) as Total_Sales
   from Orders as o
   join Products as p
   On o.Product_ID = p.Product_ID;
   
   

# Sales by product 

select 
    p.Product_Name,
    sum(o.Quantity * p.Price) as Total_Sales
    from Orders as o
    join Products as p
    on o.Product_ID = p.Product_ID
    group by p.Product_Name;
    
  
  
    
    
 
 
    
  # subquery 
  #23
  # Find products costing more than average price 
  
  
  select * 
  from Products
  where Price > (
     select AVG(price)
     from Products 
);




# Q24  find the most expensive product

select *
from Products 
where Price = (
     Select max(price)
     from Products
);   




#case 
#Categorize Products by Price 

select Product_Name,
Price,
case 
   when Price >= 30000 then 'Expensive'
   when Price >= 5000 then 'Medium'
   else 'cheap'
   end as Price_Category
from Products;



# Order BY 

# Highest Priced Products first alter

select *
from Products 
order by Price Desc;
  
  
  
  
#lowest - priced products first 

select * 
from Products
order by Price asc;






# 21 update 

# increase laptop price by 2000


Update Products
set Price = Price + 2000
where Product_ID = 101;






# delete cancelled order 

delete from Orders
where Status = 'Cancelled';





select * from Orders;
