-- DDL - Data Definition Language

create schema projeto_parte_1;

create table endereco (
	id serial not null primary key,
	cep char(8) not null,
	logradouro varchar(1000) not null,
	numero varchar(30) not null,
	bairro varchar(200) not null,
	cidade varchar(200) not null,
	uf char(2)
	);
	
create table cliente(
	id serial not null primary key,
	nome varchar(895) not null,
	cpf char(11) unique not null,
	email varchar(500) not null
	);
	
create table cupom( 
	id serial not null primary key,
	descricao varchar(1000) not null,
	valor numeric not null,
	data_inicio timestamp not null,
	data_expiracao timestamp not null
	);

create table cliente_cupom( 
	id serial primary key not null,
	fk_id_cliente int not null,
	fk_id_cupom int not null,
	foreign key (fk_id_cliente) references cliente,
	foreign key (fk_id_cupom) references cupom
	);

create table cliente_endereco( 
	id serial primary key not null,
	fk_id_cliente int not null,
	fk_id_endereco int not null,
	foreign key (fk_id_cliente) references cliente,
	foreign key (fk_id_endereco) references endereco	
);

create table pedido (
	id serial primary key not null,
	previsao_entrega date not null,
	meio_pagamento varchar(200) not null,
	status varchar(100) not null,
	data_criacao timestamp not null,
	fk_id_cliente_endereco int not null,
	fk_id_cliente_cupom int,
	foreign key (fk_id_cliente_endereco) references cliente_endereco,
	foreign key (fk_id_cliente_cupom) references cliente_cupom
	);

create table estoque(
	id serial primary key not null,
	nome varchar(1000) not null,
	fk_id_endereco int unique not null,
	foreign key (fk_id_endereco) references endereco
	);

create table fornecedor(
	id serial primary key not null,
	nome varchar (1000) not null,
	cnpj varchar (14) unique not null,
	fk_id_endereco int not null,
	foreign key (fk_id_endereco) references endereco
	);

create table produto(
	id serial primary key not null,
	descricao varchar(1000) not null,
	codigo_barras varchar(44) unique not null,
	valor numeric not null,
	fk_id_fornecedor int not null,
	foreign key (fk_id_fornecedor) references fornecedor
	);

create table produto_estoque(
	fk_id_produto int not null,
	fk_id_estoque int not null,
	quantidade int not null,
	constraint pk_produto_estoque primary key (fk_id_produto, fk_id_estoque),
	foreign key (fk_id_produto) references produto,
	foreign key (fk_id_estoque) references estoque
	);

create table carrinho(
	id serial primary key not null,
	fk_id_cliente int not null,
	fk_id_produto int not null,
	quantidade int not null,
	valor numeric not null,
	data_insercao timestamp not null,
	foreign key (fk_id_cliente) references cliente,
	foreign key (fk_id_produto) references produto
	);

create table item_pedido(
	fk_id_pedido int not null,
	fk_id_produto int not null,
	quantidade int not null,
	valor numeric not null,
	data_insercao timestamp not null,
	constraint pk_pedido_produto primary key (fk_id_pedido, fk_id_produto),
	foreign key (fk_id_pedido) references pedido,
	foreign key (fk_id_produto) references produto
	);










































