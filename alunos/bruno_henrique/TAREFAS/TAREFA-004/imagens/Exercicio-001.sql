CREATE TABLE cliente (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nome VARCHAR(100)
);

CREATE TABLE pedido (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	cliente_id INTEGER NOT NULL,
	FOREIGN KEY (cliente_id) REFERENCES cliente(id) ON DELETE CASCADE
)

insert into cliente (nome) VALUES
	('Bruno Henrique'),
	('Natanael Silva'),
	('Ana Clara'),
	('Maria'),
	('Julia');

INSERT INTO pedido (cliente_id) VALUES
	(1),
	(2),
	(3);

SELECT cliente.nome
FROM pedido
INNER JOIN cliente ON
	cliente.id = pedido.cliente_id