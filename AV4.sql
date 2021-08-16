-- Script da AV4

-- Alterar a coluna nome para nome2 e vice-versa
ALTER TABLE paciente RENAME COLUMN nome TO nome2;
ALTER TABLE paciente RENAME COLUMN nome2 TO nome;

-- Cruzar dados dos exames com os pacientes
-- INNER JOIN
SELECT * FROM exame INNER JOIN paciente
ON (exame.cpf_paciente = paciente.cpf);

-- Selecionar todos os números de telefone, onde na coluna da esquerda são adicionados
-- apenas médicos
-- LEFT OUTER JOIN
SELECT nome, num_telefone FROM telefone LEFT OUTER JOIN medico
ON (cpf_pessoa = medico.cpf);

-- Selecionar todos os números de telefone de cada pessoa
-- deixando NULL caso não haja.
-- RIGHT OUTER JOIN
SELECT nome, num_telefone FROM telefone RIGHT OUTER JOIN pessoa
ON (cpf_pessoa = pessoa.cpf);

-- Selecionar todos os números de telefone de cada pessoa
-- deixando NULL caso não haja.
-- Achei interessante a diferença nos selects entre o RIGHT e o FULL
-- FULL OUTER JOIN
SELECT nome, num_telefone FROM telefone FULL OUTER JOIN pessoa
ON (cpf_pessoa = pessoa.cpf);

-- Selecionar médico chefe da clínica ou selecionar empregados
-- IS NULL
SELECT nome, cpf, crm FROM medico WHERE cpf_chefe IS NULL;
-- IS NOT NULL
SELECT nome, cpf, crm FROM medico WHERE cpf_chefe IS NOT NULL; 


-- Contar o número total de pessoas cadastradas
-- ou o número de pacientes cadastrados
-- ou o número de médicos cadastrados
-- COUNT
SELECT COUNT(nome) FROM pessoa;
SELECT COUNT(pessoa.nome) FROM pessoa INNER JOIN paciente ON pessoa.cpf = paciente.cpf;
SELECT COUNT(pessoa.nome) FROM pessoa INNER JOIN medico ON pessoa.cpf = medico.cpf;

-- Selecionar todas as consultas de 2021, e seus respectivos pacientes, médicos, e links da chamada
-- ORDER BY
SELECT DISTINCT paciente.nome, medico.nome, consulta.link_chamada, receita.data_hora_marcacao
FROM paciente, medico, consulta, receita, marcacao
WHERE (consulta.cpf_paciente = paciente.cpf) AND (consulta.cpf_medico = medico.cpf) AND (medico.nome = receita.assinatura)
AND (TO_CHAR(receita.data_hora_marcacao, 'yyyy') = '2021') ORDER BY receita.data_hora_marcacao;



-- UPDATE: atualizar o plano de saúde de Igor Mascarenhas:
UPDATE paciente SET nome_plano = 'Unimed' WHERE cpf = '581.051.853-57';

-- DELETE: deletar médico Lucas Alfredo:
DELETE FROM medico WHERE crm ='3025';

-- SELECT-FROM-WHERE: selecionar o nome e crm de todos os oftalmologistas:
SELECT nome, crm FROM medico WHERE especialidade = 'Oftalmologia'

-- BETWEEN: selecionar todos os médicos com crm entre 1000 e 4000:
SELECT * FROM medico WHERE crm BETWEEN '1000' AND '4000';

-- IN: selecionar todos os médicos oftalmologistas, clinicos gerais e nutricionistas:
SELECT * FROM medico
WHERE especialidade IN ('Oftalmologia', 'Clínico Geral', 'Nutricionista');

-- LIKE: selecionar todas pessoas com nome iniciado em A:
SELECT * FROM pessoa
WHERE nome LIKE 'A%';

-- MAX: retorna a idade máxima de paciente
SELECT MAX(idade) AS maior_idade
FROM paciente;


-- MIN: retorna a idade mínima de paciente
SELECT MIN(idade) AS menor_idade
FROM paciente;


