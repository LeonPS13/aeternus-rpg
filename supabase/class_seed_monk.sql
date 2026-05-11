-- ============================================================
-- MONGE (Monk) — SRD 5.1 seed
-- ============================================================

-- 1. CLASS
INSERT INTO classes (
  id, name, name_en, description,
  hit_die, primary_ability, saving_throws,
  armor_proficiencies, weapon_proficiencies, tool_proficiencies,
  skill_choices_count, skill_choices,
  speed, spellcasting_ability, spellcasting_type, source
) VALUES (
  'monk',
  'Monge',
  'Monk',
  'Monges são mestres das artes marciais, aproveitando o poder do corpo em busca da perfeição física e espiritual. Eles aproveitam um poder mágico que flui através dos corpos vivos. Esse poder, chamado ki, alimenta seus poderes sobrenaturais.',
  8,
  ARRAY['dexterity','wisdom'],
  ARRAY['strength','dexterity'],
  ARRAY[]::text[],
  ARRAY['simple','shortsword'],
  ARRAY[]::text[],
  2,
  ARRAY['acrobatics','athletics','history','insight','religion','stealth'],
  30,
  NULL,
  NULL,
  'srd'
);

-- 2. LEVELS
-- Meta: martial_arts (dado de artes marciais), ki_points (= nível, começa nível 2),
--       unarmored_movement (bônus de deslocamento, começa nível 2)
INSERT INTO class_levels (
  id, class_id, level, proficiency_bonus,
  cantrips_known, spells_known,
  slot_1, slot_2, slot_3, slot_4, slot_5,
  slot_6, slot_7, slot_8, slot_9,
  meta
) VALUES
  (gen_random_uuid(),'monk', 1,2, NULL,NULL, 0,0,0,0,0,0,0,0,0,
   '{"martial_arts":"1d4"}'),
  (gen_random_uuid(),'monk', 2,2, NULL,NULL, 0,0,0,0,0,0,0,0,0,
   '{"martial_arts":"1d4","ki_points":2,"unarmored_movement":"+10"}'),
  (gen_random_uuid(),'monk', 3,2, NULL,NULL, 0,0,0,0,0,0,0,0,0,
   '{"martial_arts":"1d4","ki_points":3,"unarmored_movement":"+10"}'),
  (gen_random_uuid(),'monk', 4,2, NULL,NULL, 0,0,0,0,0,0,0,0,0,
   '{"martial_arts":"1d4","ki_points":4,"unarmored_movement":"+10"}'),
  (gen_random_uuid(),'monk', 5,3, NULL,NULL, 0,0,0,0,0,0,0,0,0,
   '{"martial_arts":"1d6","ki_points":5,"unarmored_movement":"+10"}'),
  (gen_random_uuid(),'monk', 6,3, NULL,NULL, 0,0,0,0,0,0,0,0,0,
   '{"martial_arts":"1d6","ki_points":6,"unarmored_movement":"+15"}'),
  (gen_random_uuid(),'monk', 7,3, NULL,NULL, 0,0,0,0,0,0,0,0,0,
   '{"martial_arts":"1d6","ki_points":7,"unarmored_movement":"+15"}'),
  (gen_random_uuid(),'monk', 8,3, NULL,NULL, 0,0,0,0,0,0,0,0,0,
   '{"martial_arts":"1d6","ki_points":8,"unarmored_movement":"+15"}'),
  (gen_random_uuid(),'monk', 9,4, NULL,NULL, 0,0,0,0,0,0,0,0,0,
   '{"martial_arts":"1d6","ki_points":9,"unarmored_movement":"+15"}'),
  (gen_random_uuid(),'monk',10,4, NULL,NULL, 0,0,0,0,0,0,0,0,0,
   '{"martial_arts":"1d6","ki_points":10,"unarmored_movement":"+20"}'),
  (gen_random_uuid(),'monk',11,4, NULL,NULL, 0,0,0,0,0,0,0,0,0,
   '{"martial_arts":"1d8","ki_points":11,"unarmored_movement":"+20"}'),
  (gen_random_uuid(),'monk',12,4, NULL,NULL, 0,0,0,0,0,0,0,0,0,
   '{"martial_arts":"1d8","ki_points":12,"unarmored_movement":"+20"}'),
  (gen_random_uuid(),'monk',13,5, NULL,NULL, 0,0,0,0,0,0,0,0,0,
   '{"martial_arts":"1d8","ki_points":13,"unarmored_movement":"+20"}'),
  (gen_random_uuid(),'monk',14,5, NULL,NULL, 0,0,0,0,0,0,0,0,0,
   '{"martial_arts":"1d8","ki_points":14,"unarmored_movement":"+25"}'),
  (gen_random_uuid(),'monk',15,5, NULL,NULL, 0,0,0,0,0,0,0,0,0,
   '{"martial_arts":"1d8","ki_points":15,"unarmored_movement":"+25"}'),
  (gen_random_uuid(),'monk',16,5, NULL,NULL, 0,0,0,0,0,0,0,0,0,
   '{"martial_arts":"1d8","ki_points":16,"unarmored_movement":"+25"}'),
  (gen_random_uuid(),'monk',17,6, NULL,NULL, 0,0,0,0,0,0,0,0,0,
   '{"martial_arts":"1d10","ki_points":17,"unarmored_movement":"+25"}'),
  (gen_random_uuid(),'monk',18,6, NULL,NULL, 0,0,0,0,0,0,0,0,0,
   '{"martial_arts":"1d10","ki_points":18,"unarmored_movement":"+30"}'),
  (gen_random_uuid(),'monk',19,6, NULL,NULL, 0,0,0,0,0,0,0,0,0,
   '{"martial_arts":"1d10","ki_points":19,"unarmored_movement":"+30"}'),
  (gen_random_uuid(),'monk',20,6, NULL,NULL, 0,0,0,0,0,0,0,0,0,
   '{"martial_arts":"1d10","ki_points":20,"unarmored_movement":"+30"}');

