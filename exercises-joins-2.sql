-- Tabela de departamentos
CREATE TABLE departamentos (
    id_departamento SERIAL PRIMARY KEY,
    nome VARCHAR(50)
);

-- Tabela de funcionários
CREATE TABLE funcionarios (
    id_funcionario SERIAL PRIMARY KEY,
    nome VARCHAR(50),
    sexo CHAR(1),
    cargo VARCHAR(50),
    salario NUMERIC(10,2),
    id_departamento INT REFERENCES departamentos(id_departamento),
    id_supervisor INT REFERENCES funcionarios(id_funcionario),
    cpf VARCHAR(11) UNIQUE
);

-- Tabela de clientes
CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(50),
    cpf VARCHAR(11) UNIQUE
);

-- Tabela de produtos
CREATE TABLE produtos (
    id_produto SERIAL PRIMARY KEY,
    descricao VARCHAR(100),
    preco NUMERIC(10,2)
);

-- Tabela de vendas
CREATE TABLE vendas (
    id_venda SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES clientes(id_cliente),
    id_funcionario INT REFERENCES funcionarios(id_funcionario),
    data_venda DATE,
    valor_total NUMERIC(10,2)
);

-- Tabela de itens da venda
CREATE TABLE itens_venda (
    id_item SERIAL PRIMARY KEY,
    id_venda INT REFERENCES vendas(id_venda),
    id_produto INT REFERENCES produtos(id_produto),
    quantidade INT
);

-- Departamentos
INSERT INTO departamentos (nome) VALUES 
('Vendas'), 
('RH'), 
('TI');

-- Funcionários
INSERT INTO funcionarios (nome, sexo, cargo, salario, id_departamento, cpf) VALUES
('João', 'M', 'Vendedor', 3000.00, 1, '12345678901'),
('Maria', 'F', 'RH', 2500.00, 2, '23456789012'),
('Carlos', 'M', 'Analista', 4000.00, 3, '34567890123');

-- Supervisor
UPDATE funcionarios SET id_supervisor = 1 WHERE nome = 'Carlos';

-- Clientes
INSERT INTO clientes (nome, cpf) VALUES
('Ana', '45678901234'),
('Pedro', '56789012345'),
('Carlos', '34567890123'); -- Também funcionário

-- Produtos
INSERT INTO produtos (descricao, preco) VALUES
('Notebook', 3500.00),
('Mouse', 50.00),
('Teclado', 120.00),
('Monitor', 800.00);

-- Vendas
INSERT INTO vendas (id_cliente, id_funcionario, data_venda, valor_total) VALUES
(1, 1, '2025-05-01', 3550.00),
(2, 1, '2025-05-02', 170.00),
(3, 3, '2025-05-03', 800.00);

-- Itens das vendas
INSERT INTO itens_venda (id_venda, id_produto, quantidade) VALUES
(1, 1, 1),  -- Ana comprou 1 Notebook
(1, 2, 1),  -- Ana comprou 1 Mouse
(2, 2, 2),  -- Pedro comprou 2 Mouses
(2, 3, 1),  -- Pedro comprou 1 Teclado
(3, 4, 1);  -- Carlos comprou 1 Monitor




-- 1. Liste o nome de cada cliente e o nome do funcionário que realizou sua última venda.

-- 2. Mostre todos os produtos, mesmo os que nunca foram vendidos, exibindo sua descrição e o total de vendas.

-- 3. Liste o nome dos funcionários e o nome de seus supervisores (caso tenham).

-- 4. Liste todos os clientes e, caso sejam também funcionários, mostre seu cargo.

-- 5. Mostre todos os departamentos e, ao lado, o nome de todos os funcionários, mesmo que o departamento não tenha funcionários.

-- 6. Mostre a lista de clientes e o valor total que gastaram, incluindo clientes que nunca compraram nada.

-- 7. Liste o nome dos produtos e o total de vezes que foram comprados por clientes que também são funcionários.

-- 8. Mostre o nome dos funcionários e o total de vendas realizadas, mesmo que não tenham vendido nada.

-- 9. Liste todos os clientes que compraram produtos e todos os produtos que nunca foram comprados, em uma consulta com FULL JOIN.

-- 10. Liste o nome de todos os funcionários e o nome de todos os clientes que compraram com eles, mesmo que o funcionário nunca tenha realizado vendas ou o cliente nunca tenha comprado.