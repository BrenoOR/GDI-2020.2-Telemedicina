-- Povoando Pessoas
INSERT INTO pessoa (cpf, nome, idade) VALUES ('053.142.336-88','Sheyla Lima', 15);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('010.532.546-14','José Henrique', 20);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('839.274.863-02','Lucas Alfredo', 21);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('153.545.987-13','Lara Maria', 22);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('986.647.000-87','Alberto Roberto', 30);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('923.782.185-87','Josué Aguiar', 35);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('159.738.879-12','Ana Souza', 14);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('025.105.198-45','João Kléber', 50);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('012.654.574-38','Arthur da Silva', 18);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('145.896.745-15','Roberta Lorena', 22);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('256.941.852-06','Agostinho Carrara', 45);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('985.531.992-06','Sheyla Carvalho', 31);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('723.963.381-43','Ronaldo Alves', 29);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('301.460.684-13','Ed Motta', 22);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('743.516.623-64','Carla Perez', 44);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('997.081.354-35','Igor Mascarenhas', 84);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('581.051.853-57','Igor Mascarenhas', 38);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('375.583.690-63','Breno Rodrigues', 35);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('537.098.853-62','Natan Neto', 15);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('864.652.931-82','Felipe França', 18);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('583.451.591-57','Pedro Henrique', 20);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('841.915.678-03','Eduardo Conti', 34);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('642.351.905-84','Rose Galdino', 45);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('158.910.538-32','Cassi Avelar', 20);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('689.539.958-23','Cortana da Silva', 70);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('786.962.193-38','Larissa da Costa', 75);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('135.581.486-85','Abraão Bezerra', 24);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('440.581.784-01','Isaque Farias', 30);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('232.101.104-00','Raquel Teixeira', 63);
INSERT INTO pessoa (cpf, nome, idade) VALUES ('400.898.482-31','Josué Matias', 82);

-- Paciente
INSERT INTO paciente (cpf, nome, idade, n_sus, nome_plano)
SELECT cpf, nome, idade, 4546, 'Bradesco' FROM pessoa WHERE cpf = '581.051.853-57';

INSERT INTO paciente (cpf, nome, idade, n_sus, nome_plano)
SELECT cpf, nome, idade, 4586, 'Unimed' FROM pessoa WHERE cpf = '375.583.690-63';

INSERT INTO paciente (cpf, nome, idade, n_sus, nome_plano)
SELECT cpf, nome, idade, 4510, 'Hapvida' FROM pessoa WHERE cpf = '537.098.853-62';

INSERT INTO paciente (cpf, nome, idade, n_sus, nome_plano)
SELECT cpf, nome, idade, 4154, 'SulAmérica' FROM pessoa WHERE cpf = '864.652.931-82';

INSERT INTO paciente (cpf, nome, idade, n_sus, nome_plano)
SELECT cpf, nome, idade, 4582, 'Smile Saúde' FROM pessoa WHERE cpf = '583.451.591-57';

INSERT INTO paciente (cpf, nome, idade, n_sus, nome_plano)
SELECT cpf, nome, idade, 4012, 'Amil' FROM pessoa WHERE cpf = '841.915.678-03';

INSERT INTO paciente (cpf, nome, idade, n_sus, nome_plano)
SELECT cpf, nome, idade, 4896, 'Bradesco' FROM pessoa WHERE cpf = '642.351.905-84';

INSERT INTO paciente (cpf, nome, idade, n_sus, nome_plano)
SELECT cpf, nome, idade, 4543, 'Cassi' FROM pessoa WHERE cpf = '158.910.538-32';

INSERT INTO paciente (cpf, nome, idade, n_sus, nome_plano)
SELECT cpf, nome, idade, 4023, 'Bradesco' FROM pessoa WHERE cpf = '689.539.958-23';

INSERT INTO paciente (cpf, nome, idade, n_sus, nome_plano)
SELECT cpf, nome, idade, 4151, 'SulAmérica' FROM pessoa WHERE cpf = '786.962.193-38';

INSERT INTO paciente (cpf, nome, idade, n_sus, nome_plano)
SELECT cpf, nome, idade, 3241, 'Hapvida' FROM pessoa WHERE cpf = '135.581.486-85';

