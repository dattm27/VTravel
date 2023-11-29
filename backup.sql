-- tạo cơ sở dữ liệu 
create database vtravel;
use vtravel;

-- tạo bảng account lưu thông tin các tài khoản 
drop table account;
CREATE TABLE account (
id int auto_increment primary key,
email varchar(100) not null unique,
fullname varchar(100),
username varchar(100) character set utf8mb4 not null,
password varchar(100) not null,
status varchar(6),
role varchar(5),
phone_number varchar(10) not null unique
);

-- tạo bảng proposal_custom_tour để lưu các đơn đặt tour đề xuất (người đặt customz_tour gửi)
drop table proposal_custom_tour;
create table proposal_custom_tour(
	id int primary key auto_increment ,
    user_id int not null,
    destination varchar(200),
    start_date DATE,
    end_date DATE,
    number_of_travellers int,
    note TEXT,
    status varchar(10),
    created_date DATETIME default CURRENT_TIMESTAMP,
    foreign key (user_id) references account(id)
);
-- thêm dữ liệu mẫu
insert into account(email, fullname, username, password, status, role, phone_number)
values ('dattran2003.ttn@gmail.com', 'Trần Mạnh Đạt', 'dattm03', 'dattm03', 'active', 'admin' , '0827666910');

select * from account;
select * from proposal_custom_tour;

select cus_tour.id, user_id ,fullname, destination, start_date, end_date, number_of_travellers, note, cus_tour.status, created_date
from proposal_custom_tour as cus_tour join account on cus_tour.user_id = account.id;




