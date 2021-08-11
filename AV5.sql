DROP TABLE tb_pessoa;
DROP TABLE tb_paciente;
DROP TABLE tb_medico;
DROP TABLE tb_marcacao;
DROP TABLE tb_consulta;
DROP TABLE tb_receita;
DROP TABLE tb_exame;
DROP TABLE tb_medicamento;
DROP TABLE tb_telefone;


-- Criando o tipo tp_pessoa
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (

	cpf VARCHAR2(14),
	nome VARCHAR2(100),
	idade NUMBER

) NOT FINAL;

-- Criando a tabela de pessoa

CREATE TABLE tb_pessoa OF tp_pessoa (

  cpf PRIMARY KEY

);

-- Criando o tipo tp_paciente e fazendo o mesmo herdar os atributos de tp_pessoa
CREATE OR REPLACE TYPE tp_paciente UNDER tp_pessoa (

	n_sus NUMBER,
	plano_saude VARCHAR2(100)

);

-- Criando a tabela de paciente
CREATE TABLE tb_paciente OF tp_paciente;                          


-- Criando o tipo tp_medico e fazendo o mesmo herdar os atributos de tp_pessoa
CREATE OR REPLACE TYPE tp_medico UNDER tp_pessoa (

	crm NUMBER,
	especialidade VARCHAR2(30)

);

-- Criando a tabela de medico
CREATE TABLE tb_medico OF tp_medico;


-- Criando o tipo tp_marcacao
CREATE OR REPLACE TYPE tp_marcacao AS OBJECT (

  data_hora DATE

);

-- Criando a tabela de marcacao e colocando data_hora como chave primária
CREATE TABLE tb_marcacao OF tp_marcacao (

  data_hora PRIMARY KEY

)


-- Criando o tipo tp_consulta
CREATE OR REPLACE TYPE tp_consulta AS OBJECT (

  link_chamada VARCHAR2(50),
  cpf_medico VARCHAR2(14),
  cpf_paciente VARCHAR2(14)

);

-- Criando a tabela de consulta e colocando link_chamada como chave primária
CREATE TABLE tb_consulta OF tp_consulta (

  link_chamada PRIMARY KEY

)


-- Criando o tipo tp_receita
CREATE OR REPLACE TYPE tp_receita AS OBJECT (

  cod_verificacao NUMBER,
  assinatura VARCHAR2(30)

);

-- Criando a tabela de receita e colocando cod_verificacao como chave primária
CREATE TABLE tb_receita OF tp_receita (

  cod_verificacao PRIMARY KEY

)


-- Criando o tipo tp_exame
CREATE OR REPLACE TYPE tp_exame AS OBJECT (

  cpf_paciente VARCHAR2(14),
  numero NUMBER,
  tipo VARCHAR2(50),
  resultado VARCHAR2(100),
  data_hora_marcacao DATE

);

-- Criando a tabela de exame e colocando numero como chave primária
CREATE TABLE tb_exame OF tp_exame (

  numero PRIMARY KEY

)

-- Criando o tipo tp_medicamento
CREATE OR REPLACE TYPE tp_medicamento AS OBJECT (

  nome_medicamento VARCHAR2(30),
  laboratorio VARCHAR2(30),
  contraindicacao VARCHAR2(50),
  data_fabricacao DATE,
  data_validade DATE, 
  cod_verif_receita NUMBER

);

-- Criando a tabela de medicamento e colocando nome_medicamento como chave primária
CREATE TABLE tb_medicamento OF tp_medicamento (

  nome_medicamento PRIMARY KEY

)

-- Criando o tipo tp_telefone
CREATE OR REPLACE TYPE tp_telefone AS OBJECT (

  cpf_pessoa VARCHAR2(14),
  num_telefone NUMBER

);