-- 3. CLASS FEATURES
INSERT INTO class_features (id, class_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'monk', 1,
   'Defesa Sem Armadura', 'Unarmored Defense',
   'No 1º nível, enquanto você não estiver usando armadura ou empunhando um escudo, sua Classe de Armadura é igual a 10 + seu modificador de Destreza + seu modificador de Sabedoria.',
   'feature','srd'),

  (gen_random_uuid(),'monk', 1,
   'Artes Marciais', 'Martial Arts',
   'No 1º nível, sua prática das artes marciais lhe dão maestria em estilos de combate que usam ataques desarmados e armas de monge, que são espadas curtas e qualquer arma corpo a corpo simples que não seja pesada nem de duas mãos.\n\nVocê pode usar Destreza em vez de Força para os testes de ataque e dano com ataques desarmados e armas de monge. Você pode rolar um d4 no lugar do dano normal do seu ataque desarmado. Quando usar a ação Atacar com uma arma de monge ou um ataque desarmado em seu turno, você pode fazer um ataque desarmado como ação bônus.\n\nO dado de Artes Marciais aumenta: d4 (níveis 1–4), d6 (níveis 5–10), d8 (níveis 11–16), d10 (níveis 17–20).',
   'feature','srd'),

  (gen_random_uuid(),'monk', 2,
   'Ki', 'Ki',
   'A partir do 2º nível, seu treinamento lhe permite canalizar a energia mística do ki. Você tem pontos de ki iguais ao seu nível de monge. Você gasta pontos de ki para ativar recursos de ki e os recupera ao terminar um descanso curto ou longo.\n\nRajada de Golpes: logo após usar a ação Atacar, gaste 1 ki para fazer dois ataques desarmados como ação bônus.\nDefesa Paciente: gaste 1 ki para tomar a ação Esquivar como ação bônus.\nPasso do Vento: gaste 1 ki para tomar a ação Correr ou Retirar como ação bônus; distância de salto duplicada.',
   'feature','srd'),

  (gen_random_uuid(),'monk', 2,
   'Movimento Sem Armadura', 'Unarmored Movement',
   'A partir do 2º nível, sua velocidade aumenta em +10 m enquanto você não estiver usando armadura ou empunhando um escudo. Esse bônus aumenta conforme você ganha níveis: +15 m (nível 6), +20 m (nível 10), +25 m (nível 14), +30 m (nível 18).\n\nNo 9º nível, você ganha a capacidade de se mover ao longo de superfícies verticais e através de líquidos em seu turno sem cair durante o movimento.',
   'feature','srd'),

  (gen_random_uuid(),'monk', 3,
   'Desviar Projéteis', 'Deflect Missiles',
   'A partir do 3º nível, você pode usar sua reação para desviar ou apanhar o míssil quando for atingido por um ataque de arma à distância. Quando você faz isso, o dano que recebe do ataque é reduzido em 1d10 + seu modificador de Destreza + seu nível de monge. Se você reduzir o dano a 0, você pode apanhar o míssil se ele for pequeno o suficiente. Se você apanhar um míssil desta forma, você pode gastar 1 ponto de ki para fazer um ataque à distância como parte da mesma reação.',
   'feature','srd'),

  (gen_random_uuid(),'monk', 3,
   'Tradição Monástica', 'Monastic Tradition',
   'No 3º nível, você se compromete com uma tradição monástica: Caminho da Mão Aberta, Caminho da Sombra ou Caminho dos Quatro Elementos. Sua tradição lhe concede recursos no 3º nível e novamente no 6º, 11º e 17º nível.',
   'subclass_choice','srd'),

  (gen_random_uuid(),'monk', 4,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'monk', 4,
   'Queda Lenta', 'Slow Fall',
   'A partir do 4º nível, você pode usar sua reação quando cair para reduzir qualquer dano de queda que receber em uma quantidade igual a cinco vezes seu nível de monge.',
   'feature','srd'),

  (gen_random_uuid(),'monk', 5,
   'Ataque Extra', 'Extra Attack',
   'A partir do 5º nível, você pode atacar duas vezes, em vez de uma, sempre que usar a ação Atacar em seu turno.',
   'extra_attack','srd'),

  (gen_random_uuid(),'monk', 5,
   'Golpe Atordoante', 'Stunning Strike',
   'A partir do 5º nível, você pode interferir no fluxo de ki no corpo de um oponente. Quando você acertar outra criatura com um ataque de arma de monge, você pode gastar 1 ponto de ki para tentar um golpe atordoante. O alvo deve ser bem-sucedido em um teste de resistência de Constituição ou ficará atordoado até o fim do seu próximo turno.',
   'feature','srd'),

  (gen_random_uuid(),'monk', 6,
   'Golpes Potenciados por Ki', 'Ki-Empowered Strikes',
   'A partir do 6º nível, seus ataques desarmados contam como mágicos para os fins de superar a resistência e imunidade a ataques e danos não mágicos.',
   'feature','srd'),

  (gen_random_uuid(),'monk', 7,
   'Evasão', 'Evasion',
   'No 7º nível, sua agilidade instintiva lhe permite esquivar-se de certos efeitos de área. Quando você é submetido a um efeito que permite que você faça um teste de resistência de Destreza para tomar apenas metade do dano, você não toma nenhum dano se tiver sucesso e apenas metade do dano se falhar.',
   'feature','srd'),

  (gen_random_uuid(),'monk', 7,
   'Calma das Emoções', 'Stillness of Mind',
   'A partir do 7º nível, você pode usar sua ação para encerrar um efeito sobre si mesmo que está causando que você fique encantado ou amedrontado.',
   'feature','srd'),

  (gen_random_uuid(),'monk', 8,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'monk',10,
   'Pureza do Corpo', 'Purity of Body',
   'No 10º nível, sua maestria do ki que flui através de você torna você imune a doenças e veneno.',
   'feature','srd'),

  (gen_random_uuid(),'monk',12,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'monk',13,
   'Língua do Sol e da Lua', 'Tongue of the Sun and Moon',
   'A partir do 13º nível, você aprende a tocar o ki de outras mentes para que você compreenda todas as línguas faladas. Além disso, qualquer criatura que possa entender uma língua pode entender o que você diz.',
   'feature','srd'),

  (gen_random_uuid(),'monk',14,
   'Alma Diamantina', 'Diamond Soul',
   'A partir do 14º nível, sua maestria do ki lhe concede proficiência em todos os testes de resistência. Além disso, sempre que você fizer um teste de resistência e falhar, você pode gastar 1 ponto de ki para refazê-lo e usar o segundo resultado.',
   'feature','srd'),

  (gen_random_uuid(),'monk',15,
   'Corpo Imortal', 'Timeless Body',
   'No 15º nível, seu ki sustenta você para que você sofra nenhum dos efeitos negativos da velhice, e você não pode ser envelhecido magicamente. No entanto, você ainda pode morrer de velhice. Além disso, você não precisa mais de comida ou água.',
   'feature','srd'),

  (gen_random_uuid(),'monk',16,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'monk',18,
   'Corpo Vazio', 'Empty Body',
   'A partir do 18º nível, você pode usar sua ação para gastar 4 pontos de ki para se tornar invisível por 1 minuto. Durante esse tempo, você também tem resistência a todos os danos exceto dano de força.\n\nAdicionalmente, você pode gastar 8 pontos de ki para lançar a magia Projeção Astral sem precisar de componentes materiais. Quando você faz isso, você não pode levar outros consigo.',
   'feature','srd'),

  (gen_random_uuid(),'monk',19,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'monk',20,
   'Ser Perfeito', 'Perfect Self',
   'No 20º nível, quando você rolar iniciativa e não tiver pontos de ki restantes, você recupera 4 pontos de ki.',
   'feature','srd');

