/* Exercise 1 */

Select Title, Año, Name
from Book, author_book, author
where Book.ISBN = author_book.isbn and author_book.author=author.idauthor
order by año desc;

/* Esto está hecho sin natural join*/
/*Select author_book.isbn,name,año
from Book, Author_Book, author 
where book.isbn = author_book.isbn and author.idauthor=author_book.author
ORDER BY Año DESC;
*/ 

/* Exercise 2 */

Select Title, Año
from Book 
where Book.Año < 2000;

/* Exercise 3 */

select distinct client.name, Client.IdClient
from Client, Orders where
Client.IdClient=Orders.IdClient;

select distinct client.name, Client.IdClient
from Client join Orders on /* La sintaxis del join hace que tengas que poner no */
Client.IdClient=Orders.IdClient;

/* Exercise 4 */
/*
Select *
from client join books_order on
books_order.isbn=4554672899910;
*/
Select *
from client natural join orders natural join books_order
where books_order.isbn=4554672899910;

/*  Select * from client join orders on clients.idclient= orders.idclient join books_order on */

/* Exercise 5 */
/* List of clients whose name contains ‘Jo’ and the books that they have bought. */

Select * from Client natural join Orders natural join Books_Order natural join Book
on orders.idorder=books_order.idorder and books_order.isbn=book.isbn;
/*Select distinct Client.name, book.title
from Client, book
where Client.name like '%Jo%'; 
*/


/* Exercise 6 */
/* List of clients that have bought at least a book whose price is greater than 10€ */
/*
Select Client.Name (Select * from Orders natural join Books_Order
where Books_Order.IdOrder=Orders.IdOrder and Books_Order.amount > 10)
*/
