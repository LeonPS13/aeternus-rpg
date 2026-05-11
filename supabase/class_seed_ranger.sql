-- ============================================================
-- PATRULHEIRO (Ranger) — SRD 5.1 seed
-- ============================================================

-- 1. CLASS
INSERT INTO classes (
  id, name, name_en, description,
  hit_die, primary_ability, saving_throws,
  armor_proficiencies, weapon_proficiencies, tool_proficiencies,
  skill_choices_count, skill_choices,
  speed, spellcasting_ability, spellcasting_type, source
) VALUES (
  'ranger',
  'Patrulheiro',
  'Ranger',
  'Longe da agitação das cidades e vilas, além das cercas que protegem os reinos mais pacíficos da escuridão, está uma terra áspera e inóspita habitada por monstros terríveis e aqueles que os caçam. Nessa fronteira, o patrulheiro reina soberano. Os patrulheiros são guerreiros da fronteira que combinam habilidades marciais com conhecimento das terras selvagens.',
  10,
  ARRAY['dexterity','wisdom'],
  ARRAY['strength','dexterity'],
  ARRAY['light','medium','shields'],
  ARRAY['simple','martial'],
  ARRAY[]::text[],
  3,
  ARRAY['animal_handling','athletics','insight','investigation','nature','perception','stealth','survival'],
  30,
  'wisdom',
  'known',
  'srd'
);

-- 2. LEVELS
-- ½ conjurador (conhecido): sem magias no nível 1; espaços e magias conhecidas a partir do nível 2
INSERT INTO class_levels (
  id, class_id, level, proficiency_bonus,
  cantrips_known, spells_known,
  slot_1, slot_2, slot_3, slot_4, slot_5,
  slot_6, slot_7, slot_8, slot_9,
  meta
) VALUES
  (gen_random_uuid(),'ranger', 1,2, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'ranger', 2,2, NULL,2,    2,0,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'ranger', 3,2, NULL,3,    3,0,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'ranger', 4,2, NULL,3,    3,0,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'ranger', 5,3, NULL,4,    4,2,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'ranger', 6,3, NULL,4,    4,2,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'ranger', 7,3, NULL,5,    4,3,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'ranger', 8,3, NULL,5,    4,3,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'ranger', 9,4, NULL,6,    4,3,2,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'ranger',10,4, NULL,6,    4,3,2,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'ranger',11,4, NULL,7,    4,3,3,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'ranger',12,4, NULL,7,    4,3,3,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'ranger',13,5, NULL,8,    4,3,3,1,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'ranger',14,5, NULL,8,    4,3,3,1,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'ranger',15,5, NULL,9,    4,3,3,2,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'ranger',16,5, NULL,9,    4,3,3,2,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'ranger',17,6, NULL,10,   4,3,3,3,1,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'ranger',18,6, NULL,10,   4,3,3,3,1,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'ranger',19,6, NULL,11,   4,3,3,3,2,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'ranger',20,6, NULL,11,   4,3,3,3,2,0,0,0,0, '{}'::jsonb);