-- 4. SUBCLASSES
INSERT INTO subclasses (id, class_id, name, name_en, description, level_gained, source) VALUES
  ('monk-openhand',
   'monk',
   'Caminho da Mão Aberta',
   'Way of the Open Hand',
   'Monges do Caminho da Mão Aberta são os mais mestres das artes marciais. Eles aprendem técnicas para empurrar e derrubar oponentes, manipulam o ki para curar danos no corpo e praticam meditação avançada que pode protegê-los do dano.',
   3,'srd'),

  ('monk-shadow',
   'monk',
   'Caminho da Sombra',
   'Way of Shadow',
   'Monges do Caminho da Sombra seguem uma tradição que valoriza a furtividade e o engano. Esses monges podem ser chamados de ninjas ou dançarinos das sombras, e servem como espiões e assassinos. Às vezes os membros de um monastério de sombras são agentes a serviço de um nobre.',
   3,'srd'),

  ('monk-fourelements',
   'monk',
   'Caminho dos Quatro Elementos',
   'Way of the Four Elements',
   'Você segue uma tradição monástica que abraça sua conexão com o mundo natural, redirecionando a força dos elementos através de seu corpo. Usando técnicas como Rajada Explosiva e Chicote de Chamas, você canaliza ki em formas sobrenaturais.',
   3,'srd');

