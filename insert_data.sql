-- Inserção de dados para testes no projeto ecommerce_v2
use ecommerce_v2;

-- CLIENTS
insert into clients (Fname, Minit, Lname, CPF, Address)
values 
					('Maria','M','Silva','12345678901','rua silva de prata 29, Carangola - Cidade das flores'),
					('Matheus','O','Pimentel','98765432101','rua alameda 289, Centro - Cidade das flores'),
					('Ricardo','F','Silva','45678912301','avenida alameda vinha 1009, Centro - Cidade das flores'),
					('Julia','S','França','78912345601','rua laranjeiras 861, Centro - Cidade das flores'),
					('Roberta','G','Assis','98745632101','avenida koller 19, Centro - Cidade das flores'),
					('Isabela','M','Cruz','65478912301','rua alameda das flores 28, Centro - Cidade das flores');

-- PRODUCT
insert into product (Pname, classification_kids, category, avaliacao, size) values
					('Fone de ouvido', false, 'Eletrônico', 4.50, null),
					('Barbie Elsa', true, 'Brinquedos', 3.00, null),
					('Body Carters', true, 'Vestimenta', 5.00, null),
					('Microfone Vedo - Youtuber', false, 'Eletrônico', 4.20, null),
					('Sofá retrátil', false, 'Móveis', 3.80, '3x57x80'),
					('Farinha de arroz', false, 'Alimentos', 2.50, null),
					('Fire Stick Amazon', false, 'Eletrônico', 3.70, null),
					('Livro SQL para Iniciantes', false, 'Livros', 4.90, null);

-- PAYMENT
insert into payment (idClient, idPayment, typePayment, limitAvailable) values
					(1, 1, 'Cartão', 1500.00),
					(2, 1, 'PIX', null),
					(3, 1, 'Boleto', null),
					(4, 1, 'Cartão', 2000.00);

-- ORDERS
insert into orders (idOrderClient, idPayment, orderStatus, orderDescription, sendValue, paymentCash) values
				   (1, 1, default, 'compra via aplicativo', null, 1),
				   (2, 1, default, 'compra via aplicativo', 50, 0),
				   (3, 1, 'Confirmado', null, null, 1),
				   (4, 1, default, 'compra via web site', 150, 0);

-- PRODUCT ORDER
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
						 (1, 1, 2, null),
						 (2, 1, 1, null),
						 (3, 2, 1, null);

-- PRODUCT STORAGE
insert into productStorage (storageLocation, quantity) values
						   ('Rio de Janeiro', 1000),
						   ('Rio de Janeiro', 500),
						   ('São Paulo', 10),
						   ('São Paulo', 100),
						   ('São Paulo', 10),
						   ('Brasília', 60);

-- STORAGE LOCATION
insert into storageLocation (idLproduct, idLstorage, location) values
							(1, 2, 'RJ'),
							(2, 6, 'GO');

-- SUPPLIER
insert into supplier (SocialName, CNPJ, contact) values
					 ('Almeida e filhos', '12345678912345', '21985474'),
					 ('Eletrônicos Silva', '85451964914345', '21985484'),
					 ('Eletrônicos Valma', '93456789393460', '21975474');

-- PRODUCT SUPPLIER
insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
							(1, 1, 500),
							(1, 2, 400),
							(2, 4, 633),
							(3, 3, 5),
							(2, 5, 10);

-- SELLER
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values
				   ('Tech electronics', null, '12345678945632', null, 'Rio de Janeiro', '219946287'),
				   ('Boutique Durgas', null, null, '12345678345', 'Rio de Janeiro', '219567895'),
				   ('Kids World', null, '45678912365445', null, 'São Paulo', '198657484');

-- PRODUCT SELLER
insert into productSeller (idPseller, idPproduct, prodQuantity) values
						  (1, 6, 80),
						  (2, 7, 10);


-- ATUALIZAÇÃO: status de entrega e código de rastreio
update orders set 
deliveryStatus = 'Enviado',
trackingCode = 'BR123456789'
where idOrder = 1;

update orders set 
deliveryStatus = 'Entregue',
trackingCode = 'BR987654321'
where idOrder = 2;

update orders set 
deliveryStatus = 'Pendente',
trackingCode = null
where idOrder = 3;

update orders set 
deliveryStatus = 'Enviado',
trackingCode = 'BR555666777'
where idOrder = 4;