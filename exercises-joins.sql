--DROPS
DROP TABLE IF EXISTS ItemVenda;
DROP TABLE IF EXISTS NotaFiscal;
DROP TABLE IF EXISTS Produto;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Departamento;



CREATE TABLE  Cliente 
(	CODCLIENTE serial, 
	NOME VARCHAR(100) NOT NULL, 
	CPF VARCHAR(15) UNIQUE, 
	EMAIL VARCHAR(50), 
	 CONSTRAINT "ClientePK" PRIMARY KEY (CODCLIENTE) 
) ;
CREATE TABLE  Departamento 
(	CODDEPARTAMENTO serial, 
	NOME VARCHAR(100), 
	 CONSTRAINT "DepartamentoPK" PRIMARY KEY (CODDEPARTAMENTO)
) ;
CREATE TABLE Funcionario
(
	codFuncionario serial,
	codDepartamento integer,
	CPF varchar(15) UNIQUE, 
	Nome varchar(50) NOT NULL,
	Salario numeric(7,2) NOT NULL ,
	DataNascimento date,
	Sexo varchar(1),
	Login varchar(50) UNIQUE,
	Senha text,
	codChefe int,
	CONSTRAINT "FuncionarioPK" PRIMARY KEY (codFuncionario),
	CONSTRAINT "CheckSexo" CHECK (Sexo = 'M' or Sexo = 'F'),
	CONSTRAINT "FuncionarioFKDepartamento" FOREIGN KEY (codDepartamento)
		REFERENCES Departamento (codDepartamento)
		on delete set null
		on update cascade,
	CONSTRAINT "FuncionarioFKChefe" FOREIGN KEY (codChefe)
		REFERENCES Funcionario (codFuncionario)
		on delete set null
		on update cascade
);