-- Criando a tabela de telefone e colocando num_telefone como chave primária
CREATE TABLE tb_telefone OF tp_telefone (

  num_telefone PRIMARY KEY

)
-- Inserindo dados na tabela de telefone
INSERT INTO tb_telefone VALUES ('053.142.336-88','(81)9 9982-5625');
INSERT INTO tb_telefone VALUES ('010.532.546-14','(87)9 9500-0123');
INSERT INTO tb_telefone VALUES ('839.274.863-02','(56)3 2504-6895');
INSERT INTO tb_telefone VALUES ('153.545.987-13','(41)8 3659-6184');
INSERT INTO tb_telefone VALUES ('986.647.000-87','(17)9 7878-2200');
INSERT INTO tb_telefone VALUES ('923.782.185-87','(81)3 6014-5195');
INSERT INTO tb_telefone VALUES ('159.738.879-12','(87)5 0282-1668');
INSERT INTO tb_telefone VALUES ('025.105.198-45','(31)9 9747-4820');
INSERT INTO tb_telefone VALUES ('012.654.574-38','(31)9 3048-2750');
INSERT INTO tb_telefone VALUES ('145.896.745-15','(81)9 2472-5359');
INSERT INTO tb_telefone VALUES ('256.941.852-06','(11)9 4002-8922');
INSERT INTO tb_telefone VALUES ('985.531.992-06','(81)9 4648-5329');
INSERT INTO tb_telefone VALUES ('723.963.381-43','(81)9 8379-9071');
INSERT INTO tb_telefone VALUES ('301.460.684-13','(81)9 8263-8104');
INSERT INTO tb_telefone VALUES ('743.516.623-64','(81)9 6379-4567');
INSERT INTO tb_telefone VALUES ('997.081.354-35','(81)9 6886-3546');
INSERT INTO tb_telefone VALUES ('581.051.853-57','(81)9 6886-3546');
INSERT INTO tb_telefone VALUES ('375.583.690-63','(81)9 6986-3946');
INSERT INTO tb_telefone VALUES ('537.098.853-62','(81)9 1304-6931');
INSERT INTO tb_telefone VALUES ('864.652.931-82','(81)9 8886-3546');
INSERT INTO tb_telefone VALUES ('583.451.591-57','(81)9 8786-3546');
INSERT INTO tb_telefone VALUES ('841.915.678-03','(81)9 8586-3546');
INSERT INTO tb_telefone VALUES ('642.351.905-84','(81)9 8286-3546');
INSERT INTO tb_telefone VALUES ('158.910.538-32','(81)9 8886-1246');
INSERT INTO tb_telefone VALUES ('689.539.958-23','(81)9 8889-3546');
INSERT INTO tb_telefone VALUES ('786.962.193-38','(81)9 8886-1666');
INSERT INTO tb_telefone VALUES ('135.581.486-85','(81)9 8886-2513');
INSERT INTO tb_telefone VALUES ('440.581.784-01','(81)9 8286-1546');
INSERT INTO tb_telefone VALUES ('232.101.104-00','(81)9 8886-6869');
INSERT INTO tb_telefone VALUES ('400.898.482-31','(81)9 9997-2577');
-- Inserindo dados na tabela de pessoas
INSERT INTO tb_pessoa VALUES ('053.142.336-88','Sheyla Lima', 15);
INSERT INTO tb_pessoa VALUES ('010.532.546-14','José Henrique', 20);
INSERT INTO tb_pessoa VALUES ('839.274.863-02','Lucas Alfredo', 21);
INSERT INTO tb_pessoa VALUES ('153.545.987-13','Lara Maria', 22);
INSERT INTO tb_pessoa VALUES ('986.647.000-87','Alberto Roberto', 30);
INSERT INTO tb_pessoa VALUES ('923.782.185-87','Josué Aguiar', 35);
INSERT INTO tb_pessoa VALUES ('159.738.879-12','Ana Souza', 14);
INSERT INTO tb_pessoa VALUES ('025.105.198-45','João Kléber', 50);
INSERT INTO tb_pessoa VALUES ('012.654.574-38','Arthur da Silva', 18);
INSERT INTO tb_pessoa VALUES ('145.896.745-15','Roberta Lorena', 22);
INSERT INTO tb_pessoa VALUES ('256.941.852-06','Agostinho Carrara', 45);
INSERT INTO tb_pessoa VALUES ('985.531.992-06','Sheyla Carvalho', 31);
INSERT INTO tb_pessoa VALUES ('723.963.381-43','Ronaldo Alves', 29);
INSERT INTO tb_pessoa VALUES ('301.460.684-13','Ed Motta', 22);
INSERT INTO tb_pessoa VALUES ('743.516.623-64','Carla Perez', 44);
INSERT INTO tb_pessoa VALUES ('997.081.354-35','Igor Mascarenhas', 84);
INSERT INTO tb_pessoa VALUES ('581.051.853-57','Igor Mascarenhas', 38);
INSERT INTO tb_pessoa VALUES ('375.583.690-63','Breno Rodrigues', 35);
INSERT INTO tb_pessoa VALUES ('537.098.853-62','Natan Neto', 15);
INSERT INTO tb_pessoa VALUES ('864.652.931-82','Felipe França', 18);
INSERT INTO tb_pessoa VALUES ('583.451.591-57','Pedro Henrique', 20);
INSERT INTO tb_pessoa VALUES ('841.915.678-03','Eduardo Conti', 34);
INSERT INTO tb_pessoa VALUES ('642.351.905-84','Rose Galdino', 45);
INSERT INTO tb_pessoa VALUES ('158.910.538-32','Cassi Avelar', 20);
INSERT INTO tb_pessoa VALUES ('689.539.958-23','Cortana da Silva', 70);
INSERT INTO tb_pessoa VALUES ('786.962.193-38','Larissa da Costa', 75);
INSERT INTO tb_pessoa VALUES ('135.581.486-85','Abraão Bezerra', 24);
INSERT INTO tb_pessoa VALUES ('440.581.784-01','Isaque Farias', 30);
INSERT INTO tb_pessoa VALUES ('232.101.104-00','Raquel Teixeira', 63);
INSERT INTO tb_pessoa VALUES ('400.898.482-31','Josué Matias', 82);


