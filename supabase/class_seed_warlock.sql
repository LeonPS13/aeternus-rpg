-- ============================================================
-- BRUXO (Warlock) — SRD 5.1 seed
-- ============================================================

-- 1. CLASS
INSERT INTO classes (
  id, name, name_en, description,
  hit_die, primary_ability, saving_throws,
  armor_proficiencies, weapon_proficiencies, tool_proficiencies,
  skill_choices_count, skill_choices,
  speed, spellcasting_ability, spellcasting_type, source
) VALUES (
  'warlock',
  'Bruxo',
  'Warlock',
  'Bruxos são buscadores do conhecimento que reside nos interstícios da realidade. Através de pactos com entidades misteriosas de poder sobrenatural, bruxos desbloqueiam efeitos mágicos tanto sutis como espetaculares. Diferente de outros conjuradores, seus espaços de magia se recuperam em cada descanso curto — poucos, mas poderosos.',
  8,
  ARRAY['charisma'],
  ARRAY['wisdom','charisma'],
  ARRAY['light'],
  ARRAY['simple'],
  ARRAY[]::text[],
  2,
  ARRAY['arcana','deception','history','intimidation','investigation','nature','religion'],
  30,
  'charisma',
  'known',
  'srd'
);

-- 2. LEVELS
-- Magia do Pacto: espaços únicos que sobem de nível a cada dois níveis de classe.
-- Os espaços ocupam a coluna correspondente ao seu nível atual:
--   níveis 1–2 → slot_1 | 3–4 → slot_2 | 5–6 → slot_3 | 7–8 → slot_4 | 9–20 → slot_5
-- Todos os espaços se recuperam no descanso curto (descrito na feature).
-- Meta: invocations (invocações místicas conhecidas, a partir do nível 2)
INSERT INTO class_levels (
  id, class_id, level, proficiency_bonus,
  cantrips_known, spells_known,
  slot_1, slot_2, slot_3, slot_4, slot_5,
  slot_6, slot_7, slot_8, slot_9,
  meta
) VALUES
  (gen_random_uuid(),'warlock', 1,2, 2,2,  1,0,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'warlock', 2,2, 2,3,  2,0,0,0,0,0,0,0,0, '{"invocations":2}'::jsonb),
  (gen_random_uuid(),'warlock', 3,2, 2,4,  0,2,0,0,0,0,0,0,0, '{"invocations":2}'::jsonb),
  (gen_random_uuid(),'warlock', 4,2, 3,5,  0,2,0,0,0,0,0,0,0, '{"invocations":2}'::jsonb),
  (gen_random_uuid(),'warlock', 5,3, 3,6,  0,0,2,0,0,0,0,0,0, '{"invocations":3}'::jsonb),
  (gen_random_uuid(),'warlock', 6,3, 3,7,  0,0,2,0,0,0,0,0,0, '{"invocations":3}'::jsonb),
  (gen_random_uuid(),'warlock', 7,3, 3,8,  0,0,0,2,0,0,0,0,0, '{"invocations":4}'::jsonb),
  (gen_random_uuid(),'warlock', 8,3, 3,9,  0,0,0,2,0,0,0,0,0, '{"invocations":4}'::jsonb),
  (gen_random_uuid(),'warlock', 9,4, 3,10, 0,0,0,0,2,0,0,0,0, '{"invocations":5}'::jsonb),
  (gen_random_uuid(),'warlock',10,4, 4,10, 0,0,0,0,2,0,0,0,0, '{"invocations":5}'::jsonb),
  (gen_random_uuid(),'warlock',11,4, 4,11, 0,0,0,0,3,0,0,0,0, '{"invocations":5}'::jsonb),
  (gen_random_uuid(),'warlock',12,4, 4,11, 0,0,0,0,3,0,0,0,0, '{"invocations":6}'::jsonb),
  (gen_random_uuid(),'warlock',13,5, 4,12, 0,0,0,0,3,0,0,0,0, '{"invocations":6}'::jsonb),
  (gen_random_uuid(),'warlock',14,5, 4,12, 0,0,0,0,3,0,0,0,0, '{"invocations":6}'::jsonb),
  (gen_random_uuid(),'warlock',15,5, 4,13, 0,0,0,0,3,0,0,0,0, '{"invocations":7}'::jsonb),
  (gen_random_uuid(),'warlock',16,5, 4,13, 0,0,0,0,3,0,0,0,0, '{"invocations":7}'::jsonb),
  (gen_random_uuid(),'warlock',17,6, 4,14, 0,0,0,0,4,0,0,0,0, '{"invocations":7}'::jsonb),
  (gen_random_uuid(),'warlock',18,6, 4,14, 0,0,0,0,4,0,0,0,0, '{"invocations":8}'::jsonb),
  (gen_random_uuid(),'warlock',19,6, 4,15, 0,0,0,0,4,0,0,0,0, '{"invocations":8}'::jsonb),
  (gen_random_uuid(),'warlock',20,6, 4,15, 0,0,0,0,4,0,0,0,0, '{"invocations":8}'::jsonb);