INSERT INTO paciente (cpf, nome, idade, n_sus, nome_plano)
SELECT cpf, nome, idade, 3247, 'Unimed' FROM pessoa WHERE cpf = '440.581.784-01';

INSERT INTO paciente (cpf, nome, idade, n_sus, nome_plano)
SELECT cpf, nome, idade, 2222, 'Unimed' FROM pessoa WHERE cpf = '256.941.852-06';

-- Medico
-- Chefe

INSERT INTO medico (cpf, nome, idade, crm, especialidade, cpf_chefe) 
SELECT cpf, nome, idade, 2094, 'Psicologia', '' FROM pessoa WHERE cpf = '256.941.852-06';

-- Funcionários
INSERT INTO medico (cpf, nome, idade, crm, especialidade, cpf_chefe) 
SELECT cpf, nome, idade, 3565, 'Oftalmologia', '256.941.852-06' FROM pessoa WHERE cpf = '053.142.336-88';

INSERT INTO medico (cpf, nome, idade, crm, especialidade, cpf_chefe) 
SELECT cpf, nome, idade, 3512, 'Dermatologia', '256.941.852-06' FROM pessoa WHERE cpf = '010.532.546-14';

INSERT INTO medico (cpf, nome, idade, crm, especialidade, cpf_chefe) 
SELECT cpf, nome, idade, 3025, 'Clínica Médica', '256.941.852-06' FROM pessoa WHERE cpf = '839.274.863-02';

INSERT INTO medico (cpf, nome, idade, crm, especialidade, cpf_chefe) 
SELECT cpf, nome, idade, 4565, 'Endocrinologia', '256.941.852-06' FROM pessoa WHERE cpf = '153.545.987-13';

INSERT INTO medico (cpf, nome, idade, crm, especialidade, cpf_chefe) 
SELECT cpf, nome, idade, 6365, 'Cardiologia', '256.941.852-06' FROM pessoa WHERE cpf = '986.647.000-87';

INSERT INTO medico (cpf, nome, idade, crm, especialidade, cpf_chefe) 
SELECT cpf, nome, idade, 9633, 'Oftalmologia', '256.941.852-06' FROM pessoa WHERE cpf = '923.782.185-87';

INSERT INTO medico (cpf, nome, idade, crm, especialidade, cpf_chefe) 
SELECT cpf, nome, idade, 3567, 'Clínica Médica', '256.941.852-06' FROM pessoa WHERE cpf = '159.738.879-12';

INSERT INTO medico (cpf, nome, idade, crm, especialidade, cpf_chefe) 
SELECT cpf, nome, idade, 3522, 'Dermatologia', '256.941.852-06' FROM pessoa WHERE cpf = '025.105.198-45';

INSERT INTO medico (cpf, nome, idade, crm, especialidade, cpf_chefe) 
SELECT cpf, nome, idade, 3305, 'Endocrinologia', '256.941.852-06' FROM pessoa WHERE cpf = '012.654.574-38';

INSERT INTO medico (cpf, nome, idade, crm, especialidade, cpf_chefe) 
SELECT cpf, nome, idade, 3405, 'Oftalmologia', '256.941.852-06' FROM pessoa WHERE cpf = '145.896.745-15';

INSERT INTO medico (cpf, nome, idade, crm, especialidade, cpf_chefe) 
SELECT cpf, nome, idade, 6573, 'Nutrologia', '256.941.852-06' FROM pessoa WHERE cpf = '723.963.381-43';

INSERT INTO medico (cpf, nome, idade, crm, especialidade, cpf_chefe) 
SELECT cpf, nome, idade, 6834, 'Psiquiatria', '256.941.852-06' FROM pessoa WHERE cpf = '985.531.992-06';

INSERT INTO medico (cpf, nome, idade, crm, especialidade, cpf_chefe) 
SELECT cpf, nome, idade, 2350, 'Nutrologia', '256.941.852-06' FROM pessoa WHERE cpf = '301.460.684-13';

INSERT INTO medico (cpf, nome, idade, crm, especialidade, cpf_chefe) 
SELECT cpf, nome, idade, 7325, 'Nefrologia', '256.941.852-06' FROM pessoa WHERE cpf = '743.516.623-64';