-- 3. CLASS FEATURES
INSERT INTO class_features (id, class_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'ranger', 1,
   'Inimigo Favorito', 'Favored Enemy',
   'A partir do 1º nível, você tem experiência significativa estudando, rastreando, caçando e até mesmo conversando com um tipo de inimigo. Escolha um tipo de inimigo favorito: aberrações, bestas, celestiais, constructos, dragões, elementais, fadas, feras, gigantes, humanoides (dois subtipos específicos), mortos-vivos ou plantas.\n\nVocê tem vantagem em testes de Sabedoria (Sobrevivência) para rastrear seus inimigos favoritos, e em testes de Inteligência para se lembrar de informações sobre eles. Você também aprende um idioma falado por eles, se houver.\n\nVocê escolhe um inimigo favorito adicional no 6º e no 14º nível.',
   'feature','srd'),

  (gen_random_uuid(),'ranger', 1,
   'Explorador Natural', 'Natural Explorer',
   'Você é particularmente familiarizado com um tipo de ambiente natural. Escolha um tipo de terreno favorito: ártico, costa, deserto, floresta, prado, montanha, pântano ou Subterrâneo.\n\nAo fazer um teste de Inteligência ou Sabedoria relacionado ao seu terreno favorito, seu bônus de proficiência é dobrado se você usar uma habilidade que já possui proficiência. Ao viajar por uma hora ou mais por esse terreno: terreno difícil não desacelera o grupo, o grupo não pode se perder por meios não mágicos, você acha comida e água para o grupo, percebe criaturas a até 1,5 km, e ao rastrear mantém velocidade normal sem perda de percepção.\n\nVocê escolhe um terreno adicional no 6º e no 10º nível.',
   'feature','srd'),

  (gen_random_uuid(),'ranger', 2,
   'Estilo de Luta', 'Fighting Style',
   'No 2º nível, você adota um estilo de luta como especialidade. Escolha uma opção: Arqueiria (+2 em jogadas de ataque com armas de longa distância), Defesa (+1 CA enquanto usa armadura), Duelo (+2 dano com arma em uma mão e a outra sem arma), Combate com Duas Armas (adicione modificador de habilidade ao dano do segundo ataque com duas armas leves).',
   'feature','srd'),

  (gen_random_uuid(),'ranger', 2,
   'Conjuração', 'Spellcasting',
   'No 2º nível, você aprendeu a usar a essência mágica da natureza para lançar magias. Sabedoria é sua habilidade de conjuração. Você conhece um número fixo de magias de patrulheiro e pode substituir uma magia conhecida ao subir de nível.',
   'spellcasting','srd'),

  (gen_random_uuid(),'ranger', 3,
   'Consciência Primeva', 'Primeval Awareness',
   'A partir do 3º nível, você pode usar sua ação e gastar um espaço de magia para focar sua consciência ao redor. Por 1 minuto por nível do espaço gasto, você sente se aberrações, celestiais, dragões, elementais, fadas, feras e infernais estão presentes em até 1,5 km (6 km no terreno favorito). Esse recurso não revela localização nem quantidade.',
   'feature','srd'),

  (gen_random_uuid(),'ranger', 3,
   'Arquétipo de Patrulheiro', 'Ranger Archetype',
   'No 3º nível, você escolhe um arquétipo: Caçador ou Mestre das Bestas. Seu arquétipo lhe concede recursos no 3º nível e novamente no 7º, 11º e 15º nível.',
   'subclass_choice','srd'),

  (gen_random_uuid(),'ranger', 4,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'ranger', 5,
   'Ataque Extra', 'Extra Attack',
   'A partir do 5º nível, você pode atacar duas vezes, em vez de uma, sempre que usar a ação Atacar em seu turno.',
   'extra_attack','srd'),

  (gen_random_uuid(),'ranger', 8,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'ranger', 8,
   'Passo das Terras', 'Land''s Stride',
   'A partir do 8º nível, mover-se através de terreno difícil não mágico não custa movimento extra. Você também pode passar por plantas não mágicas sem ser desacelerado e sem sofrer dano delas se tiverem espinhos ou perigos similares. Além disso, você tem vantagem em testes de resistência contra plantas criadas magicamente para impedir o movimento.',
   'feature','srd'),

  (gen_random_uuid(),'ranger',10,
   'Esconder-se à Vista', 'Hide in Plain Sight',
   'A partir do 10º nível, você pode gastar 1 minuto criando uma camuflagem com materiais naturais (lama, terra, plantas, fuligem). Uma vez camuflado, ao encostar em uma superfície sólida pelo menos tão alta e larga quanto você, você ganha +10 em testes de Destreza (Furtividade) enquanto não se mover. Mover-se mais de 1 metro ou usar uma ação anula a camuflagem.',
   'feature','srd'),

  (gen_random_uuid(),'ranger',12,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'ranger',14,
   'Desaparecer', 'Vanish',
   'A partir do 14º nível, você pode usar a ação Esconder-se como ação bônus em seu turno. Além disso, você não pode ser rastreado por meios não mágicos, a menos que escolha deixar uma trilha.',
   'feature','srd'),

  (gen_random_uuid(),'ranger',16,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'ranger',18,
   'Sentidos Selvagens', 'Feral Senses',
   'No 18º nível, você ganha sentidos sobrenaturais. Quando você ataca uma criatura que não pode ver, sua incapacidade de vê-la não impõe desvantagem em seus testes de ataque. Você também está ciente da localização de qualquer criatura invisível a até 9 metros de você, desde que ela não esteja escondida e você não esteja surdo nem cego.',
   'feature','srd'),

  (gen_random_uuid(),'ranger',19,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'ranger',20,
   'Matador de Inimigos', 'Foe Slayer',
   'No 20º nível, você se torna um caçador sem igual. Uma vez por turno, você pode adicionar seu modificador de Sabedoria ao teste de ataque ou à jogada de dano contra um de seus inimigos favoritos. Você decide usar esse recurso antes ou depois do teste, mas antes que qualquer efeito seja aplicado.',
   'feature','srd');

-- 4. SUBCLASSES
INSERT INTO subclasses (id, class_id, name, name_en, description, level_gained, source) VALUES
  ('ranger-hunter',
   'ranger',
   'Caçador',
   'Hunter',
   'Emular o arquétipo do Caçador significa aceitar o lugar de sentinela entre a civilização e os terrores das trevas. Ao adotar esse arquétipo, você aprende técnicas especializadas para lutar contra as ameaças que enfrenta, do feroz ogro às hostes invasoras de orcs.',
   3,'srd'),

  ('ranger-beastmaster',
   'ranger',
   'Mestre das Bestas',
   'Beast Master',
   'O arquétipo do Mestre das Bestas encarna uma amizade entre o mundo civilizado e a selva natural. Unido a um companheiro animal sem palavras, você ganha uma conexão profunda com o mundo animal enquanto luta ao lado de um aliado leal.',
   3,'srd');