-- Referencias para Pessoa
SELECT REF(P) FROM tb_pessoa P;

-- Valor para Pessoa
SELECT VALUE(p) into mb FROM tb_pessoa p WHERE p.crm='2350';


-- Acrescenta o atributo data_nascimento para o tipo tp_pessoa e  
-- o CASCADE propaga essa alteracao para os objetos que herdam de pessoa
ALTER TYPE tp_pessoa
	ADD ATTRIBUTE (data_nascimento VARCHAR2(5)) CASCADE;
	
-- VARRAY para Pessoa

CREATE OR REPLACE TYPE tp_pessoas AS VARRAY(5) of tp_pessoa;

CREATE TABLE tb_pessoas_por_medico(
  crm NUMBER,
  pacientes tp_pessoas);

INSERT INTO tb_pessoas_por_medico VALUES(
  50740,
  tp_pessoas(
    ('053.142.336-88','Sheyla Lima', 15),
    ('010.532.546-14','José Henrique', 20),
    ('839.274.863-02','Lucas Alfredo', 21));

-- NESTED TABLE

CREATE OR REPLACE TYPE tp_nt_exames AS TABLE OF tp_exame;

CREATE TABLE tb_exames_solicitados(
  crm_medico NUMBER,
  n_sus_paciente NUMBER,
  lista_exames tp_nt_exames)
NESTED TABLE lista_exames STORE AS tb_lista_exames;

INSERT INTO tb_exames_solicitados VALUES(
  50740,
  11369,
  tp_nt_exames(
    tp_exame('400.898.482-31', 1, 'Raio-X Perna', 'Fratura não detectada.', TO_DATE('11/08/2021', 'dd/mm/yyyy')),
    tp_exame('400.898.482-31', 2, 'Raio-X Pé', 'Fratura não detectada.', TO_DATE('11/08/2021', 'dd/mm/yyyy')),
    tp_exame('400.898.482-31', 3, 'Raio-X Joelho', 'Fratura não detectada.', TO_DATE('11/08/2021', 'dd/mm/yyyy')),
  ));
