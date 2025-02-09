create database LibraryManagement;
use LibraryManagement;

-- Tao bang
create table Authors(
	AuthorID int primary key auto_increment,
    AuthorName varchar(100) not null
);

create table Books(
	BookID int primary key auto_increment,
    Title varchar(200) not null,
    AuthorID int,
    foreign key (AuthorID) references Authors(AuthorID),
    PublishedYear year not null
);

create table Members(
	MemberID int primary key auto_increment,
    MemberName varchar(100) not null,
    JoinDate date not null
);

create table Loans(
	LoanID int primary key auto_increment,
    BookID int,
    foreign key (BookID) references Books(BookID),
    MemberID int,
    foreign key (MemberID) references Members(MemberID),
    LoanDate date not null,
    ReturnDate date
);

insert into Authors(authorname) values
('Nguyen Nhat Anh'),
('Che Lan Vien'),
('To Hoai'),
('Xuan Dieu'),
('Duong Thu Huong');

insert into Books(title,authorid,publishedyear) values 
('Mắt biếc',1,1990),
('Ngồi khóc trên cây', 1, 2013),
('Những bài thơ đánh giặc', 2, 1972),
('Dế mèn phiêu lưu ký', 3, 1941),
('Vợ chồng A Phủ', 3, 1953),
('Gửi hương cho đời', 4, 2002),
('Mùa hè lạnh',5,2016),
('Chien truong ruc lua',5,2016);

insert into Members(membername,joindate) values
('Phùng Thanh Độ', '2020-12-09'),
('Lâm Đình Khoa', '2022-06-12'),
('Nguyễn Hoàng Đức', '2024-05-29'),
('Vũ Văn Thanh', '2015-04-08'),
('Ngô Minh Nguyệt', '2009-01-07');

insert into Loans(BookID,memberid,loandate,returndate) values  
(3,1,'2024-02-03', null),
(1,2,'2022-07-12','2023-08-15'),
(5,3,'2024-06-10', null),
(2,4,'2016-08-19','2024-04-12'),
(6,5,'2010-09-08','2015-04-16'),
(3,5,'2010-08-08','2016-05-17'),
 (5,5,'2013-12-25','2016-05-17'); 
-- Lấy ra thông tin gồm 4 cột: BookID, Title, AuthorName và PublishedYear.
-- Điều kiện: chỉ lấy những cuốn sách có PublishedYear sau năm 2010.
select b.BookID, b.Title,a.AuthorName,b.PublishedYear
from Books b
join Authors a on b.authorid = a.authorid
where b.PublishedYear > 2010;

-- Tính số lượng sách mà mỗi thành viên đã mượn.
select m.memberid, m.membername, count(l.bookid) as 'So luong sach muon'
from Members m 
join Loans l on m.memberid = l.memberid
group by m.memberid;

-- Chỉ hiển thị những thành viên có số lượng sách mượn lớn hơn 2.
select m.memberid, m.membername, count(l.bookid) as 'So luong sach muon'
from Members m 
join Loans l on m.memberid = l.memberid
group by m.memberid
having count(l.bookid) > 2;

-- Lấy ra năm xuất bản sớm nhất (tức là giá trị nhỏ nhất của PublishedYear) từ bảng Books.
select * from Books 
where publishedyear = (select min(publishedyear) from Books);

-- Lấy ra danh sách các thành viên có ngày tham gia (JoinDate) 
-- nằm trong khoảng từ ‘2020-01-01’ đến ‘2022-12-31’.
select * from Members
where joindate between '2020-01-01' and '2022-12-31';

-- Lấy ra danh sách các tác giả có tên chứa chữ a
select *
from Authors
where authorname like '%a%';

-- Lấy ra danh sách các năm xuất bản (PublishedYear) từ bảng Books mà không bị trùng lặp.
select distinct publishedyear as 'Nam xuat ban'
from Books
-- group by publishedyear;