-- 5. SUBCLASS FEATURES

-- Hunter
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'ranger-hunter', 3,
   'Presa do Caçador', 'Hunter''s Prey',
   'No 3º nível, você ganha uma das seguintes habilidades à sua escolha:\n• Matador de Colossos: uma vez por turno quando você acertar uma criatura com uma arma, ela recebe 1d8 extra de dano se estiver com menos do máximo de PV.\n• Assassino de Gigantes: quando uma criatura Grande ou maior a até 1,5 m de você acertar ou errar você com um ataque, você pode usar sua reação para atacá-la.\n• Quebrador de Hordas: uma vez por turno quando você fizer um ataque de arma, pode fazer outro contra uma criatura diferente a até 1,5 m do alvo original e ao seu alcance.',
   'feature','srd'),

  (gen_random_uuid(),'ranger-hunter', 7,
   'Táticas Defensivas', 'Defensive Tactics',
   'No 7º nível, você ganha uma das seguintes habilidades à sua escolha:\n• Fuga da Horda: os ataques de oportunidade contra você são feitos com desvantagem.\n• Defesa contra Multiataques: quando uma criatura acertar você com um ataque, você ganha +4 CA contra os demais ataques dessa criatura no mesmo turno.\n• Vontade de Aço: você tem vantagem em testes de resistência contra ser amedrontado.',
   'feature','srd'),

  (gen_random_uuid(),'ranger-hunter',11,
   'Multiaque', 'Multiattack',
   'No 11º nível, você ganha uma das seguintes habilidades à sua escolha:\n• Saraivada: você pode usar sua ação para fazer um ataque à distância contra qualquer número de criaturas a até 3 metros de um ponto dentro do alcance da sua arma, com uma rolagem de ataque separada para cada alvo.\n• Ataque Rodopiante: você pode usar sua ação para fazer um ataque corpo a corpo contra qualquer número de criaturas a até 1,5 metro de você, com uma rolagem de ataque separada para cada alvo.',
   'feature','srd'),

  (gen_random_uuid(),'ranger-hunter',15,
   'Defesa Superior do Caçador', 'Superior Hunter''s Defense',
   'No 15º nível, você ganha uma das seguintes habilidades à sua escolha:\n• Evasão: quando submetido a um efeito com teste de resistência de Destreza por metade do dano, você não toma dano se bem-sucedido e apenas metade se falhar.\n• Resistir à Maré: quando um inimigo te força a mover-se usando magia ou habilidade especial, você pode usar sua reação para redirecionar esse movimento para outra criatura dentro do alcance.\n• Esquiva Incansável: quando for atingido por um ataque de uma criatura que pode ver, pode usar sua reação para impor desvantagem no teste de ataque, potencialmente fazendo-o errar.',
   'feature','srd');

-- Beast Master
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'ranger-beastmaster', 3,
   'Companheiro do Patrulheiro', 'Ranger''s Companion',
   'No 3º nível, você ganha um companheiro besta que o acompanha em suas aventuras. Escolha uma besta de tamanho Médio ou menor, com CR 1/4 ou inferior e sem velocidade de voo ou natação. A besta obedece seus comandos e age em sua iniciativa (após você). Ela tem suas próprias ações, mas só ataca se você usar sua ação para comandá-la — exceto em autodefesa. Se morrer, você pode obter outro após 8 horas de vínculo com uma nova besta.',
   'feature','srd'),

  (gen_random_uuid(),'ranger-beastmaster', 7,
   'Treinamento Excepcional', 'Exceptional Training',
   'No 7º nível, em qualquer um de seus turnos quando seu companheiro besta não atacar, você pode usar uma ação bônus para ordenar que ele tome a ação Correr, Esquivar, Desengajar ou Ajudar. Além disso, os ataques do seu companheiro besta contam como mágicos para fins de superar resistências.',
   'feature','srd'),

  (gen_random_uuid(),'ranger-beastmaster',11,
   'Fúria Bestial', 'Bestial Fury',
   'No 11º nível, seu companheiro besta pode fazer dois ataques quando você o comandar para atacar.',
   'feature','srd'),

  (gen_random_uuid(),'ranger-beastmaster',15,
   'Compartilhar Magias', 'Share Spells',
   'No 15º nível, quando você lança uma magia que tem como alvo apenas você, você pode fazer seu companheiro besta também ser alvo da magia, se ela tiver alcance de toque ou for centrada em você.',
   'feature','srd');