-- AVG: retorna a média de idade dos pacientes
SELECT AVG (idade) AS media_idade
FROM paciente;

-- GROUP BY conta a quantidade de pessoas por grupo de idade
SELECT idade, COUNT(idade)
FROM pessoa
GROUP BY idade;

-- COUNT: retorna a quantidade total de pacientes contando a partir dos cpfs
SELECT COUNT (cpf) FROM paciente;

-- SUBCONSULTA IN seleciona o nome e a idade do paciente para idade >= 24
SELECT nome, idade FROM paciente WHERE idade IN (SELECT idade from paciente WHERE idade >= 24);


-- SUBCONSULTA ANY seleciona o nome e a idade do paciente para qualquer idade > 24
SELECT nome, idade FROM paciente WHERE idade > ANY (SELECT idade from paciente WHERE idade = 24);


-- SUBCONSULTA ALL seleciona o nome e a idade do paciente para qualquer idade > 10
SELECT nome, idade FROM paciente WHERE idade > ALL (SELECT idade from paciente WHERE idade = 10);


-- Procedimento de cadastro de pessoa
-- CREATE PROCEDURE
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

-- Função que retorna o número de um exame
-- CREATE FUNCTION
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
-- Cria um indice
-- CREATE INDEX
CREATE INDEX cpf_paciente ON paciente
-- Inserir um um ou mais registro
-- INSERT INTO 
INSERT INTO pessoa VALUES ('499.898.482-85', 'Josué Matias', '82');
-- Criar views
-- CREATE views
CREATE VIEW dia_marcacao AS SELECT link_chamada, cpf_medico from consulta AS C WHERE data_hora_marcacao BETWEEN ('2021-09-07','dd-mm-yyyy') AND TO_DATE ('2021-09-07','dd-mm-yyyy')
-- Bloco anonimo
DECLARE
    v_cpf_medico medico.cpf_medico%TYPE := '256.941.852-06';
    v_cpf medico.cpf%TYPE := '256.941.852-06';
BEGIN
    UPDATE medico SET cpf_medico = v_cpf_medico WHERE cpf = v_cpf;
END;

-- HAVING
SELECT idade, COUNT(idade)
FROM pessoa
GROUP BY idade
HAVING idade > 18;

-- Criando uma variável do tipo record com dados sobre um exame que já possui resultado,
-- o atributo validadeExame pode ser usado em alguma verificação para estabelecer se o paciente
-- precisa realizar um novo exame antes de marcar uma nova consulta.
-- USO DE RECORD
DECLARE
    TYPE ExameRecTipo IS RECORD (
        tipoExame exame.tipo%type,
        medicoSolicitante medico.crm%type,
        dataSolicitacao DATE NOT NULL := TO_DATE('2021-01-01 08:00', 'yyyy-mm-dd hh24:mi'),
        validadeExame DATE NOT NULL := TO_DATE('2021-01-01 08:00', 'yyyy-mm-dd hh24:mi'));
    exame_rec ExameRecTipo;
BEGIN
    exame_rec.tipoExame := 'Hemograma';
    exame_rec.medicoSolicitante := 6533;
    exame_rec.dataSolicitacao := TO_DATE('2021-01-01 08:00', 'yyyy-mm-dd hh24:mi');
    exame_rec.validadeExame := TO_DATE('2021-10-01 08:00', 'yyyy-mm-dd hh24:mi');
END;
/

-- Cria um subset com pacientes que possuem plano de saúde do Bradesco,
-- percorre esse subset verificando se a idade deles é maior do que 40 anos,
-- se sim, troca o plano de saúde do paciente para Unimed.
-- FOR IN LOOP
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
--USO DE EXCEPTION WHEN PL#15
--INSERT INTO pessoa (cpf, nome, idade) VALUES ('997.081.354-35','Igor Mascarenhas', 84);
DECLARE -- Olha o cpf de um pessoa que tem o nome Igor Mascarenhas.
    cpf2 pessoa.cpf%type;
