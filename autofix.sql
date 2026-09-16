CREATE TABLE clientes(
ID SERIAL PRIMARY KEY,
nome TEXT NOT NULL,
email TEXT UNIQUE NOT NULL,
telefone TEXT NOT NULL,
cpf VARCHAR(11) UNIQUE NOT NULL,
data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE mecanicos(
ID SERIAL PRIMARY KEY,
nome TEXT NOT NULL,
especialidade TEXT NOT NULL,
valor_hora NUMERIC CHECK (valor_hora > 0)
);

CREATE TABLE veiculos(
ID SERIAL PRIMARY KEY,
cleinte_id INT REFERENCES clientes(ID),
placa VARCHAR(7) UNIQUE NOT NULL,
modelo TEXT NOT NULL,
marca TEXT NOT NULL,
ano INT NOT NULL
);


CREATE TABLE ordens_servico(
ID SERIAL PRIMARY KEY,
veiculo_id INT REFERENCES veiculos(ID),
mecanico_id INT REFERENCES mecanicos(ID),
data_abertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
valor_mao_obra NUMERIC NOT NULL ,
CHECK (valor_mao_obra >= 0),
status TEXT DEFAULT 'EM ABERTO' CHECK (status = 'em aberto' or status = 'em andamento' or status = 'cancelado')
);

CREATE TABLE pecas_os(
ID SERIAL PRIMARY KEY,
os_id INT REFERENCES ordens_servico(ID),
nome_peca TEXT NOT NULL,
quantidade NUMERIC NOT NULL CHECK (quantidade > 0),
valor_unitario NUMERIC CHECK (valor_unitario > 0)
);


INSERT INTO clientes (nome, email, telefone, cpf, data_cadastro)
VALUES ('nefario', 'gaybriel@gmail.com', '(48) 8765-4321', '12345678923', '11/09/2002'),
('melzi', 'baldis_basic@gmail.com', '(48) 2384-2354', '81234554321', '10/09/2002'),
('jocaco', 'urso@gmail.com', '(48) 0596-0102', '17382947264', '12/09/2002')
;

INSERT INTO mecanicos (nome, especialidade, valor_hora)
values
('artur', 'Motor', '380.00'),
('joelma', 'Injeção Eletrônica', '350.00'),
('theo', 'Suspensão', '250.00');