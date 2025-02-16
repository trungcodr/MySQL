create database QuanLySinhVien;
use QuanLySinhVien;

create table lop_hoc (
	id int primary key auto_increment,
    ten_lop varchar(150),
    khoa varchar(100)
);

create table sinh_vien (
	id int primary key auto_increment,
    ten varchar(100),
    lop_hoc_id int,
    foreign key (lop_hoc_id) references lop_hoc(id),
    diem float
);

insert into lop_hoc (ten_lop, khoa) values
('Lap trinh web co ban', 'Backend'),
('Java core','Backend'),
('Co so du lieu', 'Backend'),
('Cau truc du lieu giai thuat', 'Backend'),
('SpringBoot','Backend');

insert into sinh_vien (ten,lop_hoc_id, diem) values
('Nguyen Thanh Trung', 1, 7.5),
('Nguyen Thanh Trung', 3, 8.0),
('Phung Thanh Do', 2, 6.0),
('Phung Thanh Do', 4, 8.5),
('Phung Thanh Do', 5,4.5),
('Lam Dinh Khoa',1,6.8),
('Dinh Van Anh',3, 8.5);

--  2. Viết truy vấn để tìm giá trị điểm lớn nhất của sinh viên.
select sv.*
from sinh_vien sv
where diem = (select max(diem) from sinh_vien);

-- 3. Viết truy vấn để tính giá trị điểm trung bình của sinh viên trong 1 lớp.
delimiter //
create procedure GetAvgScore(in p_lop_hoc_id float)
begin
	select avg(diem) as 'Diem trung binh'
    from sinh_vien
    where lop_hoc_id = p_lop_hoc_id;
end //
delimiter ;
select * from sinh_vien;
call GetAvgScore(1);
call GetAvgScore(3);

/* Viết truy vấn lấy ra thông tin sinh viên gồm điểm, tên lớp, 
tên sinh viên của 1 lớp cụ thể và sắp xếp tên A-Z.*/
delimiter //
create procedure GetInfoStudents(in p_ten_lop varchar(150))
begin
	select sv.diem, lh.ten_lop,sv.ten
    from sinh_vien sv
    join lop_hoc lh
    on sv.lop_hoc_id = lh.id
    where ten_lop = p_ten_lop
    order by sv.ten asc;
    
end //
delimiter ;
drop procedure if exists GetInfoStudents;
call GetInfoStudents ('Co so du lieu');
call GetInfoStudents ('Lap trinh web co ban');

-- 5. Tạo một VIEW để hiển thị danh sách sinh viên có điểm cao nhất trong từng lớp.
create view ViewStudentScoreMax as 
select lh.ten_lop, sv.* 
from sinh_vien sv
join lop_hoc lh
on sv.lop_hoc_id = lh.id
where sv.diem = (select max(sv2.diem) from sinh_vien sv2
				where sv2.lop_hoc_id = sv.lop_hoc_id);
                
select * from ViewStudentScoreMax;

-- 6 a) Lấy danh sách sinh viên có điểm trên một mức chỉ định. Hiển thị thông báo khi không có sinh viên nào.
delimiter //
create procedure GetScoreStudents(in p_diem float)
begin 
	declare checkStudent int;
    
    select count(*) into checkStudent
    from sinh_vien
    where diem > p_diem;
    if (checkStudent = 0) then
		select 'Khong co sinh vien nao' as 'Thong bao';
	else
		select * 
		from sinh_vien
		where diem > p_diem;
    end if;
    
end //
delimiter ; 

drop procedure if exists GetScoreStudents;
 call GetScoreStudents(8.5);

-- b) Cập nhật điểm của một sinh viên dựa trên id. Hiển thị thông báo lỗi, nếu id không tồn tại
delimiter //
create procedure UpdateStudentByID(in p_id int, in p_diem int)
begin
	declare checkId int;
    
    select count(*) into checkId 
    from sinh_vien 
    where id = p_id;
    if (checkId = 0) then
		signal sqlstate '45000' set message_text = 'Id hoc sinh khong ton tai';
	else
		Update sinh_vien
		set diem = p_diem
		where id = p_id;
	end if;
end //
delimiter ;
select * from sinh_vien;
call UpdateStudentByID(1,10);

-- c) Thêm một sinh viên mới vào bảng sinh_vien. nếu tên sinh viên null => hiển thị thông báo lỗi, và không cho update
delimiter //
create procedure AddStudent(in p_ten varchar(100), in p_lop_hoc_id int, in p_diem float)
begin
	
    if  p_ten = '' then
		signal sqlstate '45000' set message_text = 'Ten sinh vien khong duoc de trong';
	else
		insert sinh_vien
        set ten = p_ten, lop_hoc_id = p_lop_hoc_id, diem = p_diem;
     end if;   
end //
delimiter ;
select * from sinh_vien;
call AddStudent('Kim Nhat Thanh',5,9.0);

/* d) Xóa một sinh viên theo id… Hiển thị thông báo
– “Xóa thành công” => Có bản ghi để xóa
– “Xóa không thàn” => Không tìm thấy bản ghi nào để xóa*/
delimiter //
create procedure DeleteStudentById(in p_id int)
begin
	declare indexStudentDelete int;
    delete from sinh_vien
    where id = p_id;
    select row_count() into indexStudentDelete;
    if indexStudentDelete > 0 then
		select 'Xoa thanh cong' as 'Thong bao';
	else
		select 'Khong tim thay ban ghi nao!' as 'Thong bao';
	end if;
end //
delimiter ;

call DeleteStudentById(9);






