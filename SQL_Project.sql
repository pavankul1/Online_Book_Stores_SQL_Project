#Basic Queries
/*1) Retrive all books in the 'Fiction' genre*/
select * from books 
where genre='Fiction';

/*2) Find books published after the year 1950*/
select * from books
where Published_Year>1950;

/*3)List all customers from the Canada0*/
select * from customers
where Country='Canada';

/*4) Show orders placed in November 2023*/
select * from orders
where Order_Date between '2023-11-01' and '2023-11-30';

/*5) Retrieve the total stock of books available*/
select sum(stock)as Total_Stock from books;

/*6) Find the details of the most expensive book*/
select * from books order by Price desc
limit 1;

/*7) Show all customers who ordered more than 1 quantity of a book*/
select * from orders
where Quantity>1;

/*8) Retrieve all orders where the total amount exceeds $20*/
select * from orders
where Total_Amount>20;

/*9) List all genres available in the Books table*/
select distinct genre from books;

/*10) Find the book with the lowest stock*/
select * from books
order by stock asc
limit 1;

/*11) Calculate the total revenue generated from all orders*/
select round(sum(Total_Amount),2)as Revenue 
from orders;

#Advanced Queries
/*1) Retrieve the total number of books sold for each genres*/
select b.Genre, sum(o.Quantity) as Total_Books_Sold
from orders o
join books b on o.book_id=b.book_id
group by b.genre;

/*2) Find the average price of books in the "Fantasy" genre*/
select round(avg(price),2)as Fantasy_Avg_Price 
from books
where Genre='Fantasy';

/*3) List customers who have placed at least 2 orders*/
select customer_id, count(order_id) as Order_Count
from orders
group by Customer_ID
having count(Order_ID)>=2;

/*4) Find the most frequently ordered book*/
select o.book_id, b.title, count(o.order_id)as Order_Count
from orders o 
join books b on o.Book_ID=b.Book_ID
group by o.book_id, b.Title
order by Order_Count desc limit 1;

/*5) Show the top 3 most expensive books of 'Fantasy' Genre*/
select * from books 
where genre='Fantasy'
order by price desc
limit 3;

/*6) Retrieve the total quantity of books sold by each author*/
select b.Author, sum(o.quantity)as Total_Books_Sold
from orders o
join books b on b.Book_ID=o.book_id
group by b.author;

/*7) List the cities where customers who spent over $30 are located*/
select distinct c.City, o.Total_Amount 
from orders o
join customers c on o.Customer_ID=c.Customer_ID
where o.Total_Amount>30;

/*8) Find the customer who spent the most on orders*/
select c.customer_id, c.name, round(sum(o.total_amount),2)as Total_Spent
from orders o 
join customers c on o.Customer_ID=c.Customer_ID
group by c.Customer_ID, c.Name
order by Total_Spent desc limit 1;

/*9) Calculate the stock remaining after fulfilling all orders*/
select b.book_id, b.title, b.stock, coalesce(sum(quantity),0)as Order_Quantity,
b.Stock-coalesce(sum(quantity),0)as Remaining_Stock
from books b
left join orders o on b.Book_ID=o.Book_ID
group by b.Book_ID, b.Title,b.Stock;
#without coalesce and using only join function, so that it will print only matched and non-null values. This result can be obtained using these 2 methods.
select b.book_id, b.title, b.stock, sum(o.quantity)as Order_Quantity,
b.stock-sum(o.quantity)as Remaining_Quantity
from books b 
join orders o on b.Book_ID=o.Book_ID
group by b.Book_ID, b.Title, b.Stock;