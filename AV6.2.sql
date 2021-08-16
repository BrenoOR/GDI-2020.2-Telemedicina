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

INSERT INTO tb_telefone VALUES ('(81)99982-5625');
INSERT INTO tb_telefone VALUES ('(56)32504-6895');
INSERT INTO tb_telefone VALUES ('(41)83659-6184');
INSERT INTO tb_telefone VALUES ('(17)97878-2200');
INSERT INTO tb_telefone VALUES ('(81)36032-5195');
INSERT INTO tb_telefone VALUES ('(87)99282-1668');
INSERT INTO tb_telefone VALUES ('(31)99747-4820');
INSERT INTO tb_telefone VALUES ('(31)93048-2750');
INSERT INTO tb_telefone VALUES ('(81)92472-5359');
INSERT INTO tb_telefone VALUES ('(11)94002-8922');
INSERT INTO tb_telefone VALUES ('(81)94648-5329');
INSERT INTO tb_telefone VALUES ('(81)98379-9071');
INSERT INTO tb_telefone VALUES ('(81)98263-8104');
INSERT INTO tb_telefone VALUES ('(81)96379-4567');
INSERT INTO tb_telefone VALUES ('(81)96886-3546');
INSERT INTO tb_telefone VALUES ('(81)96886-3546');
INSERT INTO tb_telefone VALUES ('(81)96986-3946');
INSERT INTO tb_telefone VALUES ('(81)91304-6931');
INSERT INTO tb_telefone VALUES ('(81)98886-3546');
INSERT INTO tb_telefone VALUES ('(81)98786-3546');
INSERT INTO tb_telefone VALUES ('(81)98586-3546');
INSERT INTO tb_telefone VALUES ('(81)98286-3546');
INSERT INTO tb_telefone VALUES ('(81)98886-1246');
INSERT INTO tb_telefone VALUES ('(81)98889-3546');
INSERT INTO tb_telefone VALUES ('(81)98886-1666');
INSERT INTO tb_telefone VALUES ('(81)98886-2513');
INSERT INTO tb_telefone VALUES ('(81)98286-1546');
INSERT INTO tb_telefone VALUES ('(81)98886-6869');
INSERT INTO tb_telefone VALUES ('(81)99997-2577');
INSERT INTO tb_telefone VALUES ('(81)98286-6869');
INSERT INTO tb_telefone VALUES ('(81)99297-2577');
INSERT INTO tb_telefone VALUES ('(81)99297-3577');
INSERT INTO tb_telefone VALUES ('(81)99215-2577');
INSERT INTO tb_telefone VALUES ('(81)99497-2677');
INSERT INTO tb_telefone VALUES ('(81)99197-1377');
INSERT INTO tb_telefone VALUES ('(81)98897-2577');
INSERT INTO tb_telefone VALUES ('(81)98887-2577');
INSERT INTO tb_telefone VALUES ('(81)98867-5577');
INSERT INTO tb_telefone VALUES ('(81)93302-1565');
INSERT INTO tb_telefone VALUES ('(81)93202-1565');

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