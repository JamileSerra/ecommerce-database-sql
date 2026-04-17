# 🛒 Projeto Lógico de Banco de Dados para E-commerce

## 📌 Descrição do Projeto

Este projeto consiste na modelagem lógica e implementação de um banco de dados para um cenário de e-commerce, utilizando MySQL.

Foram criadas as tabelas, definidas chaves primárias e estrangeiras, aplicadas constraints e inseridos dados para testes. Além disso, foram desenvolvidas consultas SQL para análise das informações.

---

## 🎯 Objetivo do Desafio

Replicar a modelagem de um sistema de e-commerce e aplicar refinamentos, incluindo:

* Estrutura de clientes, pedidos, produtos, fornecedores e vendedores;
* Relacionamentos entre entidades (incluindo N:N);
* Múltiplas formas de pagamento por cliente;
* Implementação de regras de negócio com constraints;
* Criação de queries SQL utilizando:

  * SELECT
  * WHERE
  * atributos derivados
  * ORDER BY
  * HAVING
  * JOIN

---

## 🧱 Estrutura do Banco de Dados

Banco criado:

```
ecommerce_v2
```

### Principais tabelas:

* `clients`
* `product`
* `payment`
* `orders`
* `productStorage`
* `supplier`
* `seller`
* `productSeller`
* `productOrder`
* `storageLocation`
* `productSupplier`

---

## ⚙️ Regras de Negócio Implementadas

* Cada cliente possui CPF único;
* Um vendedor pode ser **PF ou PJ**, mas não ambos simultaneamente (constraint CHECK);
* Um cliente pode possuir **múltiplas formas de pagamento** (chave primária composta em `payment`);
* Produtos estão relacionados a fornecedores, vendedores, pedidos e estoque;
* O modelo utiliza tabelas associativas para representar relacionamentos N:N;
* Foi implementado controle de entrega com:

  * `deliveryStatus`
  * `trackingCode`

---

## 🧩 Modelagem

O banco contempla:

* Relacionamentos 1:N (clientes → pedidos)
* Relacionamentos N:N (produtos ↔ fornecedores, produtos ↔ vendedores, produtos ↔ pedidos)
* Integridade referencial com chaves estrangeiras
* Uso de `ENUM`, `DEFAULT` e `CHECK`

---

## 💾 Estrutura do Projeto

```
ecommerce-v2/
├── schema.sql
├── insert_data.sql
├── queries.sql
└── README.md
```

---

## 🔍 Consultas Desenvolvidas

Foram criadas consultas para responder perguntas como:

* Quantos pedidos foram feitos por cada cliente?
* Algum vendedor também é fornecedor?
* Relação entre produtos, fornecedores e estoque;
* Relação entre nomes de fornecedores e produtos;
* Produtos ordenados por avaliação;
* Clientes com filtros específicos;
* Agrupamentos utilizando HAVING;
* Status de entrega e código de rastreio dos pedidos;

---

## 📊 Exemplos de Queries

### Quantidade de pedidos por cliente

```sql
select 
    c.idClient,
    c.Fname,
    count(o.idOrder) as Number_of_orders
from clients c
inner join orders o on c.idClient = o.idOrderClient
group by c.idClient, c.Fname;
```

---

### Relação entre fornecedores e produtos

```sql
select 
    s.SocialName as Fornecedor,
    p.Pname as Produto
from supplier s
inner join productSupplier ps on s.idSupplier = ps.idPsSupplier
inner join product p on ps.idPsProduct = p.idProduct;
```

---

### Vendedor que também é fornecedor

```sql
select 
    sel.socialName as Vendedor,
    sup.SocialName as Fornecedor,
    sel.cnpj
from seller sel
inner join supplier sup on sel.cnpj = sup.CNPJ;
```

---

### Status de entrega dos pedidos

```sql
select 
    idOrder,
    idOrderClient,
    deliveryStatus,
    trackingCode
from orders;
```

---

## 🧠 Aprendizados

Durante o desenvolvimento deste projeto, foram praticados:

* Modelagem lógica de banco de dados;
* Criação de tabelas com relacionamentos;
* Uso de chave primária e estrangeira;
* Aplicação de constraints;
* Manipulação de dados com INSERT e UPDATE;
* Criação de consultas SQL com diferentes cláusulas;
* Uso de JOIN para análise de dados;
* Agrupamento de dados com GROUP BY e HAVING;

---

## 🚀 Tecnologias Utilizadas

* MySQL
* MySQL Workbench

---

💡 Projeto desenvolvido para fins de estudo.

👩‍💻 Autoria: Jamile Alves Serra
