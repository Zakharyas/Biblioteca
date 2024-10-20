create database Loja default character set utf8 default collate utf8_general_ci;

use Loja;

create table Estado(
Id int primary key auto_increment,
nome varchar(30) not null,
UF varchar(2) not null
);

create table Municipio(
ID int primary key auto_increment,
estadoID int not null,
nome varchar(30) not null,
ibge int not null,
foreign key (estadoID) references Estado(ID)
);

create table Cliente(
ID int primary key auto_increment,
nome varchar(30) not null,
cpf varchar(11) not null,
celular varchar(11) not null,
endereco varchar(50) not null,
numero varchar(4) not null,
municipio int not null,
cep char(8) not null,
fk_municipio_id int not null,
foreign key (fk_municipio_id) references Municipio(ID)
);

create table ContaReceber(
ID int primary key auto_increment,
fk_cliente int not null,
fatura int not null,
dataConta date not null,
vencimento date not null,
valor decimal(18,2) not null,
situacao enum ('1', '2', '3') not null,
foreign key (fk_cliente) references Cliente(ID)
);

insert into Estado (nome, UF) values
('Piauí', 'PI'),
('Ceará', 'CE'),
('Rio Grande do Norte', 'RN');

select * from Estado;

insert into Municipio (estadoID, nome, ibge) values
(1, 'Teresina', 2211001),
(2, 'Fortaleza', 2304400),
(3, 'Natal', 2408102);

select * from Municipio;

insert into Cliente (nome, cpf, celular, endereco, numero, municipio, fk_municipio_id, cep) values
('Samuel Soares', '1234567891', '19876543', 'rua A', '1', 1, 1, '20215889'),
('Ana Tenório', '0549265877', '29876325', 'rua B', '2', 2, 2, '20060711'),
('Nicole Yasmin', '01632896715', '94263889', 'rua C', '3', 3, 3, '20500508');

select * from Cliente;

insert into ContaReceber (fk_cliente, fatura, dataConta, vencimento, valor, situacao) values
(1, 105, '2024-08-04', '2025-05-12', 100.00, '1'),
(2, 103, '2024-01-10', '2026-06-03', 200.00, '2'),
(3, 108, '2024-02-07', '2025-01-05', 300.00, '3');

select * from ContaReceber;

create view ContasNaoPagas as select CR.ID as 'ID da conta a receber', C.nome as 'Nome do Cliente',
C.cpf as 'CPF do cliente', CR.vencimento as 'Data de vencimento', CR.valor as 'Valor da conta'
from ContaReceber CR
join Cliente C on fk_cliente = C.ID 
where CR.situacao = '1';

select * from ContasNaoPagas;