-- 5. SUBCLASS FEATURES

-- Way of the Open Hand
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'monk-openhand', 3,
   'Técnica da Mão Aberta', 'Open Hand Technique',
   'A partir do 3º nível, você pode manipular o ki do inimigo quando atingi-lo com a Rajada de Golpes. Sempre que você acertar uma criatura com um dos ataques concedidos pela sua Rajada de Golpes, você pode impor um dos seguintes efeitos ao alvo: deve ser bem-sucedido em um teste de resistência de Destreza ou ser derrubado; deve ser bem-sucedido em um teste de resistência de Força ou ser empurrado até 4,5 m de você; não pode usar reações até o fim do seu próximo turno.',
   'feature','srd'),

  (gen_random_uuid(),'monk-openhand', 6,
   'Integridade do Corpo', 'Wholeness of Body',
   'No 6º nível, você ganha a habilidade de curar a si mesmo. Como ação, você pode recuperar pontos de vida iguais a três vezes seu nível de monge. Você deve terminar um descanso longo antes de poder usar esse recurso novamente.',
   'feature','srd'),

  (gen_random_uuid(),'monk-openhand',11,
   'Tranquilidade', 'Tranquility',
   'A partir do 11º nível, você pode entrar em um estado especial de meditação que o rodeia de uma aura de paz durante um descanso longo. No final do descanso longo, você ganha o efeito da magia Santuário que dura até o início de seu próximo descanso longo (a CD do teste de resistência é 8 + seu modificador de Sabedoria + seu bônus de proficiência). O efeito de Santuário termina prematuramente se você fizer um teste de ataque ou lançar uma magia que afete criaturas hostis.',
   'feature','srd'),

  (gen_random_uuid(),'monk-openhand',17,
   'Palma Tremulante', 'Quivering Palm',
   'No 17º nível, você ganha a capacidade de estabelecer vibrações letais em um inimigo. Quando você acerta uma criatura com um ataque desarmado, você pode gastar 3 pontos de ki para iniciar essas vibrações sutis que duram um número de dias igual ao seu nível de monge. As vibrações são inofensivas a menos que você as encerre. Para fazer isso, você deve usar uma ação para que a criatura faça um teste de resistência de Constituição. Se falhar, a criatura é reduzida a 0 pontos de vida. Se tiver êxito, a criatura recebe 10d10 de dano necrótico.',
   'feature','srd');

