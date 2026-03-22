# Exercício 1 — Cliente e Pedido
### 1. Quais tabelas existem?
Cliente e Pedido

### 2. Qual a cardinalidade?

Cardinalidade: 1:N;

Um cliente pode ter vários pedidos, mas um pedido só pode ter um cliente.

### 3. Defina PK e FK
* PK: Cliente (id), Pedido (id)
* FK: Pedido (cliente_id)

### 4. Faça um INNER JOIN
```sql
SELECT
    pedido.id AS pedido_id,
    cliente.id AS cliente_id
FROM pedido
INNER JOIN cliente ON
    cliente.id = pedido.cliente_id
```

![img_001-exercicio_pedido-cliente.png](./img/001-exercicio_pedido-cliente.png)