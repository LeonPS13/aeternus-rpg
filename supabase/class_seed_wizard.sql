-- ============================================================
-- MAGO (Wizard) — SRD 5.1 seed
-- ============================================================

-- 1. CLASS
INSERT INTO classes (
  id, name, name_en, description,
  hit_die, primary_ability, saving_throws,
  armor_proficiencies, weapon_proficiencies, tool_proficiencies,
  skill_choices_count, skill_choices,
  speed, spellcasting_ability, spellcasting_type, source
) VALUES (
  'wizard',
  'Mago',
  'Wizard',
  'Magos são estudiosos supremos da arte arcana. Cada magia que um mago aprende deve ser conquistada com estudo e prática, registrada em um grimório pessoal. Ao longo de sua carreira, o mago acumula um arsenal de magias que é de longe o maior e mais versátil entre todas as classes.',
  6,
  ARRAY['intelligence'],
  ARRAY['intelligence','wisdom'],
  ARRAY[]::text[],
  ARRAY['dagger','dart','sling','quarterstaff','light_crossbow'],
  ARRAY[]::text[],
  2,
  ARRAY['arcana','history','insight','investigation','medicine','religion'],
  30,
  'intelligence',
  'prepared',
  'srd'
);

-- 2. LEVELS
-- Conjurador completo preparado (Inteligência).
-- Magias preparadas = mod. Int + nível de mago (mínimo 1); spells_known=NULL.
-- Cantrips: 3 (níveis 1–3) → 4 (4–9) → 5 (10–20)
INSERT INTO class_levels (
  id, class_id, level, proficiency_bonus,
  cantrips_known, spells_known,
  slot_1, slot_2, slot_3, slot_4, slot_5,
  slot_6, slot_7, slot_8, slot_9,
  meta
) VALUES
  (gen_random_uuid(),'wizard', 1,2, 3,NULL, 2,0,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'wizard', 2,2, 3,NULL, 3,0,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'wizard', 3,2, 3,NULL, 4,2,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'wizard', 4,2, 4,NULL, 4,3,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'wizard', 5,3, 4,NULL, 4,3,2,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'wizard', 6,3, 4,NULL, 4,3,3,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'wizard', 7,3, 4,NULL, 4,3,3,1,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'wizard', 8,3, 4,NULL, 4,3,3,2,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'wizard', 9,4, 4,NULL, 4,3,3,3,1,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'wizard',10,4, 5,NULL, 4,3,3,3,2,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'wizard',11,4, 5,NULL, 4,3,3,3,2,1,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'wizard',12,4, 5,NULL, 4,3,3,3,2,1,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'wizard',13,5, 5,NULL, 4,3,3,3,2,1,1,0,0, '{}'::jsonb),
  (gen_random_uuid(),'wizard',14,5, 5,NULL, 4,3,3,3,2,1,1,0,0, '{}'::jsonb),
  (gen_random_uuid(),'wizard',15,5, 5,NULL, 4,3,3,3,2,1,1,1,0, '{}'::jsonb),
  (gen_random_uuid(),'wizard',16,5, 5,NULL, 4,3,3,3,2,1,1,1,0, '{}'::jsonb),
  (gen_random_uuid(),'wizard',17,6, 5,NULL, 4,3,3,3,2,1,1,1,1, '{}'::jsonb),
  (gen_random_uuid(),'wizard',18,6, 5,NULL, 4,3,3,3,3,1,1,1,1, '{}'::jsonb),
  (gen_random_uuid(),'wizard',19,6, 5,NULL, 4,3,3,3,3,2,1,1,1, '{}'::jsonb),
  (gen_random_uuid(),'wizard',20,6, 5,NULL, 4,3,3,3,3,2,2,1,1, '{}'::jsonb);

