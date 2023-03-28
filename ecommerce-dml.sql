-- DML - Data Manipulating Language

-- Endereços
insert into endereco(logradouro, numero, bairro, cep, cidade, uf)
	values ('Rua Springboot', 455,'Centro', '98765432', 'Cidade Tal', 'RP'),
	('Rua dos Java Fans', 1080, 'Centro', '12121244', 'Sao Paulo', 'SP'),
	('SQL street', 10, '12151232','Centro', 'Quixeré', 'CE'),
	('Avenida Java', 19, '12151234','Centro', 'Fortaleza', 'CE'),
	('Travessa DB', 20, '12151235', 'Centro', 'Recife', 'PE');


-- Clientes
insert into cliente (nome, cpf, email) values  
	('Hilario', '01013232544','hilario@email.com'), 
	('Job', '91013232523','job@email.com'),
	('Léo', '01013654544', 'leo@email.com'), 
	('Matheus', '01013654000', 'matheus@email.com'),
	('Hermanoteu', '01013654599', 'hermanoteu@email.com');

-- Cliente / Endereço
insert into cliente_endereco (fk_id_cliente, fk_id_endereco) values 
	(1,3), (2,4), (3,5), (4,1), (5,2);

-- Fornecedores
insert into fornecedor(nome, cnpj, fk_id_endereco) values
	('Só Peça Boa', '01285236998765', 2),
	('Raia Motos', '25896314785274', 5);


-- Produtos
insert into produto(descricao, codigo_barras, valor, fk_id_fornecedor) values 
('Aro Traseiro Aluminio', 'ABC0001', 230,1),
('Conjunto Raios Inox', 'CBA0002', 87,2),
('Conjunto Piscas Broz', 'BCA0003', 50,2),
('Gerador 1kva Gasolina', 'BAC0004', 1299,1),
('Kit chave soquete', 'BBC0005', 160,1);

-- Carrinho dos clientes 
insert into carrinho (fk_id_cliente, fk_id_produto, quantidade, valor, data_insercao) values
	(1,4,1,150, '2023-03-20'),
	(1,6,1,160, '2023-03-21'),
	(1,5,1,1299, '2023-03-23'),
	(3,4,1,150, '2023-03-19'),
	(3,6,1,160, '2023-03-17'),
	(3,5,1,1299, '2023-03-21'),
	(4,4,1,150, '2023-03-15'),
	(4,6,1,160, '2023-03-07'),
	(4,5,1,1299, '2023-03-09'),
	(5,2,1,230, '2023-03-07'),
	(5,3,1,87, '2023-03-09');


-- Cupoms
insert into cupom(data_expiracao, descricao, valor, data_inicio) values
	('2023-04-05', 'Quase ganha 2', 1.99,'2023-03-25'),
	('2023-04-07', 'Ganhe quase 6', 5.99,'2023-03-23'),
	('2023-04-01', 'Quase de graça', 8.99,'2023-03-24');

--Criando relação cliente e cupom
insert into cliente_cupom (fk_id_cliente, fk_id_cupom) values 
	(1,1),(2,2),(3,3);

-- Pedidos
insert into pedido(previsao_entrega, meio_pagamento,status,fk_id_cliente_endereco, data_criacao, fk_id_cliente_cupom) values
	('2023-04-02', 'Dinheiro', 'Em trânsito', 3, '2023-03-03 10:00:00', null),
	('2023-03-29', 'PIX', 'Saiu para entrega', 4, '2023-02-28 10:00:00', 1),
	('2023-04-01', 'PIX', 'Entregue', 5, '2023-03-06 10:00:00', 3),
	('2023-04-13', 'PIX', 'Entregue', 1, '2023-03-11 12:00:00', 3),
	('2023-04-01', 'Cartao', 'Entregue', 2, '2023-03-01 08:00:00', 2),
	('2023-04-18', 'PIX', 'Em preparo', 4, '2023-03-18 11:00:00', null);

-- Atualizando um pedido
update pedido set meio_pagamento = 'Boleto' where id = 3;
update pedido set previsao_entrega  = '2023-04-16' where id = 4;


-- Relacionando pedidos e produtos
insert into item_pedido(fk_id_pedido, fk_id_produto, quantidade, valor, data_insercao) values
	(11,2,4,'460','2023-03-27'), (11,6,2,'320','2023-03-27'),
	(12,3,3,'241','2023-03-27'), (12,6,1,'160','2023-03-27'),
	(7,2,2,'460','2023-03-27'), (7,4,1,'50','2023-03-27'),
	(8,4,1,'50','2023-03-27'), (8,3,1,'87','2023-03-27'),
	(9,4,5,'250','2023-03-27'), (9,2,1,'230','2023-03-27'),
	(10,6,3,'480','2023-03-27'), (10,5,1,'1299','2023-03-27');

-- Definindo endereços pazr os estoques
insert into estoque(nome, fk_id_endereco) values ('Armazem Delta', 2), ('Logistica Zeta',4);
-- Criando relação entre produto e estoque
insert into produto_estoque(fk_id_produto, fk_id_estoque , quantidade) values
	(2,2,11), (3,1,20), (4,2,5), (5,1,15), (6,1,10);

-- Atualizando informações para poder deletar o cliente
update pedido set fk_id_cliente_endereco = 5  where fk_id_cliente_endereco = 2;
update cliente_cupom set fk_id_cliente = 5 where fk_id_cliente = 2;
delete from cliente_endereco  where id = 2;
delete from carrinho  where fk_id_cliente =2;
delete from cliente where id = 2;


-- Atualizando descrição e valor de produto
update produto set descricao = 'Aro Traseiro Aluminio AE', valor ='245' where id = 2;
