Exercício 7 - Pedido completo:

Tabela Inicial
| pedido_id | cliente_nome | cliente_cidade | produto_nome | preco |
| --------- | ------------ | -------------- | ------------ | ----- |
| 1 | João | Recife | Notebook | 4000 |
| 1 | João | Recife | Mouse | 50 |
| 2 | Maria | São Paulo | Teclado | 120 |

Q1: Identifique as dependências funcionais
R1: Um pedido pode ter vários produtos, então a chave é composta.
(
pedido_id → cliente_nome, cliente_cidade
cliente_nome → cliente_cidade
produto_nome → preco
)

Q2: Normalize até **3FN**
R2: Em imagem.

Exercício 8 - Venda e vendedor

Tabela Inicial
| venda_id | vendedor_nome | loja_nome | loja_cidade |
| -------- | ------------- | --------- | ----------- |
| 1 | Carlos | Loja Centro | Recife |
| 2 | Carlos | Loja Centro | Recife |
| 3 | Ana | Loja Norte | São Paulo |

A loja depende do vendedor ou a venda depende do vendedor?
faremos o caso que a venda depende do vendedor, um vendedor pode vender para outras lojas.

Q2: Existe dependência transitiva?
R1: venda_id → loja_nome → loja_cidade

Q2: Como dividir as tabelas?
R2: Em imagem.

Exercício 9 - Sistema de universidade

Tabela inicial
| aluno_id | aluno_nome | disciplina | professor |
| -------- | ---------- | ---------- | --------- |
| 1 | Ana | Banco de Dados | Marcos |
| 2 | Pedro | Banco de Dados | Marcos |
| 3 | Ana | Redes | Carla |

Não se sabe se um professor pode estar em várias disciplinas, ou cada disciplina tem um único professor, vou levar em consideração que cada disciplina tem um único professor para essa tarefa

Q1: Existe relação **N:N**?
R1: Existe uma relação muitos-para-muitos (N:N) entre: Alunos e Disciplinas

Q2: Quais tabelas devem existir?
R2: Em imagem.

Exercício 10 - Sistema de e-commerce

Tabela Inicial
| pedido_id | cliente_nome | cliente_email | produto_nome | categoria |
| --------- | ------------ | ------------- | ------------ | --------- |
| 1 | João | joao@email.com | Notebook | Informática |
| 1 | João | joao@email.com | Mouse | Informática |
| 2 | Ana | ana@email.com | Geladeira | Eletrodomésticos |

Q1: Identifique dependências funcionais.
R1: Existem algumas dependências, sendo elas 1. Um pedido pertence a um cliente (pedido_id → cliente_nome, cliente_email) 2. O email identifica o cliente (cliente_email → cliente_nome) 3. Cada produto pertence a uma categoria (produto_nome → categoria) 4. Cada linha da tabela é identificada por (pedido_id, produto_nome)

Q2: Normalize até **3FN**.
R2: Em imagem.