-- 3. CLASS FEATURES
INSERT INTO class_features (id, class_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'wizard', 1,
   'Conjuração', 'Spellcasting',
   'Como estudante da magia arcana, você possui um grimório contendo magias que mostram os primeiros lampejo de seu verdadeiro poder. Inteligência é sua habilidade de conjuração para magias de mago.\n\nGrimório: você começa com 6 magias de 1º nível em seu grimório (escolhidas com o Mestre). Ao subir de nível, você adiciona 2 magias de qualquer nível que possa conjurar. Você pode também copiar magias encontradas em aventura (custo: 50 po e 2 horas por nível da magia).\n\nPreparar Magias: ao terminar um descanso longo, escolha magias do grimório igual ao seu modificador de Inteligência + nível de mago (mínimo 1). Truques não precisam ser preparados.\n\nConjuração Ritual: você pode conjurar qualquer magia do grimório que tenha a etiqueta de ritual, sem gastar espaço de magia, adicionando 10 minutos ao tempo de conjuração.',
   'spellcasting','srd'),

  (gen_random_uuid(),'wizard', 1,
   'Recuperação Arcana', 'Arcane Recovery',
   'Você aprendeu a recuperar parte de sua energia mágica estudando seu grimório. Uma vez por dia ao terminar um descanso curto, você pode escolher espaços de magia gastos para recuperar. Os espaços de magia recuperados podem ter um nível combinado igual ou inferior à metade do seu nível de mago (arredondado para cima), e nenhum dos espaços pode ser de 6º nível ou superior.',
   'feature','srd'),

  (gen_random_uuid(),'wizard', 2,
   'Tradição Arcana', 'Arcane Tradition',
   'No 2º nível, você escolhe uma tradição arcana, afirmando seu estudo em uma das oito escolas de magia: Abjuração, Conjuração, Adivinhação, Encantamento, Evocação, Ilusão, Necromancia ou Transmutação. Sua escolha lhe concede recursos no 2º nível e novamente no 6º, 10º e 14º nível.',
   'subclass_choice','srd'),

  (gen_random_uuid(),'wizard', 4,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'wizard', 8,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'wizard',12,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'wizard',16,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'wizard',18,
   'Maestria de Magia', 'Spell Mastery',
   'No 18º nível, você atingiu tal maestria sobre certas magias que pode conjurá-las à vontade. Escolha uma magia de mago de 1º nível e uma de 2º nível que estejam no seu grimório. Você pode conjurá-las em seu nível mais baixo sem gastar um espaço de magia. Se quiser conjurá-las em nível superior, deve gastar um espaço normalmente. Você pode trocar uma ou ambas as magias ao terminar um descanso longo.',
   'feature','srd'),

  (gen_random_uuid(),'wizard',19,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'wizard',20,
   'Magias Assinatura', 'Signature Spells',
   'No 20º nível, você ganha maestria sobre duas poderosas magias e pode conjurá-las com esforço mínimo. Escolha duas magias de mago de 3º nível em seu grimório como suas magias assinatura. Você as tem sempre preparadas e elas não contam contra seu limite de magias preparadas. Você pode conjurar cada uma uma vez sem gastar um espaço de magia. Você recupera essa capacidade ao terminar um descanso curto ou longo.',
   'feature','srd');

