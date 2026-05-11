-- ============================================================
-- PALADINO (Paladin) — SRD 5.1 seed
-- ============================================================

-- 1. CLASS
INSERT INTO classes (
  id, name, name_en, description,
  hit_die, primary_ability, saving_throws,
  armor_proficiencies, weapon_proficiencies, tool_proficiencies,
  skill_choices_count, skill_choices,
  speed, spellcasting_ability, spellcasting_type, source
) VALUES (
  'paladin',
  'Paladino',
  'Paladin',
  'Seja proclamando um Juramento de Devoção a um deus, fazendo um voto de proteção à natureza ou um juramento de vingança contra as forças do mal, os paladinos são guerreiros sagrados ungidos com poder divino. Eles combinam combate marcial com magia divina para proteger os inocentes e erradicar o mal.',
  10,
  ARRAY['strength','charisma'],
  ARRAY['wisdom','charisma'],
  ARRAY['light','medium','heavy','shields'],
  ARRAY['simple','martial'],
  ARRAY[]::text[],
  2,
  ARRAY['athletics','insight','intimidation','medicine','persuasion','religion'],
  30,
  'charisma',
  'prepared',
  'srd'
);

-- 2. LEVELS
-- ½ conjurador: espaços começam no nível 2, máximo de 5º círculo
INSERT INTO class_levels (
  id, class_id, level, proficiency_bonus,
  cantrips_known, spells_known,
  slot_1, slot_2, slot_3, slot_4, slot_5,
  slot_6, slot_7, slot_8, slot_9,
  meta
) VALUES
  (gen_random_uuid(),'paladin', 1,2, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'paladin', 2,2, NULL,NULL, 2,0,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'paladin', 3,2, NULL,NULL, 3,0,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'paladin', 4,2, NULL,NULL, 3,0,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'paladin', 5,3, NULL,NULL, 4,2,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'paladin', 6,3, NULL,NULL, 4,2,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'paladin', 7,3, NULL,NULL, 4,3,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'paladin', 8,3, NULL,NULL, 4,3,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'paladin', 9,4, NULL,NULL, 4,3,2,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'paladin',10,4, NULL,NULL, 4,3,2,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'paladin',11,4, NULL,NULL, 4,3,3,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'paladin',12,4, NULL,NULL, 4,3,3,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'paladin',13,5, NULL,NULL, 4,3,3,1,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'paladin',14,5, NULL,NULL, 4,3,3,1,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'paladin',15,5, NULL,NULL, 4,3,3,2,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'paladin',16,5, NULL,NULL, 4,3,3,2,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'paladin',17,6, NULL,NULL, 4,3,3,3,1,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'paladin',18,6, NULL,NULL, 4,3,3,3,1,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'paladin',19,6, NULL,NULL, 4,3,3,3,2,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'paladin',20,6, NULL,NULL, 4,3,3,3,2,0,0,0,0, '{}'::jsonb);

