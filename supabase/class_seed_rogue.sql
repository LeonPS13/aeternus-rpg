-- ============================================================
-- LADINO (Rogue) — SRD 5.1 seed
-- ============================================================

-- 1. CLASS
INSERT INTO classes (
  id, name, name_en, description,
  hit_die, primary_ability, saving_throws,
  armor_proficiencies, weapon_proficiencies, tool_proficiencies,
  skill_choices_count, skill_choices,
  speed, spellcasting_ability, spellcasting_type, source
) VALUES (
  'rogue',
  'Ladino',
  'Rogue',
  'Os ladinos dependem de maestria em uma variedade de habilidades, contando com a furtividade e a exploração de fraquezas dos inimigos para derrotar seus oponentes. Eles têm um talento para encontrar a solução para praticamente qualquer problema, demonstrando engenhosidade e versatilidade.',
  8,
  ARRAY['dexterity'],
  ARRAY['dexterity','intelligence'],
  ARRAY['light'],
  ARRAY['simple','hand_crossbow','longsword','rapier','shortsword'],
  ARRAY['thieves_tools'],
  4,
  ARRAY['acrobatics','athletics','deception','insight','intimidation','investigation','perception','performance','persuasion','sleight_of_hand','stealth'],
  30,
  NULL,
  NULL,
  'srd'
);

-- 2. LEVELS
-- Meta: sneak_attack — dado de Ataque Furtivo (aumenta a cada 2 níveis)
INSERT INTO class_levels (
  id, class_id, level, proficiency_bonus,
  cantrips_known, spells_known,
  slot_1, slot_2, slot_3, slot_4, slot_5,
  slot_6, slot_7, slot_8, slot_9,
  meta
) VALUES
  (gen_random_uuid(),'rogue', 1,2, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"sneak_attack":"1d6"}'),
  (gen_random_uuid(),'rogue', 2,2, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"sneak_attack":"1d6"}'),
  (gen_random_uuid(),'rogue', 3,2, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"sneak_attack":"2d6"}'),
  (gen_random_uuid(),'rogue', 4,2, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"sneak_attack":"2d6"}'),
  (gen_random_uuid(),'rogue', 5,3, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"sneak_attack":"3d6"}'),
  (gen_random_uuid(),'rogue', 6,3, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"sneak_attack":"3d6"}'),
  (gen_random_uuid(),'rogue', 7,3, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"sneak_attack":"4d6"}'),
  (gen_random_uuid(),'rogue', 8,3, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"sneak_attack":"4d6"}'),
  (gen_random_uuid(),'rogue', 9,4, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"sneak_attack":"5d6"}'),
  (gen_random_uuid(),'rogue',10,4, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"sneak_attack":"5d6"}'),
  (gen_random_uuid(),'rogue',11,4, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"sneak_attack":"6d6"}'),
  (gen_random_uuid(),'rogue',12,4, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"sneak_attack":"6d6"}'),
  (gen_random_uuid(),'rogue',13,5, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"sneak_attack":"7d6"}'),
  (gen_random_uuid(),'rogue',14,5, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"sneak_attack":"7d6"}'),
  (gen_random_uuid(),'rogue',15,5, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"sneak_attack":"8d6"}'),
  (gen_random_uuid(),'rogue',16,5, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"sneak_attack":"8d6"}'),
  (gen_random_uuid(),'rogue',17,6, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"sneak_attack":"9d6"}'),
  (gen_random_uuid(),'rogue',18,6, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"sneak_attack":"9d6"}'),
  (gen_random_uuid(),'rogue',19,6, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"sneak_attack":"10d6"}'),
  (gen_random_uuid(),'rogue',20,6, NULL,NULL, 0,0,0,0,0,0,0,0,0, '{"sneak_attack":"10d6"}');