-- 4. SUBCLASSES (8 escolas de magia)
INSERT INTO subclasses (id, class_id, name, name_en, description, level_gained, source) VALUES
  ('wizard-abjuration','wizard','Escola de Abjuração','School of Abjuration',
   'A Escola de Abjuração enfatiza a magia que bloqueia, bane ou protege. Detratores dessa tradição chamam seus praticantes de proibicionistas, achando que sua ênfase em afastar e bloquear torna-os especialistas defensivos inferiores.',2,'srd'),

  ('wizard-conjuration','wizard','Escola de Conjuração','School of Conjuration',
   'Como conjurador, você favorece magias que produzem objetos e criaturas do nada. Você pode conjurar nuvens corrosivas de ácido ou teletransportar aliados para fora do perigo. À medida que você aprende mais, você pode fazer teleportações mais precisas e até convocar criaturas de outros planos.',2,'srd'),

  ('wizard-divination','wizard','Escola de Adivinhação','School of Divination',
   'O conselho de um adivinho é procurado por reis e sacerdotes, por homens comuns e nobres. Você inclina sua mente para a magia que revela segredos ocultos pelo tempo ou distância — espreitando o futuro, lendo pensamentos e revelando o que está escondido.',2,'srd'),

  ('wizard-enchantment','wizard','Escola de Encantamento','School of Enchantment',
   'Como membro da Escola de Encantamento, você aperfeiçoou sua arte em encantar as mentes de outros. Os estudiosos dessa tradição são conhecidos como encantadores. Alguns encantadores são agentes de paz, mantendo reis a guerreiros longe de conflito desnecessário.',2,'srd'),

  ('wizard-evocation','wizard','Escola de Evocação','School of Evocation',
   'Você se concentra em magia que cria poderosos efeitos elementais como frio gélido, chamas ardentes, trovão rolante, relâmpago e ácido. Alguns evocadores encontram emprego em forças militares, servindo como artilharia para incendiar e destruir inimigos.',2,'srd'),

  ('wizard-illusion','wizard','Escola de Ilusão','School of Illusion',
   'Você se concentra em magia que cupa os sentidos e a mente, fazendo com que outros vejam o que não existe, deixe de ver o que existe, ouça fantasmas de sons, ou lembre de coisas que nunca aconteceram. Os ilusionistas são tricksters, agentes de espionagem e enganadores.',2,'srd'),

  ('wizard-necromancy','wizard','Escola de Necromancia','School of Necromancy',
   'A Escola de Necromancia explora forças cósmicas da vida, da morte e do estado-morto-vivo. À medida que você se aprofunda nos estudos, você aprende a manipular a energia que anima todos os seres vivos. Outros temem seus poderes e muitas vezes consideram os necromantes como figuras sombrias.',2,'srd'),

  ('wizard-transmutation','wizard','Escola de Transmutação','School of Transmutation',
   'Você é um estudante das magias que modificam energia e matéria. Para você, o mundo não é uma realidade fixa, mas uma percepção plástica que pode ser moldada de acordo com a sua vontade. Alguns transmutadores são tintureiros, outros são fabricantes de armas.',2,'srd');

-- 5. SUBCLASS FEATURES

-- School of Abjuration
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'wizard-abjuration', 2,
   'Erudito em Abjuração e Proteção Arcana', 'Abjuration Savant & Arcane Ward',
   'Erudito em Abjuração: o tempo e o ouro que você deve gastar para copiar uma magia de abjuração em seu grimório é reduzido pela metade.\n\nProteção Arcana: quando você conjura uma magia de abjuração de 1º nível ou superior, você pode tecer simultaneamente uma proteção mágica ao redor de si mesmo. A proteção tem PV equivalentes a duas vezes seu nível de mago + seu modificador de Inteligência. Sempre que você recebe dano, a proteção recebe o dano. Se isso reduzir os PV da proteção a 0, você recebe o dano restante. A proteção não pode exceder seus PV máximos e se reabastece ao lançar magias de abjuração.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-abjuration', 6,
   'Proteção Projetada', 'Projected Ward',
   'No 6º nível, quando uma criatura que você possa ver a até 9 metros receber dano, você pode usar sua reação para que sua Proteção Arcana absorva esse dano. Se isso reduzir os PV da proteção a 0, o alvo recebe o dano restante.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-abjuration',10,
   'Abjuração Aprimorada', 'Improved Abjuration',
   'No 10º nível, quando você conjurar uma magia de abjuração que exija que você faça uma verificação de habilidade como parte da conjuração (como Contrafeitiço e Dissipar Magia), você adiciona seu bônus de proficiência a essa verificação.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-abjuration',14,
   'Resistência a Magias', 'Spell Resistance',
   'No 14º nível, você tem vantagem em testes de resistência contra magias. Além disso, você tem resistência ao dano de magias.',
   'feature','srd');

-- School of Conjuration
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'wizard-conjuration', 2,
   'Erudito em Conjuração e Conjuração Menor', 'Conjuration Savant & Minor Conjuration',
   'Erudito em Conjuração: o tempo e ouro para copiar magias de conjuração é reduzido pela metade.\n\nConjuração Menor: como ação, você pode conjurar um objeto inanimado em sua mão ou no chão em um espaço desocupado a até 3 m. O objeto não pode exceder 90 cm em nenhuma dimensão e não pode pesar mais de 5 kg, e o valor não pode exceder 25 PO. O objeto é claramente mágico. O objeto desaparece ao terminar um descanso longo.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-conjuration', 6,
   'Transposição Benigna', 'Benign Transposition',
   'No 6º nível, como ação, você pode se teletransportar até 9 metros para um espaço desocupado que possa ver, ou você pode optar por trocar de lugar com uma criatura consentida de tamanho Médio ou menor a até 9 metros que possa ver. Uma vez que você usar esse recurso, você não pode usá-lo novamente até terminar um descanso longo ou conjurar uma magia de conjuração de 1º nível ou superior.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-conjuration',10,
   'Conjuração Focada', 'Focused Conjuration',
   'No 10º nível, enquanto estiver concentrado em uma magia de conjuração, sua concentração não pode ser quebrada como resultado de receber dano.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-conjuration',14,
   'Invocações Duráveis', 'Durable Summons',
   'No 14º nível, qualquer criatura que você convocar ou criar com uma magia de conjuração tem 30 pontos de vida temporários.',
   'feature','srd');

