-- CONSULTA À VARRAY
DROP TABLE tb_pessoas_por_medico;
DROP TABLE tb_pessoa;

CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (
	cpf VARCHAR2(14),
	nome VARCHAR2(100),
	idade NUMBER
) NOT FINAL;
/

CREATE TABLE tb_pessoa OF tp_pessoa (
  cpf PRIMARY KEY
);
/

-- CREATING VARRAY
CREATE OR REPLACE TYPE tp_pessoas AS VARRAY(5) of tp_pessoa;
/

CREATE TABLE tb_pessoas_por_medico(
  crm NUMBER,
  pacientes tp_pessoas);
/

INSERT INTO tb_pessoas_por_medico VALUES(
  50740,
  tp_pessoas(
    (tp_pessoa('053.142.336-88','Sheyla Lima', 15)),
    (tp_pessoa('010.532.546-14','José Henrique', 20)),
    (tp_pessoa('839.274.863-02','Lucas Alfredo', 21))
  )
);
/
