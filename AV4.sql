--Script da AV4

--Alterar a coluna nome para nome2 e vice-versa
ALTER TABLE paciente RENAME COLUMN nome TO nome2;
ALTER TABLE paciente RENAME COLUMN nome2 TO nome;

-- Cruzar dados dos exames com os pacientes
--INNER JOIN
SELECT * FROM exame INNER JOIN paciente
ON (exame.cpf_paciente = paciente.cpf);

--Selecionar médico chefe da clínica ou selecionar empregados
--IS NULL
SELECT nome, cpf, crm FROM medico WHERE cpf_chefe IS NULL;
--IS NOT NULL
SELECT nome, cpf, crm FROM medico WHERE cpf_chefe IS NOT NULL; 

--Selecionar todas as consultas de 2021, e seus respectivos pacientes, médicos, e links da chamada
--ORDER BY
SELECT DISTINCT paciente.nome, medico.nome, consulta.link_chamada, receita.data_hora_marcacao
FROM paciente, medico, consulta, receita, marcacao
WHERE (consulta.cpf_paciente = paciente.cpf) AND (consulta.cpf_medico = medico.cpf) AND (medico.nome = receita.assinatura)
AND (TO_CHAR(receita.data_hora_marcacao, 'yyyy') = '2021') ORDER BY receita.data_hora_marcacao;
