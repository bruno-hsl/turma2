# 📘 Projeto Spring Boot com Gradle + JPA + Flyway

## 💡 Contexto do Projeto

Sistema simples de pedidos (e-commerce):

### Entidades:

- Cliente
- Pedido
- Produto
- PedidoProduto (tabela intermediária do N:N)

### Relacionamentos:

- Cliente 1:N Pedido
- Pedido N:N Produto → resolvido com PedidoProduto

---

# 🚀 1. Criando o projeto no Spring Initializr

Acesse: https://start.spring.io

### Configurações:

- Project: Gradle
- Language: Java
- Spring Boot: versão mais recente
- Group: com.exemplo
- Artifact: pedido-api

---

# 📦 2. Dependências do projeto

Adicione as seguintes dependências:

| Dependência      | Por quê usar?                       |
|------------------|-------------------------------------|
| Spring Web       | Criar APIs REST                     |
| Spring Data JPA  | Persistência e acesso ao banco      |
| Lombok           | Reduz código boilerplate (get/set)  |
| Flyway           | Versionamento do banco (migrations) |
| Validation       | Validar dados automaticamente       |
| DevTools         | Reinício automático da aplicação    |
| H2 Driver        | Conectar com banco H2               |
| Spring Boot Test | Criar testes com JUnit              |

---

# 📦 3. build.gradle

```gradle
plugins {
    id 'java'
    id 'org.springframework.boot' version '3.2.0'
    id 'io.spring.dependency-management' version '1.1.4'
}

group = 'com.exemplo'
version = '0.0.1-SNAPSHOT'

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(17)
    }
}

repositories {
    mavenCentral()
}

dependencies {

    // Criação de APIs REST (controllers, endpoints HTTP)
    implementation 'org.springframework.boot:spring-boot-starter-web'

    // Integração com banco usando JPA/Hibernate
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'

    // Controle de versão do banco (migrations automáticas)
    implementation 'org.flywaydb:flyway-core'

    // Validação automática de dados (@NotNull, @Email, etc)
    implementation 'org.springframework.boot:spring-boot-starter-validation'

    // Reinício automático da aplicação durante desenvolvimento
    developmentOnly 'org.springframework.boot:spring-boot-devtools'

    // Driver JDBC para conexão com H2
    runtimeOnly 'com.h2database:h2'

    // Redução de código (getters, setters, construtores)
    compileOnly 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'

    // Testes com JUnit e Spring Boot
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}

test {
    useJUnitPlatform()
}
```

---

# 📁 4. Estrutura de pacotes

```
com.exemplo.pedidoapi
│
├── controller   → Camada REST (entrada da API)
├── service      → Regras de negócio
├── repository   → Acesso ao banco
├── model        → Entidades JPA
├── dto          → Objetos de transferência (opcional)
└── config       → Configurações
```

---

# ⚙️ 5. application.yml (H2)

```
spring:
  datasource:
    url: jdbc:h2:mem:pedidodb   # banco em memória
    driverClassName: org.h2.Driver
    username: sa
    password:

  jpa:
    hibernate:
      ddl-auto: update          # opcional: update para criar tabelas automaticamente
    show-sql: true
    database-platform: org.hibernate.dialect.H2Dialect

  h2:
    console:
      enabled: true
      path: /h2-console

  flyway:
    enabled: true
```

---

# 🛢️ 6. Flyway (Controle de versão do banco)

## 💡 O que é o Flyway?

O Flyway é uma ferramenta de **versionamento de banco de dados**.

👉 Ele funciona como um “Git do banco”:

- Cada alteração no banco vira um arquivo `.sql`
- O Flyway executa esses arquivos automaticamente
- Mantém histórico do que já foi executado

---

## 🎯 Por que usar Flyway?

Sem Flyway:

- Cada dev cria tabela manualmente 😩
- Diferença de estrutura entre ambientes
- Difícil manter controle

Com Flyway:

- Banco padronizado para todos ✔
- Histórico de alterações ✔
- Fácil evolução do sistema ✔

---

## 📁 Estrutura de pastas

O Flyway segue um padrão **obrigatório** dentro do projeto:

``` id="tree-flyway"
src/main/resources
│
└── db
    └── migration
        ├── V1__create_tables.sql
        ├── V2__insert_dados.sql
        └── V3__alter_table.sql
```

👉 Pasta obrigatória:

db/migration