-- 3. CLASS FEATURES
INSERT INTO class_features (id, class_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'paladin', 1,
   'Sentido Divino', 'Divine Sense',
   'A presença de um mal poderoso registra-se na consciência de um paladino como um odor nauseante, e um bem poderoso soa como música celestial em seus ouvidos. Como ação, você pode abrir sua consciência para detectar tais forças. Até o final do seu próximo turno, você conhece a localização de qualquer celestial, infernal ou morto-vivo a até 18 metros de você que não esteja por trás de cobertura total. Você sabe o tipo do ser, mas não sua identidade.\n\nVocê pode usar esse recurso um número de vezes igual a 1 + seu modificador de Carisma. Você recupera todos os usos ao terminar um descanso longo.',
   'feature','srd'),

  (gen_random_uuid(),'paladin', 1,
   'Imposição de Mãos', 'Lay on Hands',
   'Seu toque abençoado pode curar ferimentos. Você tem uma reserva de pontos de vida igual ao seu nível de paladino × 5 que se reabastece ao terminar um descanso longo. Como ação, você pode tocar uma criatura e restaurar qualquer número de pontos de vida dessa reserva. Alternativamente, você pode gastar 5 pontos de vida da reserva para curar o alvo de uma doença ou neutralizar um veneno que o aflige.',
   'feature','srd'),

  (gen_random_uuid(),'paladin', 2,
   'Estilo de Luta', 'Fighting Style',
   'No 2º nível, você adota um estilo de luta como especialidade. Escolha uma opção: Defesa (+1 CA enquanto usa armadura), Duelo (+2 dano com arma em uma mão e a outra sem arma), Combate com Armas Grandes (relance 1 ou 2 nos dados de dano de armas pesadas), Proteção (use reação para impor desvantagem em ataque contra aliado adjacente enquanto usa escudo).',
   'feature','srd'),

  (gen_random_uuid(),'paladin', 2,
   'Conjuração', 'Spellcasting',
   'No 2º nível, você aprendeu a conjurar poder divino através de meditação e oração. Carisma é sua habilidade de conjuração para magias de paladino. Você prepara uma lista de magias de paladino disponíveis para você, escolhendo um número igual ao seu modificador de Carisma + metade do seu nível de paladino, arredondado para baixo (mínimo de uma magia).',
   'spellcasting','srd'),

  (gen_random_uuid(),'paladin', 2,
   'Golpe Divino', 'Divine Smite',
   'A partir do 2º nível, quando você acertar uma criatura com um ataque de arma corpo a corpo, você pode gastar um espaço de magia de paladino para causar dano radiante extra ao alvo. O dano extra é 2d8 para um espaço de 1º nível, mais 1d8 por nível do espaço acima do 1º (máximo de 5d8). O dano aumenta em 1d8 se o alvo for um morto-vivo ou infernal, a um máximo de 6d8.',
   'feature','srd'),

  (gen_random_uuid(),'paladin', 3,
   'Saúde Divina', 'Divine Health',
   'No 3º nível, a magia divina que flui por você o torna imune a doenças.',
   'feature','srd'),

  (gen_random_uuid(),'paladin', 3,
   'Juramento Sagrado', 'Sacred Oath',
   'No 3º nível, você faz um juramento que liga você como paladino para sempre. Escolha o Juramento de Devoção, o Juramento dos Anciões ou o Juramento de Vingança. Seu juramento lhe concede recursos no 3º nível e novamente no 7º, 15º e 20º nível.',
   'subclass_choice','srd'),

  (gen_random_uuid(),'paladin', 4,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'paladin', 5,
   'Ataque Extra', 'Extra Attack',
   'A partir do 5º nível, você pode atacar duas vezes, em vez de uma, sempre que usar a ação Atacar em seu turno.',
   'extra_attack','srd'),

  (gen_random_uuid(),'paladin', 6,
   'Aura de Proteção', 'Aura of Protection',
   'A partir do 6º nível, sempre que você ou uma criatura amigável a até 3 metros de você precisar fazer um teste de resistência, a criatura ganha um bônus igual ao seu modificador de Carisma (mínimo +1). Você deve estar consciente para conceder esse bônus. No 18º nível, o alcance aumenta para 9 metros.',
   'feature','srd'),

  (gen_random_uuid(),'paladin', 7,
   'Aura de Coragem', 'Aura of Courage',
   'No 7º nível, você e criaturas amigáveis a até 3 metros de você não podem ser amedrontadas enquanto você estiver consciente. No 18º nível, o alcance aumenta para 9 metros.',
   'feature','srd'),

  (gen_random_uuid(),'paladin', 8,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'paladin',11,
   'Golpe Divino Aprimorado', 'Improved Divine Smite',
   'No 11º nível, você está tão imbuído de retidão que todos os seus ataques com arma corpo a corpo carregam poder divino. Sempre que você acertar uma criatura com uma arma corpo a corpo, ela recebe 1d8 extra de dano radiante.',
   'feature','srd'),

  (gen_random_uuid(),'paladin',12,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'paladin',14,
   'Toque Purificador', 'Cleansing Touch',
   'A partir do 14º nível, você pode usar sua ação para encerrar uma magia sobre si mesmo ou sobre uma criatura voluntária que você toque. Você pode usar esse recurso um número de vezes igual ao seu modificador de Carisma (mínimo 1). Você recupera os usos gastos ao terminar um descanso longo.',
   'feature','srd'),

  (gen_random_uuid(),'paladin',16,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'paladin',18,
   'Aprimoramentos de Aura', 'Aura Improvements',
   'No 18º nível, o alcance das suas Auras de Proteção e de Coragem aumenta de 3 metros para 9 metros.',
   'feature','srd'),

  (gen_random_uuid(),'paladin',19,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd');

-- 4. SUBCLASSES
INSERT INTO subclasses (id, class_id, name, name_en, description, level_gained, source) VALUES
  ('paladin-devotion',
   'paladin',
   'Juramento de Devoção',
   'Oath of Devotion',
   'O Juramento de Devoção prende um paladino aos mais altos ideais de justiça, virtude e ordem. Às vezes chamados de cavaleiros, esses paladinos atendem ao arquétipo clássico de um cavaleiro medieval em armadura brilhante, comprometido com a honra e a retidão.',
   3,'srd'),

  ('paladin-ancients',
   'paladin',
   'Juramento dos Anciões',
   'Oath of the Ancients',
   'O Juramento dos Anciões é tão antigo quanto a raça dos elfos e os rituais dos druidas. Às vezes chamados de cavaleiros do feérico, esses paladinos fazem seu juramento à luz do bem no mundo, defendendo a natureza e todas as criaturas vivas.',
   3,'srd'),

  ('paladin-vengeance',
   'paladin',
   'Juramento de Vingança',
   'Oath of Vengeance',
   'O Juramento de Vingança é um compromisso solene de punir aqueles que cometeram pecados terríveis. Quando o mal destrói os inocentes e os outros deuses não agem, o paladino de vingança se levanta como caçador implacável de tais forças.',
   3,'srd');

-- 5. SUBCLASS FEATURES

-- Oath of Devotion
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'paladin-devotion', 3,
   'Magias do Juramento e Canalizar Divindade', 'Oath Spells & Channel Divinity',
   'Magias do Juramento (sempre preparadas): 1º — Proteção contra o Bem e o Mal, Santuário; 2º — Restauração Menor, Zona da Verdade; 3º — Farol de Esperança, Dissipar Magia; 4º — Liberdade de Movimento, Guardião da Fé; 5º — Comunhão, Chama Atingente.\n\nCanalizar Divindade (1 uso por descanso curto ou longo):\n• Arma Sagrada: como ação bônus, infunda uma arma com energia divina por 1 minuto. Adicione seu modificador de Carisma às jogadas de ataque (mínimo +1); a arma emite luz brilhante em 6 m e penumbra em mais 6 m.\n• Expulsar Impuros: como ação, apresente seu símbolo sagrado; cada infernal ou morto-vivo que possa ver ou ouvir você a até 9 m deve fazer um teste de Sabedoria (CD de sua magia) ou fugir por 1 minuto.',
   'feature','srd'),

  (gen_random_uuid(),'paladin-devotion', 7,
   'Aura de Devoção', 'Aura of Devotion',
   'No 7º nível, você e criaturas amigáveis a até 3 metros de você não podem ser encantadas enquanto você estiver consciente. No 18º nível, o alcance aumenta para 9 metros.',
   'feature','srd'),

  (gen_random_uuid(),'paladin-devotion',15,
   'Pureza de Espírito', 'Purity of Spirit',
   'A partir do 15º nível, você é sempre protegido como se estivesse sob os efeitos da magia Proteção contra o Bem e o Mal.',
   'feature','srd'),

  (gen_random_uuid(),'paladin-devotion',20,
   'Nimbo Sagrado', 'Holy Nimbus',
   'No 20º nível, como ação você emana uma aura de luz solar por 1 minuto: luz brilhante em 9 m e penumbra em mais 9 m. Inimigos que iniciam seu turno na luz brilhante sofrem 10 de dano radiante. Você tem vantagem em testes de resistência contra magias de infernais e mortos-vivos, e eles têm desvantagem nos seus. Recupera após descanso longo.',
   'feature','srd');