-- 3. CLASS FEATURES
INSERT INTO class_features (id, class_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'warlock', 1,
   'Patrono Sobrenatural', 'Otherworldly Patron',
   'No 1º nível, você fez um acordo com um ser sobrenatural de sua escolha: o Arquifada, o Infernal ou o Grande Ancião. Seu patrono lhe concede recursos no 1º nível e novamente no 6º, 10º e 14º nível.',
   'subclass_choice','srd'),

  (gen_random_uuid(),'warlock', 1,
   'Magia do Pacto', 'Pact Magic',
   'Seu arcano pesquisado e o poder concedido por seu patrono lhe deram capacidade de lançar magias. Carisma é sua habilidade de conjuração para magias de bruxo.\n\nEspaços de Magia do Pacto: você tem espaços de magia como mostrado na tabela. O nível desses espaços cresce a cada dois níveis — todos os espaços são sempre do mesmo nível. Crucialmente, esses espaços se recuperam ao terminar um descanso curto ou longo (não apenas no descanso longo como as outras classes).',
   'spellcasting','srd'),

  (gen_random_uuid(),'warlock', 2,
   'Invocações Místicas', 'Eldritch Invocations',
   'No 2º nível, você destilou conhecimentos proibidos em uma série de invocações místicas que lhe conferem capacidades arcanas permanentes. Você aprende 2 invocações e aprende mais conforme sobe de nível. Pode substituir uma invocação ao subir de nível.\n\nExemplos de invocações (SRD): Visão do Diabo (enxergar no escuro total); Mente Despertada (telepathy 9 m); Susurros do Tumulo (falar com mortos 1×/dia); Explosão Repulsiva (Eldritch Blast empurra 3 m); Lança da Lança da Lança (Eldritch Blast vira lança); Máscara de Muitas Faces (Disfarce-se à vontade); Visão do Diabo; Olho da Lua (Clarividência 1×/dia).',
   'feature','srd'),

  (gen_random_uuid(),'warlock', 3,
   'Dádiva do Pacto', 'Pact Boon',
   'No 3º nível, seu patrono concede um presente em reconhecimento ao seu serviço leal. Escolha uma das seguintes opções:\n• Pacto da Corrente: você aprende a magia Encontrar Familiar e pode invocar familiares especiais (imp, pseudodragão, quasit ou sprite), podendo atacar em seu lugar como ação bônus.\n• Pacto da Lâmina: você pode usar sua ação para criar uma arma de pacto em sua mão vazia. Você pode usar Carisma para testes de ataque e dano com ela. Ela some se estiver a mais de 1,5 m por 1 minuto.\n• Pacto do Tomo: seu patrono te entrega um grimório (Livro das Sombras) com 3 truques quaisquer (de qualquer classe). Enquanto os tiver, eles contam como magias de bruxo para você.',
   'feature','srd'),

  (gen_random_uuid(),'warlock', 4,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'warlock', 8,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'warlock',11,
   'Arcanum Místico (6º)', 'Mystic Arcanum (6th)',
   'No 11º nível, seu patrono lhe concede um segredo mágico chamado arcanum. Escolha uma magia de 6º nível da lista de bruxo. Você pode lançá-la uma vez sem gastar um espaço de magia. Você deve terminar um descanso longo antes de fazê-lo novamente.',
   'feature','srd'),

  (gen_random_uuid(),'warlock',12,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'warlock',13,
   'Arcanum Místico (7º)', 'Mystic Arcanum (7th)',
   'No 13º nível, seu patrono lhe concede mais um segredo mágico. Escolha uma magia de 7º nível da lista de bruxo. Você pode lançá-la uma vez sem gastar um espaço de magia. Você deve terminar um descanso longo antes de fazê-lo novamente.',
   'feature','srd'),

  (gen_random_uuid(),'warlock',15,
   'Arcanum Místico (8º)', 'Mystic Arcanum (8th)',
   'No 15º nível, seu patrono lhe concede mais um segredo mágico. Escolha uma magia de 8º nível da lista de bruxo. Você pode lançá-la uma vez sem gastar um espaço de magia. Você deve terminar um descanso longo antes de fazê-lo novamente.',
   'feature','srd'),

  (gen_random_uuid(),'warlock',16,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'warlock',17,
   'Arcanum Místico (9º)', 'Mystic Arcanum (9th)',
   'No 17º nível, seu patrono lhe concede mais um segredo mágico. Escolha uma magia de 9º nível da lista de bruxo. Você pode lançá-la uma vez sem gastar um espaço de magia. Você deve terminar um descanso longo antes de fazê-lo novamente.',
   'feature','srd'),

  (gen_random_uuid(),'warlock',19,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'warlock',20,
   'Mestre Místico', 'Eldritch Master',
   'No 20º nível, você pode pedir ao seu patrono que restaure seus espaços de magia gastos. Você pode fazer isso passando 1 minuto suplicando ao seu patrono em oração ou rituais. Você recupera todos os espaços da Magia do Pacto. Você deve terminar um descanso longo antes de usar esse recurso novamente.',
   'feature','srd');

