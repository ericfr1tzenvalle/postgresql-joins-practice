# 📚 Exercícios de SQL — Consultas com JOIN, GROUP BY e HAVING

## ✅ Descrição

Este repositório contém a resolução de exercícios de SQL utilizando comandos de junção (`JOIN`), agregação (`GROUP BY`), filtro com `HAVING` e outras operações essenciais em bancos de dados relacionais.

As consultas foram adaptadas para o **PostgreSQL**, respeitando sua sintaxe e recursos.

---

## 📝 Estrutura dos Exercícios

Cada exercício propõe uma consulta SQL a partir de um esquema de banco de dados com as seguintes tabelas principais:

- `cliente`
- `notafiscal`
- `itemvenda`
- `funcionario`

Os enunciados incluem operações como:

- Combinações com `INNER JOIN` , `LEFT JOIN` e `FULL JOIN`.
- Cálculo de médias e totais com `AVG` e `SUM`.
- Filtros condicionais com `WHERE` e `HAVING`.
- Agrupamento de dados com `GROUP BY`.

---

## ⚙️ Tecnologias Utilizadas

- **PostgreSQL** — Sistema de Gerenciamento de Banco de Dados Relacional.
- **SQL** — Structured Query Language.
- **Git** — Para versionamento de código.

---

## 🚀 Como Executar

1. Clone o repositório:

```bash
git clone https://github.com/ericfr1tzenvalle/postgresql-joins-practice.git
```

2. Conecte-se ao seu banco de dados PostgreSQL.

3. Execute os scripts `.sql` conforme a ordem dos exercícios.

---

## 📂 Exercícios Resolvidos

### ✅ Exemplo de Consultas

**j) Nome e média em compras (R$) para clientes que compraram em média acima de R$30:**

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

## 💡 Observações

- Todos os comandos foram testados no PostgreSQL.
- Caso use outro SGBD, podem ser necessárias pequenas adaptações de sintaxe.
