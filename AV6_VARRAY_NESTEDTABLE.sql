-- Resetando a sessão.
DROP TABLE tb_receitas;
DROP TABLE tb_consultas;
DROP TABLE tb_medicamentos;
DROP TABLE tb_medicos;
DROP TABLE tb_pacientes;
DROP TYPE tp_receita;
DROP TYPE tp_consulta;
DROP TYPE tp_medico;
DROP TYPE tp_paciente;
DROP TYPE nt_medicamentos;
DROP TYPE tp_medicamento;
DROP TYPE nt_substancias;
DROP TYPE tp_substancia;
DROP TYPE tp_pessoa;
DROP TYPE tp_telefones;
DROP TYPE tp_telefone;
DROP TYPE tp_endereco;

-- Criando os tipos que serão usados.
CREATE TYPE tp_telefone AS OBJECT(
    ddd VARCHAR2(2),
    numero VARCHAR(9),
    MEMBER FUNCTION prettyTel RETURN VARCHAR2,
    MAP MEMBER FUNCTION rawTel RETURN VARCHAR2
);
/

CREATE TYPE BODY tp_telefone AS
    MEMBER FUNCTION prettyTel RETURN VARCHAR2 IS
        BEGIN
            IF LENGTH(numero) = 9 THEN
                RETURN '(' || ddd || ') ' || SUBSTR(numero, 1, 1) || ' ' ||
                        SUBSTR(numero, 2, 4) || '-' || SUBSTR(numero, 6, 4);
            ELSE
                RETURN '(' || ddd || ') ' || SUBSTR(numero, 1, 4) || '-' ||
                        SUBSTR(numero, 5, 4);
            END IF;
        END;
    MAP MEMBER FUNCTION rawTel RETURN VARCHAR2 IS
        BEGIN
            RETURN ddd || numero;
        END;
END;
/

CREATE TYPE tp_telefones AS VARRAY(2) OF tp_telefone;
/

CREATE TYPE tp_endereco AS OBJECT(
    logradouro VARCHAR2(30),
    numero VARCHAR2(4),
    complemento VARCHAR2(30),
    bairro VARCHAR2(15),
    cidade VARCHAR2(15),
    estado VARCHAR2(2),
    cep VARCHAR2(8),
    MEMBER FUNCTION prettyEnd RETURN VARCHAR2
);
/

CREATE TYPE BODY tp_endereco AS
    MEMBER FUNCTION prettyEnd RETURN VARCHAR2 IS
        ender VARCHAR2(500);
        BEGIN
            ender := logradouro || ' - nº ' || numero;
            IF complemento IS NOT NULL THEN
                ender := ender || ' (' || complemento || ')';
            END IF;
            ender := ender || ', ' || bairro || ' - ' || cidade || '/' || estado || '. CEP: ' ||
                        SUBSTR(cep, 1, 2) || '.' || SUBSTR(cep, 3, 3)|| '-' || SUBSTR(cep, 6, 3) || '.';
            RETURN ender;
        END;
END;
/

CREATE TYPE tp_pessoa AS OBJECT(
    cpf VARCHAR2(11),
    nome VARCHAR2(30),
    sexo VARCHAR2(1),
    dataNascimento DATE,
    telefones tp_telefones,
    endereco tp_endereco,
    MEMBER FUNCTION getIdade RETURN NUMBER
)NOT FINAL;
/

CREATE TYPE BODY tp_pessoa AS
    MEMBER FUNCTION getIdade RETURN NUMBER IS
        BEGIN
            RETURN TRUNC((MONTHS_BETWEEN(SYSDATE, dataNascimento)/12), 0);
        END;
END;
/

CREATE TYPE tp_paciente UNDER tp_pessoa(
    sus VARCHAR2(4),
    plano VARCHAR2(15),
    MEMBER FUNCTION prettyPac RETURN VARCHAR2
);
/

