-- Criação do banco/meu primeiro projeto
create database ecommerce_v2;
use ecommerce_v2;

-- CLIENTE
create table clients (
    idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    address varchar(255),
    constraint unique_cpf_client unique (CPF)
);


-- PRODUTO
create table product (
    idProduct int auto_increment primary key,
    Pname varchar(100) not null,
    classification_kids bool default false,
    category enum('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Livros', 'Móveis') not null,
    avaliacao decimal(4,2) default 0,
    size varchar(10)
);


-- PAGAMENTO
create table payment (
    idClient int,
    idPayment int,
    typePayment enum('Boleto', 'PIX', 'Cartão', 'Dois Cartões'),
    limitAvailable decimal(10,2),
    primary key (idClient, idPayment),

    constraint fk_payment_client
        foreign key (idClient) references clients(idClient)
);

-- PEDIDO
create table orders (
    idOrder int auto_increment primary key,
    idOrderClient int,
    idPayment int,
    orderStatus enum('Cancelado', 'Confirmado', 'Em Processamento') default 'Em Processamento',
    orderDescription varchar(255),
    sendValue decimal(10,2) default 10.00,
    paymentCash bool default false,

    constraint fk_orders_client
        foreign key (idOrderClient) references clients(idClient),

    constraint fk_orders_payment
        foreign key (idOrderClient, idPayment)
        references payment(idClient, idPayment)
);


-- ESTOQUE
create table productStorage (
    idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);

alter table productStorage auto_increment = 1;

-- FORNECEDOR
create table supplier (
    idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(14) not null,
    contact varchar(15) not null,
    constraint unique_supplier unique (CNPJ)
);


-- VENDEDOR
create table seller (
    idSeller int auto_increment primary key,
    socialName varchar(255) not null,
    abstName varchar(255),
    cnpj char(14),
    cpf char(11),
    location varchar(255),
    contact varchar(15) not null,

    constraint unique_cnpj_seller unique (cnpj),
    constraint unique_cpf_seller unique (cpf),

    constraint chk_seller_cpf_or_cnpj
        check (
            (cnpj is not null and cpf is null) or
            (cnpj is null and cpf is not null)
        )
);


-- PRODUTO / VENDEDOR
create table productSeller (
    idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),

    constraint fk_productseller_seller
        foreign key (idPseller) references seller(idSeller),

    constraint fk_productseller_product
        foreign key (idPproduct) references product(idProduct)
);

-- PRODUTO / PEDIDO
create table productOrder (
    idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),

    constraint fk_productorder_product
        foreign key (idPOproduct) references product(idProduct),

    constraint fk_productorder_order
        foreign key (idPOorder) references orders(idOrder)
);

-- PRODUTO EM ESTOQUE
create table storageLocation (
    idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),

    constraint fk_storagelocation_product
        foreign key (idLproduct) references product(idProduct),

    constraint fk_storagelocation_storage
        foreign key (idLstorage) references productStorage(idProdStorage)
);

-- PRODUTO FORNECEDOR
create table productSupplier (
    idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),

    constraint fk_product_supplier_supplier
        foreign key (idPsSupplier) references supplier(idSupplier),

    constraint fk_product_supplier_product
        foreign key (idPsProduct) references product(idProduct)
);


-- ALTERAÇÃO: adicionar informações de entrega
alter table orders
add column deliveryStatus enum('Pendente', 'Enviado', 'Entregue') default 'Pendente',
add column trackingCode varchar(20);
