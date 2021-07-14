--Evitar duplicação de tabelas

DROP TABLE pessoa;
DROP TABLE paciente;
DROP TABLE medico;
DROP TABLE exame;
DROP TABLE receita;
DROP TABLE consulta;
DROP TABLE marcacao;
DROP TABLE telefone;
DROP TABLE medicamento;

--Criação de tabelas

CREATE TABLE pessoa (cpf VARCHAR2(14),
                     nome VARCHAR2(30) NOT NULL,
                     CONSTRAINT pessoa_pk_ck PRIMARY KEY (cpf),
                     CONSTRAINT pessoa_ck CHECK (cpf LIKE ('___.___.___-__')));

CREATE TABLE paciente (cpf VARCHAR2(14),
                       nome VARCHAR2(30) NOT NULL,
                       prioridade NUMBER,
                       n_sus NUMBER,
                       nome_plano VARCHAR2(30),
                       CONSTRAINT paciente_pk PRIMARY KEY (cpf),
                       CONSTRAINT paciente_plano_ck CHECK (plano IN ('SIMPLES', 'FAMILIA', 'ESPECIAL', 'PRIME')),
                       CONSTRAINT paciente_cpf_ck CHECK (cpf LIKE ('___.___.___-__')));

CREATE TABLE medico (cpf VARCHAR(14),
                     nome VARCHAR2(30) NOT NULL,
                     crm NUMBER,
                     especialidade VARCHAR2(50),
                     cpf_chefe VARCHAR2(14),
                     CONSTRAINT medico_pk PRIMARY KEY (cpf), 
                     CONSTRAINT medico_cpf_chefe_fk FOREIGN KEY (cpf_chefe) REFERENCES medico (cpf),
                     CONSTRAINT medico_cpf_ck CHECK (cpf LIKE ('___.___.___-__'),
                     CONSTRAINT medico_cpf_chefe_ck CHECK (cpf LIKE ('___.___.___-__'));
                     
                      
CREATE TABLE consulta (link_chamada VARCHAR2(50),
                       cpf_medico VARCHAR2(14),
                       CONSTRAINT consulta_pk PRIMARY KEY (link_chamada),
                       CONSTRAINT consulta_medico_fk FOREIGN KEY (cpf_medico) REFERENCES medico (cpf),
                       CONSTRAINT consulta_cpf_medico_ck CHECK (cpf_medico LIKE ('___.___.___-__')));
                       
CREATE TABLE marcacao (data_hora DATE,
                       CONSTRAINT marcacao_pk PRIMARY KEY (data_hora));
                       
CREATE TABLE telefone (cpf_pessoa VARCHAR2(14) NOT NULL,
                       num_telefone VARCHAR2(11),
                       CONSTRAINT telefone_pk PRIMARY KEY (cpf_pessoa, num_telefone),
                       CONSTRAINT telefone_cpf_pessoa_ck CHECK (cpf_pessoa LIKE '___.___.___-__'),
                       CONSTRAINT telefone_num_telefone_ck CHECK (num_telefone LIKE '(__) _ ____-____'));
                       
CREATE TABLE medicamento (cod_verif_receita NUMBER NOT NULL,
                          nome_medicamento VARCHAR2(30),
                          CONSTRAINT medicamento_pk PRIMARY KEY (cod_verif_receita, nome_medicamento));
                          
CREATE TABLE exame (cpf_paciente VARCHAR2(14),
                    numero NUMBER NOT NULL,
                    tipo VARCHAR2(50),
                    resultado VARCHAR2(100),
                    data_hora_marcacao DATE NOT NULL,
                    CONSTRAINT exame_pk PRIMARY KEY (cpf_paciente, numero),
                    CONSTRAINT exame_marcacao_fk FOREIGN KEY (data_hora_marcacao) REFERENCES marcacao (data_hora),
                    CONSTRAINT exame_cpf_paciente_ck CHECK (cpf_paciente LIKE ('___.___.___-__'));
                    
CREATE TABLE receita (cod_verificacao NUMBER NOT NULL,
                      assinatura VARCHAR2(30),
                      data_hora_marcacao DATE NOT NULL,
                      CONSTRAINT receita_pk PRIMARY KEY (cod_verificacao),
                      CONSTRAINT receira_marcacao_fk FOREIGN KEY (data_hora_marcacao) REFERENCES marcacao (data_hora));


-- Criação de sequências
                        
CREATE SEQUENCE exame_numero
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    ORDER
    CACHE 20;

CREATE SEQUENCE receita_cod_verificacao
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    CACHE 50;
