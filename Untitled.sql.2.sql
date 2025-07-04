Create database company_db ; 
Use company_db ; 

Create table companies (
company_id int primary key,
name varchar(50),
founded_year int,
industry varchar(50),
headquatres varchar(100),
employee_count int,
revenue float ); 

Select * from companies ;

Create table employees (
employee_id int primary key,
company_id int,
first_name varchar(50),
last_name varchar(50),
department varchar(50),
position varchar(50),
hire_date date,
salary int,
foreign key (company_id) references companies(company_id) 
);

Select * from employees ; 


Create table products (
product_id int primary key,
company_id  int,
product_name varchar(50),
category varchar(50),
launch_year int,
price float,
foreign key (company_id) references companies(company_id)
);


Select * from products ; 



delimiter $$
Create procedure get_products ()
begin
Select product_name , price from products ;
End $$
delimiter ;

call get_products (); 

delimiter $$
Create procedure get_employees ()
begin 
Select first_name , last_name , hire_date , sum(salary) from employees 
group by first_name , last_name , hire_date with rollup ;
End $$
delimiter ;

call get_employees (); 


Drop procedure get_employees ; 

Select sum(price) , product_id  from products 
group by product_id with rollup ; 

drop procedure  get_employees ; 

call get_employees (); 

Select employee_id , sum(salary) from employees 
group by employee_id with rollup ; 


delimiter $$
Create procedure get_companies ()
begin
Select company_id , name , sum(revenue) from companies
group by company_id , name ;
end $$
delimiter ;


drop procedure get_companies ; 


Call get_companies () ;


