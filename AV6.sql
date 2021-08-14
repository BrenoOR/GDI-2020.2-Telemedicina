-- Creating TYPE and TABLE for examples

DROP TABLE tb_pessoa;
/

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

SELECT nome, cpf, idade FROM tb_pessoa ORDER BY nome;
/

-- Start of Consulting

SELECT REF(v) FROM tb_pessoa v WHERE cpf = '400.898.482-31';
/