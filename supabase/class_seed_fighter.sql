-- ============================================================
-- GUERREIRO (Fighter) — SRD 5.1 seed
-- ============================================================

-- 1. CLASS
INSERT INTO classes (
  id, name, name_en, description,
  hit_die, primary_ability, saving_throws,
  armor_proficiencies, weapon_proficiencies, tool_proficiencies,
  skill_choices_count, skill_choices,
  speed, spellcasting_ability, spellcasting_type, source
) VALUES (
  'fighter',
  'Guerreiro',
  'Fighter',
  'Guerreiros compartilham uma maestria com armas e armaduras, além de um conhecimento profundo das habilidades de combate. Eles são bem familiarizados com a morte, tanto em infligir quanto em encarar de frente. São versáteis o suficiente para usar armas pesadas e pesadas armaduras, ou armas mais ágeis.',
  10,
  ARRAY['strength','dexterity'],
  ARRAY['strength','constitution'],
  ARRAY['light','medium','heavy','shields'],
  ARRAY['simple','martial'],
  ARRAY[]::text[],
  2,
  ARRAY['acrobatics','animal_handling','athletics','history','insight','intimidation','perception','survival'],
  30,
  NULL,
  NULL,
  'srd'
);

-- 2. LEVELS
-- Meta: action_surge (usos por descanso curto, começa nível 2)
--       indomitable (usos por descanso longo, começa nível 9)
INSERT INTO class_levels (
  id, class_id, level, proficiency_bonus,
  cantrips_known, spells_known,
  slot_1, slot_2, slot_3, slot_4, slot_5,
  slot_6, slot_7, slot_8, slot_9,
  meta
) VALUES
  (gen_random_uuid(),'fighter', 1,2, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'fighter', 2,2, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"action_surge":1}'),
  (gen_random_uuid(),'fighter', 3,2, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"action_surge":1}'),
  (gen_random_uuid(),'fighter', 4,2, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"action_surge":1}'),
  (gen_random_uuid(),'fighter', 5,3, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"action_surge":1}'),
  (gen_random_uuid(),'fighter', 6,3, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"action_surge":1}'),
  (gen_random_uuid(),'fighter', 7,3, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"action_surge":1}'),
  (gen_random_uuid(),'fighter', 8,3, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"action_surge":1}'),
  (gen_random_uuid(),'fighter', 9,4, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"action_surge":1,"indomitable":1}'),
  (gen_random_uuid(),'fighter',10,4, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"action_surge":1,"indomitable":1}'),
  (gen_random_uuid(),'fighter',11,4, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"action_surge":1,"indomitable":1}'),
  (gen_random_uuid(),'fighter',12,4, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"action_surge":1,"indomitable":1}'),
  (gen_random_uuid(),'fighter',13,5, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"action_surge":1,"indomitable":2}'),
  (gen_random_uuid(),'fighter',14,5, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"action_surge":1,"indomitable":2}'),
  (gen_random_uuid(),'fighter',15,5, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"action_surge":1,"indomitable":2}'),
  (gen_random_uuid(),'fighter',16,5, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"action_surge":1,"indomitable":2}'),
  (gen_random_uuid(),'fighter',17,6, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"action_surge":2,"indomitable":3}'),
  (gen_random_uuid(),'fighter',18,6, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"action_surge":2,"indomitable":3}'),
  (gen_random_uuid(),'fighter',19,6, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"action_surge":2,"indomitable":3}'),
  (gen_random_uuid(),'fighter',20,6, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"action_surge":2,"indomitable":3}');

