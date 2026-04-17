use ecommerce_v2;

-- 1) Recuperação simples com SELECT
select * from clients;

-- 2) Filtro com WHERE
select *
from product
where category = 'Eletrônico';

-- 3) Expressão para atributo derivado
select 
    idClient,
    concat(Fname, ' ', Lname) as Nome_Completo,
    CPF
from clients;

-- 4) ORDER BY
select 
    idProduct,
    Pname,
    category,
    avaliacao
from product
order by avaliacao desc;

-- 5) JOIN entre tabelas
select 
    c.idClient,
    concat(c.Fname, ' ', c.Lname) as Cliente,
    o.idOrder,
    o.orderStatus,
    o.orderDescription
from clients c
inner join orders o on c.idClient = o.idOrderClient;

-- 6) Quantos pedidos foram feitos por cada cliente?
select 
    c.idClient,
    c.Fname,
    count(o.idOrder) as Number_of_orders
from clients c
inner join orders o on c.idClient = o.idOrderClient
group by c.idClient, c.Fname;

-- 7) Produtos com seus fornecedores
select 
    p.Pname as Produto,
    s.SocialName as Fornecedor,
    ps.quantity as Quantidade_Fornecedor
from product p
inner join productSupplier ps on p.idProduct = ps.idPsProduct
inner join supplier s on ps.idPsSupplier = s.idSupplier;

-- 8) Relação de produtos e estoques
select 
    p.Pname as Produto,
    ps.storageLocation as Local_Estoque,
    ps.quantity as Quantidade
from product p
inner join storageLocation sl on p.idProduct = sl.idLproduct
inner join productStorage ps on sl.idLstorage = ps.idProdStorage;

-- 9) Fornecedores e produtos cadastrados
select 
    s.SocialName as Fornecedor,
    p.Pname as Produto
from supplier s
inner join productSupplier ps on s.idSupplier = ps.idPsSupplier
inner join product p on ps.idPsProduct = p.idProduct
order by s.SocialName;

-- 10) Algum vendedor também é fornecedor?
select 
    sel.socialName as Vendedor,
    sup.SocialName as Fornecedor,
    sel.cnpj
from seller sel
inner join supplier sup on sel.cnpj = sup.CNPJ;

-- 11) Clientes com mais de 1 pedido
select 
    c.idClient,
    c.Fname,
    count(o.idOrder) as Total_Pedidos
from clients c
inner join orders o on c.idClient = o.idOrderClient
group by c.idClient, c.Fname
having count(o.idOrder) > 1;

-- 12) Pedidos com valor de frete maior que 40
select 
    idOrder,
    idOrderClient,
    sendValue
from orders
where sendValue > 40
order by sendValue desc;

-- 13) Produtos vendidos por vendedores
select 
    se.socialName as Vendedor,
    p.Pname as Produto,
    ps.prodQuantity as Quantidade
from seller se
inner join productSeller ps on se.idSeller = ps.idPseller
inner join product p on ps.idPproduct = p.idProduct;

-- 14) Quantidade de produtos por categoria
select 
    category,
    count(*) as Total_Produtos
from product
group by category
order by Total_Produtos desc;

-- 15) Pagamentos cadastrados por cliente
select 
    c.idClient,
    concat(c.Fname, ' ', c.Lname) as Cliente,
    p.typePayment as Tipo_Pagamento,
    p.limitAvailable
from clients c
inner join payment p on c.idClient = p.idClient;

-- 16) Status de entrega e código de rastreio dos pedidos
select 
    idOrder,
    idOrderClient,
    deliveryStatus,
    trackingCode
from orders
order by idOrder;