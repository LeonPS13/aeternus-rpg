-- ============================================================
-- Seed: Bárbaro (Barbarian) — D&D 5e SRD
-- Tabelas: classes, class_levels, class_features,
--          subclasses, subclass_features
-- ============================================================

-- ── classes ──────────────────────────────────────────────────
INSERT INTO classes (
  id, name, name_en, description, hit_die,
  primary_ability, saving_throws,
  armor_proficiencies, weapon_proficiencies, tool_proficiencies,
  skill_choices_count, skill_choices,
  speed, spellcasting_ability, spellcasting_type, source
) VALUES (
  'barbarian',
  'Bárbaro',
  'Barbarian',
  'Um guerreiro feroz que canaliza uma fúria primitiva para feitos extraordinários de força e resistência. Bárbaros prosperam no caos do combate, absorvendo golpes que derrubariam qualquer outro guerreiro e respondendo com força devastadora.',
  12,
  ARRAY['strength'],
  ARRAY['strength', 'constitution'],
  ARRAY['light', 'medium', 'shields'],
  ARRAY['simple', 'martial'],
  ARRAY[]::text[],
  2,
  ARRAY['animal_handling', 'athletics', 'intimidation', 'nature', 'perception', 'survival'],
  30,
  NULL,
  NULL,
  'srd'
);

-- ── class_levels ─────────────────────────────────────────────
-- meta: { rages, rage_damage, brutal_critical }
-- rages null = ilimitado (nível 20)
-- slot_1..9 omitidos: NOT NULL DEFAULT 0 no schema
INSERT INTO class_levels (class_id, level, proficiency_bonus, meta)
VALUES
  ('barbarian',  1, 2, '{"rages":2,"rage_damage":2,"brutal_critical":0}'),
  ('barbarian',  2, 2, '{"rages":3,"rage_damage":2,"brutal_critical":0}'),
  ('barbarian',  3, 2, '{"rages":3,"rage_damage":2,"brutal_critical":0}'),
  ('barbarian',  4, 2, '{"rages":4,"rage_damage":2,"brutal_critical":0}'),
  ('barbarian',  5, 3, '{"rages":4,"rage_damage":2,"brutal_critical":0}'),
  ('barbarian',  6, 3, '{"rages":4,"rage_damage":2,"brutal_critical":0}'),
  ('barbarian',  7, 3, '{"rages":4,"rage_damage":2,"brutal_critical":0}'),
  ('barbarian',  8, 3, '{"rages":4,"rage_damage":2,"brutal_critical":0}'),
  ('barbarian',  9, 4, '{"rages":4,"rage_damage":3,"brutal_critical":1}'),
  ('barbarian', 10, 4, '{"rages":4,"rage_damage":3,"brutal_critical":1}'),
  ('barbarian', 11, 4, '{"rages":4,"rage_damage":3,"brutal_critical":1}'),
  ('barbarian', 12, 4, '{"rages":5,"rage_damage":3,"brutal_critical":1}'),
  ('barbarian', 13, 5, '{"rages":5,"rage_damage":3,"brutal_critical":2}'),
  ('barbarian', 14, 5, '{"rages":5,"rage_damage":3,"brutal_critical":2}'),
  ('barbarian', 15, 5, '{"rages":5,"rage_damage":3,"brutal_critical":2}'),
  ('barbarian', 16, 5, '{"rages":5,"rage_damage":4,"brutal_critical":2}'),
  ('barbarian', 17, 6, '{"rages":6,"rage_damage":4,"brutal_critical":3}'),
  ('barbarian', 18, 6, '{"rages":6,"rage_damage":4,"brutal_critical":3}'),
  ('barbarian', 19, 6, '{"rages":6,"rage_damage":4,"brutal_critical":3}'),
  ('barbarian', 20, 6, '{"rages":null,"rage_damage":4,"brutal_critical":3}');

