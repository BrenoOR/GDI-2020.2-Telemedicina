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

-- MAX: selecionar o médico com o maior número de crm:
SELECT MAX(crm) AS MaiorCRM
FROM medico;


-- Procedimento de cadastro de pessoa
-- CREATE PROCEDURE
PROCEDURE add_pessoa (novo_cpf VARCHAR2, novo_nome VARCHAR2) IS  
    new_cpf VARCHAR2(14); 
    new_nome VARCHAR2(30); 
    addCpf pessoa.cpf%TYPE; 
    BEGIN  
        new_cpf := novo_cpf; 
        new_nome := novo_nome; 
        INSERT INTO pessoa VALUES (add_pessoa.new_cpf, add_pessoa.new_nome); 
    END;
