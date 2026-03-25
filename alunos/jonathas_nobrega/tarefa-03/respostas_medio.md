Exercicio 4 - Funcionários e Departamento:

Tabela Inicial
| funcionario_id | nome | departamento | gerente_departamento |
| -------------- | ---- | ------------ | -------------------- |
| 1 | João | TI | Carlos |
| 2 | Ana | TI | Carlos |
| 3 | Pedro | RH | Maria |

Q1: Existe **dependência transitiva**?
R1: existem dependências transitivas, pois gerente_departamento depende de departamento, não diretamente da chave primária. (funcionario_id → departamento → gerente_departamento)

Q2: A tabela está na **3FN**?
R2: Não

Q3: Como separar corretamente?
R3: Em imagem.

Exercício 5 - Produtos e Categoria:

Tabela Inicial
| produto_id | produto_nome | categoria_id | categoria_nome |
| ---------- | ------------ | ------------ | -------------- |
| 1 | Notebook | 10 | Informática |
| 2 | Mouse | 10 | Informática |
| 3 | Geladeira | 20 | Eletrodomésticos |

Q1: Qual dependência funcional existe?
R1: Existe a dependência funcional produto_id -> produto_nome, categoria_id e categoria_id -> categoria_nome.

Q2: Como ficaria a tabela na **3FN**?
R2: Em imagem.

Exercício 6 - Matrícula de alunos:

Tabela inicial
| aluno_id | aluno_nome | curso_id | curso_nome |
| -------- | ---------- | -------- | ---------- |
| 1 | Ana | 101 | Engenharia |
| 2 | Pedro | 101 | Engenharia |
| 3 | Carlos | 102 | Direito |

Perguntas:

Q1: Quais atributos dependem de quais?
R1: Existe a dependência transitiva aluno_id -> curso_id -> curso_nome. (aluno_id define nome do aluno, aluno_id define o curso_id, e curso_id define o nome do curso)

Q2: Separe as tabelas corretamente.
R2: Em imagem.