CREATE TABLE NotaFiscal
(
  codNotaFiscal serial,
  dataVenda date,
  codCliente integer,
  codFuncionario integer,
  CONSTRAINT "NotaFiscalPK" PRIMARY KEY (codNotaFiscal),
  CONSTRAINT "NotaFiscalFKCliente" FOREIGN KEY (codCliente)
      REFERENCES cliente (codcliente) ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT "NotaFiscalFKFuncionario" FOREIGN KEY (codFuncionario)
      REFERENCES funcionario (codFuncionario) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE Produto
(
	codProduto serial,
	descricao varchar(100) NOT NULL,
	precoUnit numeric(9,2) NOT NULL,
	qtdeEstoque integer NOT NULL,
	CONSTRAINT "ProdutoPK" PRIMARY KEY (codProduto)
);
CREATE TABLE ItemVenda
(
	codProduto integer,
	codNotaFiscal integer,
	quantidade numeric(6,3) NOT NULL,
	precoUnitVenda numeric(9,2) NOT NULL,

	CONSTRAINT "ItemVendaPK" PRIMARY KEY (codProduto, codNotaFiscal),
	CONSTRAINT "ItemVendaFKProduto" FOREIGN KEY (codProduto) 
		REFERENCES Produto (codProduto) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT "ItemVendaFKNotaFiscal" FOREIGN KEY (codNotaFiscal) 
		REFERENCES NotaFiscal (codNotaFiscal) 
);


--inserts	
--clientes
INSERT INTO cliente (nome,cpf,email)VALUES
( 'Maria Julia', '08736201', 'mariah1234@gmail.com'),
( 'Carlos André Cadutra', '8723436201', 'cadutra12@yahoo.com.br'),
( 'Jose Geraldo', '092887221', 'zegege3@hotmail.com'),
( 'Rita Maria Julia Toschini', '01225687321', 'ritinhatoschini@hotmail.com'),
( 'Adriano Carlos Fonseca', '98222187321', 'fonsecao88@gmail.com'),
( 'Paulo Lopes', '121232521', 'fonsecao88@gmail.com'),
( 'José Bruno Lázaro', '45698762433', 'lazarento@hotmail.com');

--deptos
INSERT INTO departamento (nome) VALUES ('TI'),('Marketing'),('Vendas'),('Gestão'),('Produção'),('novo depto');

--funcionarios
INSERT INTO funcionario (codDepartamento,codChefe,CPF,nome,salario,datanascimento,sexo,login,senha) VALUES 
--1
(4,null,'092887221', 'Jose Geraldo', 18765, to_date('02/03/1982','DD/MM/YYYY'), 'M', 'zeh', md5('zehS2')), 	
--2
(1,1,'08736201','Maria Julia', 3765, to_date('02/04/1985','DD/MM/YYYY'), 'F', 'mariah', md5('mariasinha')), 
--3
(4,null,'05722201','Sergio Boss', 15000, to_date('01/12/1975','DD/MM/YYYY'), 'M', 'sBoss', md5('TheBoss')),
--4
(2,1,'765527221', 'Jean Valjean', 4560.7, to_date('10/11/1950','DD/MM/YYYY'), 'M', 'jan', md5('tupeton')),
--5
(5,1,'12998762', 'Ricardo Tote', 1770, to_date('20/09/1997','DD/MM/YYYY'), 'M', 'Cadu', md5('ricardim')),
--6
(4,1,'828722121', 'Geraldo Julio Sperafico', 8765, to_date('28/02/1945','DD/MM/YYYY'), 'M', 'gjs', md5('chefinho')),
--7
(3,3,'121232521', 'Paulo Lopes', 5600, to_date('15/08/1999','DD/MM/YYYY'), 'M', 'lopes', md5('lopespower')),
--8
(5,5,'0344617221','Carla Montenegro', 7000.23,to_date('02/03/1995','DD/MM/YYYY'),'F','carla',md5('gatinha95')),	
--9
(3,7,'09232287221', 'Josefa Fátima', 4666, to_date('12/07/1970','DD/MM/YYYY'), 'F', 'josefa', md5('zehfinha')),
--10
(1,1,'45698762433', 'José Bruno Lázaro', 4200, to_date('12/07/2000','DD/MM/YYYY'), 'M', 'zeLaser', md5('lazarento')),
--11
(null,7,'09232547621', 'Josefa sem depto', 4900, to_date('12/07/1979','DD/MM/YYYY'), 'F', 'semAmiga', md5('semAmiga'));


INSERT INTO produto (descricao, precounit, qtdeEstoque) VALUES 
('achocolatado nescau', 6.7, 100),			--1
('leite integral Damby', 3.2, 300),			--2
('banana prata kg', 4.74, 50),				--3
('tomate gaucho kg', 8.21, 40),				--4
('maça argentina kg', 10.15, 60),			--5
('refrigerante coca-cola lata', 2.85, 500),		--6
('refrigerante coca-cola 2l', 5.15, 400),		--7
('refrigerante guaraná antartica lata', 2.75, 600),	--8
('refrigerante sukita 2l', 5, 450),			--9
('água mineral água da pedra 500ml', 2.15, 1000),	--10
('pão francês "little cacete" kg', 5.85, 200),		--11
('detergente líquido limpol', 3.15, 240),		--12
('shampo  Clear Men do CR7', 10.75, 30),		--13
('creme dental sorriso 4d', 4.99, 25),			--14
('biscoito nesfit sabor chocolate', 2.85, 70),		--15
('Smart TV LED 32" HD Samsung 32J4300 ', 1599.90, 8),	--16 
('papel higiênico neve 40m c/4', 6.15, 48),		--17
('pen drive kingston 4GB', 40.99, 10),			--18 
('cerveja coruja viva weiss', 15.99, 15),		--19
('refrigerante guaraná biri 2l', 1.99, 55),		--20
('erva mate tacapi sabor canela 500g', 7.99, 45); 	--21


--insert de 10 vendas

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '2 years', 6,1);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(1,1,1,6.5), (1,2,2,3.0), (1,4,1.23,10.5);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '1 year 62 days', 6,2);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES (2,3,1.54,	4.22),(2,6,4, 2.39);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '55 days', 5,3);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(3,7,3, 4.99),(3,10,6, 1.99),(3,11,0.54, 5.85),(3,2,3, 2.65);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '50 days', 8,4);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(4,12,1, 2.95),(4,14,3, 3.99),(4,13,2, 9.75),(4,21,1, 6.99);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '45 days', 6,5);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(5,20,10, 0.99), (5,15,3,  2.85), (5,19,2,  15.99);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '40 days', 5,6);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(6,16,1, 1699.90),(6,18,2, 45.99);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '30 days', 8,4);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES (7,20,12, 1.99);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '1 year 25 days', 6,1);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(8,2,12, 3.2), (8,11,0.3, 5.85), (8,21,1, 7.99);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '10 days', 6,4);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(9,6,2, 2.80),(9,7,3, 4.75),(9,9,1, 4.5);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '1 day', 3,4);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(10,6,2, 2.80),(10,2,3, 3.10),(10,21,2, 8.49);

-- Cliente(codCliente, nome, email, cpf)
-- Departamento(codDepartamento, nome)
-- Funcionario(codFuncionario, nome, cpf, salario, dataNascimento, sexo, login, senha, codDepartamento, codChefe )
-- codDepartamento referencia Departamento
-- codChefe referencia Funcionario
-- Produto(codProduto, descricao, precoUnit, qtdeEstoque)
-- NotaFiscal(codNotaFiscal, dataVenda, codCliente, codFuncionario)
-- codCliente referencia Cliente
-- codFuncionario referencia Funcionario
-- ItemVenda(codNotaFiscal, codProduto, quantidade, precoVenda)
-- codNotaFiscal referencia NotaFiscal
-- codProduto referencia Produto


