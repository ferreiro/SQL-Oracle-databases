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

Select *
from client, books_order where
books_order.isbn=4554672899910;

Select *
from client natural join books_order where
books_order.isbn=4554672899910;