/*											Relatório:	

1. Criação do Banco de Dados "Loja"

Primeiramente, criei o banco de dados denominado "Loja" com o conjunto de caracteres 
padrão como utf8 e a collation utf8_general_ci. Isso garante que o banco de dados suporte 
caracteres acentuados e diferentes idiomas.

create database Loja default character set utf8 default collate utf8_general_ci;
use Loja;

2. Estrutura das Tabelas
2.1. Tabela Estado

A tabela Estado foi criada para armazenar as informações sobre os estados. Ela contém três colunas:

    Id: Um identificador único auto-incremental.
    nome: O nome do estado.
    UF: A sigla do estado.

create table Estado(
Id int primary key auto_increment,
nome varchar(30) not null,
UF varchar(2) not null
);

2.2. Tabela Municipio

A tabela Municipio foi criada para armazenar as cidades, com um relacionamento direto
 com a tabela Estado:

    ID: Um identificador único auto-incremental.
    estadoID: Um identificador que referencia a tabela Estado.
    nome: O nome do município.
    ibge: O código IBGE do município.

create table Municipio(
ID int primary key auto_increment,
estadoID int not null,
nome varchar(30) not null,
ibge int not null,
foreign key (estadoID) references Estado(ID)
);

2.3. Tabela Cliente

A tabela Cliente foi criada para armazenar os dados dos clientes. Esta tabela possui as 
seguintes colunas:

    ID: Um identificador único auto-incremental.
    nome, cpf, celular, endereco, numero, cep: Informações básicas do cliente.
    fk_municipio_id: Uma chave estrangeira que referencia o município do cliente.

create table Cliente(
ID int primary key auto_increment,
nome varchar(30) not null,
cpf varchar(11) not null,
celular varchar(11) not null,
endereco varchar(50) not null,
numero varchar(4) not null,
municipio int not null,
cep char(8) not null,
fk_municipio_id int not null,
foreign key (fk_municipio_id) references Municipio(ID)
);

2.4. Tabela ContaReceber

A tabela ContaReceber foi criada para gerenciar as contas a receber dos clientes:

    ID: Identificador único auto-incremental.
    fk_cliente: Chave estrangeira que referencia o cliente.
    fatura, dataConta, vencimento, valor: Informações financeiras da conta.
    situacao: A situação da conta, definida como '1' (não paga), '2' (paga parcialmente),
    '3' (paga totalmente).

create table ContaReceber(
ID int primary key auto_increment,
fk_cliente int not null,
fatura int not null,
dataConta date not null,
vencimento date not null,
valor decimal(18,2) not null,
situacao enum ('1', '2', '3') not null,
foreign key (fk_cliente) references Cliente(ID)
);

3. Inserção de Dados

Inseri dados iniciais nas tabelas para testar e validar a estrutura do banco de dados.
3.1. Inserção de Estados

insert into Estado (nome, UF) values
('Piauí', 'PI'),
('Ceará', 'CE'),
('Rio Grande do Norte', 'RN');

3.2. Inserção de Municípios

insert into Municipio (estadoID, nome, ibge) values
(1, 'Teresina', 2211001),
(2, 'Fortaleza', 2304400),
(3, 'Natal', 2408102);

3.3. Inserção de Clientes

insert into Cliente (nome, cpf, celular, endereco, numero, municipio, fk_municipio_id, cep) values
('Samuel Soares', '1234567891', '19876543', 'rua A', '1', 1, 1, '20215889'),
('Ana Tenório', '0549265877', '29876325', 'rua B', '2', 2, 2, '20060711'),
('Nicole Yasmin', '01632896715', '94263889', 'rua C', '3', 3, 3, '20500508');

3.4. Inserção de Contas a Receber

insert into ContaReceber (fk_cliente, fatura, dataConta, vencimento, valor, situacao) values
(1, 105, '2024-08-04', '2025-05-12', 100.00, '1'),
(2, 103, '2024-01-10', '2026-06-03', 200.00, '2'),
(3, 108, '2024-02-07', '2025-01-05', 300.00, '3');

4. Criação da Visão "ContasNaoPagas"

Para facilitar a consulta das contas a receber que ainda não foram pagas, criei uma visão 
chamada ContasNaoPagas. Esta visão retorna informações essenciais, como o ID da conta, o nome 
e CPF do cliente, a data de vencimento e o valor da conta.

create view ContasNaoPagas as 
select CR.ID as 'ID da conta a receber', 
       C.nome as 'Nome do Cliente',
       C.cpf as 'CPF do cliente', 
       CR.vencimento as 'Data de vencimento', 
       CR.valor as 'Valor da conta'
from ContaReceber CR
join Cliente C on fk_cliente = C.ID 
where CR.situacao = '1';

4.1. Consulta à Visão

Para visualizar as contas ainda não pagas, utilizei a seguinte consulta:

select * from ContasNaoPagas;

Conclusão

A implementação do banco de dados "Loja" foi realizada com sucesso, contemplando a 
criação de tabelas essenciais para a gestão de estados, municípios, clientes e contas a receber. 
Além disso, inseri dados de exemplo para testar a estrutura e criei uma visão que facilita a consulta
das contas não pagas. Este banco de dados está agora pronto para ser utilizado em um ambiente 
de produção ou para futuros aprimoramentos.

*/  