INSERT INTO medico (cpf, nome, idade, crm, especialidade, cpf_chefe) 
SELECT cpf, nome, idade, 8234, 'Neurologia', '256.941.852-06' FROM pessoa WHERE cpf = '232.101.104-00';

INSERT INTO medico (cpf, nome, idade, crm, especialidade, cpf_chefe) 
SELECT cpf, nome, idade, 4436, 'Neurologia', '256.941.852-06' FROM pessoa WHERE cpf = '400.898.482-31';

-- Povoando consulta
INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/cfp-biki-icz', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 2350 AND n_sus = 4546;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/pdh-ryth-kwc', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 2094 AND n_sus = 4586;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/ith-gere-kio', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 3305 AND n_sus = 4510;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/tvh-sdfq-wck', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 3405 AND n_sus = 4154;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/vht-bqwz-wtk', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 3567 AND n_sus = 4582;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/ojh-dgad-wep', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 6365 AND n_sus = 4012;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/lht-adfw-sdf', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 4565 AND n_sus = 4896;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/tvh-cvbb-cas', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 9633 AND n_sus = 4543;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/ath-hgjd-lok', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 3565 AND n_sus = 4023;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/thz-hjgy-jhn', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 3512 AND n_sus = 4151;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/ath-fgse-cfs', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 3025 AND n_sus = 3241;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/bhy-asda-ujf', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 3522 AND n_sus = 3247;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/cht-bsdf-qer', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 6834 AND n_sus = 4896;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/has-zahg-gui', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 7325 AND n_sus = 4154;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/sho-rieg-edo', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 6573 AND n_sus = 4586;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/xin-zhao-jng', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 8234 AND n_sus = 4546;

INSERT INTO  consulta (link_chamada, cpf_medico, cpf_paciente)
SELECT 'https://meet.google.com/sha-cori-nga', medico.cpf, paciente.cpf
FROM medico, paciente WHERE crm = 4436 AND n_sus = 4543;

