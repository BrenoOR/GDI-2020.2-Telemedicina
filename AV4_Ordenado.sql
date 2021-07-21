-- Script da AV4
--(PRECISA REVISAR: #35)
--(PRECISA FAZER: #28)

-- #01 ALTER TABLE
-- Alterar a coluna nome para nome2 e vice-versa.
ALTER TABLE paciente RENAME COLUMN nome TO nome2;
ALTER TABLE paciente RENAME COLUMN nome2 TO nome;

-- #02 CREATE INDEX
-- Cria um indice.
/*Cria, mas não sabemos como verificar*/
CREATE INDEX cpf_paciente ON paciente (cpf, nome);

-- #03 INSERT INTO 
-- Inserir um um ou mais registro.
INSERT INTO pessoa VALUES ('499.898.482-85', 'Josué Matias', 82);

-- #04 UPDATE
-- Atualizar o plano de saúde de Igor Mascarenhas.
UPDATE paciente SET nome_plano = 'Unimed' WHERE cpf = '581.051.853-57';

-- #05 DELETE
-- Deletar um número de telefone.
DELETE FROM telefone WHERE num_telefone = '(81) 9 9999-5555';

-- #06 SELECT-FROM-WHERE
-- Selecionar o nome e crm de todos os oftalmologistas.
SELECT nome, crm FROM medico WHERE especialidade = 'Oftalmologia';

-- #07 BETWEEN
-- Selecionar todos os médicos com crm entre 1000 e 4000.
SELECT * FROM medico WHERE crm BETWEEN '1000' AND '4000';

-- #08 IN
-- Selecionar todos os médicos oftalmologistas, clinicos gerais e nutricionistas.
SELECT * FROM medico
WHERE especialidade IN ('Oftalmologia', 'Clínica Médica', 'Nutrologia');

-- #09 LIKE
-- Selecionar todas pessoas com nome iniciado em A.
SELECT * FROM pessoa
WHERE nome LIKE 'A%';

-- #10 IS NULL ou IS NOT NULL
-- Selecionar médico chefe da clínica ou selecionar empregados.
SELECT nome, cpf, crm FROM medico WHERE cpf_chefe IS NULL;
SELECT nome, cpf, crm FROM medico WHERE cpf_chefe IS NOT NULL;

-- #11 INNER JOIN
-- Cruzar (juntar) dados dos exames com os pacientes.
SELECT * FROM exame INNER JOIN paciente
ON (exame.cpf_paciente = paciente.cpf);

-- #12 MAX
-- Retorna a idade máxima de paciente.
SELECT MAX(idade) AS maior_idade
FROM paciente;

-- #13 MIN
-- Retorna a idade mínima de paciente.
SELECT MIN(idade) AS menor_idade
FROM paciente;

-- #14 AVG
-- Retorna a média de idade dos pacientes.
SELECT AVG (idade) AS media_idade
FROM paciente;

-- #15 COUNT
-- Contar o número total de pessoas cadastradas,
-- ou o número de pacientes cadastrados,
-- ou o número de médicos cadastrados.
SELECT COUNT(nome) FROM pessoa;
SELECT COUNT(pessoa.nome) FROM pessoa INNER JOIN paciente ON pessoa.cpf = paciente.cpf;
SELECT COUNT(pessoa.nome) FROM pessoa INNER JOIN medico ON pessoa.cpf = medico.cpf;

-- #16 LEFT ou RIGHT ou FULL OUTER JOIN
-- Selecionar todos os números de telefone, onde na coluna da esquerda são adicionados
-- apenas médicos.
SELECT nome, num_telefone FROM telefone LEFT OUTER JOIN medico
ON (cpf_pessoa = medico.cpf);
-- Selecionar todos os números de telefone de cada pessoa
-- deixando NULL caso não haja.
SELECT nome, num_telefone FROM telefone RIGHT OUTER JOIN pessoa
ON (cpf_pessoa = pessoa.cpf);
-- Selecionar todos os números de telefone de cada pessoa
-- deixando NULL caso não haja.
-- Achei interessante a diferença nos selects entre o RIGHT e o FULL.
SELECT nome, num_telefone FROM telefone FULL OUTER JOIN pessoa
ON (cpf_pessoa = pessoa.cpf);

-- #17 SUBCONSULTA COM OPERADOR RELACIONAL
-- Seleciona quais médicos são mais velhos que o paciente mais velho.
SELECT * FROM medico WHERE idade > (SELECT MAX(idade) FROM paciente) ORDER BY nome;

-- #18 SUBCONSULTA COM IN
-- Seleciona o nome e a idade do paciente para idade >= 24.
SELECT nome, idade FROM paciente WHERE idade IN (SELECT idade from paciente WHERE idade >= 24);

-- #19 SUBCONSULTA COM ANY
-- Seleciona o nome e a idade do paciente para qualquer idade > 24.
SELECT nome, idade FROM paciente WHERE idade > ANY (SELECT idade from paciente WHERE idade = 24);

-- #20 SUBCONSULTA COM ALL
-- Seleciona o nome e a idade do paciente para qualquer idade > 10.
SELECT nome, idade FROM paciente WHERE idade > ALL (SELECT idade from paciente WHERE idade = 10);

-- #21 ORDER BY
-- Selecionar todas as consultas de 2021, e seus respectivos pacientes, médicos, e links da chamada.
SELECT DISTINCT paciente.nome, medico.nome, consulta.link_chamada, receita.data_hora_marcacao
FROM paciente, medico, consulta, receita, marcacao
WHERE (consulta.cpf_paciente = paciente.cpf) AND (consulta.cpf_medico = medico.cpf) AND (medico.nome = receita.assinatura)
AND (TO_CHAR(receita.data_hora_marcacao, 'yyyy') = '2021') ORDER BY receita.data_hora_marcacao;

-- #22 GROUP BY
-- Conta a quantidade de pessoas por grupo de idade.
SELECT idade, COUNT(idade)
FROM pessoa
GROUP BY idade;

-- #23 HAVING
-- Conta a quantidade de pessoas por grupo de idade acima de 18 anos.
SELECT idade, COUNT(idade)
FROM pessoa
GROUP BY idade
HAVING idade > 18;

-- #24 UNION ou INTERSECT ou MINUS
-- Simulando um SELECT * FROM pessoa, combinando as tabelas paciente e medico.
SELECT nome
FROM medico
UNION
SELECT nome
FROM paciente
ORDER BY nome;
-- Filtrando os cpfs de medicos / pacientes que têm um telefone cadastrado
SELECT cpf
FROM medico
INTERSECT
SELECT cpf_pessoa
FROM telefone;

SELECT cpf
FROM paciente
INTERSECT
SELECT cpf_pessoa
FROM telefone;
-- Filtrando os cpfs de medicos / pacientes que não têm um telefone cadastrado
SELECT cpf
FROM medico
MINUS
SELECT cpf_pessoa
FROM telefone;

SELECT cpf
FROM paciente
MINUS
SELECT cpf_pessoa
FROM telefone;

-- #25 CREATE VIEW
-- Criaando uma view que mostra os médicos que também são pacientes.
-- DROP VIEW medicoP;
CREATE VIEW medicoP AS
    SELECT medico.nome, medico.crm
    FROM medico
    INNER JOIN paciente
    ON (medico.cpf = paciente.cpf);
-- Testando a view.
INSERT INTO paciente (cpf, nome, idade, n_sus, nome_plano)
SELECT cpf, nome, idade, 2222, 'Unimed' FROM pessoa WHERE cpf = '256.941.852-06';
SELECT * FROM medicoP;

-- #26 GRANTE / REVOKE
-- Dando permissão publica para deletar na tabela telefone e depois revogando essa permissão.
/*Can't view on live sql*/
GRANT DELETE ON telefone TO public;
REVOKE DELETE ON telefone FROM public;

-- #27 USO DE RECORD
-- Criando uma variável do tipo record com dados sobre um exame que já possui resultado,
-- o atributo validadeExame pode ser usado em alguma verificação para estabelecer se o paciente
-- precisa realizar um novo exame antes de marcar uma nova consulta.
DECLARE
    TYPE ExameRecTipo IS RECORD (
        tipoExame exame.tipo%type,
        medicoSolicitante medico.crm%type,
        dataSolicitacao DATE NOT NULL := TO_DATE('2021-01-01 08:00', 'yyyy-mm-dd hh24:mi'),
        validadeExame DATE NOT NULL := TO_DATE('2021-01-01 08:00', 'yyyy-mm-dd hh24:mi'));
    exame_rec ExameRecTipo;
    m_nome medico.nome%TYPE;
BEGIN
    exame_rec.tipoExame := 'Hemograma';
    exame_rec.medicoSolicitante := 3305;
    exame_rec.dataSolicitacao := TO_DATE('2021-01-01 08:00', 'yyyy-mm-dd hh24:mi');
    exame_rec.validadeExame := TO_DATE('2021-10-01 08:00', 'yyyy-mm-dd hh24:mi');
    SELECT nome INTO m_nome FROM medico WHERE crm = exame_rec.medicoSolicitante;
    DBMS_OUTPUT.PUT_LINE('Exame: ' || exame_rec.tipoExame);
    DBMS_OUTPUT.PUT_LINE('Médico solicitante: ' || m_nome);
    DBMS_OUTPUT.PUT_LINE('Data da solicitação: ' || exame_rec.dataSolicitacao);
    DBMS_OUTPUT.PUT_LINE('Validade do exama: ' || exame_rec.validadeExame);
END;
/

-- #28 USO DE ESTRUTURA DE DADOS DO TIPO TABLE
-- PRECISA FAZER

-- #29 BLOCO ANÔNIMO
-- Armazenado o link da consulta de um paciente na variável result_link.
DECLARE
    result_link VARCHAR2(50);
BEGIN
    SELECT link_chamada INTO result_link FROM consulta WHERE cpf_paciente = '537.098.853-62';
    DBMS_OUTPUT.PUT_LINE('Link: ' || result_link);
END;

-- #30 CREATE PROCEDURE
-- Procedimento de cadastro de pessoa.
CREATE OR REPLACE PROCEDURE add_pessoa (novo_cpf VARCHAR2, novo_nome VARCHAR2, nova_idade NUMBER) IS  
    new_cpf VARCHAR2(14); 
    new_nome VARCHAR2(30); 
    new_idade NUMBER;
    addCpf pessoa.cpf%TYPE; 
    BEGIN  
        new_cpf := novo_cpf; 
        new_nome := novo_nome; 
        new_idade := nova_idade;
        INSERT INTO pessoa VALUES (add_pessoa.new_cpf, add_pessoa.new_nome, add_pessoa.new_idade); 
    END;
/
-- Para testar e visualizar o resultado do procedimento acima
EXECUTE add_pessoa ('432.675.839-21', 'Januário Olímpio', 38);
SELECT * from pessoa WHERE cpf = '432.675.839-21'; 

-- #31 CREATE FUNCTION
-- Função que retorna o número de um exame.
CREATE OR REPLACE FUNCTION get_exame_num (paciente_cpf IN VARCHAR2) 
    RETURN NUMBER
    IS resp_exame_num NUMBER; 
    BEGIN 
        SELECT DISTINCT numero
        INTO resp_exame_num
        FROM exame, paciente 
        WHERE (paciente_cpf = paciente.cpf) AND (paciente.cpf = exame.cpf_paciente);
        RETURN resp_exame_num; 
    END;
/
-- Para testar a função criada acima
DECLARE result_exame NUMBER;
BEGIN
    result_exame := get_exame_num('375.583.690-63');
    DBMS_OUTPUT.PUT_LINE('Num: ' || result_exame);
END;
/

-- #32 %TYPE
-- criando uma variavel do mesmo tipo que medico.especialidade.
DECLARE
    med_espe medico.especialidade%TYPE;
BEGIN
        SELECT especialidade INTO med_espe FROM medico WHERE nome = 'Agostinho Carrara';
    dbms_output.put_line(med_espe);
END;

-- #33 %ROWTYPE
-- Criando uma variável do tipo record usando %ROWTYPE, dessa forma, temos uma cópia exata de um registro
-- de consulta que podemos "sujar" em alguma operação sem comprometer o estado do banco de dados.
DECLARE
    consulta_rec consulta%ROWTYPE;
BEGIN
    SELECT link_chamada, cpf_medico, cpf_paciente INTO consulta_rec FROM consulta WHERE consulta.link_chamada = 'https://meet.google.com/tvh-sdfq-wck';
END;
/

-- #34 IF ELSIF
-- Olha se tem mais Medicos que Pacientes.
DECLARE
 total1 number;
 total2 number;
BEGIN
 SELECT COUNT(*) INTO total1 FROM medico;
 SELECT COUNT(*) INTO total2 FROM paciente;
 IF(total1 > total2) THEN
     dbms_output.put_line('Mais Medicos que Pacientes');
 ELSIF(total1 < total2) THEN
    dbms_output.put_line('Mais Pacientes que Medicos');
 ELSE
    dbms_output.put_line('Numero de Medicos e Pacientes iguais');
 END IF;
END;

-- #35 CASE WHEN
-- PRECISA REVISAR
SELECT * FROM medico
ORDER BY
(CASE
    WHEN medico.crm < 5000 THEN medico.crm
    WHEN medico.especialidade = 'Neurologia' THEN medico.nome
    ELSE medico.especialidade
END);

-- #36 LOOP EXIT WHEN
-- Varrendo a tabela de pacientes até encontrar um paciente com idade maior ou igual a 50 anos.
DECLARE
    CURSOR v_pacientes IS
        SELECT * FROM paciente;
    v_paciente  paciente%ROWTYPE;
BEGIN
    FOR v_paciente IN v_pacientes LOOP
        IF v_paciente.idade < 50 THEN
            dbms_output.put_line(v_paciente.nome || ' é muito novo para nossos testes.');
        ELSE
            dbms_output.put_line(v_paciente.nome || ' é um bom candidato para nossos testes.');
        END IF;
        EXIT WHEN v_paciente.idade >= 50;
    END LOOP;
END;
/

-- #37 WHILE LOOP
-- Classificando entre idoso e não idoso.
DECLARE 
    cursor cPessoa IS
    SELECT * from pessoa;
    var_pessoa pessoa%ROWTYPE;
    
BEGIN
    OPEN cPessoa;
    FETCH cPessoa INTO var_pessoa;
    WHILE cPessoa%FOUND 
    LOOP
        IF( var_pessoa.idade > 60) 
        THEN
            dbms_output.put_line('IDOSOS: '|| var_pessoa.nome || '- IDADE: ' || var_pessoa.idade);
        ELSE
            dbms_output.put_line('não idosos: ' || var_pessoa.nome || '- IDADE: ' || var_pessoa.idade);
        END IF;
        FETCH cPessoa INTO var_pessoa;
    END LOOP;
    CLOSE cPessoa;
END;

-- #38 FOR IN LOOP
-- Cria um subset com pacientes que possuem plano de saúde do Bradesco,
-- percorre esse subset verificando se a idade deles é maior do que 40 anos,
-- se sim, troca o plano de saúde do paciente para Unimed.
DECLARE
    CURSOR v_pacientes IS
        SELECT * FROM paciente WHERE nome_plano = 'Bradesco';
    v_paciente  paciente%ROWTYPE;
BEGIN
     FOR v_paciente IN v_pacientes LOOP
        IF v_paciente.idade > 40 THEN
            UPDATE paciente SET nome_plano = 'Unimed' WHERE cpf = v_paciente.cpf;
        END IF;
     END LOOP;
END;
/

-- #39 SELECT … INTO
-- O exemplo a seguir usa uma SELECT INTO para obter o nome de um medico com base no seu CPF, que é a chave primária da tabela medico.
DECLARE
  medico_nome medico.nome%TYPE;
BEGIN
  -- get name of the customer 100 and assign it to l_customer_name
  SELECT nome INTO medico_nome
  FROM medico
  WHERE cpf = '256.941.852-06';
  -- show the customer name
  dbms_output.put_line( medico_nome );
END;

-- #40 CURSOR (OPEN, FETCH e CLOSE)
-- Verificando se uma linha telefônica é local ou de outro DDD.
DECLARE
    CURSOR v_telefones IS
        SELECT * from telefone;
    v_telefone telefone%ROWTYPE;

BEGIN
    OPEN v_telefones;
    FETCH v_telefones INTO v_telefone;
    WHILE v_telefones%FOUND
    LOOP
        IF(v_telefone.num_telefone LIKE '(81%') THEN
            dbms_output.put_line('Esta é uma linha local, para chamar, disque: ' ||
            SUBSTR(v_telefone.num_telefone, 6, 1) || SUBSTR(v_telefone.num_telefone, 8, 4) ||
            SUBSTR(v_telefone.num_telefone, 13, 4) || '.');
        ELSE
            dbms_output.put_line('Esta linha pertence a outro DDD, para chamar, disque: 0 + código da operadora + ' ||
            SUBSTR(v_telefone.num_telefone, 2, 2) || ' + ' || SUBSTR(v_telefone.num_telefone, 6, 1) ||
            SUBSTR(v_telefone.num_telefone, 8, 4) || SUBSTR(v_telefone.num_telefone, 13, 4) || '.');
        END IF;
        FETCH v_telefones INTO v_telefone;
    END LOOP;
    CLOSE v_telefones;
END;
/

-- #41 EXCEPTION WHEN
-- INSERT INTO pessoa (cpf, nome, idade) VALUES ('997.081.354-35','Igor Mascarenhas', 84);
-- Olha o cpf de um pessoa que tem o nome Igor Mascarenhas.
DECLARE
    cpf2 pessoa.cpf%type;
BEGIN
    SELECT P.cpf into cpf2 FROM pessoa P WHERE P.nome = 'Igor Mascarenhas'; 
    DBMS_OUTPUT.PUT_LINE('o cpf do pessoa é: ' || cpf2);
EXCEPTION
    WHEN TOO_MANY_ROWS THEN RAISE_APPLICATION_ERROR (-20404 ,'mais de uma pessoa retornada');
END;

-- #42 USO DE PAR METROS (IN, OUT ou IN OUT)
-- Procedimento que retorna o nome e o telefone do médico que atenderá uma consulta.
CREATE OR REPLACE PROCEDURE tel_med (lk_chm IN consulta.link_chamada%TYPE,
    m_cpf IN OUT consulta.cpf_medico%TYPE, m_nome OUT medico.nome%TYPE,
    tel_m OUT telefone.num_telefone%TYPE) IS
    BEGIN
        SELECT cpf_medico INTO m_cpf FROM consulta WHERE link_chamada = lk_chm;
        SELECT nome INTO m_nome FROM medico WHERE cpf = m_cpf;
        SELECT num_telefone INTO tel_m FROM telefone WHERE cpf_pessoa = m_cpf;
    END;
/
-- Código para testar o procedimento acima.
DECLARE
    m_cpf consulta.cpf_medico%TYPE;
    m_nome medico.nome%TYPE;
    tel_m telefone.num_telefone%TYPE;
    BEGIN
    tel_med('https://meet.google.com/cfp-biki-icz', m_cpf, m_nome, tel_m);
    dbms_output.put_line('Dr. ' || m_nome || '. Tel.: ' || tel_m);
    END;
/

--- #43 CREATE OR REPLACE PACKAGE
-- Package para cadastro de paciente.
CREATE OR REPLACE PACKAGE cadastrar_paciente AS
    PROCEDURE cad_pessoa (novo_cpf VARCHAR2, novo_nome VARCHAR2, nova_idade NUMBER);
    PROCEDURE cad_paciente (novo_cpf VARCHAR2, novo_n_sus NUMBER, novo_plano VARCHAR2);
END cadastrar_paciente;
/



-- #44 CREATE OR REPLACE PACKAGE BODY
-- Package body para o package de cadastro de pacientes.
CREATE OR REPLACE PACKAGE BODY cadastrar_paciente AS
    new_nome VARCHAR2(30);
    novo_nome VARCHAR2(30);
    PROCEDURE cad_pessoa (novo_cpf VARCHAR2, novo_nome VARCHAR2, nova_idade NUMBER) AS
    BEGIN
        cadastrar_paciente.new_nome := novo_nome;
        INSERT INTO pessoa VALUES (novo_cpf, novo_nome, nova_idade);
    END cad_pessoa;
    
    PROCEDURE cad_paciente (novo_cpf VARCHAR2, novo_n_sus NUMBER, novo_plano VARCHAR2) AS
    BEGIN
        cadastrar_paciente.new_nome := novo_nome;
        INSERT INTO paciente (cpf, nome, idade, n_sus, nome_plano)
        SELECT cpf, nome, idade, cad_paciente.novo_n_sus, cad_paciente.novo_plano
        FROM pessoa WHERE cpf = novo_cpf; 
    END cad_paciente;
BEGIN 
    DBMS_OUTPUT.PUT_LINE('Adicionado o pessoa: ' || TO_CHAR(new_nome) );
    DBMS_OUTPUT.PUT_LINE('Adicionado o paciente: ' || TO_CHAR(new_nome) );
END cadastrar_paciente;
/
--Teste do package acima: Inserindo Genivaldo no banco de dados
EXECUTE cadastrar_paciente.cad_pessoa ('523.748.235-53', 'Genivaldo Herrera', 20);
EXECUTE cadastrar_paciente.cad_paciente('523.748.235-53', 6233, 'Cassi');
SELECT * FROM pessoa WHERE cpf = '523.748.235-53';
SELECT * FROM paciente WHERE cpf = '523.748.235-53';

-- #45 CREATE OR REPLACE TRIGGER (COMANDO)
-- Criando trigger que dispara ao tentar inserir ou atualizar uma marcação em um final de semana.
CREATE OR REPLACE TRIGGER diaMarcacao
    BEFORE INSERT OR UPDATE ON marcacao
    BEGIN
        IF (TO_CHAR(SYSDATE, 'DY') in ('SAT', 'SUN')) THEN
            RAISE_APPLICATION_ERROR (-20202,'Marcações só podem ser feitas em dias da semana.');
        END IF;
    END diaMarcacao;
/

-- #46 CREATE OR REPLACE TRIGGER (LINHA)
-- Criando uma trigger que é disparada ao tentar incluir ou editar uma marcação com uma data anterior à presente.
CREATE OR REPLACE TRIGGER remarcacao
    BEFORE INSERT OR UPDATE ON marcacao
    FOR EACH ROW
    BEGIN
        IF (TO_DATE(:NEW.data_hora, 'yyyy-mm-dd') <= TO_DATE(SYSDATE, 'yyyy-mm-dd')) THEN
            RAISE_APPLICATION_ERROR (-20202,'A nova data da consulta precisa ser posterior ao dia de hoje.');
        END IF;
    END remarcacao;
/
