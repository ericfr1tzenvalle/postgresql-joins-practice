# 📚 Exercícios de SQL — Consultas com JOIN, GROUP BY e HAVING  

## ✅ Descrição

Este repositório contém a resolução de exercícios de SQL utilizando comandos de junção (`JOIN`), agregação (`GROUP BY`), filtro com `HAVING` e outras operações essenciais em bancos de dados relacionais.

As consultas foram adaptadas para o **PostgreSQL**, respeitando sua sintaxe e recursos.

---

## ✅ Description

This repository contains SQL exercises using `JOIN`, `GROUP BY`, `HAVING`, and other essential operations for relational databases.

All queries are adapted for **PostgreSQL**, following its syntax and specific features.

---
Os enunciados incluem operações como:  
The exercises include operations such as:

- Combinações com `INNER JOIN`, `LEFT JOIN` e `FULL JOIN`.  
  Combinations using `INNER JOIN`, `LEFT JOIN`, and `FULL JOIN`.

- Cálculo de médias e totais com `AVG` e `SUM`.  
  Calculating averages and totals using `AVG` and `SUM`.

- Filtros condicionais com `WHERE` e `HAVING`.  
  Conditional filters using `WHERE` and `HAVING`.

- Agrupamento de dados com `GROUP BY`.  
  Data grouping with `GROUP BY`.

---

## ⚙️ Tecnologias Utilizadas | Technologies Used

- **PostgreSQL** — Sistema de Gerenciamento de Banco de Dados Relacional.  
  **PostgreSQL** — Relational Database Management System.

- **SQL** — Structured Query Language.

- **Git** — Para versionamento de código.  
  **Git** — For code versioning.

---

## 🚀 Como Executar | How to Run

1. Clone o repositório:  
   Clone the repository:

```bash
git clone https://github.com/ericfr1tzenvalle/postgresql-joins-practice.git
```

2. Conecte-se ao seu banco de dados PostgreSQL.  
   Connect to your PostgreSQL database.

3. Execute os scripts `.sql` conforme a ordem dos exercícios.  
   Execute the `.sql` scripts following the exercise order.

---

## 📂 Exercícios Resolvidos | Solved Exercises

### ✅ Exemplo de Consultas | Example Queries

**j) Nome e média em compras (R$) para clientes que compraram em média acima de R$30:**  
**(Customer name and average purchase amount for customers with average purchases above R$30):**

```sql
SELECT c.nome, AVG(i.precounitvenda) AS media_compra
FROM cliente AS c
INNER JOIN notafiscal AS n ON n.codcliente = c.codcliente
LEFT JOIN itemvenda AS i ON i.codnotafiscal = n.codnotafiscal
GROUP BY c.nome
HAVING AVG(i.precounitvenda) > 30;
```

---

**k) Nome do cliente, do funcionário e o total da compra para vendas realizadas no último mês:**  
**(Customer name, employee name, and total purchase amount for sales made in the last month):**

```sql
SELECT c.nome AS cliente, f.nome AS funcionario, SUM(i.precounitvenda * i.qtd) AS total_compra
FROM notafiscal AS n
INNER JOIN cliente AS c ON n.codcliente = c.codcliente
INNER JOIN funcionario AS f ON n.codfuncionario = f.codfuncionario
INNER JOIN itemvenda AS i ON n.codnotafiscal = i.codnotafiscal
WHERE n.datavenda >= (CURRENT_DATE - INTERVAL '1 month')
GROUP BY c.nome, f.nome;
```

---

## 💡 Observações | Notes

- Todos os comandos foram testados no PostgreSQL.  
  All commands were tested on PostgreSQL.

- Caso use outro SGBD, podem ser necessárias pequenas adaptações de sintaxe.  
  If you use a different DBMS, slight syntax adjustments might be required.