--Realize as consultas pedidas se necessário utilize Junções de tabelas.
--a. O nome dos funcionários e de seus respectivos departamentos.
SELECT f.nome as "NomeFuncionario", d.nome as "NomeDepartamento" from funcionario as f
INNER JOIN departamento as d USING(coddepartamento);

--b. Quantas diferentes pessoas (todos seus dados) existem no banco de dados (clientes e funcionários).
SELECT f.*, c.* from funcionario as f
FULL JOIN cliente as c ON c.cpf = f.cpf;



--c. O item 1.j agrupado por nome do departamento e ordenado pelo nome do departamento para funcionários do sexo masculino com salário maior que 2000


--d. A descrição dos produtos bem como o número de itens que foram vendidos, ordenado pelo número de itens que foram vendidos.
SELECT p.descricao,   COALESCE(sum(i.quantidade))::INTEGER as "Total" from produto as p -- 
LEFT JOIN itemvenda as i ON i.codproduto = p.codproduto
GROUP BY p.descricao
ORDER BY sum(i.quantidade) DESC;

--e. A descrição e número de vezes que cada produto foi vendido, ordenado pelo número de vezes que foi.
SELECT p.descricao, count(i.codproduto) from produto as p
LEFT JOIN itemvenda as i ON i.codproduto = p.codproduto
GROUP BY p.descricao
ORDER BY count(*) DESC;

--f. A listas dos clientes que mais vezes compram na loja. Nome e total de compras ordenado pelo total de compras.
SELECT c.nome, count(n.codcliente) as "TotalCompras" FROM cliente as c
LEFT JOIN notafiscal as n ON c.codcliente = n.codcliente
GROUP BY c.nome
ORDER BY count(*) DESC;


--g. A lista dos funcionários que mais vendas realizaram. Nome e total de vendas realizadas ordenado pelo total de compras.
SELECT f.nome, count(n.codfuncionario) as "TotalVendas" from funcionario as f
LEFT JOIN notafiscal as n ON f.codfuncionario  = n.codfuncionario
GROUP BY  f.nome
ORDER BY count(*) DESC;



--h. A lista dos departamentos e o total em vendas (R$) realizadas por cada departamento.
SELECT d.*, COALESCE(sum(i.quantidade * i.precoUnitVenda),0) AS total_vendas from departamento as d
LEFT JOIN funcionario as f ON f.coddepartamento = d.coddepartamento
LEFT JOIN notafiscal as n ON n.codfuncionario = f.codfuncionario
LEFT JOIN itemvenda as i ON i.codnotafiscal = n.codnotafiscal
GROUP BY d.nome,d.coddepartamento
ORDER BY total_vendas DESC;


--i. Sobre os clientes que são funcionários mostrar o nome, o total em vendas realizadas (R$) e o total em compras realizadas (R$)
SELECT c.nome, COALESCE(sum(i.quantidade * i.precoUnitVenda),0) as total_vendas, COALESCE(sum(i2.quantidade * i2.precoUnitVenda),0) as total_compras
FROM cliente as c
INNER JOIN funcionario as f ON f.cpf = c.cpf
LEFT JOIN notafiscal as n ON n.codfuncionario = f.codfuncionario
LEFT JOIN itemvenda as i ON i.codnotafiscal = n.codnotafiscal
LEFT JOIN notafiscal as n2 ON n2.codcliente = c.codcliente
LEFT JOIN itemvenda as i2 ON i2.codnotafiscal = n2.codnotafiscal
GROUP BY c.nome
ORDER BY total_vendas;

 

--j. O nome e a média em compras (R$) para os clientes que compraram em média acima de R$30 em cada compra.
SELECT 
  c.nome, 
  AVG(total_compra) AS media_compra
FROM cliente c
INNER JOIN notafiscal n ON n.codcliente = c.codcliente
INNER JOIN (
  SELECT codnotafiscal, SUM(precounitvenda * quantidade) AS total_compra
  FROM itemvenda
  GROUP BY codnotafiscal
) i ON i.codnotafiscal = n.codnotafiscal
GROUP BY c.nome
HAVING AVG(total_compra) > 30; 



--k. Nome do cliente, do funcionário e o total da compra para vendas realizadas no último mês.
SELECT 
  c.nome AS nome_cliente,
  f.nome AS nome_funcionario,
  SUM(i.precounitvenda * i.quantidade) AS total_compra
FROM notafiscal n
INNER JOIN cliente c ON n.codcliente = c.codcliente
INNER JOIN funcionario f ON n.codfuncionario = f.codfuncionario
INNER JOIN itemvenda i ON n.codnotafiscal = i.codnotafiscal
WHERE n.datavenda >= CURRENT_DATE - INTERVAL '1 month'
GROUP BY n.codnotafiscal, c.nome, f.nome;
