use QuanLySinhVien;

-- 7.  Viết một trigger tự động cập nhật điểm của sinh viên thành 0 nếu điểm nhập vào nhỏ hơn 0.
DELIMITER //

CREATE TRIGGER before_insert_update_diem
BEFORE INSERT ON sinh_vien
FOR EACH ROW
BEGIN
    -- Kiểm tra nếu điểm nhỏ hơn 0, cập nhật thành 0
    IF NEW.diem < 0 THEN
        SET NEW.diem = 0;
    END IF;
END //

CREATE TRIGGER before_update_diem
BEFORE UPDATE ON sinh_vien
FOR EACH ROW
BEGIN
    -- Kiểm tra nếu điểm cập nhật nhỏ hơn 0, cập nhật thành 0
    IF NEW.diem < 0 THEN
        SET NEW.diem = 0;
    END IF;
END //

DELIMITER ;
INSERT INTO sinh_vien (ten, lop_hoc_id, diem) 
VALUES ('Nguyen Thi Mai', 1, -5);
-- 8.  Viết một trigger ghi log vào bảng log_diem mỗi khi điểm sinh viên bị cập nhật.
create table log_diem (
	id int primary key auto_increment,
    old_diem float,
    new_diem float,
    update_time timestamp default current_timestamp,
    sinh_vien_id int,
    foreign key (sinh_vien_id) references sinh_vien(id)
);

delimiter //
create trigger after_update_diem
after update on sinh_vien
for each row
begin
	if old.diem <> new.diem then
		insert into log_diem(sinh_vien_id,old_diem,new_diem,update_time)
		values (new.id,old.diem,new.diem,now());
    end if;
end //
delimiter ;
-- 9.  Viết một trigger không cho phép xóa lớp học nếu vẫn còn sinh viên trong lớp.
delimiter //
create trigger before_delete_class
before delete on lop_hoc
for each row
begin
	declare check_student int;
    select count(*)  into check_student 
    from sinhvien 
    where lop_hoc_id = old.id;
    
    if check_student > 0 then 
		signal sqlstate '45000' set message_text = 'Khong the xoa lop hoc vi van con hoc sinh';
	end if;
end //
delimiter ;
-- 10. Viết một trigger tự động gán điểm 10 cho sinh viên mới nếu điểm chưa được nhập khi thêm mới.
delimiter //
create trigger before_insert_score
before insert on sinh_vien
for each row
begin
	if new.diem is null then
		set new.diem = 10;
	end if;
end //
delimiter ;

INSERT INTO sinh_vien (ten, lop_hoc_id) 
VALUES ('Ngo Minh Nguyet', 5 );
select * from sinh_vien;
-- 11. Viết một trigger cập nhật điểm trung bình toàn lớp mỗi khi có sinh viên được thêm hoặc sửa điểm.
delimiter //
create trigger after_insert_score_update_avg
after insert on sinh_vien
for each row
begin 
	
end //
delimiter ;