-- Povoando Pessoas

INSERT INTO pessoa (cpf, nome) VALUES ('000.532.546-14','José Henrique');
INSERT INTO pessoa (cpf, nome) VALUES ('839.274.863-02','Lucas Alfredo');
INSERT INTO pessoa (cpf, nome) VALUES ('153.545.987-13','Lara Maria');
INSERT INTO pessoa (cpf, nome) VALUES ('986.647.000-87','Alberto Roberto');
INSERT INTO pessoa (cpf, nome) VALUES ('923.782.185-87','Josué Aguiar');
INSERT INTO pessoa (cpf, nome) VALUES ('159.738.879-12','Ana Souza');
INSERT INTO pessoa (cpf, nome) VALUES ('025.105.198-45','João Kléber');
INSERT INTO pessoa (cpf, nome) VALUES ('012.654.574-38','Arthur da Silva');
INSERT INTO pessoa (cpf, nome) VALUES ('145.896.745-15','Roberta Lorena');
INSERT INTO pessoa (cpf, nome) VALUES ('256.941.852-06','Agostinho Carrara');

-- Paciente
INSERT INTO paciente (cpf, nome, prioridade, n_sus, nome_plano) VALUES ('000.111.222-44', 'Igor', 1, 4546, 'Bradesco');
INSERT INTO paciente (cpf, nome, prioridade, n_sus, nome_plano) VALUES ('001.111.222-44', 'Laura', 2, 4586, 'Unimed');
INSERT INTO paciente (cpf, nome, prioridade, n_sus, nome_plano) VALUES ('002.115.222-44', 'Lucas', 3, 4510, 'Hapvida');
INSERT INTO paciente (cpf, nome, prioridade, n_sus, nome_plano) VALUES ('003.117.222-44', 'Hugo', 4, 4154, 'SulAmérica');
INSERT INTO paciente (cpf, nome, prioridade, n_sus, nome_plano) VALUES ('004.111.252-44', 'Cristina', 5, 4582, 'Smile Saúde');
INSERT INTO paciente (cpf, nome, prioridade, n_sus, nome_plano) VALUES ('005.111.222-44', 'Rose', 6, 4896, 'Bradesco');
INSERT INTO paciente (cpf, nome, prioridade, n_sus, nome_plano) VALUES ('006.111.222-44', 'Maria', 7, 4543, 'Cassi');
INSERT INTO paciente (cpf, nome, prioridade, n_sus, nome_plano) VALUES ('007.111.222-44', 'Ricardo', 8, 4012, 'Amil');
INSERT INTO paciente (cpf, nome, prioridade, n_sus, nome_plano) VALUES ('008.111.202-44', 'Eduardo', 9, 4023, 'Bradesco');
INSERT INTO paciente (cpf, nome, prioridade, n_sus, nome_plano) VALUES ('009.111.222-44', 'Hiago', 10, 4151, 'SulAmérica');

-- Medico
INSERT INTO medico (cpf, nome, crm, especialidade, cpf_chefe) VALUES ('000.452.074-98', 'Eduardo', 3565, 'Oftalmologia', '111.111.111-12');
INSERT INTO medico (cpf, nome, crm, especialidade, cpf_chefe) VALUES ('000.546.321-00', 'Mário', 3512, 'Dermatologista', '111.111.111-15');
INSERT INTO medico (cpf, nome, crm, especialidade, cpf_chefe) VALUES ('157.302.254-80', 'Ana', 3025, 'Clínico Geral', '111.222.111-89');
INSERT INTO medico (cpf, nome, crm, especialidade, cpf_chefe) VALUES ('001.002.003-00', 'Maria', 4565, 'Endocrinologista', '112.654.312-11');
INSERT INTO medico (cpf, nome, crm, especialidade, cpf_chefe) VALUES ('202.000.604-01', 'Eduarda', 6365, 'Cardiologista', '111.741.000-11');
INSERT INTO medico (cpf, nome, crm, especialidade, cpf_chefe) VALUES ('000.555.444-00', 'Felicity', 9633, 'Oftalmologia', '214.865.111-10');
INSERT INTO medico (cpf, nome, crm, especialidade, cpf_chefe) VALUES ('545.636.978-45', 'Crislaine', 3567, 'Clínico Geral', '111.545.921-11');
INSERT INTO medico (cpf, nome, crm, especialidade, cpf_chefe) VALUES ('545.231.852-74', 'Samuel', 3522, 'Dermatologista', '525.963.159-11');
INSERT INTO medico (cpf, nome, crm, especialidade, cpf_chefe) VALUES ('101.202.303-98', 'Sara', 3305, 'Endocrinologista', '951.654.753-02');
INSERT INTO medico (cpf, nome, crm, especialidade, cpf_chefe) VALUES ('101.202.654-87', 'Alexandre', 3405, 'Oftalmologia', '123.654.987-05');