-- Oath of the Ancients
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'paladin-ancients', 3,
   'Magias do Juramento e Canalizar Divindade', 'Oath Spells & Channel Divinity',
   'Magias do Juramento (sempre preparadas): 1º — Enredar, Riso Histérico de Tasha; 2º — Luz da Lua, Revelar Invisíveis; 3º — Crescimento Vegetal, Proteção contra Energia; 4º — Dominar Besta, Força da Natureza; 5º — Comunhão com a Natureza, Trepadeira Aprisionadora.\n\nCanalizar Divindade:\n• Fúria da Natureza: como ação, enrede uma criatura visível a até 3 m com plantas espectrais. Ela fica restrita até superar um teste de Força ou Destreza (CD de sua magia).\n• Expulsar os Ímpios: como ação, apresente seu símbolo sagrado; cada fada ou infernal que possa ver ou ouvir você a até 9 m deve fazer um teste de Sabedoria ou fugir por 1 minuto.',
   'feature','srd'),

  (gen_random_uuid(),'paladin-ancients', 7,
   'Aura de Proteção contra Magia', 'Aura of Warding',
   'No 7º nível, energia mágica antiga flui por você: você e criaturas amigáveis a até 3 metros de você têm resistência a dano de magias. No 18º nível, o alcance aumenta para 9 metros.',
   'feature','srd'),

  (gen_random_uuid(),'paladin-ancients',15,
   'Sentinela Imortal', 'Undying Sentinel',
   'A partir do 15º nível, quando você seria reduzido a 0 PV e não é morto instantaneamente, você pode escolher cair a 1 PV em vez disso. Você não pode usar esse recurso novamente até terminar um descanso longo. Adicionalmente, você não sofre penalidades de envelhecimento e não pode ser envelhecido magicamente.',
   'feature','srd'),

  (gen_random_uuid(),'paladin-ancients',20,
   'Campeão Ancião', 'Elder Champion',
   'No 20º nível, como ação você assume a forma de uma força da natureza por 1 minuto: você reganha 10 PV no início de cada turno; ao usar Imposição de Mãos, pode gastar 5 PV para curar uma condição (encantado, amedrontado, paralisado ou envenenado); magias que levam 1 ação podem ser lançadas como ação bônus. Recupera após descanso longo.',
   'feature','srd');

