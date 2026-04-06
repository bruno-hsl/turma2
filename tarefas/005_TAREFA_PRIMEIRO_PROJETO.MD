# 📝 Tarefa: Sistema de Biblioteca com Spring Boot + H2 + Flyway

## 💡 Contexto

Você deve criar um **sistema de biblioteca** que gerencie **empréstimos de livros**.  
O objetivo é praticar os conceitos de **relacionamento entre entidades**, **controle de versão do banco de dados com Flyway** e **testes de persistência**.

---

## 📌 Entidades

O sistema deve ter as seguintes entidades e relacionamentos:

- **Livro**: id, título, autor
- **Leitor**: id, nome, email
- **Emprestimo**: id, dataEmprestimo, dataDevolucao, relacionando um **Leitor**
- **LivroEmprestimo**: tabela intermediária para relacionar **Livro** e **Emprestimo**, com o campo **quantidade**

### Relacionamentos

- **Leitor → Emprestimo**: 1:N (um leitor pode fazer vários empréstimos)
- **Emprestimo → Livro**: N:N (um empréstimo pode ter vários livros e um livro pode ser emprestado várias vezes)

---

## 🚀 Requisitos da Tarefa

1. **Criação das tabelas no banco com Flyway**
    - Criar um arquivo de migração para **criar as tabelas** no banco de dados.
    - Criar um segundo arquivo de migração para **inserir dados de exemplo** (livros e leitores).

2. **Desenvolvimento das entidades**
    - Implementar as classes de entidade de acordo com os requisitos mencionados.

3. **Criação dos Repositories**
    - Criar interfaces de repositórios para acesso ao banco de dados utilizando `JpaRepository`.

4. **Serviços**
    - Implementar métodos no serviço para gerenciar empréstimos e buscar livros por leitor.

5. **Testes Unitários**
    - Criar testes unitários para validar a persistência dos dados:
        - Testar a criação de **Leitores** e **Livros**.
        - Testar o registro de **empréstimos**.

6. **Consultas SQL**
    - Utilizar o console H2 para fazer consultas SQL manuais:
        - Listar todos os livros emprestados.
        - Contar quantos empréstimos cada livro teve.

---

## 🔎 Desafios Extras

1. Criar uma consulta para **listar os livros emprestados por um determinado leitor**.
2. Criar uma consulta nativa para **contar os empréstimos de cada livro no sistema**.

---

## 📜 Considerações Finais

- O sistema deve ser **robusto** e **bem testado**.
- Utilizar **Flyway** para versionamento do banco de dados e para manter a integridade das migrações.
- O console H2 deve ser usado para consultas SQL e para inspecionar os dados.