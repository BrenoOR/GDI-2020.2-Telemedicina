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
INSERT INTO tb_telefone VALUES ('56 3 2504-6895');
INSERT INTO tb_telefone VALUES ('41 8 3659-6184');
INSERT INTO tb_telefone VALUES ('17 9 7878-2200');
INSERT INTO tb_telefone VALUES ('81 3 6032-5195');
INSERT INTO tb_telefone VALUES ('87 5 0282-1668');
INSERT INTO tb_telefone VALUES ('31 9 9747-4820');
INSERT INTO tb_telefone VALUES ('31 9 3048-2750');
INSERT INTO tb_telefone VALUES ('81 9 2472-5359');
INSERT INTO tb_telefone VALUES ('11 9 4002-8922');
INSERT INTO tb_telefone VALUES ('81 9 4648-5329');
INSERT INTO tb_telefone VALUES ('81 9 8379-9071');
INSERT INTO tb_telefone VALUES ('81 9 8263-8104');
INSERT INTO tb_telefone VALUES ('81 9 6379-4567');
INSERT INTO tb_telefone VALUES ('81 9 6886-3546');
INSERT INTO tb_telefone VALUES ('81 9 6886-3546');
INSERT INTO tb_telefone VALUES ('81 9 6986-3946');
INSERT INTO tb_telefone VALUES ('81 9 1304-6931');
INSERT INTO tb_telefone VALUES ('81 9 8886-3546');
INSERT INTO tb_telefone VALUES ('81 9 8786-3546');
INSERT INTO tb_telefone VALUES ('81 9 8586-3546');
INSERT INTO tb_telefone VALUES ('81 9 8286-3546');
INSERT INTO tb_telefone VALUES ('81 9 8886-1246');
INSERT INTO tb_telefone VALUES ('81 9 8889-3546');
INSERT INTO tb_telefone VALUES ('81 9 8886-1666');
INSERT INTO tb_telefone VALUES ('81 9 8886-2513');
INSERT INTO tb_telefone VALUES ('81 9 8286-1546');
INSERT INTO tb_telefone VALUES ('81 9 8886-6869');
INSERT INTO tb_telefone VALUES ('81 9 9997-2577');
INSERT INTO tb_telefone VALUES ('81 9 8286-6869');
INSERT INTO tb_telefone VALUES ('81 9 9297-2577');
INSERT INTO tb_telefone VALUES ('81 9 9297-3577');
INSERT INTO tb_telefone VALUES ('81 9 9215-2577');
INSERT INTO tb_telefone VALUES ('81 9 9497-2677');
INSERT INTO tb_telefone VALUES ('81 9 9197-1377');
INSERT INTO tb_telefone VALUES ('81 9 8897-2577');
INSERT INTO tb_telefone VALUES ('81 9 8887-2577');
INSERT INTO tb_telefone VALUES ('81 9 8867-5577');
INSERT INTO tb_telefone VALUES ('81 9 3302-1565');
INSERT INTO tb_telefone VALUES ('81 9 3202-1565');

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