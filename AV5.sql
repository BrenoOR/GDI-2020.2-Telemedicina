CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (

	nome VARCHAR2(100),
	idade NUMBER,
	telefone NUMBER,
	CPF VARCHAR2(14)

) NOT FINAL;

CREATE OR REPLACE TYPE tp_paciente UNDER tp_pessoa (

	n_sus NUMBER,
	plano_saude VARCHAR2(100)
);


CREATE OR REPLACE TYPE tp_medico UNDER tp_pessoa (

	crm NUMBER,
	especialidade VARCHAR2(30)
);

CREATE TABLE tb_paciente OF tp_paciente;

//Referencias para endereco
SELECT REF(e) FROM endereco e;

//Valor para
SELECT VALUE(p) FROM tb_paciente;
VALUE (P) (nome,cpf);

ALTER TYPE tb_paciente 
	ADD ATTRIBUTE (idade NUMBER);
	