-- Povoando consulta
INSERT INTO  consulta   VALUES ( 'https://meet.google.com/cfp-biki-icz',906.274.860-02);
INSERT INTO  consulta   VALUES ( 'https://meet.google.com/pdh-ryth-kwc',688.789.920-54);
INSERT INTO  consulta   VALUES ( 'https://meet.google.com/ith-gere-kio',824.874.820-01);
INSERT INTO  consulta   VALUES ( 'https://meet.google.com/tvh-sdfq-wck',612.636.730-82);
INSERT INTO  consulta   VALUES ( 'https://meet.google.com/vht-bqwz-wtk',830.286.750-05);
INSERT INTO  consulta   VALUES ( 'https://meet.google.com/ojh-dgad-wep',596.004.180-47);
INSERT INTO  consulta   VALUES ( 'https://meet.google.com/lht-adfw-sdf',976.310.480-70);
INSERT INTO  consulta   VALUES ( 'https://meet.google.com/tvh-cvbb-cas',912.878.930-07);
INSERT INTO  consulta   VALUES ( 'https://meet.google.com/ath-hgjd-lok',066.989.880-57);
INSERT INTO  consulta   VALUES ( 'https://meet.google.com/thz-hjgy-jhn',737.129.450-51);
INSERT INTO  consulta   VALUES ( 'https://meet.google.com/ath-fgse-cfs',737.543.550-23);
INSERT INTO  consulta   VALUES ( 'https://meet.google.com/bhy-asda-ujf',494.073.100-60);
INSERT INTO  consulta   VALUES ( 'https://meet.google.com/cht-bsdf-qer',485.476.990-40);
INSERT INTO  consulta   VALUES ( 'https://meet.google.com/phg-djjd-urr',212.139.580-67);
INSERT INTO  consulta   VALUES ( 'https://meet.google.com/hsd-kfdj-uot',536.650.360-46);

-- Povoando marcacao
INSERT INTO marcacao VALUES (2021-07-13);


-- Povoando telefone
INSERT INTO telefone   VALUES (906.274.860-02,'(81)9 9999-5555');
INSERT INTO telefone   VALUES (688.789.920-54,'(14) 9 3193-8477');
INSERT INTO telefone   VALUES (824.874.820-01,'(52) 9 8282-5729');
INSERT INTO telefone   VALUES (612.636.730-82,'(19) 9 2856-1077');
INSERT INTO telefone   VALUES (830.286.750-05,'(88) 9 8513-4740');
INSERT INTO telefone   VALUES (596.004.180-47,'(27) 9 9644-2468');
INSERT INTO telefone   VALUES (976.310.480-70,'(38) 9 0362-3351');
INSERT INTO telefone   VALUES (912.878.930-07,'(48) 9 1200-4900');
INSERT INTO telefone   VALUES (066.989.880-57,'(61) 9 9203-0994');
INSERT INTO telefone   VALUES (737.129.450-51,'(25) 9 0203-7190');
INSERT INTO telefone   VALUES (737.543.550-23,'(39) 9 8310-4750');
INSERT INTO telefone   VALUES (494.073.100-60,'(55) 9 0116-1728');
INSERT INTO telefone   VALUES (485.476.990-40,'(56) 9 7396-1081');
INSERT INTO telefone   VALUES (212.139.580-67,'(60) 9 1745-0317');
INSERT INTO telefone   VALUES (536.650.360-46,'(12) 9 1376-6526');


