DROP TABLE tb_pessoa;
DROP TABLE tb_paciente;
DROP TABLE tb_medico;
DROP TABLE tb_marcacao;
DROP TABLE tb_consulta;
DROP TABLE tb_receita;
DROP TABLE tb_exame;
DROP TABLE tb_medicamento;
DROP TABLE tb_telefone;


--01. CREATE OR REPLACE TYPE
-- Criando o tipo tp_consulta.
CREATE OR REPLACE TYPE tp_consulta AS OBJECT (
  link VARCHAR2(50),
  MEMBER FUNCTION getLink RETURN VARCHAR2,
  MEMBER PROCEDURE setLink(l VARCHAR2)
);
/

-- 02. CREATE OR REPLACE TYPE BODY
-- Implementando a função e o método declarado em  tp_consulta.
CREATE OR REPLACE TYPE BODY tp_consulta AS
  MEMBER FUNCTION getLink RETURN VARCHAR2 IS
    BEGIN
      RETURN link;
    END;
  MEMBER PROCEDURE setLink(l VARCHAR2) IS
    BEGIN
      link := l;
    END;
END;
/
-- Testando o tipo criado.
DECLARE
  cons tp_consulta;
BEGIN
  cons := NEW tp_consulta('https://meet.google.com/lht-adfw-sdf');
  DBMS_OUTPUT.PUT_LINE('Link da consulta: ' || cons.getLink());
  cons.setLink('https://meet.google.com/tvh-cvbb-cas');
  DBMS_OUTPUT.PUT_LINE('Novo link da consulta: ' || cons.getLink());
END;
/

-- 03. MEMBER PROCEDURE 

CREATE OR REPLACE TYPE exam_tp AS OBJECT (
  tipo    VARCHAR2(50),
  resultado    VARCHAR2(50),
  dataex    VARCHAR2(50),
  MEMBER PROCEDURE remarcar(r VARCHAR2)
);
/

--MUDA O VALOR DE RESULTADO PARA REMARCAR
CREATE OR REPLACE TYPE BODY exam_tp AS

  MEMBER PROCEDURE remarcar(r VARCHAR2) IS
    BEGIN
      resultado := r;
    END;
END;
/

DECLARE
  exam exam_tp;
BEGIN
  exam := NEW exam_tp('Glicemia em jejum', 'Ok', '2020-09-21 09:30');
  DBMS_OUTPUT.PUT_LINE('Resultado: ' || exam.resultado);
  exam.remarcar('Remarcar');
  DBMS_OUTPUT.PUT_LINE('Resultado ' || exam.resultado);
END;
/


-- 04. MEMBER FUNCTION
-- Criando o tipo tp_medico.
CREATE OR REPLACE TYPE tp_medico AS OBJECT (
    cpf varchar2(14),
    nome varchar2(100),
    idade NUMBER,
    crm number,
    especialidade varchar2(50),
  salario NUMBER,
  MEMBER FUNCTION getsalario RETURN NUMBER,
  MEMBER FUNCTION salarioanual RETURN NUMBER
);
/

-- Definindo a função declarada em  tp_medico. SALARIO ANUAL
CREATE OR REPLACE TYPE BODY tp_medico AS
  MEMBER FUNCTION getsalario RETURN NUMBER IS
    BEGIN
      RETURN salario;
    END;
 MEMBER FUNCTION salarioanual RETURN NUMBER IS
    BEGIN
      RETURN salario * 12;
    END;
END;
/
-- Testando a função.
DECLARE
  med tp_medico;
BEGIN
  med := NEW tp_medico('112.823.534-03','Igor Eduardo', 15, 425484, 'Dermatologia', 12000);
  DBMS_OUTPUT.PUT_LINE(' Nome: ' || med.nome || ' Especialidade: ' || med.especialidade || ' Salario: ' || med.getsalario());
  DBMS_OUTPUT.PUT_LINE('Salario Anual: ' || med.salarioanual());
END;
/


-- 05. ORDER MEMBER FUNCTION
-- Criando o tipo tp_pessoa.
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (
  cpf VARCHAR2(14),
	nome VARCHAR2(30),
	idade NUMBER,
  MEMBER FUNCTION getNome RETURN VARCHAR2,
  ORDER MEMBER FUNCTION maiorPrioridade(p tp_pessoa) RETURN INTEGER
) NOT FINAL;
/
-- Implementando a função maiorPrioridade definida em tp_pessoa.
CREATE OR REPLACE TYPE BODY tp_pessoa AS
  MEMBER FUNCTION getNome RETURN VARCHAR2 IS
    BEGIN
      RETURN nome;
    END;
  ORDER MEMBER FUNCTION maiorPrioridade(p tp_pessoa) RETURN INTEGER IS
    BEGIN
      IF p.idade < self.idade THEN
        RETURN 1;
      ELSIF p.idade = self.idade THEN
        RETURN 0;
      ELSE
        RETURN -1;
      END IF;
    END;
