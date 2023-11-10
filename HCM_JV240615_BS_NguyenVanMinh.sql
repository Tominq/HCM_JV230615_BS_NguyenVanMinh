-- tạo db
create
database test;

use
test;

    -- tạo table categories
CREATE TABLE categories
(
    id     INT PRIMARY KEY AUTO_INCREMENT,
    name   VARCHAR(100) NOT NULL UNIQUE,
    status TINYINT DEFAULT 0
);

-- tạo table products
create table products
(
    id          int primary key auto_increment,
    name        varchar(200) not null,
    price       float        not null,
    image       varchar(200),
    category_id int,
    foreign key (category_id) references categories (id)
);

-- tạo table customers
create table customers
(
    id       int primary key auto_increment,
    name     varchar(100) not null,
    email    varchar(100) not null unique,
    image    varchar(200),
    birthday date,
    gender   tinyint
);

-- tạo table orders
create table orders
(
    id          int primary key auto_increment,
    customer_id int,
    created     timestamp default current_timestamp,
    status      tinyint   default 0,
    foreign key (customer_id) references customers (id)
);

-- tạo table orders detalis
create table order_details
(
    order_id   int,
    product_id int,
    quantity   int   not null,
    price      float not null,
    foreign key (order_id) references orders (id),
    foreign key (product_id) references products (id)
);

-- thêm dữ liệu vào các bảng
insert into categories (name, status)
values ('Áo', 1),
       ('Quân', 1),
       ('Mü', 1),
       ('Giày', 1);

insert into products (name, category_id, price)
values ('Áo sơ mi', 1, 150000),
       ('Áo khoác dạ', 1, 500000),
       ('Quần Kaki', 2, 200000),
       ('Giầy tây', 4, 1000000),
       ('Mũ bảo hiểm A1', 3, 100000);

insert into customers (name, email, birthday, gender)
values ('Nguyễn Minh Khôi', 'khoi@gmail.com', '2021-12-21', 1),
       ('Nguyễn Khánh Linh', 'linh@gmail.com', '2001-12-12', 0),
       ('Đỗ Khánh Linh', 'linh2@gmail.com', '1999-01-01', 0);

insert into orders (customer_id, created, status)
values (1, '2023-11-08', 0),
       (2, '2023-11-09', 0),
       (1, '2023-11-09', 0),
       (3, '2023-11-09', 0);

insert into order_details (order_id, product_id, quantity, price)
values (1, 1, 1, 149000),
       (1, 2, 1, 499000),
       (2, 2, 2, 499000),
       (3, 2, 1, 499000),
       (4, 1, 1, 149000);

-- 1. Hiển thị danh sách danh mục gồm id,name,status
select id, name, status
from categories;

-- 2. Hiển thị danh sách sản phẩm gồm id,name,price,sale_price,category_name(tên
-- danh mục)
select p.id, p.name, p.price, c.name as category_name
from products p
         join categories c on c.id = p.category_id;


-- 3. Hiển thị danh sách sản phẩm có giá lớn hơn 200000
select id, name, price
from products
where price > 200000;


-- 4. Hiển thị 3 sản phẩm có giá cao nhất
select id, name, price
from products
order by price desc limit 3;

-- 5. Hiển thị danh sách đơn hàng gồm id,customer_name,created,status.
select o.id, c.id as cusid, created, status, c.name as customer_name
from orders o
         join customers c on o.customer_id = c.id;

-- Cập nhật trạng thái đơn hàng có id là 1
update orders
set status = 1
where id = 1;

-- Hiển thị chi tiết đơn hàng của đơn hàng có id là 1, bao gồm
-- order_id,product_name,quantity,price,total_money là giá trị của (price * quantity)
select od.order_id as order_id, od.quantity, od.price, od.quantity * od.price as total_money, p.name as product_name
from order_details od
         join products p on p.id = od.product_id
where od.order_id = 1;

-- Danh sách danh mục gồm, id,name, quantity_product(đếm trong bảng product) (20đ)
select c.id, c.name, count(p.id) as quantity_produc
from categories c
         left join products p on c.id = p.category_id
group by c.id, c.name;