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
INSERT INTO medico VALUES (00000000000, 'Eduardo', 3565, 'Oftalmologia', 11111111111);

-- Povoando consulta
INSERT INTO consulta VALUES ('https://meet.google.com/gig-ciiu-exj', 00000000000);

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
INSERT INTO exame VALUES (96385274112, 35, 'Acuidade Visual', 'Ok', 2021-07-13);

-- Povoando receita
INSERT INTO receita VALUES (546, 'Sheyla Lima', 2021-07-13);