-- ── class_features ───────────────────────────────────────────
INSERT INTO class_features (
  id, class_id, level, name, name_en, description, type, source
) VALUES

  -- Nível 1
  (gen_random_uuid(), 'barbarian', 1,
   'Fúria', 'Rage',
   'Em combate, você luta com uma ferocidade primitiva. Em seu turno, você pode entrar em Fúria como ação bônus.

Enquanto em Fúria, você obtém os seguintes benefícios se não estiver usando armadura pesada: vantagem em testes de Força e salvaguardas de Força; bônus de dano em ataques de corpo a corpo com armas que usam Força (conforme a tabela do Bárbaro); resistência a dano contundente, perfurante e cortante.

A Fúria dura 1 minuto. Ela termina cedo se você ficar inconsciente ou se seu turno terminar sem que você tenha atacado uma criatura hostil ou recebido dano desde seu último turno. Você também pode encerrar sua Fúria como ação bônus no seu turno.

Após entrar em Fúria o número de vezes indicado para seu nível, você deve terminar um descanso longo antes de poder entrar em Fúria novamente.',
   'feature', 'srd'),

  (gen_random_uuid(), 'barbarian', 1,
   'Defesa Sem Armadura', 'Unarmored Defense',
   'Enquanto não estiver usando armadura, sua Classe de Armadura é igual a 10 + seu modificador de Destreza + seu modificador de Constituição. Você pode usar um escudo e ainda obter esse benefício.',
   'feature', 'srd'),

  -- Nível 2
  (gen_random_uuid(), 'barbarian', 2,
   'Ataque Imprudente', 'Reckless Attack',
   'A partir do 2º nível, você pode descartar toda preocupação com defesa ao realizar o primeiro ataque em seu turno. Ao fazer isso, você tem vantagem nas jogadas de ataque de corpo a corpo com armas que usam Força durante esse turno, mas ataques contra você têm vantagem até o início de seu próximo turno.',
   'feature', 'srd'),

  (gen_random_uuid(), 'barbarian', 2,
   'Sentido de Perigo', 'Danger Sense',
   'No 2º nível, você adquire uma percepção sobrenatural sobre quando as coisas ao redor não estão certas, concedendo vantagem em situações de perigo. Você tem vantagem em salvaguardas de Destreza contra efeitos que você pode ver, como armadilhas e magias. Para ganhar esse benefício, você não pode estar cego, surdo ou incapacitado.',
   'feature', 'srd'),

  -- Nível 3
  (gen_random_uuid(), 'barbarian', 3,
   'Caminho Primário', 'Primal Path',
   'No 3º nível, você escolhe um caminho que molda a natureza de sua fúria. O Caminho do Berserker e o Caminho do Guerreiro Totêmico estão disponíveis no SRD. Sua escolha concede recursos no 3º nível e novamente no 6º, 10º e 14º níveis.',
   'feature', 'srd'),

  -- Nível 4
  (gen_random_uuid(), 'barbarian', 4,
   'Incremento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de habilidade de sua escolha em 2, ou pode aumentar dois valores de habilidade de sua escolha em 1 cada. Como de costume, você não pode aumentar um valor de habilidade acima de 20 usando esse recurso.',
   'asi', 'srd'),

  -- Nível 5
  (gen_random_uuid(), 'barbarian', 5,
   'Ataque Extra', 'Extra Attack',
   'A partir do 5º nível, você pode atacar duas vezes, em vez de uma, sempre que realizar a ação de Atacar em seu turno.',
   'extra_attack', 'srd'),

  (gen_random_uuid(), 'barbarian', 5,
   'Movimento Veloz', 'Fast Movement',
   'A partir do 5º nível, sua velocidade aumenta em 3 metros enquanto não estiver usando armadura pesada.',
   'feature', 'srd'),

  -- Nível 7
  (gen_random_uuid(), 'barbarian', 7,
   'Instinto Selvagem', 'Feral Instinct',
   'No 7º nível, seus instintos ficam tão aguçados que você tem vantagem em testes de iniciativa. Além disso, se você estiver surpreso no início do combate e não estiver incapacitado, você pode agir normalmente em seu primeiro turno, mas somente se entrar em Fúria antes de fazer qualquer outra coisa nesse turno.',
   'feature', 'srd'),

  -- Nível 8
  (gen_random_uuid(), 'barbarian', 8,
   'Incremento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de habilidade de sua escolha em 2, ou pode aumentar dois valores de habilidade de sua escolha em 1 cada. Como de costume, você não pode aumentar um valor de habilidade acima de 20 usando esse recurso.',
   'asi', 'srd'),

  -- Nível 9
  (gen_random_uuid(), 'barbarian', 9,
   'Crítico Brutal', 'Brutal Critical',
   'A partir do 9º nível, você pode rolar um dado de dano da arma adicional ao determinar o dano extra de um acerto crítico com um ataque de corpo a corpo. Esse número de dados extras aumenta para dois no 13º nível e para três no 17º nível.',
   'feature', 'srd'),

  -- Nível 11
  (gen_random_uuid(), 'barbarian', 11,
   'Fúria Inabalável', 'Relentless Rage',
   'A partir do 11º nível, sua Fúria pode mantê-lo lutando apesar de ferimentos graves. Se você cair para 0 pontos de vida enquanto está em Fúria e não morrer imediatamente, você pode fazer uma salvaguarda de Constituição (CD 10). Se você obtiver sucesso, você cai para 1 ponto de vida em vez disso. Cada vez que você usar esse recurso após o primeiro, o CD aumenta em 5. Quando você terminar um descanso curto ou longo, o CD retorna a 10.',
   'feature', 'srd'),

  -- Nível 12
  (gen_random_uuid(), 'barbarian', 12,
   'Incremento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de habilidade de sua escolha em 2, ou pode aumentar dois valores de habilidade de sua escolha em 1 cada. Como de costume, você não pode aumentar um valor de habilidade acima de 20 usando esse recurso.',
   'asi', 'srd'),

  -- Nível 15
  (gen_random_uuid(), 'barbarian', 15,
   'Fúria Persistente', 'Persistent Rage',
   'A partir do 15º nível, sua Fúria é tão intensa que ela termina cedo apenas se você ficar inconsciente ou se você escolher encerrá-la.',
   'feature', 'srd'),

  -- Nível 16
  (gen_random_uuid(), 'barbarian', 16,
   'Incremento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de habilidade de sua escolha em 2, ou pode aumentar dois valores de habilidade de sua escolha em 1 cada. Como de costume, você não pode aumentar um valor de habilidade acima de 20 usando esse recurso.',
   'asi', 'srd'),

  -- Nível 18
  (gen_random_uuid(), 'barbarian', 18,
   'Poder Indomável', 'Indomitable Might',
   'A partir do 18º nível, se o total de um teste de Força for menor que o seu valor de Força, você pode usar esse valor em vez do total.',
   'feature', 'srd'),

  -- Nível 19
  (gen_random_uuid(), 'barbarian', 19,
   'Incremento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de habilidade de sua escolha em 2, ou pode aumentar dois valores de habilidade de sua escolha em 1 cada. Como de costume, você não pode aumentar um valor de habilidade acima de 20 usando esse recurso.',
   'asi', 'srd'),

  -- Nível 20
  (gen_random_uuid(), 'barbarian', 20,
   'Campeão Primário', 'Primal Champion',
   'No 20º nível, você incorpora o poder da selvageria. Seu valor de Força aumenta em 4 e seu valor de Constituição aumenta em 4. Seus máximos para esses valores também aumentam em 4.',
   'feature', 'srd');

