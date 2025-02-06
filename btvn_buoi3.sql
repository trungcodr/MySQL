use testDB;

create table Students1(
	student_id int primary key,
    student_name varchar(100),
    student_age int
);

create table Courses(
	course_id int primary key,
    course_name varchar(100),
    course_description varchar(200)
);

create table Enrollments(
	enrollment_id int primary key auto_increment,
    student_id int,
    course_id int,
    foreign key ( student_id) references Students1(student_id),
    foreign key (course_id) references Courses(course_id)
);

insert into Students1(student_id, student_name, student_age) values 
(1, 'Nguyen Thanh Trung', 23),
(2, 'Nguyen Thanh Tung', 15),
(3, 'Ta Dinh Thuong', 10),
(4, 'Tran Phuc Nguyen', 40),
(5, 'Phung Thanh Do', 5),
(6, 'Lam Dinh Khoa', 20);
insert into Courses (course_id, course_name, course_description) values
(1, 'Web co ban','html,css'),
(2,'Java co ban','Java core'),
(3,'Co so du lieu', 'MySQL'),
(4,'Thuat toan','Data Al'),
(5,'FrameWork','SrpingBoot');

insert into Enrollments ( student_id, course_id) values
(1,1),
(1,3),
(2,4),
(3,5),
(3,3),
(4,5),
(4,1),
(5,4);

-- Bài tập 1: Lấy danh sách tất cả sinh viên và thông tin khóa học mà họ đã đăng ký.
select s1.*, c.*
from Enrollments e
join Students1 s1 on s1.student_id = e.student_id
join Courses c on c.course_id = e.course_id;

-- Bài tập 2: Lấy tên của tất cả các khóa học mà một sinh viên cụ thể đã đăng ký (sử dụng tham số student_id). 
select c.course_name, s1.student_name
from Students1 s1
join Enrollments e on s1.student_id = e.student_id
join Courses c on c.course_id = e.course_id
where s1.student_id = 1;

-- Bài tập 3: Lấy danh sách tất cả sinh viên và số lượng khóa học mà họ đã đăng ký.
select s1.student_name, count(e.enrollment_id) as 'So luong khoa hoc dang ky'
from Students1 s1
left join Enrollments e on s1.student_id = e.student_id
group by s1.student_id;

-- Bài tập 4: Lấy tất cả các khóa học mà chưa có sinh viên nào đăng ký.
select c.* 
from Courses c
left join Enrollments e on c.course_id = e.course_id
where e.course_id is null;

-- Bài tập 5: Lấy tất cả sinh viên và thông tin khóa học mà họ đã đăng ký, sắp xếp theo tên sinh viên và tên khóa học.
select s1.student_name, c.*
from Enrollments e
join Students1 s1 on s1.student_id = e.student_id
join Courses c on c.course_id = e.course_id
order by s1.student_name asc, c.course_name asc;

-- Bài tập 6: Lấy tất cả các sinh viên và thông tin của họ, cùng với tên khóa học mà họ đăng ký (nếu có).
select s1.*, c.course_name
from Students1 s1
left join Enrollments e on e.student_id = s1.student_id
left join Courses c on c.course_id = e.course_id;

--  Bài tập 7: Lấy danh sách tất cả sinh viên và thông tin của họ, cùng với tên khóa học mà họ đăng ký (nếu có). 
-- Sắp xếp theo tên sinh viên và tuổi từ cao xuống thấp.
select s1.*, c.course_name
from Students1 s1
left join Enrollments e on e.student_id = s1.student_id
left join Courses c on c.course_id = e.course_id
order by s1.student_age desc;

-- Bài tập 8: Lấy tất cả các khóa học và số lượng sinh viên đã đăng ký vào mỗi khóa học.
select c.course_name, count(s1.student_id)
from Courses c
left join Enrollments e on c.course_id = e.course_id
left join Students1 s1 on s1.student_id = e.student_id
group by c.course_name;