👉 Se mudar o nome, o Flyway não encontra os arquivos

🧾 Padrão de nome dos arquivos

Formato obrigatório:

```
V<versão>__<descrição>.sql
```

Exemplos:

```
V1__create_tables.sql
V2__insert_clientes.sql
V3__add_coluna_preco.sql
```

⚠️ Regras importantes

```
Sempre começa com V
Versão é incremental (1, 2, 3...)
Usa dois underscores __
Não pode repetir versão
```

🚀 Como o Flyway funciona na prática

Quando você roda a aplicação:

```
Ele conecta no banco
Cria uma tabela interna chamada: flyway_schema_history
Verifica quais scripts já foram executados
Executa apenas os novos
```

🧠 Exemplo da tabela interna

```
SELECT * FROM flyway_schema_history;
```

Ela guarda:

```
versão
nome do script
data de execução
```

🛠️ Exemplo de Migration

```
📁 V1__create_tables.sql

CREATE TABLE cliente (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE produto (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2)
);
```

➕ Criando novas versões

Exemplo: adicionar coluna

```
📁 V2__add_coluna_telefone.sql

ALTER TABLE cliente ADD COLUMN telefone VARCHAR(20);
```

👉 O Flyway vai:

```
ver que V1 já rodou
executar apenas V2
```

❌ O que NÃO fazer

```
🚫 Alterar script já executado
🚫 Apagar arquivo antigo
🚫 Reutilizar número de versão
```

👉 Isso quebra o controle do Flyway

✅ Boas práticas

```
✔ Sempre criar nova versão
✔ Scripts pequenos e claros
✔ Nome descritivo
✔ Versionar junto com o código
```

🔎 Como testar

Suba a aplicação
Verifique se tabelas foram criadas
Rode:
SELECT * FROM cliente;

⚠️ Problemas comuns

```
❌ Flyway não executa
Pasta errada (db/migration)
Nome errado do arquivo
Conexão com banco falhou

❌ Erro de versão duplicada
👉 Já existe um V1
✔ Solução:
criar V2

❌ Tabela já existe
👉 Script foi rodado manualmente antes
✔ Solução:
recriar banco
ou ajustar histórico
```

👉 "Flyway é quem cria o banco automaticamente quando a aplicação sobe."

👉 "Você nunca mais cria tabela na mão."

---

# 🧩 7. Entidades (Model)

📌 Cliente

```
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Cliente {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Nome do cliente
    private String nome;

    // Email validado automaticamente
    @Email
    private String email;

    // Um cliente possui vários pedidos
    @OneToMany(mappedBy = "cliente")
    private List<Pedido> pedidos;
}
```

📌 Produto

```
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Produto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nome;
    private Double preco;
}
```

📌 Pedido

```
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Pedido {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String dataPedido;

    // Muitos pedidos pertencem a um cliente
    @ManyToOne
    @JoinColumn(name = "cliente_id")
    private Cliente cliente;

    // Um pedido possui vários produtos (via tabela intermediária)
    @OneToMany(mappedBy = "pedido")
    private List<PedidoProduto> itens;
}
```

📌 PedidoProduto

```
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "pedido_produto")
public class PedidoProduto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Quantidade do produto no pedido
    private Integer quantidade;

    // Relacionamento com pedido
    @ManyToOne
    @JoinColumn(name = "pedido_id")
    private Pedido pedido;

    // Relacionamento com produto
    @ManyToOne
    @JoinColumn(name = "produto_id")
    private Produto produto;
}
```

---

# 🗄️ 8. Repository (Camada de acesso a dados)

## 💡 O que é um Repository?

O Repository é responsável por:

- Acessar o banco de dados
- Executar consultas
- Salvar, atualizar e deletar dados

---

## 🚀 JpaRepository (o grande benefício)

```java
public interface ClienteRepository extends JpaRepository<Cliente, Long> {
}
```

🧠 O que isso significa?

```
👉 Ao estender JpaRepository, você ganha vários métodos prontos automaticamente
👉 Não precisa escrever SQL básico
```

✅ Métodos que já vêm prontos

Sem escrever nada, você já pode usar:

```
repository.save(cliente);      // salva ou atualiza
repository.findAll();          // lista todos
repository.findById(1L);       // busca por ID
repository.deleteById(1L);     // deleta por ID
```

🎯 Por que isso é importante?

- Evita código repetitivo
- Aumenta produtividade
- Padrão usado no mercado