-- 3. CLASS FEATURES
INSERT INTO class_features (id, class_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'fighter', 1,
   'Estilo de Luta', 'Fighting Style',
   'Você adota um estilo particular de luta como sua especialidade. Escolha uma das seguintes opções: Arqueria (+2 em testes de ataque com armas de ataque à distância), Defesa (+1 CA com armadura), Duelo (+2 de dano ao acertar com arma de uma mão sem usar outra arma), Luta com Duas Armas (adiciona modificador de atributo ao dano do ataque com arma secundária), Proteção (reação para impor desvantagem no ataque contra aliado próximo) ou Combate com Armas Grandes (+2 no dano ao rolar 1 ou 2 com dado de dano de arma pesada).',
   'feature','srd'),

  (gen_random_uuid(),'fighter', 1,
   'Retomar o Fôlego', 'Second Wind',
   'Você tem uma reserva limitada de energia que pode usar para se proteger. Em seu turno, você pode usar uma ação bônus para recuperar pontos de vida igual a 1d10 + seu nível de guerreiro. Após usar esse recurso, você deve terminar um descanso curto ou longo antes de usá-lo novamente.',
   'feature','srd'),

  (gen_random_uuid(),'fighter', 2,
   'Ação Ampliada', 'Action Surge',
   'A partir do 2º nível, você pode se superar brevemente para além de seus limites normais por um momento. Em seu turno, você pode tomar uma ação adicional além de sua ação normal e possível ação bônus. Após usar esse recurso, você deve terminar um descanso curto ou longo antes de usá-lo novamente. A partir do 17º nível, você pode usá-lo duas vezes antes de um descanso, mas somente uma vez no mesmo turno.',
   'feature','srd'),

  (gen_random_uuid(),'fighter', 3,
   'Arquétipo Marcial', 'Martial Archetype',
   'No 3º nível, você escolhe um arquétipo que reflete seu estilo e técnica: Campeão, Mestre de Batalha ou Cavaleiro Arcano. O arquétipo lhe concede recursos no 3º nível e novamente no 7º, 10º, 15º e 18º nível.',
   'subclass_choice','srd'),

  (gen_random_uuid(),'fighter', 4,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'fighter', 5,
   'Ataque Extra', 'Extra Attack',
   'A partir do 5º nível, você pode atacar duas vezes, em vez de uma, sempre que usar a ação Atacar em seu turno.',
   'extra_attack','srd'),

  (gen_random_uuid(),'fighter', 6,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'fighter', 8,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'fighter', 9,
   'Indomável', 'Indomitable',
   'A partir do 9º nível, você pode rolar novamente um teste de resistência que falhou. Se fizer isso, você deverá usar o novo resultado, e não poderá usar esse recurso novamente até terminar um descanso longo. Você pode usar esse recurso duas vezes entre descansos longos a partir do 13º nível e três vezes entre descansos longos a partir do 17º nível.',
   'feature','srd'),

  (gen_random_uuid(),'fighter',11,
   'Ataque Extra (×3)', 'Extra Attack (×3)',
   'A partir do 11º nível, você pode atacar três vezes, em vez de duas, sempre que usar a ação Atacar em seu turno.',
   'extra_attack','srd'),

  (gen_random_uuid(),'fighter',12,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'fighter',14,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'fighter',16,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'fighter',19,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'fighter',20,
   'Ataque Extra (×4)', 'Extra Attack (×4)',
   'A partir do 20º nível, você pode atacar quatro vezes, em vez de três, sempre que usar a ação Atacar em seu turno.',
   'extra_attack','srd');

-- 4. SUBCLASSES
INSERT INTO subclasses (id, class_id, name, name_en, description, level_gained, source) VALUES
  ('fighter-champion',
   'fighter',
   'Campeão',
   'Champion',
   'O arquétipo do Campeão foca no desenvolvimento de habilidades físicas brutas para atingir a perfeição mortal. Os que se modelam sobre esse arquétipo combinam rigoroso treinamento com excelência física para acertar golpes devastadores.',
   3,'srd'),

  ('fighter-battlemaster',
   'fighter',
   'Mestre de Batalha',
   'Battle Master',
   'Os que emulam o arquétipo de Mestre de Batalha empregam técnicas de combate passadas pelas gerações. Para um Mestre de Batalha, o combate é uma área acadêmica, que às vezes inclui outras habilidades além das habilidades de combate.',
   3,'srd'),

  ('fighter-eldritchknight',
   'fighter',
   'Cavaleiro Arcano',
   'Eldritch Knight',
   'O arquétipo de Cavaleiro Arcano combina a maestria em combate típica de todos os guerreiros com um estudo cuidadoso da magia. Os Cavaleiros Arcanos usam técnicas mágicas similares às praticadas pelos magos, focando em magia de abjuração e evocação.',
   3,'srd');

-- 5. SUBCLASS FEATURES

-- Champion
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'fighter-champion', 3,
   'Crítico Aprimorado', 'Improved Critical',
   'A partir do 3º nível, seus ataques com arma marcam um acerto crítico em uma rolagem de 19 ou 20.',
   'feature','srd'),

  (gen_random_uuid(),'fighter-champion', 7,
   'Atleta Notável', 'Remarkable Athlete',
   'A partir do 7º nível, você pode adicionar metade do seu bônus de proficiência (arredondado para cima) a qualquer teste de Força, Destreza ou Constituição que você fizer e que ainda não use seu bônus de proficiência. Além disso, quando você faz um salto em comprimento com corrida, a distância que você pode cobrir aumenta por um número de pés igual ao seu modificador de Força.',
   'feature','srd'),

  (gen_random_uuid(),'fighter-champion',10,
   'Estilo de Luta Adicional', 'Additional Fighting Style',
   'No 10º nível, você pode escolher um segundo estilo de luta dentre as opções disponíveis para o guerreiro.',
   'feature','srd'),

  (gen_random_uuid(),'fighter-champion',15,
   'Crítico Superior', 'Superior Critical',
   'A partir do 15º nível, seus ataques com arma marcam um acerto crítico em uma rolagem de 18-20.',
   'feature','srd'),

  (gen_random_uuid(),'fighter-champion',18,
   'Sobrevivente', 'Survivor',
   'No 18º nível, você atingiu o pináculo de resiliência em batalha. No início de cada um de seus turnos, você recupera pontos de vida igual a 5 + seu modificador de Constituição se você tiver não mais que metade de seus pontos de vida, mas não se você tiver 0 pontos de vida.',
   'feature','srd');