-- School of Divination
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'wizard-divination', 2,
   'Erudito em Adivinhação e Presságio', 'Divination Savant & Portent',
   'Erudito em Adivinhação: o tempo e ouro para copiar magias de adivinhação é reduzido pela metade.\n\nPresságio: vislumbres do futuro começam a permear sua consciência. Ao terminar um descanso longo, role dois d20s e anote os resultados. Você pode substituir qualquer jogada de ataque, teste de habilidade ou teste de resistência feito por você ou por uma criatura que possa ver pelo resultado de um desses dados. Você deve escolher antes da jogada e cada dado pode ser usado apenas uma vez. Os dados não utilizados são perdidos ao terminar um descanso longo.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-divination', 6,
   'Adivinhação Especializada', 'Expert Divination',
   'No 6º nível, ao conjurar uma magia de adivinhação de 2º nível ou superior usando um espaço de magia, você recupera um espaço de magia gasto. O espaço recuperado deve ser de nível menor que a magia que você conjurou, e não pode ser de 6º nível ou superior.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-divination',10,
   'O Terceiro Olho', 'The Third Eye',
   'No 10º nível, você pode usar sua ação para aumentar seus poderes de percepção. Escolha um dos seguintes benefícios (dura até você terminar um descanso curto ou longo): Visão no Escuro (60 m), Visão Etérea (enxerga até o Plano Etéreo em 18 m), Visão Maior (lê qualquer idioma), ou Perceber Invisível (vê criaturas e objetos invisíveis em até 3 m).',
   'feature','srd'),

  (gen_random_uuid(),'wizard-divination',14,
   'Maior Presságio', 'Greater Portent',
   'No 14º nível, as visões concessadas pelo seu recurso de Presságio se tornam mais vívidas e precisas. Você rola três dados d20 para o seu Presságio, em vez de dois.',
   'feature','srd');

-- School of Enchantment
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'wizard-enchantment', 2,
   'Erudito em Encantamento e Olhar Hipnótico', 'Enchantment Savant & Hypnotic Gaze',
   'Erudito em Encantamento: o tempo e ouro para copiar magias de encantamento é reduzido pela metade.\n\nOlhar Hipnótico: como ação, escolha uma criatura a até 1,5 m. Se a criatura puder ver você, ela deverá ser bem-sucedida em um teste de Sabedoria (CD de sua magia) ou ficará encantada por você até o fim de seu próximo turno. A criatura encantada tem velocidade 0 e está incapacitada e visivelmente atordoada. Em turnos subsequentes, você pode usar sua ação para manter esse efeito. Criaturas imunes ao encantamento não são afetadas. Ao encerrar o efeito, a criatura é imune por 24 horas.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-enchantment', 6,
   'Charme Instintivo', 'Instinctive Charm',
   'No 6º nível, quando uma criatura visível a até 9 m atacar você, você pode usar sua reação para desviar o ataque — caso seu teste de Sabedoria (CD de sua magia) falhe. A criatura deve fazer o ataque contra a criatura mais próxima que possa ver exceto você e si mesma. Após o uso, a criatura fica imune por 24 horas. Você deve terminar um descanso longo antes de usar o recurso novamente.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-enchantment',10,
   'Encantamento Dividido', 'Split Enchantment',
   'No 10º nível, quando você conjura uma magia de encantamento que tem como alvo apenas uma criatura, você pode fazer com que ela tenha como alvo uma segunda criatura.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-enchantment',14,
   'Alterar Memórias', 'Alter Memories',
   'No 14º nível, você ganha a habilidade de fazer uma criatura incapaz de lembrar que foi encantada por você. Quando o efeito de encantamento terminar em uma criatura encantada por uma de suas magias de mago, você pode usar sua ação para tentar fazer a criatura esquecer parte do tempo em que esteve encantada. A criatura deve ser bem-sucedida em um teste de Inteligência (CD de sua magia) ou perderá memória de um número de horas igual a 1 + seu modificador de Carisma (mínimo 1).',
   'feature','srd');

