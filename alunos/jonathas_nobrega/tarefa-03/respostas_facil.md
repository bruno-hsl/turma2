Exercicio 1 - Telefones de Cliente:

Q1: A tabela está na na **1FN**?
R1: Não está na **1FN** porque a coluna "telefones" possui múltiplos valores no mesmo campo.

Q2: Como modelar corretamente os telefones?
R2: Em imagem.

Exercicio 2 - Pedido com vários produtos:

Tabela inicial
| pedido_id | cliente | produtos |
| --------- | ------- | -------- |
| 1 | João | arroz, feijão |
| 2 | Maria | leite |

Q1: Qual problema de normalização existe?
R1: A tabela não está na **1FN** porque a coluna produtos possui múltiplos valores no mesmo campo.

Q2: Como ficaria a estrutura após aplicar **1FN**?
R2: Em imagem.

Exercicio 3 - Curso e alunos:

Tabela inicial
| curso_id | curso_nome | alunos |
| -------- | ---------- | ------ |
| 1 | Java | Ana, Carlos, Pedro |

Q1: Qual regra da **1FN** está sendo violada?
R1: A coluna alunos possui vários valores na mesma célula:

Q2: Como ficaria a modelagem correta?
R2: Em imagem.
