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

-- Referencias para endereco
SELECT REF(e) FROM endereco e;

-- Valor para
SELECT VALUE(p) FROM tb_paciente;
VALUE (P) (nome,cpf);

ALTER TYPE tb_paciente 
	ADD ATTRIBUTE (idade NUMBER);
	