-- ── subclasses ───────────────────────────────────────────────
INSERT INTO subclasses (
  id, class_id, name, name_en, description, level_gained, source
) VALUES
  (
    'barbarian-berserker',
    'barbarian',
    'Caminho do Berserker',
    'Path of the Berserker',
    'Para alguns bárbaros, a fúria é um meio para uma finalidade — essa finalidade sendo a violência. O Caminho do Berserker é um caminho de fúria implacável, escorregadio de sangue. Ao seguir esse caminho, você se entrega à fúria, colocando tudo em risco para atacar de forma avassaladora e desesperada.',
    3,
    'srd'
  ),
  (
    'barbarian-totem-warrior',
    'barbarian',
    'Caminho do Guerreiro Totêmico',
    'Path of the Totem Warrior',
    'O Caminho do Guerreiro Totêmico é um caminho espiritual no qual o bárbaro aceita um espírito animal como guia, protetor e inspiração. Em combate, seu espírito totêmico preenche você com poder sobrenatural, adicionando força mágica a seus feitos físicos brutais.',
    3,
    'srd'
  );

-- ── subclass_features: Caminho do Berserker ──────────────────
INSERT INTO subclass_features (
  id, subclass_id, level, name, name_en, description, type, source
) VALUES

  (gen_random_uuid(), 'barbarian-berserker', 3,
   'Frenesi', 'Frenzy',
   'A partir do momento em que você escolhe esse caminho no 3º nível, você pode entrar em frenesi ao lutar em Fúria. Se você fizer isso, durante a Fúria você pode fazer um único ataque com arma de corpo a corpo como ação bônus em cada um de seus turnos após este. Quando sua Fúria terminar, você sofre um nível de exaustão.',
   'feature', 'srd'),

  (gen_random_uuid(), 'barbarian-berserker', 6,
   'Fúria Desnorteada', 'Mindless Rage',
   'A partir do 6º nível, você não pode ser enfeitiçado ou amedrontado enquanto estiver em Fúria. Se você estiver enfeitiçado ou amedrontado quando entrar em Fúria, o efeito é suspenso pela duração da Fúria.',
   'feature', 'srd'),

  (gen_random_uuid(), 'barbarian-berserker', 10,
   'Presença Intimidante', 'Intimidating Presence',
   'A partir do 10º nível, você pode usar sua ação para amedrontar alguém com sua presença ameaçadora. Escolha uma criatura que você possa ver em um alcance de 9 metros. Se ela puder ver ou ouvir você, deve ter sucesso em uma salvaguarda de Sabedoria (CD = 8 + seu bônus de proficiência + seu modificador de Carisma) ou ficar amedrontada com você até o final de seu próximo turno. Em turnos subsequentes, você pode usar sua ação para estender o efeito até o final de seu próximo turno. O efeito termina se a criatura terminar seu turno fora da linha de visão ou a mais de 18 metros de você. Se ela obtiver sucesso, você não pode usar esse recurso contra ela novamente por 24 horas.',
   'feature', 'srd'),

  (gen_random_uuid(), 'barbarian-berserker', 14,
   'Retaliação', 'Retaliation',
   'A partir do 14º nível, quando você receber dano de uma criatura que esteja a 1,5 metro de você, você pode usar sua reação para fazer um ataque de corpo a corpo com arma contra essa criatura.',
   'feature', 'srd');