-- 4. SUBCLASSES
INSERT INTO subclasses (id, class_id, name, name_en, description, level_gained, source) VALUES
  ('warlock-archfey',
   'warlock',
   'O Arquifada',
   'The Archfey',
   'Seu patrono é um senhor ou senhora do Feywild, um ser da lenda que reina sobre um domínio mágico. Os motivos de tal ser são frequentemente inescrutáveis, e às vezes caprichosos, e podem incluir o recolhimento de uma dívida antiga ou ajudar a manter o equilíbrio primevo da natureza.',
   1,'srd'),

  ('warlock-fiend',
   'warlock',
   'O Infernal',
   'The Fiend',
   'Você fez um pacto com um infernal poderoso dos planos infernais. Tais seres desejam a corrupção ou a destruição de todas as coisas, eventualmente incluindo você. Os infernais poderosos incluem lorde dos demônios e arquidevil. Você tem proficiência em língua Abissal ou Infernal.',
   1,'srd'),

  ('warlock-greatoldone',
   'warlock',
   'O Grande Ancião',
   'The Great Old One',
   'Seu patrono é um ser misterioso cuja natureza é totalmente diferente das outras entidades. Sua esfera de influência não corresponde a nada no plano material. Ele pode ter enviado lances de magia através dos sonhos, ou ele pode ser uma divindade que está despertando.',
   1,'srd');

-- 5. SUBCLASS FEATURES

-- The Archfey
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'warlock-archfey', 1,
   'Lista de Magias Expandida e Presença Feérica', 'Expanded Spells & Fey Presence',
   'Magias do Patrono (sempre preparadas): 1º — Sono, Cor Cegante; 2º — Calmar Emoções, Fantasia; 3º — Blink, Hipnose; 4º — Dominar Besta, Grande Invisibilidade; 5º — Dominar Pessoa, Parece Existir.\n\nPresença Feérica: como ação, escolha um cubo de 3 m originando em você. Cada criatura nessa área deve ser bem-sucedida em um teste de Sabedoria (CD de sua magia) ou ficará encantada ou amedrontada (à sua escolha) por você até o fim do seu próximo turno. Você deve terminar um descanso curto ou longo antes de usar esse recurso novamente.',
   'feature','srd'),

  (gen_random_uuid(),'warlock-archfey', 6,
   'Fuga Nebulosa', 'Misty Escape',
   'No 6º nível, você pode se dissipar em névoa quando estiver em perigo. Quando você receber dano, pode usar sua reação para ficar invisível e se teletransportar até 18 metros para um espaço desocupado que possa ver. Você permanece invisível até o início do seu próximo turno ou até atacar ou lançar uma magia. Você deve terminar um descanso curto ou longo antes de usar esse recurso novamente.',
   'feature','srd'),

  (gen_random_uuid(),'warlock-archfey',10,
   'Defesas Sedutoras', 'Beguiling Defenses',
   'No 10º nível, seu patrono te ensina a virar encantamentos contra seus criadores. Você é imune ao estado encantado e, quando outra criatura tentar te encantar, você pode usar sua reação para tentar virar o feitiço contra ela. A criatura deve ser bem-sucedida em um teste de Sabedoria (CD de sua magia) ou ficará encantada por você por 1 minuto.',
   'feature','srd'),

  (gen_random_uuid(),'warlock-archfey',14,
   'Delírio Sombrio', 'Dark Delirium',
   'No 14º nível, você pode mergulhar uma criatura em uma ilusão. Como ação, escolha uma criatura que possa ver a até 18 m. Ela deve fazer um teste de Sabedoria (CD de sua magia) ou ficará encantada ou amedrontada (sua escolha) por 1 minuto ou até perder a concentração. A ilusão a faz ver fantasias sedutoras ou aterrorizantes. Você deve terminar um descanso curto ou longo antes de usar esse recurso novamente.',
   'feature','srd');