BEGIN
    SELECT P.cpf into cpf2 FROM pessoa P WHERE P.nome = 'Igor Mascarenhas'; 
    DBMS_OUTPUT.PUT_LINE('o cpf do pessoa é: ' || cpf2);
EXCEPTION
    WHEN TOO_MANY_ROWS THEN RAISE_APPLICATION_ERROR (-20404 ,'mais de uma pessoa retornada');
END;

-- USO DE SELECT … INTO PL#13
--O exemplo a seguir usa uma SELECT INTO para obter o nome de um medico com base no seu CPF, que é a chave primária da tabela medico.
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

-- Criando uma trigger que é disparada ao tentar incluir ou editar uma marcação com uma data anterior à presente.
-- CREATE OR REPLACE TRIGGER (LINHA)
CREATE OR REPLACE TRIGGER remarcacao
    BEFORE INSERT OR UPDATE ON marcacao
    FOR EACH ROW
    BEGIN
        IF (TO_DATE(:NEW.data_hora, 'yyyy-mm-dd') <= TO_DATE(SYSDATE, 'yyyy-mm-dd')) THEN
            RAISE_APPLICATION_ERROR (-20202,'A nova data da consulta precisa ser posterior ao dia de hoje.');
        END IF;
    END remarcacao;
/

-- USO DE IF ELSIF PL#8
DECLARE -- olha se tem mais Medicos que Pacientes
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


--USO de %TYPE PL#6
DECLARE -- criando uma variavel do mesmo tipo que medico.especialidade
    med_espe medico.especialidade%TYPE;
BEGIN
        SELECT especialidade INTO med_espe FROM medico WHERE nome = 'Agostinho Carrara';
    dbms_output.put_line(med_espe);
END;

-- CASE WHEN

SELECT * FROM medico
CASE
    WHEN medico.crm < 5000 THEN dbms_output.put_line(medico.crm)
    WHEN medico.especialidade = 'Neurologia' THEN dbms_output.put_line(medico.nome)
    ELSE dbms_output.put_line(medico.especialidade)
END;

-- Criando uma variável do tipo record usando %ROWTYPE, dessa forma, temos uma cópia exata de um registro
-- de consulta que podemos "sujar" em alguma operação sem comprometer o estado do banco de dados.
-- %ROWTYPE
DECLARE
    consulta_rec consulta%ROWTYPE;
BEGIN
    SELECT link_chamada, cpf_medico, cpf_paciente INTO consulta_rec FROM consulta WHERE consulta.link_chamada = 'https://meet.google.com/tvh-sdfq-wck';
END;
/

-- USO DO %ROWTYPE #PL7 , CURSOR (OPEN, FETCH e CLOSE) #PL14 , WHILE LOOP #PL11
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

-- Criando trigger que dispara ao tentar inserir ou atualizar uma marcação em um final de semana.
-- CREATE OR REPLACE TRIGGER (COMANDO)
CREATE OR REPLACE TRIGGER diaMarcacao
    BEFORE INSERT OR UPDATE ON marcacao
    BEGIN
        IF (TO_CHAR(SYSDATE, 'DY') in ('SAT', 'SUN')) THEN
            RAISE_APPLICATION_ERROR (-20202,'Marcações só podem ser feitas em dias da semana.');
        END IF;
    END diaMarcacao;
/

-- Simulando um SELECT * FROM pessoa, combinando as tabelas paciente e medico
-- UNION
SELECT nome
FROM medico
UNION
SELECT nome
FROM paciente
ORDER BY nome;

-- Filtrando os cpfs de medicos / pacientes que têm um telefone cadastrado
-- INTERSECT
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
-- MINUS
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

-- Seleciona quais médicos são mais velhos que o paciente mais velho.
-- SUBCONSULTA COM OPERADOR RELACIONAL
SELECT * FROM medico WHERE idade > (SELECT MAX(idade) FROM paciente) ORDER BY nome;

-- Procedimento que retorna o nome e o telefone do médico que atenderá uma consulta.
-- USO DE PAR METROS (IN, OUT ou IN OUT)
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
