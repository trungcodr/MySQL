use testDB;

create table Products(
	id int primary key auto_increment,
	name varchar(255),
    category varchar(100),
    price decimal(10,2),
    stock int
);

insert into Products(name,category,price,stock) values 
('Thai Duong 2','Shampoo', 490000,10),
('Head&Shoulder','Shampoo', 75000,10),
('Clearman','Shampoo', 80000,5),
('Pentine','Shampoo', 50000,0),
('Thai Duong','Shampoo', 1000000,1),
('Xmen','Body Wash', 750000,10),
('Loriel','Gel', 30000,100);

select * from Products;

-- Tang gia san pham có id là 2 lên 10% 
update Products
set price = (price*0.1) + price
where id = 2;

-- Xóa một sản phẩm có stock = 0.
delete from Products 
where stock = 0;

-- Truy vấn lấy sản phẩm có giá nhỏ nhất.
select * from Products
where price = (select min(price) from Products);

-- Truy vấn lấy sản phẩm có giá lớn nhất.
select * from Products
where price = (select max(price) from Products);

-- Tính tổng số lượng sản phẩm (SUM) và giá trung bình (AVG).
select sum(stock) as 'Tong so luong san pham' , avg(price) as 'Gia trung binh' 
from Products;

-- Lấy danh sách sản phẩm có giá lớn hơn 100, sắp xếp theo giá giảm dần.
select * from Products
where price > 100
order by price desc;

-- Lấy danh sách sản phẩm theo thứ tự giá tăng dần và giảm dần.
select * from Products
order by price asc;

-- Lấy sản phẩm có giá cao hơn giá trung bình của tất cả các sản phẩm.
select * from Products
where price > (select avg(price) from Products);