END;
/
-- Testando a função maiorPrioridade.
DECLARE
  pess1 tp_pessoa;
  pess2 tp_pessoa;
BEGIN
  pess1 := NEW tp_pessoa('053.142.336-88','Sheyla Lima', 15);
  pess2 := NEW tp_pessoa('010.532.546-14','José Henrique', 20);
  CASE pess1.maiorPrioridade(pess2)
    WHEN 1 THEN
      DBMS_OUTPUT.PUT_LINE(pess1.getNome || ' tem maior prioridade que ' || pess2.getNome || '.');
    WHEN 0 THEN
      DBMS_OUTPUT.PUT_LINE(pess1.getNome || ' e ' || pess2.getNome || ' possuem a mesma prioridade.');
    WHEN -1 THEN
      DBMS_OUTPUT.PUT_LINE(pess2.getNome || ' tem maior prioridade que ' || pess1.getNome || '.');
  END CASE;
END;
/

-- 06. MAP MEMBER FUNCTION
CREATE OR REPLACE TYPE tp_medicamento AS OBJECT (

  nome_medicamento VARCHAR2(30),
  laboratorio VARCHAR2(30),
  contraindicacao VARCHAR2(50),
  data_fabricacao varchar2(51),
  data_validade varchar2(51), 
  cod_verif_receita NUMBER,
  cod INTEGER,
  MAP MEMBER FUNCTION medToInt RETURN INTEGER
);
/

CREATE OR REPLACE TYPE BODY tp_medicamento AS 
  MAP MEMBER FUNCTION medToInt RETURN INTEGER IS
  BEGIN
     RETURN cod;
  END medToInt;
END;
/

DECLARE
 mto tp_medicamento;
 
BEGIN
  mto :=NEW tp_medicamento('Paracetamol','Medley','Dengue','21-08-2020','21-08-2022',457,1);
 
DBMS_OUTPUT.PUT_LINE('COD:' || mto.medToInt()); 
  END;
/

-- 07. CONSTRUCTOR FUNCTION
-- Criando o tipo tp_pessoa com um novo construtor.
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (
	cpf VARCHAR2(14),
	nome VARCHAR2(30),
	idade NUMBER,
	CONSTRUCTOR FUNCTION tp_pessoa(nc VARCHAR2, nn VARCHAR2, nd VARCHAR2) RETURN SELF AS RESULT
) NOT FINAL;
/
-- Implementando o novo construtor que calcula a idade da pessoa com base em sua data de nascimento.
CREATE OR REPLACE TYPE BODY tp_pessoa AS
  CONSTRUCTOR FUNCTION tp_pessoa(nc VARCHAR2, nn VARCHAR2, nd VARCHAR2) RETURN SELF AS RESULT IS
    BEGIN
      self.cpf := nc;
      self.nome := nn;
      self.idade := EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(nd, 'yyyy-mm-dd'));
      RETURN;
    END;
END;
/
-- Testando o novo construtor.
DECLARE
  pess tp_pessoa;
BEGIN
  pess := NEW tp_pessoa('581.051.853-57','Igor Mascarenhas', '1993-02-11');
  DBMS_OUTPUT.PUT_LINE('Pessoa: ' || pess.nome || '.');
  DBMS_OUTPUT.PUT_LINE('Idade: ' || pess.idade || '.');
END;
/

-- 08. OVERRIDING MEMBER
-- Criando um tipo pessoa.
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (
  cpf VARCHAR2(14),
	nome VARCHAR2(30),
	idade NUMBER,
  MEMBER FUNCTION getIdentificacao RETURN VARCHAR2
) NOT FINAL;
/
-- Implementando a função getIdentificacao;
CREATE OR REPLACE TYPE BODY tp_pessoa AS
  MEMBER FUNCTION getIdentificacao RETURN VARCHAR2 IS
    BEGIN
      RETURN nome || ' - ' || idade || ' anos.';
    END;
END;
/
-- Criando um tipo médico que herda a função getIdentificacao de tp_pessoa e sobrescreve ela.
CREATE OR REPLACE TYPE tp_medico UNDER tp_pessoa (
  crm NUMBER,
  especialidade VARCHAR2(50),
  cpf_chefe VARCHAR2(14),
  OVERRIDING MEMBER FUNCTION getIdentificacao RETURN VARCHAR2
);
/
-- Implementando a função getIdentificacao para o tipo tp_medico.
CREATE OR REPLACE TYPE BODY tp_medico AS
  OVERRIDING MEMBER FUNCTION getIdentificacao RETURN VARCHAR2 IS
    BEGIN
      RETURN 'Dr. ' || nome || ' - CRM: ' || crm || '.';
    END;
