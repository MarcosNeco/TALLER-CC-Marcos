
-- Question 1

CREATE TABLE EmployeeDetails (
EmpID INT PRIMARY KEY,
FullName VARCHAR(255),
ManagerID INT,
FOREIGN KEY (ManagerID) REFERENCES EmployeeDetails(EmpID)
);



INSERT INTO EmployeeDetails (EmpID, FullName, ManagerID) VALUES
(1, 'Alice Johnson', NULL), -- Alice is a top-level manager (no manager above her)
(2, 'Bob Smith', 1), -- Bob's manager is Alice
(3, 'Charlie Reeds', 1), -- Charlie's manager is Alice
(4, 'Diana Green', 2), -- Diana's manager is Bob
(5, 'Evan Strokes', 2), -- Evan's manager is Bob
(6, 'Fiona Cheng', 3), -- Fiona's manager is Charlie
(7, 'George Kimmel', 3), -- George's manager is Charlie
(8, 'Hannah Morse', 3), -- Hannah's manager is Charlie
(9, 'Ian DeVoe', 3), -- Ian's manager is Charlie
(10, 'Jenny Hills', 3); -- Jenny's manager is Charlie



SELECT * FROM EmployeeDetails 
where empid in (select distinct managerid from employeedetails)



--Question 2

INSERT INTO EmployeeDetails (EmpID, FullName, ManagerID) VALUES
(21, 'Alex Smith', 3)


select * from (
select *, row_number() over(order by EmpID) as row_num
from employeedetails e 
) as sub 
where row_num % 2 = 1


--Question 3 

-- Creating the Products table
CREATE TABLE products (
   product_id serial PRIMARY KEY,
   name varchar, 
   color varchar,
   price float,
   sku int
)


  
-- Creating the Customers table
CREATE TABLE customers (
	customer_id serial PRIMARY KEY,
	name varchar not null,
	birthdate date not null,
	cpf varchar not null,
	rg varchar, 
	created_at timestamp not null,
	constraint unique_cpf unique (cpf), 
	constraint unique_rg unique (rg)
)

--creating address for customer
create table customer_address(
  address_id serial primary key,
  customer_id int not null,
  streetLine varchar (100) not null,
  city varchar(100) not null,
  state varchar(100) not null,
  postal_code varchar(20) not null, 
  country varchar(100) not null,
  foreign key(customer_id) references customers(customer_id)
)


CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id int not null, 
  order_date timestamp default current_timestamp,
  status varchar(50) not null,
  total_amount decimal(10, 2) not null, 
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
)


create table order_product(
  order_product_id serial primary key, 
  order_id int, 
  product_id int, 
  price decimal(10, 2) not null, --perhaps price if it has any discount
  foreign key (order_id) references orders(order_id),
  foreign key (product_id) references products(product_id)
)


create table payments(
 payment_id serial primary key, 
 order_id int, 
 payment_date timestamp default current_timestamp,
 payment_method varchar(50) not null, 
 payment_status varchar(50) not null,
 foreign key(order_id) references orders(order_id)
)



--question 4 

-- Creating the table for sales people
CREATE TABLE t_sales_person (
    sales_person_id serial PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(50),
    salary INT
);

-- Creating the table for aggregate sales
CREATE TABLE t_aggregate_sales (
    sales_id serial PRIMARY KEY,
    month INT,
    amount DECIMAL(10, 2),
    sales_person_id INT,
    FOREIGN KEY (sales_person_id) REFERENCES t_sales_person(sales_person_id)
)


-- Inserting data into t_sales_person
INSERT INTO t_sales_person (sales_person_id, name, position, salary) VALUES
(1, 'Steve', 'Senior', 80000),
(2, 'Bill', 'Intermediate', 60000),
(3, 'Alan', 'Intermediate', 62000),
(4, 'Gordon', 'Junior', 30000),
(5, 'Robert', 'Junior', 25000);

-- Inserting data into t_aggregate_sales
INSERT INTO t_aggregate_sales (sales_id, month, amount, sales_person_id) VALUES
(1, 202312, 1000, 1),
(2, 202312, 5000, 2),
(3, 202312, 2000, 3),
(4, 202312, 100, 4),
(5, 202312, 2500, 5),
(6, 202401, 6500, 1),
(7, 202401, 8000, 2),
(8, 202401, 10000, 5),
(9, 202401, 100, 4),
(10, 202401, 300, 3);



-- answer
SELECT
name,
position,
salary,
agg_sp.agg_sales,
RANK() OVER (ORDER BY agg_sales DESC) as rank
from t_sales_person sp
join (
select sales_person_id, 
sum(amount) as agg_sales
from t_aggregate_sales s
group by sales_person_id
) as agg_sp on sp.sales_person_id = agg_sp.sales_person_id




-- Question 6

-- Students
-- Teachers
-- Attendance
-- Assignments
-- Grades
-- Classes

-- Student table
  
-- Teacher table
  
-- Attendance table
  -- need to have a foreing key for student
  -- need to have a foreing key for teacher

-- classes table 
  -- should have a reference to teacher
  
-- assigments table 
  -- should have a reference for teacher and student

-- classes 
  -- should have a reference for teacher



-- Question 7
create table person_profession(
  id serial not null, 
  name varchar(50) not null, 
  profession varchar(10) not null
)


insert into person_profession values(1, 'Sam', 'Doctor')

insert into person_profession values(2, 'Shyam', 'Actor')

insert into person_profession values(3, 'Samuel', 'Cricketer')

insert into person_profession values(4, 'Sammy', 'Singer')


-- answer
select name || '(' || substring(profession from 1 for 1) || ')'
from person_profession