-- School of Evocation
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'wizard-evocation', 2,
   'Erudito em Evocação e Esculpir Magias', 'Evocation Savant & Sculpt Spells',
   'Erudito em Evocação: o tempo e ouro para copiar magias de evocação é reduzido pela metade.\n\nEsculpir Magias: você pode criar bolsões de segurança relativa em seus efeitos de evocação. Quando você conjurar uma magia de evocação que afeta outras criaturas que você possa ver, você pode escolher um número de criaturas igual a 1 + o nível da magia. As criaturas escolhidas passam automaticamente em seus testes de resistência contra a magia, e não recebem dano se normalmente receberiam metade do dano em um teste bem-sucedido.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-evocation', 6,
   'Truque Potente', 'Potent Cantrip',
   'No 6º nível, seus truques nocivos afetam ainda criaturas que evitam a brunt de seus efeitos. Quando uma criatura for bem-sucedida em um teste de resistência contra seu truque, ela recebe metade do dano do truque (se houver), mas não sofre nenhum efeito adicional do truque.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-evocation',10,
   'Evocação Potencializada', 'Empowered Evocation',
   'No 10º nível, você pode adicionar seu modificador de Inteligência a uma jogada de dano de qualquer magia de evocação de mago que você conjurar.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-evocation',14,
   'Sobrecarga', 'Overchannel',
   'No 14º nível, você pode aumentar o poder de suas magias mais simples. Quando você conjurar uma magia de mago de 5º nível ou inferior que cause dano, você pode causar o dano máximo com essa magia. A primeira vez que você fizer isso, você não sofrerá efeitos adversos. Mas se você usar esse recurso novamente antes de terminar um descanso longo, você receberá 2d12 de dano necrótico por nível da magia imediatamente após conjurá-la, e isso aumenta a cada uso adicional nesse período.',
   'feature','srd');

-- School of Illusion
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'wizard-illusion', 2,
   'Erudito em Ilusão e Ilusão Menor Aprimorada', 'Illusion Savant & Improved Minor Illusion',
   'Erudito em Ilusão: o tempo e ouro para copiar magias de ilusão é reduzido pela metade.\n\nIlusão Menor Aprimorada: você aprende o truque Ilusão Menor. Quando o conjurar, pode criar tanto um som como uma imagem com um único lançamento. Além disso, o alcance do truque aumenta para 9 m para você.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-illusion', 6,
   'Ilusões Maleáveis', 'Malleable Illusions',
   'No 6º nível, quando você conjurar uma magia de ilusão que tiver uma duração de 1 minuto ou mais, você pode usar sua ação para mudar a natureza dessa ilusão (usando os parâmetros normais de criação da magia), desde que possa ver a ilusão.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-illusion',10,
   'Eu Ilusório', 'Illusory Self',
   'No 10º nível, você pode criar uma cópia ilusória instantânea de si mesmo como reação a um ataque. A cópia interpõe-se entre o atacante e você, fazendo com que o ataque erre automaticamente. Uma vez que você usar esse recurso, você não pode usá-lo novamente até terminar um descanso curto ou longo.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-illusion',14,
   'Realidade Ilusória', 'Illusory Reality',
   'No 14º nível, você aprendeu o segredo de tecer magia das sombras em suas ilusões para dar-lhes uma semirealidade. Quando você conjurar uma magia de ilusão de 1º nível ou superior, você pode escolher um objeto inanimado e não mágico dentro da ilusão para se tornar real. Você pode fazer isso em seu turno como ação bônus enquanto a magia continuar. O objeto permanece real por 1 minuto, após o qual se torna ilusório novamente.',
   'feature','srd');

