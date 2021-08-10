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
-- Inserindo dados na tabela de consulta
INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/cfp-biki-icz', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 2350 AND n_sus = 4546;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/pdh-ryth-kwc', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 2094 AND n_sus = 4586;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/ith-gere-kio', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 3305 AND n_sus = 4510;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/tvh-sdfq-wck', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 3405 AND n_sus = 4154;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/vht-bqwz-wtk', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 3567 AND n_sus = 4582;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/ojh-dgad-wep', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 6365 AND n_sus = 4012;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/lht-adfw-sdf', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 4565 AND n_sus = 4896;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/tvh-cvbb-cas', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 9633 AND n_sus = 4543;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/ath-hgjd-lok', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 3565 AND n_sus = 4023;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/thz-hjgy-jhn', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 3512 AND n_sus = 4151;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/ath-fgse-cfs', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 3025 AND n_sus = 3241;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/bhy-asda-ujf', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 3522 AND n_sus = 3247;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/cht-bsdf-qer', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 6834 AND n_sus = 4896;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/has-zahg-gui', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 7325 AND n_sus = 4154;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/sho-rieg-edo', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 6573 AND n_sus = 4586;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/xin-zhao-jng', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 8234 AND n_sus = 4546;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/sha-cori-nga', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 4436 AND n_sus = 4543;

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


-- Adicionando um atributo ao paciente-- Acrescenta o atributo data_nascimento para o tipo tp_pessoa e  
-- o CASCADE propaga essa alteracao para os objetos que herdam de pessoa
ALTER TYPE tp_pessoa
	ADD ATTRIBUTE (data_nascimento VARCHAR2(5)) CASCADE;
	
