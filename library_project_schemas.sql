create database library_project;

use library_project;

drop table if exists branch;
create table branch
(
branch_id varchar(10) primary key,
	manager_id varchar(10)	,
    branch_address varchar(50),
	contact_no varchar(50)
);

create table employees
(
emp_id varchar(20) primary key,
	emp_name varchar(25),
	position varchar(25),
	salary int,
	branch_id varchar(30)
);

create table books
(
isbn varchar(50) primary key,
	book_title varchar(75),
	category varchar(50),
	rental_price float,
	status varchar(50),	
    author varchar(50),
    publisher varchar(50)
);

create table members
(
member_id varchar(50) primary key,
	member_name varchar(50),
    member_address varchar(50),
	reg_date date
);

create table issued_status
(
issued_id varchar(20) primary key,
	issued_member_id varchar(20),
    issued_book_name varchar(75),
	issued_date date,
	issued_book_isbn varchar(50),
	issued_emp_id varchar(50)
    );

create table returned_status
(
return_id varchar(50) primary key,
	issued_id varchar(50),
	return_book_name varchar(50),
	return_date date,
	return_book_isbn varchar(50)
);

-- Foreign key--
alter table issued_status
add constraint fk_members
foreign key (issued_member_id)
references members(member_id);

alter table issued_status
add constraint fk_books
foreign key (issued_book_isbn)
references books(isbn);

alter table issued_status
add constraint fk_employees
foreign key (issued_emp_id)
references employees(emp_id);

alter table employees
add constraint fk_branch
foreign key (branch_id)
references branch(branch_id);

alter table returned_status
add constraint fk_issued_status
foreign key (issued_id)
references issued_status(issued_id);

select * from books;
select * from branch;
select * from employees;
select * from issued_status;
select * from returned_status;

-- Project questions--
insert into books(isbn, book_title, category, rental_price, status, author, publisher)
values
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

update members
set member_address = '125 Main St'
where member_id = 'C101';

select * from members;

delete from issued_status
where issued_id = 'IS107';

select * from issued_status;

select * from issued_status
where issued_emp_id = 'E101';

select issued_emp_id,
count(issued_id) as  Total_Book_issued
from issued_status
group by issued_emp_id
having count(issued_id) > 1;

-- CTAS-- Cteate a table as summary

select b.isbn,
b.book_title, 
count(ist.issued_id) as no_issued
from books as b
join
issued_status as ist
on ist.issued_book_isbn = b.isbn
group by 1,2;

Create table  book_cnts
as
select b.isbn,
b.book_title, 
count(ist.issued_id) as no_issued
from books as b
join
issued_status as ist
on ist.issued_book_isbn = b.isbn
group by 1,2;

select * from book_cnts;

select * from books
where category = "Classic";

select
b.category,
sum(b.rental_price),
count(*)
from books as b
join issued_status as ist
on ist.issued_book_isbn = b.isbn
group by 1;

insert into members(
member_id, member_name, member_address, reg_date)
values
('C120','sam', '145 Main St', '2024-06-01'),
('C121', 'john', '133 Main St', '2024-05-01');

select * from employees as e1
join
branch as b
on b.branch_id = e1.branch_id
join
employees as e2
on b.manager_id = e2.emp_id;