-- Battle Master
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'fighter-battlemaster', 3,
   'Superioridade de Combate', 'Combat Superiority',
   'No 3º nível, você aprende manobras que são impulsionadas por recursos especiais chamados dados de superioridade. Você aprende 3 manobras de sua escolha. Você tem 4 dados de superioridade d8; esses dados são gastos quando você usa uma manobra, e você os recupera ao terminar um descanso curto ou longo. Seu número de manobras e dados aumentam conforme você ganha níveis: 5 manobras e 5 dados no 7º nível, 7 manobras e 6 dados no 10º nível, 9 manobras e 6 dados no 15º nível.',
   'feature','srd'),

  (gen_random_uuid(),'fighter-battlemaster', 3,
   'Estudante de Guerra', 'Student of War',
   'No 3º nível, você ganha proficiência com um tipo de ferramentas de artesão de sua escolha.',
   'feature','srd'),

  (gen_random_uuid(),'fighter-battlemaster', 7,
   'Conhecer Seu Inimigo', 'Know Your Enemy',
   'A partir do 7º nível, se você passar pelo menos 1 minuto observando ou interagindo com outra criatura fora do combate, você pode aprender certas informações sobre suas capacidades em comparação com as suas. O DM lhe diz se a criatura é sua igual, superior ou inferior em relação a duas das seguintes características de sua escolha: nível de Força, Destreza, Constituição, CA, pontos de vida totais, níveis de classe (se houver) e níveis de guerreiro (se houver).',
   'feature','srd'),

  (gen_random_uuid(),'fighter-battlemaster',10,
   'Superioridade de Combate Aprimorada', 'Improved Combat Superiority',
   'No 10º nível, seus dados de superioridade se tornam d10. No 18º nível, eles se tornam d12.',
   'feature','srd'),

  (gen_random_uuid(),'fighter-battlemaster',15,
   'Implacável', 'Relentless',
   'A partir do 15º nível, quando você rola iniciativa e não tem dados de superioridade restantes, você recupera 1 dado de superioridade.',
   'feature','srd');

-- Eldritch Knight
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'fighter-eldritchknight', 3,
   'Conjuração Arcana', 'Spellcasting',
   'Quando você atingir o 3º nível, você aumenta seu treinamento marcial com a capacidade de lançar magias. Sua habilidade de conjuração é Inteligência. Você aprende truques e magias predominantemente de abjuração e evocação, seguindo a tabela de progressão do Cavaleiro Arcano (terço de conjurador): 2 espaços de 1º nível no nível 3, chegando a 4/3/3/1 espaços de 1º-4º nível no nível 20. Você aprende 2 truques do mago, mais Luz Mágica obrigatoriamente.',
   'spellcasting','srd'),

  (gen_random_uuid(),'fighter-eldritchknight', 3,
   'Vínculo com Arma', 'Weapon Bond',
   'No 3º nível, você aprende um ritual que cria uma ligação mágica entre você e uma arma. Você realiza o ritual durante 1 hora, que pode ser feita durante um descanso curto. A arma deve estar ao seu alcance durante todo o ritual. Você pode ter até duas armas vinculadas ao mesmo tempo. Você não pode ser desarmado dessas armas, a menos que esteja incapacitado, e se estiverem no mesmo plano de existência, você pode invocá-las para sua mão livre como ação bônus.',
   'feature','srd'),

  (gen_random_uuid(),'fighter-eldritchknight', 7,
   'Magia de Guerra', 'War Magic',
   'A partir do 7º nível, quando você usa sua ação para lançar um truque, você pode fazer um ataque com arma como ação bônus.',
   'feature','srd'),

  (gen_random_uuid(),'fighter-eldritchknight',10,
   'Golpe Arcano', 'Eldritch Strike',
   'No 10º nível, você aprende a fazer com que os ataques com arma enfraqueçam a resistência de uma criatura às suas magias. Quando você acerta uma criatura com um ataque de arma, essa criatura tem desvantagem em seu próximo teste de resistência contra uma magia que você lança antes do fim de seu próximo turno.',
   'feature','srd'),

  (gen_random_uuid(),'fighter-eldritchknight',15,
   'Carga Arcana', 'Arcane Charge',
   'No 15º nível, você ganha a capacidade de teletransportar até 30 pés para um espaço desocupado que você possa ver quando usar sua Ação Ampliada. Você pode teletransportar antes ou depois da ação adicional.',
   'feature','srd'),

  (gen_random_uuid(),'fighter-eldritchknight',18,
   'Magia de Guerra Aprimorada', 'Improved War Magic',
   'A partir do 18º nível, quando você usa sua ação para lançar uma magia, você pode fazer um ataque com arma como ação bônus.',
   'feature','srd');