👉 Você escreve menos código e faz mais coisas

🔍 Query derivada (sem SQL)

O Spring cria consultas com base no nome do método:

```
List<Cliente> findByNome(String nome);
```

👉 O Spring interpreta:

```
SELECT * FROM cliente WHERE nome = ?
```

🔥 Native Query (SQL puro)

Quando você precisa de mais controle, pode usar SQL diretamente:

```
@Query(value = "SELECT * FROM cliente WHERE email = ?1", nativeQuery = true)
List<Cliente> buscarPorEmail(String email);
```

🧠 Explicação

- @Query → permite escrever consulta manual
- nativeQuery = true → indica que é SQL do banco (não JPQL)
- ?1 → primeiro parâmetro do método

📌 Exemplo mais avançado

```
@Query(value = "SELECT * FROM cliente WHERE nome LIKE %?1%", nativeQuery = true)
List<Cliente> buscarPorNomeParcial(String nome);
```

👉 Isso permite buscar:

"Jo" → João, Jose, Jonas

⚠️ Quando usar Native Query?

Use quando:

Query é muito complexa

- Precisa de performance
- Usa recursos específicos do banco

Evite quando:

- Dá pra usar método derivado
- Query é simples

# ⚙️ 9. Service (Camada de regra de negócio)

💡 O que é o Service?

É a camada onde ficam:

- Regras de negócio
- Validações
- Orquestração entre classes

👉 Ele usa o Repository, mas não acessa banco diretamente

📌 Exemplo

```
@Service
public class ClienteService {

    private final ClienteRepository repository;

    // Injeção de dependência (Spring cria o objeto automaticamente)
    public ClienteService(ClienteRepository repository) {
        this.repository = repository;
    }

    // Salva cliente
    public Cliente salvar(Cliente cliente) {
        return repository.save(cliente);
    }

    // Lista todos os clientes
    public List<Cliente> listar() {
        return repository.findAll();
    }

    // Busca por nome (query derivada)
    public List<Cliente> buscarPorNome(String nome) {
        return repository.findByNome(nome);
    }

    // Busca por email (native query)
    public List<Cliente> buscarPorEmail(String email) {
        return repository.buscarPorEmail(email);
    }
}
```

🎯 Explicação didática

```
👉 Repository = fala com o banco
👉 Service = decide o que fazer
```

---

# 🧪 10. Testes Unitários e Estrutura

💡 Por que testar?

Testes ajudam a:

- Garantir que métodos funcionem corretamente
- Evitar regressões quando alteramos código
- Melhorar confiabilidade do sistema

---

📁 Estrutura de pastas para testes

No Spring Boot com Gradle:

```
src/test/java/com/exemplo/pedidoapi
├── repository → Testes unitários dos Repositories
│ └── ClienteRepositoryTest.java
├── service → Testes unitários dos Services
│ └── ClienteServiceTest.java
└── model → (opcional) testes de entidades ou validações
```

> Tudo em `src/test/java` é código de teste e **não vai para produção**.


⚡ Dependências importantes para testes

No Gradle já temos:

```gradle
testImplementation 'org.springframework.boot:spring-boot-starter-test'
```

Inclui:

- JUnit 5 → framework principal de testes
- AssertJ → assertions fluentes
- Mockito → mocks e stubs (simular objetos)
- Spring Test → integra testes com contexto Spring

---

# 🧩 10.1 Teste de Repository

```
@DataJpaTest
class ClienteRepositoryTest {

    @Autowired
    private ClienteRepository repository;

    @Test
    void deveSalvarEBuscarCliente() {
        // Arrange
        Cliente cliente = new Cliente();
        cliente.setNome("João");
        cliente.setEmail("joao@email.com");

        // Act
        repository.save(cliente);

        // Query derivada
        List<Cliente> encontrados = repository.findByNome("João");

        // Assert
        assertFalse(encontrados.isEmpty(), "Deve encontrar cliente pelo nome");

        // Native query
        List<Cliente> porEmail = repository.buscarPorEmail("joao@email.com");
        assertFalse(porEmail.isEmpty(), "Deve encontrar cliente pelo email");
    }
}
```

💡 Explicações

```
@DataJpaTest → sobe apenas contexto JPA, rápido para testar consultas
Testa tanto query derivada quanto native query
Usa banco H2 em memória por padrão
Ideal para validar acesso a dados e mapeamentos
```

