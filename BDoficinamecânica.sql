create database oficina;
use oficina;

-- Criando todas as tabelas em sequência
create table cliente(
	idCliente int auto_increment primary key,
    nome varchar(300) not null,
    CPF char(11) not null,
    telefone varchar(11) not null,
    endereco varchar(300) not null,
    constraint unique_CPF unique (CPF)
);

create table veiculo(
	codVeiculo int auto_increment primary key,
    idVeiculo varchar(45)not null,
    idCliente int,
    constraint fk_veiculo_cliente foreign key (idCliente) references cliente(idCliente)
);

create table equipeMecanica(
	idEquipe int auto_increment primary key,
    servico varchar(45) not null
);

create table mecanico(
	idMecanico int auto_increment primary key,
    codMecanico int not null,
    nome varchar(45)not null,
    endereco varchar(45)not null,
    especialidade varchar(45),
    fkequipe int,
    constraint fk_mecanico_equipe foreign key (fkequipe) references equipeMecanica(idEquipe)
);

create table pecas(
	idVP int auto_increment primary key,
    valorP varchar(25) not null
);

create table trabalhoMecanico(
	idTM int auto_increment primary key,
    valorTM varchar(255)
);

create table consertoRevisao(
	equipeM int,
    idVeiculo int,
    OS int not null,
    idTM int,
    idVP int,
    dataOS varchar(45) not null,
    valorOS varchar(45)not null,
    statusOS varchar(45)not null,
    prazoDias varchar(45)not null,
    constraint fk_conserto_equipe foreign key (equipeM) references equipeMecanica(idEquipe),
    constraint fk_conserto_veiculo foreign key (idVeiculo) references veiculo(idVeiculo),
    constraint fk_conserto_TM foreign key (idTM) references trabalhoMecanico(idTM),
    constraint fk_conserto_pecas foreign key (idValor) references pecas(idVP)
);

create table autorizarNegar(
	idAutorizarNegar int auto_increment primary key,
    autorizacao varchar(45),
    negacao varchar(45),
    dataR date not null,
    idCliente int,
    idVeiculo int,
    idEquipeMecanicos int,
    constraint fk_autorizarnegar_cliente foreign key (idCliente) references cliente(idCliente),
    constraint fk_autorizarnegar_veiculo foreign key (idVeiculo) references veiculo(idVeiculo),
    constraint fk_autorizarnegar_equipe foreign key (idEquipe) references equipeMecanica(idEquipe)
);

create table autorizado(
	idAutorizado int auto_increment primary key,
    dataPrevisao varchar(45) not null,
    OSautorizada int not null,
    dataOS varchar(45) not null,
    statusOS varchar(45) not null,
    idEquipeMecanicos int,
    idAutorizarNegar int,
    idCliente int,
    idVeiculo int,
    constraint fk_autorizado_equipe foreign key (idEquipeMecanicos) references equipeMecanica(idEquipe),
    constraint fk_autorizado_id foreign key (idAutorizarNegar) references autorizarNegar(idAutorizarNegar),
    constraint fk_autorizado_cliente foreign key (idCliente) references cliente(idCliente),
    constraint fk_autorizado_veiculo foreign key (idVeiculo) references veiculo(idVeiculo)
);

-- Inserindo dados para testarmos e "imprimirmos" os valores em testes
insert into cliente(nome, CPF, telefone, endereco) values
	('testecliente1','15589658741','11111111111','Rua Ipê'),
    ('testecliente2','25253639852','22222222222','Rua Orquidea'),
    ('testecliente3','14785236953','22222222223','Rua Pau Brasil');

insert into veiculo(idVeiculo, idCliente) values
	('1478523698','1'),
    ('1235469782','2'),
    ('2593481561','3');

insert into equipeMecanica(servico) values
	('testeservico1'),
    ('testeservico2'),
    ('testeservico3');

insert into mecanico(CodMecanico, nome, endereco, especialidade, equipeMecanico) values
	('12345','mecanico1','Rua Ipê','especialidade1','1'),
    ('23456','mecanico2','Rua Orquidea','especialidade2','2'),
    ('34567','mecanico3','Rua Pau Brasil','especialidade3','3');

insert into pecas(valorPecas) values
	('10,00');

insert into trabalhoMecanico(ValorMaoObra) values
	('50,00');

insert into consertoRevisao (OS, dataOs, valorOs, statusOs, prazoDias) values
	('001',20221104,'60,00','A espera de um milagre','100 dias');

insert into autorizarNegar(autorizacao, negacao, dataR) values
    (null,'sim','20221104'),
    ('sim',null,'20221104');

insert into autorizado(dataprevisao, OSautorizada, dataOS, statusOS) values
	('20222107','001','20220105','Concluida');

-- queries (vamos ver se tá funcionando mesmo)
select * from cliente;
select count(*) from cliente;
select * from cliente c,veiculo v where c.idCliente=v.idCliente;
select Nome,Telefone,idVeiculo from cliente c,veiculo v where c.idCliente=v.idCliente group by idVeiculo;