-- The Fiend
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'warlock-fiend', 1,
   'Lista de Magias Expandida e Bênção do Infernal', 'Expanded Spells & Dark One''s Blessing',
   'Magias do Patrono (sempre preparadas): 1º — Mãos Ardentes, Comando; 2º — Cegar/Ensurdecer, Riso Histérico de Tasha; 3º — Bola de Fogo, Forma Gasosa; 4º — Escudo de Fogo, Parede de Fogo; 5º — Chama Atingente, Santificar.\n\nBênção do Infernal: quando você reduzir uma criatura hostil a 0 PV, você ganha pontos de vida temporários iguais ao seu modificador de Carisma + seu nível de bruxo (mínimo 1). Esses pontos de vida temporários desaparecem ao terminar um descanso longo.',
   'feature','srd'),

  (gen_random_uuid(),'warlock-fiend', 6,
   'Sorte do Infernal', 'Dark One''s Own Luck',
   'No 6º nível, você pode invocar seu patrono para alterar o destino a seu favor. Quando fizer um teste de habilidade ou teste de resistência, você pode usar esse recurso para adicionar 1d10 ao resultado. Você pode fazer isso depois de ver o resultado inicial mas antes que qualquer efeito do teste ocorra. Você deve terminar um descanso curto ou longo antes de usar esse recurso novamente.',
   'feature','srd'),

  (gen_random_uuid(),'warlock-fiend',10,
   'Resiliência Infernal', 'Fiendish Resilience',
   'No 10º nível, você pode escolher um tipo de dano quando terminar um descanso curto ou longo. Você ganha resistência a esse tipo de dano até escolher um diferente com esse recurso. O dano de armas e dano mágico pode ser escolhido.',
   'feature','srd'),

  (gen_random_uuid(),'warlock-fiend',14,
   'Arremesso pelo Inferno', 'Hurl Through Hell',
   'No 14º nível, quando acertar uma criatura com um ataque, você pode usar esse recurso para transportá-la instantaneamente por planos infernais. A criatura some e percorre um pesadelo infernal. No final do seu próximo turno, ela retorna ao espaço que ocupava anteriormente ou no mais próximo disponível. Se a criatura não for um infernal, ela recebe 10d10 de dano psíquico ao retornar. Você deve terminar um descanso longo antes de usar esse recurso novamente.',
   'feature','srd');

-- The Great Old One
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'warlock-greatoldone', 1,
   'Lista de Magias Expandida e Mente Desperta', 'Expanded Spells & Awakened Mind',
   'Magias do Patrono (sempre preparadas): 1º — Dissonant Whispers, Compulsão Incomum de Tasha; 2º — Detectar Pensamentos, Fantasia; 3º — Clairvoyance, Enviar Mensagem; 4º — Dominar Besta, Phantasmal Killer; 5º — Dominar Pessoa, Telepatia.\n\nMente Desperta: sua magia alienígena fortalece sua mente. Você pode se comunicar telepáticamente com qualquer criatura que possa ver a até 9 metros de você. Você não precisa compartilhar um idioma, mas a criatura deve ser capaz de entender pelo menos um idioma.',
   'feature','srd'),

  (gen_random_uuid(),'warlock-greatoldone', 6,
   'Proteção Entrópica', 'Entropic Ward',
   'No 6º nível, você aprendeu a proteger a si mesmo magicamente contra dano e a transformar tentativas frustradas de atingi-lo em sorte para você. Quando uma criatura fizer uma jogada de ataque contra você, você pode usar sua reação para impor desvantagem nessa jogada. Se o ataque errar, seu próximo ataque contra a criatura tem vantagem se você o fizer antes do final do seu próximo turno. Você deve terminar um descanso curto ou longo antes de usar esse recurso novamente.',
   'feature','srd'),

  (gen_random_uuid(),'warlock-greatoldone',10,
   'Escudo Psíquico', 'Thought Shield',
   'No 10º nível, seus pensamentos não podem ser lidos por telepatia ou outros meios a não ser que você permita. Você também tem resistência a dano psíquico e, quando uma criatura te causar dano psíquico, ela recebe a mesma quantidade de dano psíquico.',
   'feature','srd'),

  (gen_random_uuid(),'warlock-greatoldone',14,
   'Criar Servo', 'Create Thrall',
   'No 14º nível, você ganha a habilidade de infectar a mente de um humanoide com a magia alienígena do seu patrono. Você pode usar sua ação para tocar um humanoide incapacitado. Essa criatura fica encantada por você até que uma magia Remover Maldição seja lançada nela, a condição mágica seja dissipada, ou você use esse recurso novamente. Você pode se comunicar telepáticamente com o servo enquanto estiver no mesmo plano de existência.',
   'feature','srd');