-- ── subclass_features: Caminho do Guerreiro Totêmico ─────────
INSERT INTO subclass_features (
  id, subclass_id, level, name, name_en, description, type, source
) VALUES

  (gen_random_uuid(), 'barbarian-totem-warrior', 3,
   'Buscador de Espírito', 'Spirit Seeker',
   'Ao adotar esse estilo de vida no 3º nível, você ganha a habilidade de lançar as magias Falar com Animais e Localizar Animais ou Plantas como rituais.',
   'feature', 'srd'),

  (gen_random_uuid(), 'barbarian-totem-warrior', 3,
   'Espírito Totêmico', 'Totem Spirit',
   'No 3º nível, você escolhe um animal totêmico e ganha seu espírito como aliado espiritual durante a Fúria.

Urso: Enquanto em Fúria, você tem resistência a todos os tipos de dano, exceto dano psíquico. Os espíritos dos ursos te tornam resistente o suficiente para suportar qualquer punição.

Águia: Enquanto em Fúria e não usando armadura pesada, outras criaturas têm desvantagem em ataques de oportunidade contra você, e você pode usar a ação Disparar como ação bônus em seu turno. O espírito da águia te torna predador do ar e da terra.

Lobo: Enquanto em Fúria, seus aliados têm vantagem em jogadas de ataque de corpo a corpo contra qualquer criatura a 1,5 metro de você que seja hostil a você. O espírito do lobo faz de você um líder de caçadores.',
   'feature', 'srd'),

  (gen_random_uuid(), 'barbarian-totem-warrior', 6,
   'Aspecto da Besta', 'Aspect of the Beast',
   'No 6º nível, você ganha um aspecto mágico com base no animal totêmico de sua escolha. Você pode escolher o mesmo animal do 3º nível ou um diferente.

Urso: Seu peso de carga (incluindo máximo de levantamento e empurrão) é dobrado, e você tem vantagem em testes de Força para empurrar, puxar, levantar ou quebrar objetos.

Águia: Você pode ver até 1,5 km de distância com nitidez, discernindo detalhes finos como se estivesse a 30 metros. Além disso, luz fraca não impõe desvantagem nos seus testes de Percepção.

Lobo: Você pode rastrear outras criaturas enquanto viaja em ritmo rápido, e pode se mover furtivamente enquanto viaja em ritmo normal.',
   'feature', 'srd'),

  (gen_random_uuid(), 'barbarian-totem-warrior', 10,
   'Caminhante dos Espíritos', 'Spirit Walker',
   'No 10º nível, você pode lançar a magia Comunhão com a Natureza como um ritual. Ao fazê-lo, um espírito guia lhe apresenta uma visão em vez dos fatos normais que a magia fornece.',
   'feature', 'srd'),

  (gen_random_uuid(), 'barbarian-totem-warrior', 14,
   'Sintonia Totêmica', 'Totemic Attunement',
   'No 14º nível, você ganha um benefício mágico com base em um animal totêmico de sua escolha. Você pode escolher o mesmo animal de uma escolha anterior ou um diferente.

Urso: Enquanto em Fúria, qualquer criatura a 1,5 metro de você que seja hostil tem desvantagem em ataques contra alvos que não sejam você ou outra criatura com esse recurso. Uma criatura imune ao medo ignora esse efeito.

Águia: Enquanto em Fúria, você tem velocidade de voo de 4,5 metros. Esse benefício funciona apenas em rajadas curtas; você cai se terminar seu turno no ar sem nada para sustentá-lo.

Lobo: Enquanto em Fúria, você pode usar ação bônus em seu turno para derrubar uma criatura Grande ou menor ao acertá-la com um ataque de corpo a corpo com arma.',
   'feature', 'srd');