CREATE TYPE BODY tp_paciente AS
    MEMBER FUNCTION prettyPac RETURN VARCHAR2 IS
        ident VARCHAR2(500);
        BEGIN
            ident := nome || '. CPF: ' ||
                        SUBSTR(self.cpf, 1, 3) || '.' || SUBSTR(self.cpf, 4, 3) || '.' || SUBSTR(self.cpf, 7, 3) || '-' || SUBSTR(self.cpf, 10, 2) ||
                        '. Idade: ' || self.getIdade() ||
                        '. Fones: ' || telefones(1).prettyTel() || ', ' || telefones(2).prettyTel() ||
                        '. Endereço: ' || endereco.prettyEnd() || ' Número do SUS: ' || sus ||
                        '. Plano de Saúde: ' || plano || '.';
            IF sexo = 'M' THEN
                RETURN 'Sr. ' || ident;
            ELSE
                RETURN 'Sra. ' || ident;
            END IF;
        END;
END;
/

CREATE TYPE tp_medico UNDER tp_pessoa(
    crm VARCHAR2(4),
    especialidade VARCHAR2(15),
    MEMBER FUNCTION prettyMed RETURN VARCHAR2
);
/

ALTER TYPE tp_medico
    ADD ATTRIBUTE (chefe REF tp_medico)
CASCADE;

CREATE TYPE BODY tp_medico AS
    MEMBER FUNCTION prettyMed RETURN VARCHAR2 IS
        ident VARCHAR2(500);
        cNome VARCHAR2(30);
        cCrm VARCHAR2(4);
        BEGIN
            ident := nome || ' - ' || especialidade || '. CRM: ' || crm || '. Fones: ' ||
                        telefones(1).prettyTel() || ', ' || telefones(2).prettyTel() || '.';
            IF chefe IS NOT NULL THEN
                SELECT DEREF(M.chefe).nome INTO cNome FROM tb_medicos M WHERE M.cpf = self.cpf;
                SELECT DEREF(M.chefe).crm INTO cCrm FROM tb_medicos M WHERE M.cpf = self.cpf;
                ident := ident || ' Médico responsável: ' || cNome ||
                            ', CRM ' || cCrm || '.';
            END IF;
            IF sexo = 'M' THEN
                RETURN 'Dr. ' || ident;
            ELSE
                RETURN 'Dra. ' || ident;
            END IF;
        END;
END;
/

CREATE TYPE tp_consulta AS OBJECT(
    medico REF tp_medico,
    paciente REF tp_paciente,
    linkChamada VARCHAR2(50),
    dataHora DATE
);
/

CREATE TYPE tp_substancia AS OBJECT(
    nome VARCHAR2(30),
    quantidade NUMBER,
    unidade VARCHAR2(5),
    MEMBER FUNCTION prettySub RETURN VARCHAR2
);
/

CREATE TYPE BODY tp_substancia AS
    MEMBER FUNCTION prettySub RETURN VARCHAR2 IS
        BEGIN
            RETURN nome || ' ' || quantidade || unidade;
        END;
END;
/

CREATE TYPE nt_substancias AS TABLE OF tp_substancia;
/

CREATE TYPE tp_medicamento AS OBJECT(
    codigo VARCHAR2(5),
    nome VARCHAR2(30),
    laboratorio VARCHAR2(15),
    substancias nt_substancias,
    disponibilidade CHAR(1)
);
/

CREATE TYPE nt_medicamentos AS TABLE OF tp_medicamento;
/

CREATE TYPE tp_receita AS OBJECT(
    codVerificacao VARCHAR2(8),
    dataPrescricao DATE,
    dataValidade DATE,
    medicamentos nt_medicamentos,
    consulta REF tp_consulta
);
/

-- Criando as tabelas que serão usadas.
CREATE TABLE tb_pacientes OF tp_paciente(
    UNIQUE (sus),
    PRIMARY KEY (cpf)
);

CREATE TABLE tb_medicos OF tp_medico(
    UNIQUE (crm),
    PRIMARY KEY (cpf)
);

CREATE TABLE tb_consultas OF tp_consulta(
    PRIMARY KEY (linkChamada, dataHora)
);

CREATE TABLE tb_medicamentos OF tp_medicamento(
    PRIMARY KEY (codigo)
)NESTED TABLE substancias STORE AS tb_substancias;

CREATE TABLE tb_receitas OF tp_receita(
    PRIMARY KEY (codVerificacao)
)NESTED TABLE medicamentos STORE AS tb_nt_medicamentos
(NESTED TABLE substancias STORE AS tb_nt_substancias);

