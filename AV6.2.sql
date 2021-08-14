-- Creating TYPE and TABLE for examples

DROP TABLE tb_telefone;
/

CREATE OR REPLACE TYPE tp_telefone AS OBJECT (
  num_telefone VARCHAR2(14),
  CONSTRUCTOR FUNCTION tp_telefone(numero NUMBER) RETURN SELF AS RESULT,
  CONSTRUCTOR FUNCTION tp_telefone(ddd VARCHAR2, numero VARCHAR2) RETURN SELF AS RESULT
);
/

CREATE TABLE tb_telefone OF tp_telefone (

  num_telefone PRIMARY KEY

);
/

INSERT INTO tb_telefone VALUES ('81 9 9982-5625');
/
SELECT num_telefone FROM tb_telefone ORDER BY num_telefone;
/

-- SELECT DEREF
SELECT DEREF(num_tefone) FROM tb_telefone;
DEREF(TELEFONE) (num_telefone);
/
---TESTE (Não esta funcionando)
INSERT INTO tb_telefone VALUES 
    ('100.255.003.10','21','9 9959-0001');
INSERT INTO customer_telefones
    SELECT 999,REF(a) from tb_telefone a;
SELECT telefone FROM customer_telefones;
/
SELECT DEREF(telefone) FROM customer_telefones;
DEREF(TELEFONE) (CPF,DDD,FONE)