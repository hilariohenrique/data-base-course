-- 1 Listar todos os cliente que tem o nome 'ANA'.> Dica: Buscar sobre função Like

select * from cliente c where c.nome like 'ana%';
select * from cliente c where c.nome like '%ana';
select * from cliente c where c.nome ilike '%ana%';
select * from cliente c where c.nome ilike '%ana%Lo%';

-- 2 Pedidos feitos em 2023

select * from pedido p where p.data_criacao >= '2023-01-01' and p.data_criacao <= '2023-12-31';
select * from pedido p where p.data_criacao between '2023-01-01' and '2023-12-31';
select * from pedido p where p.data_criacao between 
	to_date('01-01-2023', 'DD-MM-YYYY') and 
	to_date('31-12-2023', 'DD-MM-YYYY');
	
--3 Pedidos feitos em Janeiro de qualquer ano

select *from pedido p where to_char(p.data_criacao, 'MM') = '01';

--4 Itens de pedido com valor entre R$2 e R$5
select * from item_pedido ip  where ip.valor between 2 and 5;

-- 5 Trazer o Item mais caro comprado em um pedido
select max(valor) from item_pedido ip ;

--6 Listar todos os status diferentes de pedidos
select distinct status from pedido p;

-- 7 Listar o maior, menor e valor médio dos produtos disponíveis.
select max(valor), min(valor), avg(valor) from produto p;

--8 Listar fornecedores com os dados: nome, cnpj, logradouro, numero, 
-- cidade e uf de todos os fornecedores;
select f.nome, f.cnpj, e.logradouro , e.numero , e.cidade , e.uf 
from endereco e ,fornecedor f
where e.id = f.id_endereco ;

--9 Informações de produtos em estoque com os dados: id do estoque, 
-- descrição do produto, quantidade do produto no estoque, logradouro, 
-- numero, cidade e uf do estoque;

select ie.id_estoque , p.descricao, ie.quantidade, e.logradouro , e.numero , 
e.cidade , e.uf
from item_estoque ie, estoque est, endereco e, produto p 
where ie.id_estoque = est.id 
and est.id_endereco = e.id 
and ie.id_produto = p.id;


/* 10 Informações sumarizadas de estoque de produtos com os dados: 
descrição do produto, código de barras, quantidade total do produto 
em todos os estoques;*/

select p.descricao, p.codigo_barras, sum(ie.quantidade) qtd_todos_estoques 
from produto p, item_estoque ie
where p.id = ie.id_produto 
group by p.descricao, p.codigo_barras;

/*11 Informações do carrinho de um cliente específico 
 * (cliente com cpf '26382080861') com os dados: 
 * descrição do produto, quantidade no carrinho, valor do produto.
*/

select p.descricao , ic.quantidade, p.valor  
from item_carrinho ic, cliente c, produto p
 where c.cpf = '26382080861'
 and ic.id_produto = p.id 
 and  ic.id_cliente  = c.id;

/*12 Relatório de quantos produtos diferentes cada cliente tem 
 * no carrinho ordenado pelo cliente que tem mais produtos no 
 * carrinho para o que tem menos, com os dados: id do cliente, 
 * nome, cpf e quantidade de produtos diferentes no carrinho.*/

select c.id, c.nome, c.cpf , count(*) produtos_carrinho 
from item_carrinho ic, cliente c 
 where ic.id_cliente  = c.id
group by c.id, c.nome, c.cpf
order by produtos_carrinho desc;

/*13 - Relatório com os produtos que estão em um carrinho a 
 * mais de 10 meses, ordenados pelo inserido a mais tempo, 
 * com os dados: id do produto, descrição do produto, data 
 * de inserção no carrinho, id do cliente e nome do cliente;
*/

select p.id, p.descricao, ic.data_insercao, c.id, c.nome  
from produto p, item_carrinho ic, cliente c
where ic.data_insercao <= current_date - interval '10 months'
and c.id = ic.id_cliente 
and ic.id_produto = p.id
order by ic.data_insercao asc;