END;
/
-- Testando o comportamento da função em um tipo pessoa e em um tipo médico.
DECLARE
  pess tp_pessoa;
  med tp_medico;
BEGIN
  pess := NEW tp_pessoa('581.051.853-57','Igor Mascarenhas', 20);
  DBMS_OUTPUT.PUT_LINE(pess.getIdentificacao);
  med := NEW tp_medico('025.105.198-45', 'João Kléber', 50, 3305, 'Endocrinologia', '256.941.852-06');
  DBMS_OUTPUT.PUT_LINE(med.getIdentificacao);
END;
/

-- 09. FINAL MEMBER
--Criamos um type tp_pessoa
--aqui declaramos 1 função em tp_pessoa que é FINAL
--ou seja, ela não pode ser sobrescrita pelos tipos derivados
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (

	cpf VARCHAR2(14),
	nome VARCHAR2(100),
	idade NUMBER,
	FINAL MEMBER FUNCTION getNome RETURN VARCHAR2

) NOT FINAL;
/

CREATE OR REPLACE TYPE BODY tp_pessoa AS
    FINAL MEMBER FUNCTION getNome RETURN VARCHAR2 IS
        BEGIN
            RETURN nome;
        END;
END;
/

--Criamos um type tp_medico derivando de tp_pessoa
CREATE OR REPLACE TYPE tp_medico UNDER tp_pessoa (
	crm NUMBER,
	especialidade VARCHAR2(30),
	FINAL MEMBER FUNCTION getCRM RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY tp_medico AS
    FINAL MEMBER FUNCTION getCRM RETURN NUMBER IS
        BEGIN
            RETURN crm;
        END;
END;
/

--Testando a implementação das funções
--Obs.: Caso tentássemos sobrescrever a função
-- getNome de tp_pessoa em tp_medico, teríamos um erro de tipo
-- em tp_medico
DECLARE
    med1 tp_medico;
BEGIN
    med1 := NEW tp_medico('010.532.546-14','José Henrique', 20, 5613, 'Cardiologia');
    DBMS_OUTPUT.PUT_LINE('CRM de ' || med1.getNome || ' é: ' || med1.getCRM);
END;
/

-- 11. HERANÇA DE TIPOS (UNDER/NOT FINAL)
-- Criando o tipo tp_pessoa
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (

	cpf VARCHAR2(14),
	nome VARCHAR2(100),
	idade NUMBER

) NOT FINAL;
/

-- 13. CREATE TABLE OF
-- Criando a tabela de pessoa
CREATE TABLE tb_pessoa OF tp_pessoa (

  cpf PRIMARY KEY

);
/


-- Criando o tipo tp_paciente e fazendo o mesmo herdar os atributos de tp_pessoa
CREATE OR REPLACE TYPE tp_paciente UNDER tp_pessoa (

	n_sus NUMBER,
	plano_saude VARCHAR2(100)

);
/


-- Criando a tabela de paciente
CREATE TABLE tb_paciente OF tp_paciente;                          
/

-- Criando o tipo tp_medico e fazendo o mesmo herdar os atributos de tp_pessoa
CREATE OR REPLACE TYPE tp_medico UNDER tp_pessoa (
/
	crm NUMBER,
	especialidade VARCHAR2(30)

);
/

-- Criando a tabela de medico
CREATE TABLE tb_medico OF tp_medico;
/

-- Criando o tipo tp_marcacao
CREATE OR REPLACE TYPE tp_marcacao AS OBJECT (

  data_hora DATE
  paciente WITH ROWID REFERENCES tb_paciente --14. ROWID

);
/

-- Criando a tabela de marcacao e colocando data_hora como chave primária
CREATE TABLE tb_marcacao OF tp_marcacao (

  data_hora PRIMARY KEY

)
/

-- Criando o tipo tp_consulta
CREATE OR REPLACE TYPE tp_consulta AS OBJECT (

  link_chamada VARCHAR2(50),
  cpf_medico VARCHAR2(14),
  cpf_paciente VARCHAR2(14)

);
/

-- Criando a tabela de consulta e colocando link_chamada como chave primária
CREATE TABLE tb_consulta OF tp_consulta (

  link_chamada PRIMARY KEY

)
/

-- 16. SCOPE I
-- Criando o tipo tp_receita
CREATE OR REPLACE TYPE tp_receita AS OBJECT (

  cod_verificacao NUMBER,
  assinatura VARCHAR2(30)

);
/


-- Criando a tabela de receita e colocando cod_verificacao como chave primária
CREATE TABLE tb_receita OF tp_receita (

  cod_verificacao PRIMARY KEY

)
/


-- Criando o tipo tp_exame
CREATE OR REPLACE TYPE tp_exame AS OBJECT (

  cpf_paciente VARCHAR2(14),
  numero NUMBER,
  tipo VARCHAR2(50),
  resultado VARCHAR2(100),
  data_hora_marcacao DATE

);
/


-- Criando a tabela de exame e colocando numero como chave primária
CREATE TABLE tb_exame OF tp_exame (

  numero PRIMARY KEY

)
/

-- Criando o tipo tp_medicamento
CREATE OR REPLACE TYPE tp_medicamento AS OBJECT (

  nome_medicamento VARCHAR2(30),
  laboratorio VARCHAR2(30),
  contraindicacao VARCHAR2(50),
  data_fabricacao DATE,
  data_validade DATE, 
  cod_verif_receita NUMBER

);
/

-- 10. NOT INSTANTIABLE
-- Criando a tabela de medicamento e colocando nome_medicamento como chave primária
CREATE TABLE tb_medicamento OF tp_medicamento (

  nome_medicamento PRIMARY KEY

) NOT INSTANTIABLE;
/

-- Criando o tipo tp_telefone
CREATE OR REPLACE TYPE tp_telefone AS OBJECT (
  num_telefone VARCHAR2(14),
  CONSTRUCTOR FUNCTION tp_telefone(numero NUMBER) RETURN SELF AS RESULT,
  CONSTRUCTOR FUNCTION tp_telefone(ddd VARCHAR2, numero VARCHAR2) RETURN SELF AS RESULT
);
/

CREATE OR REPLACE TYPE BODY tp_telefone AS
  CONSTRUCTOR FUNCTION tp_telefone (numero NUMBER)
  RETURN SELF AS RESULT IS
  BEGIN
    SELF.num_telefone := '(81)' || SUBSTR(TO_CHAR(numero), 1, 5) || '-' || SUBSTR(TO_CHAR(numero), 6, 9);
    RETURN;
  END;
  CONSTRUCTOR FUNCTION tp_telefone (ddd VARCHAR2, numero VARCHAR2)
  RETURN SELF AS RESULT IS
  BEGIN
    SELF.num_telefone := ddd||numero;
    RETURN;
  END;
END;
/

DECLARE
    tel1 tp_telefone;
    tel2 tp_telefone;
BEGIN
    tel1 := NEW tp_telefone('(87)','99898-0707');
    DBMS_OUTPUT.PUT_LINE(tel1.num_telefone);
    tel2 := NEW tp_telefone(984950555);
    DBMS_OUTPUT.PUT_LINE(tel2.num_telefone);
END;
/


-- Criando a tabela de telefone e colocando num_telefone como chave primária
CREATE TABLE tb_telefone OF tp_telefone (

  num_telefone PRIMARY KEY

);
/


-- 17. INSERT INTO
-- Inserindo dados na tabela de telefone
INSERT INTO tb_telefone VALUES ('053.142.336-88','(81)9 9982-5625');
INSERT INTO tb_telefone VALUES ('010.532.546-14','(87)9 9500-0123');
INSERT INTO tb_telefone VALUES ('839.274.863-02','(56)3 2504-6895');
INSERT INTO tb_telefone VALUES ('153.545.987-13','(41)8 3659-6184');
INSERT INTO tb_telefone VALUES ('986.647.000-87','(17)9 7878-2200');
INSERT INTO tb_telefone VALUES ('923.782.185-87','(81)3 6032-5195');
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
/

-- 15. REF
-- Referencias para Pessoa
SELECT REF(P) FROM tb_pessoa P;
/

-- 18. VALUE
-- Valor para Pessoa
SELECT VALUE(p) into mb FROM tb_pessoa p WHERE p.crm='2350';
/


-- 12. ALTER TYPE
-- Acrescenta o atributo data_nascimento para o tipo tp_pessoa e  
-- o CASCADE propaga essa alteracao para os objetos que herdam de pessoa
ALTER TYPE tp_pessoa
	ADD ATTRIBUTE (data_nascimento VARCHAR2(5)) CASCADE;
/

-- Removendo o atributo data_nascimento do tipo tp_pessoa
ALTER TYPE tp_pessoa 
	DROP ATTRIBUTE (data_nascimento VARCHAR2(5)) CASCADE;
/


-- 19. VARRAY para Pessoa
CREATE OR REPLACE TYPE tp_pessoas AS VARRAY(5) of tp_pessoa;
/

CREATE TABLE tb_pessoas_por_medico(
  crm NUMBER,
  pacientes tp_pessoas);
/

INSERT INTO tb_pessoas_por_medico VALUES(
  50740,
  tp_pessoas(
    ('053.142.336-88','Sheyla Lima', 15),
    ('010.532.546-14','José Henrique', 20),
    ('839.274.863-02','Lucas Alfredo', 21));
/	

-- 20. NESTED TABLE
CREATE OR REPLACE TYPE tp_nt_exames AS TABLE OF tp_exame;
/
	
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
/
