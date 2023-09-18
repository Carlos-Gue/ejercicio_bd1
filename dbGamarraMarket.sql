drop database if exists dbGamarraMarket;
create database dbGamarraMarket
default character set utf8;
use dbGamarraMarket;

create table cliente
(
	id int auto_increment,
    tipo_documento char(3),
    numero_documento char(9),
    nombres varchar(60),
    apellidos varchar(90),
    email varchar(80),
    celular char(9),
    fecha_nacimiento date,
    activo bool default('1'),
    constraint cliente_pk primary key (id)
);

create table venta
(
	id int auto_increment,
    fecha_hora timestamp,
    cliente_id int,
    vendedor_id int,
	activo bool default(1),
    constraint venta_pk primary key (id)
);


create table vendedor
(
	id int auto_increment,
    tipo_documento char(3),
    numero_documento char(9),
    nombres varchar(60),
    apellidos varchar(90),
    salario decimal(8,2),
    celular char(9),
    email varchar(80),
    activo bool default(1),
	constraint vendedor primary key (id)
);

create table venta_detalle
(
	id int auto_increment,
    venta_id int,
    prenda_id int,
	cantidad int,
	constraint venta_detalle primary key (id)
);

create table prenda
(
	id int auto_increment,
    descripcion varchar(90),
    marca varchar(60),
    cantidad int,
    talla varchar(10),
    precio decimal(8,2),
    activo bool default(1),
	constraint prenda primary key (id)
);

alter table venta
		add constraint venta_cliente foreign key (cliente_id)
	references cliente (id)
    on update cascade
    on delete cascade
;

alter table venta
		add constraint venta_vendedor foreign key (vendedor_id)
	references vendedor (id)
    on update cascade
    on delete cascade
;

alter table venta_detalle
		add constraint venta_detalle_venta foreign key (venta_id)
	references venta (id)
    on update cascade
    on delete cascade
;

alter table venta_detalle
		add constraint venta_detalle_prenda foreign key (prenda_id)
	references prenda (id)
    on update cascade
    on delete cascade
;

select
	i.constraint_name, k.table_name, k.column_name,
    k.referenced_table_name, k.referenced_column_name
from
	information_schema.table_constraints i
left join information_schema.key_column_usage k
on i.constraint_name = k.constraint_name
where i.constraint_type = 'foreign key'
and i.table_schema = database();