-- 3. CLASS FEATURES
INSERT INTO class_features (id, class_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'rogue', 1,
   'Perícia', 'Expertise',
   'No 1º nível, escolha duas de suas proficiências em perícias ou sua proficiência com ferramentas de ladrão. O bônus de proficiência é dobrado para qualquer teste de habilidade que você fizer usando uma das perícias ou ferramentas escolhidas. No 6º nível, você pode escolher mais duas de suas proficiências (em perícias ou com ferramentas de ladrão) para ganhar esse benefício.',
   'feature','srd'),

  (gen_random_uuid(),'rogue', 1,
   'Ataque Furtivo', 'Sneak Attack',
   'A partir do 1º nível, você sabe como atacar sutilmente e explorar a distração de um inimigo. Você pode causar 1d6 de dano extra a um inimigo que você acertar com um ataque se tiver vantagem no teste de ataque ou se outro inimigo do alvo estiver a até 1,5 m dele. O ataque deve usar uma arma de acuidade ou de ataque à distância. O dano extra aumenta em 1d6 a cada dois níveis de ladino.',
   'feature','srd'),

  (gen_random_uuid(),'rogue', 1,
   'Argot dos Ladrões', 'Thieves'' Cant',
   'Durante seu treinamento de ladino, você aprendeu o Argot dos Ladrões, uma linguagem secreta de gírias, gestos e sinais usados pelos ladrões e membros de guildas semelhantes. Você pode usar esse idioma para comunicar mensagens secretas aos outros que conhecem a linguagem.',
   'feature','srd'),

  (gen_random_uuid(),'rogue', 2,
   'Ação Ardilosa', 'Cunning Action',
   'A partir do 2º nível, sua agilidade e rapidez mental permitem que você se mova e aja rapidamente. Você pode usar uma ação bônus em cada um dos seus turnos no combate. Essa ação pode ser usada apenas para tomar as ações Correr, Retirar ou Esconder.',
   'feature','srd'),

  (gen_random_uuid(),'rogue', 3,
   'Arquétipo de Ladino', 'Roguish Archetype',
   'No 3º nível, você escolhe um arquétipo que emular no exercício de suas habilidades de ladino: Ladrão, Assassino ou Trapaceiro Arcano. Seu arquétipo lhe concede recursos no 3º nível e novamente no 9º, 13º e 17º nível.',
   'subclass_choice','srd'),

  (gen_random_uuid(),'rogue', 4,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'rogue', 5,
   'Esquiva Sobrenatural', 'Uncanny Dodge',
   'A partir do 5º nível, quando um atacante que você possa ver o acerta com um ataque, você pode usar sua reação para reduzir o dano pela metade contra você.',
   'feature','srd'),

  (gen_random_uuid(),'rogue', 6,
   'Perícia (2ª)', 'Expertise (2nd)',
   'No 6º nível, você escolhe mais duas proficiências (em perícias ou ferramentas de ladrão) para ter seu bônus de proficiência dobrado.',
   'feature','srd'),

  (gen_random_uuid(),'rogue', 7,
   'Evasão', 'Evasion',
   'A partir do 7º nível, você pode esquivar-se habilmente de certos efeitos de área, como o sopro ardente de um dragão vermelho. Quando você é submetido a um efeito que permite que você faça um teste de resistência de Destreza para tomar apenas metade do dano, você não toma nenhum dano se tiver sucesso e apenas metade do dano se falhar.',
   'feature','srd'),

  (gen_random_uuid(),'rogue', 8,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'rogue',10,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'rogue',11,
   'Talento Confiável', 'Reliable Talent',
   'No 11º nível, você refinou suas habilidades escolhidas até quase a perfeição. Sempre que você fizer um teste de habilidade que lhe permita adicionar seu bônus de proficiência, você pode tratar um d20 de 9 ou inferior como um 10.',
   'feature','srd'),

  (gen_random_uuid(),'rogue',12,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'rogue',14,
   'Sentidos às Cegas', 'Blindsense',
   'A partir do 14º nível, se você for capaz de ouvir, você estará ciente da localização de quaisquer criaturas ocultas ou invisíveis a até 3 metros de você.',
   'feature','srd'),

  (gen_random_uuid(),'rogue',15,
   'Mente Escorregadia', 'Slippery Mind',
   'No 15º nível, você adquiriu maior força mental. Você ganha proficiência em testes de resistência de Sabedoria.',
   'feature','srd'),

  (gen_random_uuid(),'rogue',16,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'rogue',18,
   'Elusivo', 'Elusive',
   'A partir do 18º nível, você é tão evasivo que atacantes raramente têm vantagem sobre você. Nenhuma jogada de ataque tem vantagem contra você enquanto você não estiver incapacitado.',
   'feature','srd'),

  (gen_random_uuid(),'rogue',19,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'rogue',20,
   'Golpe de Sorte', 'Stroke of Luck',
   'No 20º nível, você tem uma dom sobrenatural para ter sucesso quando você precisa. Se o seu ataque errar o alvo, você pode transformar o erro em acerto. Alternativamente, se você falhar em um teste de habilidade, você pode tratar a rolagem do d20 como um 20. Após usar esse recurso, você deve terminar um descanso curto ou longo antes de usá-lo novamente.',
   'feature','srd');