-- School of Necromancy
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'wizard-necromancy', 2,
   'Erudito em Necromancia e Colheita Sombria', 'Necromancy Savant & Grim Harvest',
   'Erudito em Necromancia: o tempo e ouro para copiar magias de necromancia é reduzido pela metade.\n\nColheita Sombria: uma vez por turno quando você matar um ou mais inimigos com uma magia de 1º nível ou superior, você recupera pontos de vida iguais a duas vezes o nível da magia, ou três vezes se for uma magia de necromancia. Esse benefício não se aplica a criaturas mortas-vivas ou constructos.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-necromancy', 6,
   'Servos de Mortos-Vivos', 'Undead Thralls',
   'No 6º nível, você adiciona a magia Animar Mortos à sua lista de magias se ela ainda não estiver lá. Quando você usar Animar Mortos, você pode animar um zumbi ou esqueleto adicional. O morto-vivo que você criar tem PV máximos aumentados em seu nível de mago e adiciona seu bônus de proficiência às jogadas de dano de armas.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-necromancy',10,
   'Imunidade aos Mortos-Vivos', 'Inured to Undeath',
   'No 10º nível, você tem resistência ao dano necrótico e seu máximo de PV não pode ser reduzido. Você passou tanto tempo lidando com forças da morte que se acostumou a algumas delas.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-necromancy',14,
   'Comandar Mortos-Vivos', 'Command Undead',
   'No 14º nível, você pode usar a magia para exercer controle sobre mortos-vivos. Como ação, escolha um morto-vivo que possa ver a até 18 m. Essa criatura deve fazer um teste de Carisma (CD de sua magia). Se falhar, a criatura ficará sob seu controle por 24 horas ou até você usar esse recurso novamente. Mortos-vivos com Inteligência 8 ou superior têm vantagem. Se falharem por mais de 5, ficam permanentemente sob seu controle (até você ter mais de 2× seu nível de mago em mortos-vivos controlados).',
   'feature','srd');

-- School of Transmutation
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'wizard-transmutation', 2,
   'Erudito em Transmutação e Alquimia Menor', 'Transmutation Savant & Minor Alchemy',
   'Erudito em Transmutação: o tempo e ouro para copiar magias de transmutação é reduzido pela metade.\n\nAlquimia Menor: você pode alterar temporariamente as propriedades físicas de um objeto não mágico, mudando-o de um material para outro. Você realiza um procedimento especial de alquimia em um objeto composto inteiramente de madeira, pedra, ferro/aço, cobre ou prata, transformando-o em um desses outros materiais. Para cada 10 minutos dedicados, você pode transformar um cubo de 30 cm. Após 1 hora sem alquimia, o objeto reverte ao material original.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-transmutation', 6,
   'Pedra do Transmutador', 'Transmuter''s Stone',
   'No 6º nível, você pode gastar 8 horas criando uma pedra de transmutador que armazena magia de transmutação. Você pode se beneficiar dela ou dá-la a outra criatura. A pedra dá um dos seguintes benefícios (escolha ao criar): Visão no Escuro 18 m, +3 m de velocidade, proficiência em testes de Constituição, ou resistência a ácido/frio/fogo/relâmpago/trovão (escolha ao criar). Você pode mudar o benefício ao conjurar uma magia de transmutação de 1º nível ou superior enquanto segura a pedra.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-transmutation',10,
   'Cambiante', 'Shapechanger',
   'No 10º nível, você adiciona a magia Polimorfismo à lista de magias de mago se ainda não estiver lá. Você pode conjurá-la sem gastar um espaço de magia, mas ao fazê-lo, só pode se transformar em besta com CR 1 ou inferior. Você deve terminar um descanso curto ou longo antes de usar esse recurso novamente.',
   'feature','srd'),

  (gen_random_uuid(),'wizard-transmutation',14,
   'Mestre Transmutador', 'Master Transmuter',
   'No 14º nível, você pode usar sua ação para consumir a magia armazenada em sua pedra do transmutador para produzir um dos seguintes efeitos: Transmutar Matéria (até 1,5 m³ de material não mágico em outro), Grande Restauração (como a magia sem gastar espaço), Cura (restaurar todos os PV de uma criatura consentida), Juventude (reduzir a idade de até 3d10 anos, mínimo 13 anos), Elixir da Vida (encerrar todos os males, doenças, amaldiçoamentos, exaustão e efeitos que reduzam atributos em uma criatura tocada). A pedra é consumida.',
   'feature','srd');
