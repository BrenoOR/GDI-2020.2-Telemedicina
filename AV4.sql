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
SELECT COUNT(paciente.nome) FROM paciente INNER JOIN pessoa ON pessoa.cpf = paciente.cpf;
SELECT COUNT(medico.nome) FROM medico INNER JOIN pessoa ON pessoa.cpf = medico.cpf;

-- Selecionar todas as consultas de 2021, e seus respectivos pacientes, médicos, e links da chamada
-- ORDER BY
SELECT DISTINCT paciente.nome, medico.nome, consulta.link_chamada, receita.data_hora_marcacao
FROM paciente, medico, consulta, receita, marcacao
WHERE (consulta.cpf_paciente = paciente.cpf) AND (consulta.cpf_medico = medico.cpf) AND (medico.nome = receita.assinatura)
AND (TO_CHAR(receita.data_hora_marcacao, 'yyyy') = '2021') ORDER BY receita.data_hora_marcacao;