-- 4. SUBCLASSES
INSERT INTO subclasses (id, class_id, name, name_en, description, level_gained, source) VALUES
  ('rogue-thief',
   'rogue',
   'Ladrão',
   'Thief',
   'Você aprimora suas habilidades nas artes do furto. Ladrões, bandidos, batedores de carteira e outros criminosos normalmente seguem esse arquétipo, mas também o fazem ladinos que preferem se pensar como buscadores de tesouros profissionais, exploradores, espreitadores e investigadores.',
   3,'srd'),

  ('rogue-assassin',
   'rogue',
   'Assassino',
   'Assassin',
   'Você se concentra na sombria arte do assassinato. Alimentado por venenos, disfarces e emboscadas, você habilita a morte de outros. Assassinos alinham-se frequentemente ao mal, mas alguns são profissionais quase desapaixonados por sua macabra escolha de profissão.',
   3,'srd'),

  ('rogue-arcanetrickster',
   'rogue',
   'Trapaceiro Arcano',
   'Arcane Trickster',
   'Alguns ladinos aprimoram suas habilidades com magia, geralmente com as escolas de ilusão e encantamento. Esses trapaceiros arcanos incluem ladrões de dedos rápidos que hipnotizam suas vítimas, aventureiros que podem escalar paredes e assassinos que se tornam invisíveis quando precisam.',
   3,'srd');

-- 5. SUBCLASS FEATURES

-- Thief
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'rogue-thief', 3,
   'Mãos Rápidas', 'Fast Hands',
   'A partir do 3º nível, você pode usar a ação bônus concedida pela sua Ação Ardilosa para fazer um teste de Destreza (Prestidigitação), usar suas ferramentas de ladrão para abrir uma fechadura ou desarmar uma armadilha, ou tomar a ação Usar um Objeto.',
   'feature','srd'),

  (gen_random_uuid(),'rogue-thief', 3,
   'Trabalho de Segundo Andar', 'Second-Story Work',
   'Quando você escolhe esse arquétipo no 3º nível, você ganha a capacidade de trepar mais rápido do que o normal; trepar não custa movimento extra. Além disso, quando você faz um salto em comprimento com corrida, a distância que você pode cobrir aumenta por um número de pés igual ao seu modificador de Destreza.',
   'feature','srd'),

  (gen_random_uuid(),'rogue-thief', 9,
   'Furtividade Suprema', 'Supreme Sneak',
   'A partir do 9º nível, você tem vantagem em um teste de Destreza (Furtividade) se você se mover não mais do que metade da sua velocidade no mesmo turno.',
   'feature','srd'),

  (gen_random_uuid(),'rogue-thief',13,
   'Usar Objeto Mágico', 'Use Magic Device',
   'No 13º nível, você aprendeu o suficiente sobre o funcionamento da magia para poder improvisar o uso de itens mesmo quando eles não são destinados a você. Você ignora todos os requisitos de classe, raça e nível no uso de itens mágicos.',
   'feature','srd'),

  (gen_random_uuid(),'rogue-thief',17,
   'Reflexos do Ladrão', 'Thief''s Reflexes',
   'Quando você atingir o 17º nível, você ficou especialmente habilidoso em montar emboscadas e escapar rapidamente de perigo. Você pode fazer dois turnos durante o primeiro round de qualquer combate. Você faz o primeiro turno na sua iniciativa e o segundo turno na sua iniciativa menos 10.',
   'feature','srd');