-- Povoando marcacao
INSERT INTO marcacao VALUES (TO_DATE ('2021-07-13 14:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO marcacao VALUES (TO_DATE ('2020-08-14 15:30', 'yyyy-mm-dd hh24:mi'));
INSERT INTO marcacao VALUES (TO_DATE ('2020-09-21 09:30', 'yyyy-mm-dd hh24:mi'));
INSERT INTO marcacao VALUES (TO_DATE ('2020-10-24 10:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO marcacao VALUES (TO_DATE ('2020-11-30 08:40', 'yyyy-mm-dd hh24:mi'));
INSERT INTO marcacao VALUES (TO_DATE ('2021-06-14 10:15', 'yyyy-mm-dd hh24:mi'));
INSERT INTO marcacao VALUES (TO_DATE ('2021-06-21 14:20', 'yyyy-mm-dd hh24:mi'));
INSERT INTO marcacao VALUES (TO_DATE ('2021-04-03 16:20', 'yyyy-mm-dd hh24:mi'));
INSERT INTO marcacao VALUES (TO_DATE ('2021-02-17 09:25', 'yyyy-mm-dd hh24:mi'));
INSERT INTO marcacao VALUES (TO_DATE ('2021-02-28 14:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO marcacao VALUES (TO_DATE ('2020-06-21 15:10', 'yyyy-mm-dd hh24:mi'));
INSERT INTO marcacao VALUES (TO_DATE ('2021-05-01 10:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO marcacao VALUES (TO_DATE ('2021-04-04 08:30', 'yyyy-mm-dd hh24:mi'));
INSERT INTO marcacao VALUES (TO_DATE ('2021-03-09 09:20', 'yyyy-mm-dd hh24:mi'));
INSERT INTO marcacao VALUES (TO_DATE ('2021-01-27 15:50', 'yyyy-mm-dd hh24:mi'));
INSERT INTO marcacao VALUES (TO_DATE ('2021-07-19 09:20', 'yyyy-mm-dd hh24:mi'));
INSERT INTO marcacao VALUES (TO_DATE ('2021-09-07 15:50', 'yyyy-mm-dd hh24:mi'));

-- Povoando telefone
INSERT INTO telefone SELECT cpf, '(81) 9 9999-5555' FROM pessoa WHERE cpf = '053.142.336-88';
INSERT INTO telefone SELECT cpf, '(14) 9 3193-8477' FROM pessoa WHERE cpf = '010.532.546-14';
INSERT INTO telefone SELECT cpf, '(52) 9 8282-5729' FROM pessoa WHERE cpf = '839.274.863-02';
INSERT INTO telefone SELECT cpf, '(19) 9 2856-1077' FROM pessoa WHERE cpf = '153.545.987-13';
INSERT INTO telefone SELECT cpf, '(88) 9 8513-4740' FROM pessoa WHERE cpf = '986.647.000-87';
INSERT INTO telefone SELECT cpf, '(27) 9 9644-2468' FROM pessoa WHERE cpf = '923.782.185-87';
INSERT INTO telefone SELECT cpf, '(38) 9 0362-3351' FROM pessoa WHERE cpf = '159.738.879-12';
INSERT INTO telefone SELECT cpf, '(48) 9 1200-4900' FROM pessoa WHERE cpf = '025.105.198-45';
INSERT INTO telefone SELECT cpf, '(61) 9 9203-0994' FROM pessoa WHERE cpf = '012.654.574-38';
INSERT INTO telefone SELECT cpf, '(25) 9 0203-7190' FROM pessoa WHERE cpf = '145.896.745-15';
INSERT INTO telefone SELECT cpf, '(39) 9 8310-4750' FROM pessoa WHERE cpf = '256.941.852-06';
INSERT INTO telefone SELECT cpf, '(55) 9 0116-1728' FROM pessoa WHERE cpf = '985.531.992-06';
INSERT INTO telefone SELECT cpf, '(56) 9 7396-1081' FROM pessoa WHERE cpf = '723.963.381-43';
INSERT INTO telefone SELECT cpf, '(60) 9 1745-0317' FROM pessoa WHERE cpf = '301.460.684-13';
INSERT INTO telefone SELECT cpf, '(12) 9 1376-6526' FROM pessoa WHERE cpf = '743.516.623-64';

-- Povoando exame
INSERT INTO exame 
SELECT cpf, exame_numero.NEXTVAL, 'Acuidade Visual', 'Ok', TO_DATE ('2021-07-13 14:00', 'yyyy-mm-dd hh24:mi')
FROM paciente WHERE cpf = '581.051.853-57';

INSERT INTO exame
SELECT cpf, exame_numero.NEXTVAL, 'Hemograma', 'Ok', TO_DATE ('2020-08-14 15:30', 'yyyy-mm-dd hh24:mi')
FROM paciente WHERE cpf = '841.915.678-03';

INSERT INTO exame
SELECT cpf, exame_numero.NEXTVAL, 'Glicemia em jejum', 'Ok', TO_DATE ('2020-09-21 09:30', 'yyyy-mm-dd hh24:mi')
FROM paciente WHERE cpf = '841.915.678-03';

INSERT INTO exame
SELECT cpf, exame_numero.NEXTVAL, 'Colesterol e Triglicerídeos', 'Ok', TO_DATE ('2020-10-24 10:00', 'yyyy-mm-dd hh24:mi')
FROM paciente WHERE cpf = '158.910.538-32';

INSERT INTO exame
SELECT cpf, exame_numero.NEXTVAL, 'TGO (AST) e TGP (ALT)', 'Ok', TO_DATE ('2020-11-30 08:40', 'yyyy-mm-dd hh24:mi')
FROM paciente WHERE cpf = '375.583.690-63';

INSERT INTO exame
SELECT cpf, exame_numero.NEXTVAL, 'TSH e T4 livre', 'Ok', TO_DATE ('2021-06-14 10:15', 'yyyy-mm-dd hh24:mi')
FROM paciente WHERE cpf = '537.098.853-62';

INSERT INTO exame
SELECT cpf, exame_numero.NEXTVAL, 'Ácido Úrico', 'Ok', TO_DATE ('2021-06-21 14:20', 'yyyy-mm-dd hh24:mi')
FROM paciente WHERE cpf = '864.652.931-82';

INSERT INTO exame
SELECT cpf, exame_numero.NEXTVAL, 'Mamografia', 'Ok', TO_DATE ('2021-04-03 16:20', 'yyyy-mm-dd hh24:mi')
FROM paciente WHERE cpf = '786.962.193-38';

INSERT INTO exame
SELECT cpf, exame_numero.NEXTVAL, 'Teste cardiopulmonar', 'Ok', TO_DATE ('2021-02-17 09:25', 'yyyy-mm-dd hh24:mi')
FROM paciente WHERE cpf = '689.539.958-23';

INSERT INTO exame
SELECT cpf, exame_numero.NEXTVAL, 'Anamnese clínica e esportiva', 'Ok', TO_DATE ('2021-02-28 14:00', 'yyyy-mm-dd hh24:mi')
FROM paciente WHERE cpf = '158.910.538-32';

INSERT INTO exame
SELECT cpf, exame_numero.NEXTVAL, 'Dosagem de PSA', 'Ok', TO_DATE ('2020-06-21 15:10', 'yyyy-mm-dd hh24:mi')
FROM paciente WHERE cpf = '642.351.905-84';

INSERT INTO exame
SELECT cpf, exame_numero.NEXTVAL, 'Avaliação física completa', 'Ok', TO_DATE ('2021-05-01 10:00', 'yyyy-mm-dd hh24:mi')
FROM paciente WHERE cpf = '841.915.678-03';

INSERT INTO exame
SELECT cpf, exame_numero.NEXTVAL, 'Ressonância Magnética', 'Ok', TO_DATE ('2021-04-04 08:30', 'yyyy-mm-dd hh24:mi')
FROM paciente WHERE cpf = '583.451.591-57';

INSERT INTO exame
SELECT cpf, exame_numero.NEXTVAL, 'Tomografia Computadorizada', 'Ok', TO_DATE ('2021-03-09 09:20', 'yyyy-mm-dd hh24:mi')
FROM paciente WHERE cpf = '642.351.905-84';

INSERT INTO exame
SELECT cpf, exame_numero.NEXTVAL, 'Ultra-sonografia', 'Ok', TO_DATE ('2021-01-27 15:50', 'yyyy-mm-dd hh24:mi')
FROM paciente WHERE cpf = '537.098.853-62';

-- Povoando receita
INSERT INTO receita VALUES (receita_cod_verificacao.NEXTVAL, 'Sheyla Lima', TO_DATE ('2021-07-13 14:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO receita VALUES (receita_cod_verificacao.NEXTVAL, 'José Henrique', TO_DATE ('2020-08-14 15:30', 'yyyy-mm-dd hh24:mi'));
INSERT INTO receita VALUES (receita_cod_verificacao.NEXTVAL, 'Lucas Alfredo',  TO_DATE ('2020-09-21 09:30', 'yyyy-mm-dd hh24:mi'));
INSERT INTO receita VALUES (receita_cod_verificacao.NEXTVAL, 'Lara Maria', TO_DATE ('2020-10-24 10:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO receita VALUES (receita_cod_verificacao.NEXTVAL, 'Alberto Roberto', TO_DATE ('2020-11-30 08:40', 'yyyy-mm-dd hh24:mi'));
INSERT INTO receita VALUES (receita_cod_verificacao.NEXTVAL, 'Josué Aguiar', TO_DATE ('2021-06-14 10:15', 'yyyy-mm-dd hh24:mi'));
INSERT INTO receita VALUES (receita_cod_verificacao.NEXTVAL, 'Ana Souza', TO_DATE ('2021-06-21 14:20', 'yyyy-mm-dd hh24:mi'));
INSERT INTO receita VALUES (receita_cod_verificacao.NEXTVAL, 'João Kléber', TO_DATE ('2021-04-03 16:20', 'yyyy-mm-dd hh24:mi'));
INSERT INTO receita VALUES (receita_cod_verificacao.NEXTVAL, 'Arthur da Silva', TO_DATE ('2021-02-17 09:25', 'yyyy-mm-dd hh24:mi'));
INSERT INTO receita VALUES (receita_cod_verificacao.NEXTVAL, 'Roberta Lorena', TO_DATE ('2021-02-28 14:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO receita VALUES (receita_cod_verificacao.NEXTVAL, 'Agostinho Carrara', TO_DATE ('2020-06-21 15:10', 'yyyy-mm-dd hh24:mi'));
INSERT INTO receita VALUES (receita_cod_verificacao.NEXTVAL, 'Sheyla Carvalho', TO_DATE ('2021-05-01 10:00', 'yyyy-mm-dd hh24:mi'));
INSERT INTO receita VALUES (receita_cod_verificacao.NEXTVAL, 'Ronaldo Alves', TO_DATE ('2021-04-04 08:30', 'yyyy-mm-dd hh24:mi'));
INSERT INTO receita VALUES (receita_cod_verificacao.NEXTVAL, 'Ed Motta', TO_DATE ('2021-03-09 09:20', 'yyyy-mm-dd hh24:mi'));
INSERT INTO receita VALUES (receita_cod_verificacao.NEXTVAL, 'Carla Perez', TO_DATE ('2021-01-27 15:50', 'yyyy-mm-dd hh24:mi'));

-- Povoando medicamento
INSERT INTO medicamento 
SELECT 'Paracetamol', cod_verificacao
FROM receita WHERE data_hora_marcacao = TO_DATE ('2021-07-13 14:00', 'yyyy-mm-dd hh24:mi');

INSERT INTO medicamento 
SELECT 'Xarelto', cod_verificacao
FROM receita WHERE data_hora_marcacao = TO_DATE ('2020-08-14 15:30', 'yyyy-mm-dd hh24:mi');

INSERT INTO medicamento 
SELECT 'Albendazol', cod_verificacao
FROM receita WHERE data_hora_marcacao = TO_DATE ('2020-09-21 09:30', 'yyyy-mm-dd hh24:mi');

INSERT INTO medicamento 
SELECT 'Puran', cod_verificacao
FROM receita WHERE data_hora_marcacao = TO_DATE ('2020-10-24 10:00', 'yyyy-mm-dd hh24:mi');

INSERT INTO medicamento 
SELECT 'Victoza', cod_verificacao
FROM receita WHERE data_hora_marcacao = TO_DATE ('2020-11-30 08:40', 'yyyy-mm-dd hh24:mi');

INSERT INTO medicamento 
SELECT 'Torsilax', cod_verificacao
FROM receita WHERE data_hora_marcacao = TO_DATE ('2021-06-14 10:15', 'yyyy-mm-dd hh24:mi');

INSERT INTO medicamento 
SELECT 'Addera D3', cod_verificacao
FROM receita WHERE data_hora_marcacao = TO_DATE ('2021-06-21 14:20', 'yyyy-mm-dd hh24:mi');

INSERT INTO medicamento 
SELECT 'Dorflex', cod_verificacao
FROM receita WHERE data_hora_marcacao = TO_DATE ('2021-04-03 16:20', 'yyyy-mm-dd hh24:mi');

INSERT INTO medicamento 
SELECT 'Anthelios', cod_verificacao
FROM receita WHERE data_hora_marcacao = TO_DATE ('2021-02-17 09:25', 'yyyy-mm-dd hh24:mi');

INSERT INTO medicamento 
SELECT 'Bromazepam', cod_verificacao
FROM receita WHERE data_hora_marcacao = TO_DATE ('2021-02-28 14:00', 'yyyy-mm-dd hh24:mi');

INSERT INTO medicamento 
SELECT 'Diazepam', cod_verificacao
FROM receita WHERE data_hora_marcacao = TO_DATE ('2020-06-21 15:10', 'yyyy-mm-dd hh24:mi');

INSERT INTO medicamento 
SELECT 'Gardenal', cod_verificacao
FROM receita WHERE data_hora_marcacao = TO_DATE ('2021-05-01 10:00', 'yyyy-mm-dd hh24:mi');

INSERT INTO medicamento 
SELECT 'Rivotril', cod_verificacao
FROM receita WHERE data_hora_marcacao = TO_DATE ('2021-04-04 08:30', 'yyyy-mm-dd hh24:mi');

INSERT INTO medicamento 
SELECT 'Imipramina', cod_verificacao
FROM receita WHERE data_hora_marcacao = TO_DATE ('2021-03-09 09:20', 'yyyy-mm-dd hh24:mi');

INSERT INTO medicamento 
SELECT 'Ivermectina', cod_verificacao
FROM receita WHERE data_hora_marcacao = TO_DATE ('2021-01-27 15:50', 'yyyy-mm-dd hh24:mi');