-- Oath of Vengeance
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'paladin-vengeance', 3,
   'Magias do Juramento e Canalizar Divindade', 'Oath Spells & Channel Divinity',
   'Magias do Juramento (sempre preparadas): 1º — Enfeitiçar Pessoa, Castigar; 2º — Segurar Pessoa, Invisibilidade; 3º — Hipnose, Proteção de Energia; 4º — Banimento, Mover Terra; 5º — Dominação de Pessoa, Segurar Monstro.\n\nCanalizar Divindade:\n• Abjurar Inimigo: como ação, escolha uma criatura visível a até 18 m. Ela deve fazer um teste de Sabedoria (infernais e mortos-vivos com desvantagem) ou ficar amedrontada por 1 minuto com velocidade 0.\n• Voto de Inimizade: como ação bônus, declare voto contra uma criatura. Você tem vantagem em testes de ataque contra ela por 1 minuto (ou até ela cair a 0 PV ou ficar incapacitada).',
   'feature','srd'),

  (gen_random_uuid(),'paladin-vengeance', 7,
   'Vingador Implacável', 'Relentless Avenger',
   'No 7º nível, quando você acerta um ataque de oportunidade, pode se mover até metade de sua velocidade imediatamente após o ataque como parte da mesma reação, sem provocar ataques de oportunidade.',
   'feature','srd'),

  (gen_random_uuid(),'paladin-vengeance',15,
   'Alma da Vingança', 'Soul of Vengeance',
   'A partir do 15º nível, quando uma criatura sob efeito do seu Voto de Inimizade fizer um ataque, você pode usar sua reação para fazer um ataque corpo a corpo contra ela se estiver ao seu alcance.',
   'feature','srd'),

  (gen_random_uuid(),'paladin-vengeance',20,
   'Anjo Vingador', 'Avenging Angel',
   'No 20º nível, como ação você se transforma por 1 hora: asas surgem dando velocidade de voo de 18 m; uma aura de terror em 9 m força criaturas hostis a fazer um teste de Sabedoria ao entrarem ou iniciarem o turno nela (falha = amedrontadas por 1 minuto). Recupera após descanso longo.',
   'feature','srd');