# 🧩 10.2 Teste de Service

```
@SpringBootTest
class ClienteServiceTest {

    @Autowired
    private ClienteService service;

    @Test
    void deveSalvarCliente() {
        // Arrange
        Cliente cliente = new Cliente();
        cliente.setNome("Maria");
        cliente.setEmail("maria@email.com");

        // Act
        Cliente salvo = service.salvar(cliente);

        // Assert
        assertNotNull(salvo.getId(), "ID do cliente não pode ser nulo");
        assertEquals("Maria", salvo.getNome());
    }

    @Test
    void deveListarClientes() {
        // Act
        List<Cliente> lista = service.listar();

        // Assert
        assertNotNull(lista, "A lista não pode ser nula");
    }

    @Test
    void deveBuscarPorNome() {
        // Act
        List<Cliente> encontrados = service.buscarPorNome("Maria");

        // Assert
        assertFalse(encontrados.isEmpty(), "Deve encontrar clientes com o nome Maria");
    }

    @Test
    void deveBuscarPorEmail() {
        // Act
        List<Cliente> encontrados = service.buscarPorEmail("maria@email.com");

        // Assert
        assertFalse(encontrados.isEmpty(), "Deve encontrar clientes pelo email");
    }
}
```

💡 Explicações

```
@SpringBootTest → sobe contexto completo do Spring, incluindo Repositories
Testa regras de negócio do Service
Usa asserts para validar comportamento esperado
Não testa endpoints (foco exclusivo em Service + Repository)
```

# ✅ 10.3 Boas práticas

```
Criar uma classe de teste por Service/Repository
Nomear métodos de teste com verbos descritivos (deveSalvarCliente)
Separar testes unitários (Repository) de integração (Service)
Utilizar banco em memória (H2) para testes rápidos
Validar todos os cenários críticos: salvar, listar, buscar, atualizar, deletar
Evitar lógica complexa dentro de testes — testar comportamento, não implementação
```

🧠 10.4 Resumo das anotações

| Tipo de teste               | Anotação          | Camada     | Observações                                 |
|-----------------------------|-------------------|------------|---------------------------------------------|
| Unitário Repository         | `@DataJpaTest`    | Repository | Testa queries e persistência                |
| Unitário/Integração Service | `@SpringBootTest` | Service    | Testa regras de negócio usando Repositories |

---

# Rodar a aplicação

Pelo IDE (IntelliJ, Eclipse, VS Code):

Abra a classe principal com @SpringBootApplication (ex: PedidoApiApplication).
Clique em Run.

Pelo terminal com Gradle:

```
./gradlew bootRun
```
ou, no Windows:

```
gradlew.bat bootRun
```
🟢 A aplicação deve iniciar e no console você verá mensagens do Spring Boot e do Flyway aplicando migrations.

Acessar o console H2

Abra o navegador e vá para:
```
http://localhost:8080/h2-console
```

Na tela de login:

```
Campo	Valor
Driver Class	org.h2.Driver
JDBC URL	jdbc:h2:mem:pedidodb
User Name	sa
Password	(vazio)
Clique em Connect.
```

✅ Agora você está conectado ao banco H2 da aplicação em memória.

Visualizar tabelas e dados

No console H2, você pode executar comandos SQL:

Listar tabelas:
```
SHOW TABLES;
```

Ver dados de clientes:
```
SELECT * FROM cliente;
```

Inserir um novo cliente (opcional):
```
INSERT INTO cliente(nome, email) VALUES('Ana', 'ana@email.com');
```

Atualizar:
```
UPDATE cliente SET nome = 'Ana Maria' WHERE id = 1;
```

Deletar:
```
DELETE FROM cliente WHERE id = 1;
```

Ver SQL gerado pelo JPA

- Se show-sql: true está habilitado, o Spring Boot vai imprimir todos os inserts, updates e selects no terminal quando você rodar os testes ou o service.
- Isso é útil para ver exatamente o que está acontecendo no banco sem abrir o console.


💡 Dicas importantes

```
H2 em memória apaga todos os dados quando a aplicação fecha.
Para manter dados entre reinícios, troque mem por file:
url: jdbc:h2:file:./data/pedidodb
Se quiser ver a estrutura das tabelas do Flyway:
SELECT * FROM flyway_schema_history;
Isso mostra quais migrations já foram aplicadas.
```
