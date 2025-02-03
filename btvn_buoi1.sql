use testDB;

create table Person(
	id int auto_increment primary key,
    fullName varchar(50),
    address varchar(50),
    job varchar(50),
    birthday date not null,
    salary decimal
);

insert into Person(id,fullName,address,job,birthday,salary) values
(1, 'Carmella Phebey', 'Czech Republic', 'Architect', '1982-03-16', 4192 ),
(2, 'Cindy O''Neill', 'Ukraine', 'Scientist', '1972-09-10', 3912),
(3, 'Dani Hillyatt', 'Czech Republic', 'Athlete', '1974-02-16', 5095),
(4, 'Laurel Sebrens', 'Indonesia', 'Firefighter', '1950-09-23', 4769),
(5, 'Adelbert Bosanko', 'Jamaica', 'Programmer', '2000-05-22', 3950),
(6, 'Hillary Hinckley', 'Indonesia', 'Doctor', '1963-07-05', 3267),
(7, 'Stacee Reah', 'Finland', 'Photographer', '1963-03-08', 9099),
(8, 'Georas Jiran', 'Poland', 'Designer', '1970-05-03', 9783),
(9, 'Lydon Seals', 'China', 'Carpenter', '1961-02-11', 6979),
(10, 'Maurine Dougan', 'Czech Republic', 'Pilot', '1967-01-07', 3777);

select * from Person;