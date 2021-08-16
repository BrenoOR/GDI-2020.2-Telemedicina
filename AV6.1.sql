DROP TABLE tb_pessoa;
DROP TABLE tb_telefone;

CREATE OR REPLACE TYPE tp_telefone AS OBJECT (

  num_telefone VARCHAR2(14),
  CONSTRUCTOR FUNCTION tp_telefone(ddd VARCHAR2, num VARCHAR2) RETURN SELF AS RESULT

)FINAL;

CREATE TABLE tb_telefone OF tp_telefone (

  num_telefone PRIMARY KEY

)

CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (

	cpf VARCHAR2(14),
	nome VARCHAR2(100),
	idade NUMBER,
  num_telefone REF tp_telefone

) NOT FINAL;

CREATE TABLE tb_pessoa OF tp_pessoa (

  cpf PRIMARY KEY

);

INSERT INTO tb_telefone VALUES ('(81)99999-7641');
INSERT INTO tb_telefone VALUES ('(81)99999-7777');


INSERT INTO tb_pessoa VALUES ('053.142.336-88','Sheyla Lima', 15, (SELECT REF(V) FROM tb_telefone V WHERE num_telefone = '(81)99999-7641'));

select deref(P.num_telefone).num_telefone from tb_pessoa P;
