CREATE TABLE pedido (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY
);

CREATE TABLE produto (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nome VARCHAR(255)
);

CREATE TABLE pedido_produto (
	pedido_id INTEGER,
	produto_id INTEGER,
	PRIMARY KEY (pedido_id, produto_id),
	FOREIGN KEY (pedido_id) REFERENCES pedido(id),
	FOREIGN KEY (produto_id) REFERENCES produto(id)
);