-- Assassin
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'rogue-assassin', 3,
   'Proficiências Bônus', 'Bonus Proficiencies',
   'Quando você escolhe esse arquétipo no 3º nível, você ganha proficiência com o kit de disfarce e o kit de venenos.',
   'feature','srd'),

  (gen_random_uuid(),'rogue-assassin', 3,
   'Assassinar', 'Assassinate',
   'A partir do 3º nível, você é perigoso no momento em que entra em batalha. Você tem vantagem em testes de ataque contra qualquer criatura que ainda não tenha agido. Além disso, qualquer acerto que você conseguir contra uma criatura que seja surpreendida é um acerto crítico.',
   'feature','srd'),

  (gen_random_uuid(),'rogue-assassin', 9,
   'Especialização em Infiltração', 'Infiltration Expertise',
   'A partir do 9º nível, você pode criar identidades falsas para si mesmo infalivelmente. Você deve gastar sete dias e 25 po para estabelecer história, profissão e afiliações para uma identidade. Você não pode estabelecer uma identidade que pertença a outra pessoa. Depois, você pode se apresentar como essa persona.',
   'feature','srd'),

  (gen_random_uuid(),'rogue-assassin',13,
   'Impostor', 'Impostor',
   'No 13º nível, você obtém a habilidade de imitar o discurso, a escrita e o comportamento de outra pessoa impecavelmente, dado pelo menos três horas de estudo da pessoa (observando sua fala, examinando sua escrita e estudando seus gestos). Seu disfarce é tão eficaz que qualquer pessoa que não observou a pessoa que você está imitando em ação acredita em você.',
   'feature','srd'),

  (gen_random_uuid(),'rogue-assassin',17,
   'Golpe Mortal', 'Death Strike',
   'A partir do 17º nível, você torna-se um mestre da morte instantânea. Quando você ataca e acerta uma criatura que está surpresa, ela deve fazer um teste de resistência de Constituição (CD 8 + seu modificador de Destreza + seu bônus de proficiência). Se falhar, duplique o dano do ataque contra a criatura.',
   'feature','srd');

-- Arcane Trickster
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'rogue-arcanetrickster', 3,
   'Conjuração Arcana', 'Spellcasting',
   'Quando você atingir o 3º nível, você ganha a capacidade de lançar magias. Sua habilidade de conjuração é Inteligência. Como conjurador de terço de nível, você aprende 3 truques do mago e usa a tabela do Trapaceiro Arcano para espaços de magia: 2 espaços de 1º nível no nível 3, progredindo até 4/3/3/1 espaços de 1º a 4º nível no nível 20. As magias aprendidas devem ser de encantamento ou ilusão, exceto duas que podem ser de qualquer escola.',
   'spellcasting','srd'),

  (gen_random_uuid(),'rogue-arcanetrickster', 3,
   'Legerdemain da Mão do Mago', 'Mage Hand Legerdemain',
   'A partir do 3º nível, quando você lança Mão do Mago, você pode tornar a mão espectral invisível e pode realizar as seguintes tarefas adicionais com ela: guardar um objeto que a mão segura em um contêiner usado por outra criatura; retirar um objeto de um contêiner usando por outra criatura; usar ferramentas de ladrão para abrir fechaduras e desarmar armadilhas à distância. Você pode realizar uma dessas tarefas sem ser notado com um teste de Destreza (Prestidigitação) bem-sucedido contra um teste de Sabedoria (Percepção) passivo de quem estiver observando.',
   'feature','srd'),

  (gen_random_uuid(),'rogue-arcanetrickster', 9,
   'Emboscada Mágica', 'Magical Ambush',
   'A partir do 9º nível, se você estiver escondido de uma criatura quando você lança uma magia nela, a criatura tem desvantagem em qualquer teste de resistência que ela fizer contra a magia neste turno.',
   'feature','srd'),

  (gen_random_uuid(),'rogue-arcanetrickster',13,
   'Trapaceiro Versátil', 'Versatile Trickster',
   'No 13º nível, você ganha a capacidade de distrair alvos com sua Mão do Mago. Como ação bônus em seu turno, você pode designar uma criatura a até 1,5 m da mão espectral criada pela magia. Fazer isso lhe dá vantagem em testes de ataque contra essa criatura até o final do turno.',
   'feature','srd'),

  (gen_random_uuid(),'rogue-arcanetrickster',17,
   'Ladrão de Magias', 'Spell Thief',
   'No 17º nível, você ganha a capacidade de roubar magicamente o conhecimento de como lançar uma magia de outro conjurador. Imediatamente depois que uma criatura lança uma magia que tem como alvo você ou que inclui você em sua área de efeito, você pode usar sua reação para forçar a criatura a fazer um teste de resistência de Sabedoria. A CD é igual à sua CD de resistência de magia. Se falhar, você nega o efeito da magia sobre você e rouba o conhecimento da magia se ela for pelo menos 1º nível e de um nível que você possa lançar.',
   'feature','srd');
