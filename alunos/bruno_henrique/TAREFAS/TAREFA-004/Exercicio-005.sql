CREATE TABLE aluno (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nome VARCHAR(100)
);

CREATE TABLE professor (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nome VARCHAR(100)
);

CREATE TABLE disciplina (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nome VARCHAR(100)
);

CREATE TABLE aluno_disciplina (
	aluno_id INTEGER,
	disciplina_id INTEGER,
	PRIMARY KEY (aluno_id, disciplina_id),
	FOREIGN KEY (aluno_id) REFERENCES aluno(id),
	FOREIGN KEY (disciplina_id) REFERENCES disciplina(id)
);

CREATE TABLE professor_disciplina (
	professor_id INTEGER,
	disciplina_id INTEGER,
	PRIMARY KEY (professor_id, disciplina_id),
	FOREIGN KEY (professor_id) REFERENCES professor(id),
	FOREIGN KEY (disciplina_id) REFERENCES disciplina(id)
);