-- Povoando as tabelas.
INSERT INTO tb_pacientes VALUES (tp_paciente('56815654844', 'João da Silva', 'M', TO_DATE('27/05/1993', 'dd/mm/yyyy'),
                                                tp_telefones(tp_telefone('81', '34458888'), tp_telefone('81', '988775456')),
                                                tp_endereco('Rua Fernando Pessoa', '42', 'casa b', 'Centro', 'São Macaparana', 'RO', '51843450'),
                                                '2541', 'Bradesco'));
INSERT INTO tb_pacientes VALUES (tp_paciente('16545654844', 'Anderson Pereira', 'M', TO_DATE('17/02/1973', 'dd/mm/yyyy'),
                                                tp_telefones(tp_telefone('81', '34499988'), tp_telefone('81', '977775456')),
                                                tp_endereco('Rua Domingos Rocha', '200', null, 'Fundão', 'Maracanã', 'TO', '51849950'),
                                                '1341', 'Unimed'));
INSERT INTO tb_pacientes VALUES (tp_paciente('13339654844', 'Carlos Andrade', 'M', TO_DATE('02/11/2002', 'dd/mm/yyyy'),
                                                tp_telefones(tp_telefone('87', '33798888'), tp_telefone('87', '988763356')),
                                                tp_endereco('Avenida Cinco', '142', 'apt 101', 'Centro', 'Tambores', 'AM', '57443450'),
                                                '2510', 'Bradesco'));
INSERT INTO tb_pacientes VALUES (tp_paciente('13278554844', 'Ricardo Meira', 'M', TO_DATE('08/06/1999', 'dd/mm/yyyy'),
                                                tp_telefones(tp_telefone('87', '34458005'), tp_telefone('87', '988775000')),
                                                tp_endereco('Avenida Franco Felix', '20', 'Ao lado da padaria', 'Canudos', 'Marechal Marega', 'AC', '51843000'),
                                                '3331', 'Hapvida'));
INSERT INTO tb_pacientes VALUES (tp_paciente('13219634844', 'André Poveda', 'M', TO_DATE('13/04/1990', 'dd/mm/yyyy'),
                                                tp_telefones(tp_telefone('41', '34459748'), tp_telefone('41', '999975456')),
                                                tp_endereco('Rua Tony Goes', '1', null, 'Dunas', 'São Jorge', 'PR', '51842250'),
                                                '2599', 'Amil'));
INSERT INTO tb_pacientes VALUES (tp_paciente('13215654154', 'Ana Carvalho', 'F', TO_DATE('27/05/1993', 'dd/mm/yyyy'),
                                                tp_telefones(tp_telefone('71', '34452288'), tp_telefone('71', '986695456')),
                                                tp_endereco('Rua Leão', '514', 'apt 602', 'Poço Fundo', 'Canelas', 'MS', '57773450'),
                                                '2991', 'Unimed'));
INSERT INTO tb_pacientes VALUES (tp_paciente('13215654009', 'Marta Alencar', 'F', TO_DATE('27/05/1963', 'dd/mm/yyyy'),
                                                tp_telefones(tp_telefone('19', '21268888'), tp_telefone('19', '988770506')),
                                                tp_endereco('Avenida Borges Filho', '4', 'casa b', 'Penas', 'São Bento', 'RO', '51807450'),
                                                '2941', 'Bradesco'));
INSERT INTO tb_pacientes VALUES (tp_paciente('13652548844', 'Carla Arruda', 'F', TO_DATE('01/10/2012', 'dd/mm/yyyy'),
                                                tp_telefones(tp_telefone('31', '34269888'), tp_telefone('31', '988925456')),
                                                tp_endereco('Rua Antônio Nobre', '72', 'Casa com muro branco', 'Muro Alto', 'Pilares', 'MT', '51844000'),
                                                '0145', 'Unimed'));
