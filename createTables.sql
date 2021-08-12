DROP TABLE medicamento;
DROP TABLE telefone;
DROP TABLE marcacao;
DROP TABLE exame;
DROP TABLE receita;
DROP TABLE consulta;
DROP TABLE medico;
DROP TABLE paciente;
DROP TABLE pessoa;
DROP SEQUENCE exame_numero_seq;
DROP SEQUENCE receita_cod_verificacao_seq;

--Criação de tabelas

CREATE TABLE pessoa (cpf VARCHAR2(14),
                     nome VARCHAR2(30) NOT NULL,
                     idade NUMBER NOT NULL,
                     CONSTRAINT pessoa_pk PRIMARY KEY (cpf),
                     CONSTRAINT pessoa_cpf_ck CHECK (cpf LIKE ('___.___.___-__')));

CREATE TABLE paciente (cpf VARCHAR2(14),
                       nome VARCHAR2(30) NOT NULL,
                       idade NUMBER NOT NULL,
                       n_sus NUMBER,
                       plano_saude VARCHAR2(30),
                       CONSTRAINT paciente_pk PRIMARY KEY (cpf),
                       CONSTRAINT paciente_plano_saude_ck CHECK (plano_saude IN ('Bradesco', 'Unimed', 'Hapvida', 'SulAmérica', 'Smile Saúde', 'Cassi', 'Amil')),
                       CONSTRAINT paciente_cpf_ck CHECK (cpf LIKE ('___.___.___-__')));

CREATE TABLE medico (cpf VARCHAR(14),
                     nome VARCHAR2(30) NOT NULL,
                     idade NUMBER NOT NULL,
                     crm NUMBER,
                     especialidade VARCHAR2(50),
                     cpf_chefe VARCHAR2(14),
                     CONSTRAINT medico_pk PRIMARY KEY (cpf), 
                     CONSTRAINT medico_cpf_chefe_fk FOREIGN KEY (cpf_chefe) REFERENCES medico (cpf),
                     CONSTRAINT medico_cpf_ck CHECK (cpf LIKE ('___.___.___-__')),
                     CONSTRAINT medico_cpf_medico_ck CHECK (cpf_medico LIKE ('___.___.___-__')));
                     
                      
CREATE TABLE consulta (link_chamada VARCHAR2(50),
                       CONSTRAINT consulta_pk PRIMARY KEY (link_chamada));

CREATE TABLE receita (cod_verificacao NUMBER NOT NULL,
                      assinatura VARCHAR2(30) NOT NULL,
                      link_chamada_consulta VARCHAR2(50),
                      CONSTRAINT cpf_paciente FOREIGN KEY (pessoa_pk) REFERENCES pessoa (cpf), 
                      CONSTRAINT receita_pk PRIMARY KEY (cod_verificacao),
                      CONSTRAINT receita_link_chamada_consulta_fk FOREIGN KEY (link_chamada_consulta) REFERENCES consulta (link_chamada));
                       
CREATE TABLE exame (cod_verif_receita NUMBER NOT NULL,
                    numero NUMBER NOT NULL,
                    tipo VARCHAR2(50),
                    resultado VARCHAR2(100),
                    CONSTRAINT exame_pk PRIMARY KEY (cod_verif_receita, numero));

CREATE TABLE marcacao (data_hora DATE,
                       cpf_paciente VARCHAR2(14),
                       cpf_medico VARCHAR2(14),
                       link_chamada_consulta VARCHAR2(50),
                       CONSTRAINT marcacao_pk PRIMARY KEY (data_hora),
                       CONSTRAINT marcacao_cpf_paciente_fk FOREIGN KEY (cpf_paciente) REFERENCES paciente (cpf),
                       CONSTRAINT marcacao_cpf_medico_fk FOREIGN KEY (cpf_medico) REFERENCES medico (cpf),
                       CONSTRAINT marcacao_link_chamada_consulta_fk FOREIGN KEY (link_chamada_consulta) REFERENCES consulta (link_chamada),
                       CONSTRAINT marcacao_cpf_paciente_ck CHECK (cpf_paciente LIKE ('___.___.___-__')),
                       CONSTRAINT marcacao_cpf_medico_ck CHECK (cpf_medico LIKE ('___.___.___-__')));
                       
CREATE TABLE telefone (cpf_pessoa VARCHAR2(14) NOT NULL,
                       num_telefone VARCHAR2(16),
                       CONSTRAINT telefone_pk PRIMARY KEY (cpf_pessoa, num_telefone),
                       CONSTRAINT telefone_cpf_pessoa_ck CHECK (cpf_pessoa LIKE ('___.___.___-__')),
                       CONSTRAINT telefone_num_telefone_ck CHECK (num_telefone LIKE ('(__) _ ____-____')));
                                        
CREATE TABLE medicamento (nome VARCHAR2(30) NOT NULL,
                          laboratorio VARCHAR2(50) NOT NULL,
                          contraindicacao VARCHAR2(50) NOT NULL,
                          data_fabricacao DATE NOT NULL,
                          data_validade DATE NOT NULL,
                          cod_verif_receita NUMBER NOT NULL,
                          CONSTRAINT medicamento_pk PRIMARY KEY (nome),
                          CONSTRAINT medicamento_cod_verif_receita_fk FOREIGN KEY (cod_verif_receita) REFERENCES receita(cod_verificacao));

-- Criação de sequências
                        
CREATE SEQUENCE exame_numero_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    ORDER
    CACHE 20;

CREATE SEQUENCE receita_cod_verificacao_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    CACHE 50;