-- Povoando medicamento
INSERT INTO medicamento VALUES (55, 'Paracetamol');

-- Povoando exame
INSERT INTO exame VALUES (906.274.860-02, 48, 'Acuidade Visual', 'Ok', 2021-07-13);
INSERT INTO exame VALUES (688.789.920-54, 96, 'Hemograma', 'Ok', 2020-08-14);
INSERT INTO exame VALUES (824.874.820-01, 22, 'Glicemia em jejum', 'Ok', 2020-09-21);
INSERT INTO exame VALUES (612.636.730-82, 75, 'Colesterol e Triglicerídeos', 'Ok', 2020-10-24);
INSERT INTO exame VALUES (830.286.750-05, 63, 'TGO (AST) e TGP (ALT)', 'Ok', 2020-11-30);
INSERT INTO exame VALUES (596.004.180-47, 89, 'TSH e T4 livre', 'Ok', 2021-06-14);
INSERT INTO exame VALUES (976.310.480-70, 14, 'Ácido Úrico', 'Ok', 2021-06-21);
INSERT INTO exame VALUES (912.878.930-07, 38, 'Mamografia', 'Ok', 2021-04-05);
INSERT INTO exame VALUES (066.989.880-57, 75, 'Teste cardiopulmonar', 'Ok', 2021-02-17);
INSERT INTO exame VALUES (737.129.450-51, 96, 'Anamnese clínica e esportiva', 'Ok', 2021-02-28);
INSERT INTO exame VALUES (737.543.550-23, 24, 'Dosagem de PSA', 'Ok', 2020-06-21);
INSERT INTO exame VALUES (494.073.100-60, 32, 'Avaliação física completa', 'Ok', 2021-05-01);
INSERT INTO exame VALUES (485.476.990-40, 21, 'Ressonância Magnética', 'Ok', 2021-04-04);
INSERT INTO exame VALUES (212.139.580-67, 17, 'Tomografia Computadorizada', 'Ok', 2021-03-09);
INSERT INTO exame VALUES (536.650.360-46, 11, 'Ultra-sonografia', 'Ok', 2021-01-27);

-- Povoando receita
INSERT INTO receita VALUES (546, 'Sheyla Lima', 2021-07-12);
INSERT INTO receita VALUES (874, 'José Henrique', 2021-07-12);
INSERT INTO receita VALUES (221, 'Lucas Alfredo', 2021-07-12);
INSERT INTO receita VALUES (372, 'Lara Maria', 2021-07-12);
INSERT INTO receita VALUES (996, 'Alberto Roberto', 2021-07-12);
INSERT INTO receita VALUES (481, 'Josué Aguiar', 2021-07-13);
INSERT INTO receita VALUES (015, 'Ana Souza', 2021-07-13);
INSERT INTO receita VALUES (542, 'João Kléber', 2021-07-13);
INSERT INTO receita VALUES (671, 'Arthur da Silva', 2021-07-13);
INSERT INTO receita VALUES (778, 'Roberta Lorena', 2021-07-13);
INSERT INTO receita VALUES (926, 'Agostinho Carrara', 2021-07-14);
INSERT INTO receita VALUES (450, 'Sheyla Carvalho', 2021-07-14);
INSERT INTO receita VALUES (119, 'Ronaldo Alves', 2021-07-14);
INSERT INTO receita VALUES (207, 'Ed Motta', 2021-07-14);
INSERT INTO receita VALUES (599, 'Carla Perez', 2021-07-14);