INSERT INTO tb_pacientes VALUES (tp_paciente('13215652224', 'Tina Lopes', 'F', TO_DATE('14/05/1998', 'dd/mm/yyyy'),
                                                tp_telefones(tp_telefone('21', '34407788'), tp_telefone('21', '988945456')),
                                                tp_endereco('Rua Padre Rosa', '88', 'apt 11', 'Centro', 'Murão', 'AC', '51855450'),
                                                '1000', 'Amil'));
INSERT INTO tb_pacientes VALUES (tp_paciente('13310654844', 'Karen Joffer', 'F', TO_DATE('31/12/1997', 'dd/mm/yyyy'),
                                                tp_telefones(tp_telefone('11', '34458000'), tp_telefone('11', '988775886')),
                                                tp_endereco('Avenida João Pessoa', '90', 'quadra 3', 'Torrões', 'Moinhos', 'PE', '51845150'),
                                                '3101', 'Hapvida'));

INSERT INTO tb_medicos VALUES (tp_medico('55643389715', 'Marina Cabral', 'F', TO_DATE('15/09/1984', 'dd/mm/yyyy'),
                                            tp_telefones(tp_telefone('87', '21263014'), tp_telefone('87', '994172114')),
                                            tp_endereco('Avenida São Cristovão', '84', 'apt 2001', 'Barra Grande', 'Juracema', 'RN', '58940052'),
                                            '5016', 'Cardiologista', null));
INSERT INTO tb_medicos VALUES (tp_medico('52293389715', 'Paulo Cabral', 'M', TO_DATE('25/10/1983', 'dd/mm/yyyy'),
                                            tp_telefones(tp_telefone('87', '21263014'), tp_telefone('87', '988272114')),
                                            tp_endereco('Avenida São Cristovão', '84', 'apt 2001', 'Barra Grande', 'Juracema', 'RN', '58940052'),
                                            '5015', 'Cardiologista', (SELECT REF(M) FROM tb_medicos M WHERE M.cpf = '55643389715')));
INSERT INTO tb_medicos VALUES (tp_medico('55643389844', 'Paula Andora', 'F', TO_DATE('01/01/1995', 'dd/mm/yyyy'),
                                            tp_telefones(tp_telefone('27', '33363014'), tp_telefone('27', '998272114')),
                                            tp_endereco('Rua Paulo Nunes', '144', null, 'Centro', 'Cosmo', 'SC', '58944452'),
                                            '1017', 'Cardiologista', (SELECT REF(M) FROM tb_medicos M WHERE M.cpf = '55643389715')));
INSERT INTO tb_medicos VALUES (tp_medico('09043389715', 'Mauro Oliveira', 'M', TO_DATE('25/06/1989', 'dd/mm/yyyy'),
                                            tp_telefones(tp_telefone('18', '21263000'), tp_telefone('18', '988882114')),
                                            tp_endereco('Avenida Clovis Moura', '500', 'apt 201', 'Alvorada', 'Tucumã', 'RJ', '59942252'),
                                            '2217', 'Dermatologista', null));
INSERT INTO tb_medicos VALUES (tp_medico('10443389715', 'Pedro Duarte', 'M', TO_DATE('13/03/1971', 'dd/mm/yyyy'),
                                            tp_telefones(tp_telefone('31', '21290014'), tp_telefone('31', '994382114')),
                                            tp_endereco('Rua Aurora', '1', 'quadra 4', 'Salgadinho', 'Praia Grande', 'PR', '58011052'),
                                            '5997', 'Dermatologista', (SELECT REF(M) FROM tb_medicos M WHERE M.cpf = '09043389715')));

INSERT INTO tb_medicamentos VALUES ('0001', 'Dorflex', 'Sanofi',
                                    nt_substancias(tp_substancia('Dipirona Monoidratada', 300, 'mg'),
                                                    tp_substancia('Citrato de Orfenadrina', 35, 'mg'),
                                                    tp_substancia('Cafeína Anidra', 50, 'mg')),
                                    'S');

-- Manipulando as tabelas.
SELECT p.prettyPac() AS Dados_do_Paciente FROM tb_pacientes p;

SELECT m.prettyMed() AS Dados_do_Medico FROM tb_medicos m;

SELECT s.prettySub() AS Dados_da_Substancia FROM tb_medicamentos m, TABLE (m.substancias) s WHERE m.nome = 'Dorflex';