-- Way of Shadow
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'monk-shadow', 3,
   'Artes das Sombras', 'Shadow Arts',
   'A partir do 3º nível, você pode usar seu ki para duplicar os efeitos de certas magias. Como ação, você pode gastar 2 pontos de ki para lançar Escuridão, Visão no Escuro, Passo Silencioso ou Silêncio, sem fornecer componentes materiais. Além disso, você ganha o truque Ilusão Menor se ainda não o souber.',
   'feature','srd'),

  (gen_random_uuid(),'monk-shadow', 6,
   'Passo nas Sombras', 'Shadow Step',
   'No 6º nível, você ganha a habilidade de se mover das sombras. Quando você está em uma área de luz fraca ou escuridão, como ação bônus você pode se teletransportar até 18 metros para um espaço desocupado que você possa ver e que também esteja em luz fraca ou escuridão. Você então tem vantagem no primeiro ataque corpo a corpo que fizer antes do final do turno.',
   'feature','srd'),

  (gen_random_uuid(),'monk-shadow',11,
   'Manto das Sombras', 'Cloak of Shadows',
   'No 11º nível, você aprende a esconder-se no tecido das sombras. Quando você está em uma área de luz fraca ou escuridão, pode usar sua ação para se tornar invisível. Você permanece invisível até fazer um ataque, lançar uma magia ou estar em uma área de luz brilhante.',
   'feature','srd'),

  (gen_random_uuid(),'monk-shadow',17,
   'Oportunista', 'Opportunist',
   'No 17º nível, você pode aproveitar a distração de uma criatura por seus aliados. Quando uma criatura a até 1,5 m de você for atingida por um ataque feito por uma criatura que não seja você, você pode usar sua reação para fazer um ataque corpo a corpo contra aquela criatura.',
   'feature','srd');

-- Way of the Four Elements
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'monk-fourelements', 3,
   'Seguidor do Elemento', 'Disciple of the Elements',
   'No 3º nível, você aprende disciplinas mágicas que aproveitam o poder dos quatro elementos. Ao ganhar esse recurso, você aprende 2 disciplinas elementais de sua escolha. Você aprende disciplinas adicionais nos níveis 6, 11 e 17.\n\nExemplos de disciplinas: Rajada Explosiva (2 ki — 3d10 trovejante, empurra 6 m), Braço do Vento Uivante (2 ki — como Gust of Wind), Chão Ondulante (3 ki — como Earthquake), Forma de Água (2 ki — como Shape Water e Create Water), Chicote de Chamas (2 ki — 3d6 fogo, puxa criatura). Cada disciplina usa ki cujo custo aumenta com efeitos mais poderosos.',
   'feature','srd'),

  (gen_random_uuid(),'monk-fourelements', 6,
   'Disciplina Elemental Adicional', 'Additional Elemental Discipline',
   'No 6º nível, você aprende mais uma disciplina elemental de sua escolha. Algumas disciplinas de nível superior também ficam disponíveis.',
   'feature','srd'),

  (gen_random_uuid(),'monk-fourelements',11,
   'Disciplina Elemental Adicional', 'Additional Elemental Discipline',
   'No 11º nível, você aprende mais uma disciplina elemental e pode agora escolher disciplinas que custam até 4 pontos de ki (como Corpo de Pedra Viva e Forma de Ar).',
   'feature','srd'),

  (gen_random_uuid(),'monk-fourelements',17,
   'Disciplina Elemental Adicional', 'Additional Elemental Discipline',
   'No 17º nível, você aprende mais uma disciplina elemental e pode escolher as mais poderosas, como Montanha Imóvel (5 ki — como Mover Terra) e Maré Etérea (5 ki — como Controle da Água).',
   'feature','srd');
