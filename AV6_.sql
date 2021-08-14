-- Resetando a sessão.
DROP TABLE tb_pacientes;
DROP TYPE tp_paciente;
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
                        SUBSTR(numero, 2, 5) || '-' || SUBSTR(numero, 6, 9);
            ELSE
                RETURN '(' || ddd || ') ' || SUBSTR(numero, 1, 4) || '-' ||
                        SUBSTR(numero, 5, 8);
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
        BEGIN
            RETURN logradouro || ' - nº ' || numero || ' (' || complemento || '), ' ||
                    bairro || ', ' || cidade || ' - ' || estado || '. CEP: ' ||
                    SUBSTR(cep, 1, 3) || '.' || SUBSTR(cep, 4, 6) || SUBSTR(cep, 7, 8) || '.';
        END;
END;
/

CREATE TYPE tp_pessoa AS OBJECT(
    cpf VARCHAR2(11),
    nome VARCHAR2(30),
    dataNascimento DATE,
    telefones tp_telefones,
    endereco tp_endereco
)NOT FINAL;
/

CREATE type tp_paciente UNDER tp_pessoa(
    sus VARCHAR2(4),
    plano VARCHAR2(15)
);
/

-- Criando as tabelas que serão usadas.
CREATE TABLE tb_pacientes OF tp_paciente(
    UNIQUE (sus),
    PRIMARY KEY (cpf)
);

-- Povoando as tabelas.
INSERT INTO tb_pacientes VALUES (tp_paciente('13215654844', 'João da Silva', TO_DATE('27/05/1993', 'dd/mm/yyyy'),
                                                tp_telefones(tp_telefone('81', '34458888'), tp_telefone('81', '988775456')),
                                                tp_endereco('Rua Fernando Pessoa', '42', 'casa b', 'Centro', 'São Macaparana', 'RO', '51843450'),
                                                '2541', 'Bradesco'));

-- Manipulando as tabelas.
