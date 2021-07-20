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
SELECT COUNT(pessoa.nome) FROM pessoa INNER JOIN medico ON pessoa.cpf = paciente.cpf;
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
CREATE OR REPLACE PROCEDURE add_pessoa (novo_cpf VARCHAR2, novo_nome VARCHAR2) IS  
    new_cpf VARCHAR2(14); 
    new_nome VARCHAR2(30); 
    addCpf pessoa.cpf%TYPE; 
    BEGIN  
        new_cpf := novo_cpf; 
        new_nome := novo_nome; 
        INSERT INTO pessoa VALUES (add_pessoa.new_cpf, add_pessoa.new_nome); 
    END;
/
-- Para testar e visualizar o resultado do procedimento acima
EXECUTE add_pessoa ('432.675.839-21', 'Januário Olímpio');
SELECT * from pessoa WHERE cpf = '432.675.839-21'; 

-- Função que retorna o link de uma consulta
-- CREATE FUNCTION
CREATE OR REPLACE FUNCTION get_link_consulta (pessoa_cpf IN VARCHAR2) 
    RETURN VARCHAR2 
    IS resp_link VARCHAR2(50); 
    BEGIN 
        SELECT DISTINCT consulta.link_chamada 
        INTO resp_link 
        FROM consulta, pessoa 
        WHERE ((consulta.cpf_medico = pessoa.cpf) AND (consulta.cpf_medico = pessoa_cpf)) OR ((consulta.cpf_paciente = pessoa.cpf) AND (consulta.cpf_medico = pessoa_cpf)); 
        RETURN (resp_link); 
    END;
/

-- Para testar a função criada acima
DECLARE result_link VARCHAR2(50);
BEGIN
    result_link := get_link_consulta('986.647.000-87');
    DBMS_OUTPUT.PUT_LINE('Link: ' || result_link);
END;
/
-- Cria um indice
-- CREATE INDEX
CREATE INDEX index_pessoa
ON table_pess(nome[,cpf,telefone]);
/
-- Inserir um um ou mais registro
-- INSERT INTO 
INSERT INTO pesso VALUES (add_pessoa.new_cpf,add_pessoa.new_pessoa);
-- Criar views
-- CREATE views
CREATE VIEW Medico
AS SELECT nome,crm
FROM nome
INNER JOIN crm
ON nome =crm;
-- Bloco anonimo
DECLARE
    result_link VARCHAR2(50);
BEGIN
    result_link := get_link_consulta('159.738.879-12');
    DBMS_OUTPUT.PUT_LINE('Link: ' || result_link);
END;

-- HAVING
SELECT idade, COUNT(idade)
FROM pessoa
GROUP BY idade
HAVING COUNT(idade) > 0;

-- USO DE RECORD
--DECLARE 
--TYPE exame_tipo IS RECORD (
--    tipoExame EXAME.TIPO%TYPE ,
--    medicoSolicitante MEDICO.CRM%TYPE,
--    dataSolicitacao DATE NOT NULL,
--    dataResultado DATE NOT NULL
--);

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
