-- =============================================================================
-- BARDO (Bard) — D&D 5e SRD
-- =============================================================================

-- 1. Classe
INSERT INTO classes (
  id, name, name_en, description, hit_die,
  primary_ability, saving_throws,
  armor_proficiencies, weapon_proficiencies, tool_proficiencies,
  skill_choices_count, skill_choices,
  speed, spellcasting_ability, spellcasting_type, source
) VALUES (
  'bard', 'Bardo', 'Bard',
  'Bardos são mestres da magia através da arte. Seja em palavras de poder, melodias encantadas ou histórias lendárias, os bardos tecem magia em cada performance. Além de conjuradores versáteis, são espertos negociadores, exploradores ágeis e inspiradores natos — capazes de impulsionar aliados com sua Inspiração de Bardo.',
  8,
  ARRAY['charisma'],
  ARRAY['dexterity', 'charisma'],
  ARRAY['light'],
  ARRAY['simple', 'hand_crossbow', 'longsword', 'rapier', 'shortsword'],
  ARRAY['instrumento_musical'],
  3,
  ARRAY['acrobatics','animal_handling','arcana','athletics','deception','history',
        'insight','intimidation','investigation','medicine','nature','perception',
        'performance','persuasion','religion','sleight_of_hand','stealth','survival'],
  30, 'charisma', 'known', 'srd'
);

-- 2. Progressão (20 níveis)
-- Bardo é conjurador completo: inclui slot_1..9 e cantrips_known/spells_known.
INSERT INTO class_levels (
  class_id, level, proficiency_bonus, cantrips_known, spells_known,
  slot_1, slot_2, slot_3, slot_4, slot_5, slot_6, slot_7, slot_8, slot_9,
  meta
) VALUES
  ('bard',  1, 2, 2,  4,  2, 0, 0, 0, 0, 0, 0, 0, 0, '{"bardic_inspiration":"d6"}'),
  ('bard',  2, 2, 2,  5,  3, 0, 0, 0, 0, 0, 0, 0, 0, '{"bardic_inspiration":"d6"}'),
  ('bard',  3, 2, 2,  6,  4, 2, 0, 0, 0, 0, 0, 0, 0, '{"bardic_inspiration":"d6"}'),
  ('bard',  4, 2, 3,  7,  4, 3, 0, 0, 0, 0, 0, 0, 0, '{"bardic_inspiration":"d6"}'),
  ('bard',  5, 3, 3,  8,  4, 3, 2, 0, 0, 0, 0, 0, 0, '{"bardic_inspiration":"d8"}'),
  ('bard',  6, 3, 3,  9,  4, 3, 3, 0, 0, 0, 0, 0, 0, '{"bardic_inspiration":"d8"}'),
  ('bard',  7, 3, 3, 10,  4, 3, 3, 1, 0, 0, 0, 0, 0, '{"bardic_inspiration":"d8"}'),
  ('bard',  8, 3, 3, 11,  4, 3, 3, 2, 0, 0, 0, 0, 0, '{"bardic_inspiration":"d8"}'),
  ('bard',  9, 4, 3, 12,  4, 3, 3, 3, 1, 0, 0, 0, 0, '{"bardic_inspiration":"d8"}'),
  ('bard', 10, 4, 4, 14,  4, 3, 3, 3, 2, 0, 0, 0, 0, '{"bardic_inspiration":"d10"}'),
  ('bard', 11, 4, 4, 15,  4, 3, 3, 3, 2, 1, 0, 0, 0, '{"bardic_inspiration":"d10"}'),
  ('bard', 12, 4, 4, 15,  4, 3, 3, 3, 2, 1, 0, 0, 0, '{"bardic_inspiration":"d10"}'),
  ('bard', 13, 5, 4, 16,  4, 3, 3, 3, 2, 1, 1, 0, 0, '{"bardic_inspiration":"d10"}'),
  ('bard', 14, 5, 4, 18,  4, 3, 3, 3, 2, 1, 1, 0, 0, '{"bardic_inspiration":"d10"}'),
  ('bard', 15, 5, 4, 19,  4, 3, 3, 3, 2, 1, 1, 1, 0, '{"bardic_inspiration":"d12"}'),
  ('bard', 16, 5, 4, 19,  4, 3, 3, 3, 2, 1, 1, 1, 0, '{"bardic_inspiration":"d12"}'),
  ('bard', 17, 6, 4, 20,  4, 3, 3, 3, 2, 1, 1, 1, 1, '{"bardic_inspiration":"d12"}'),
  ('bard', 18, 6, 4, 22,  4, 3, 3, 3, 3, 1, 1, 1, 1, '{"bardic_inspiration":"d12"}'),
  ('bard', 19, 6, 4, 22,  4, 3, 3, 3, 3, 2, 1, 1, 1, '{"bardic_inspiration":"d12"}'),
  ('bard', 20, 6, 4, 22,  4, 3, 3, 3, 3, 2, 2, 1, 1, '{"bardic_inspiration":"d12"}');

-- 3. Habilidades de Classe
INSERT INTO class_features (class_id, level, name, name_en, description, type, source)
VALUES
  -- Nível 1
  ('bard', 1, 'Magia', 'Spellcasting',
   'Você aprendeu a desvendar e remodelar a estrutura da realidade em harmonia com a sua música e palavras. Sua habilidade de conjuração é Carisma (CD de resistência = 8 + bônus de proficiência + modificador de Carisma; bônus de ataque = bônus de proficiência + modificador de Carisma). Você usa um instrumento musical como foco arcano.',
   'spellcasting', 'srd'),

  ('bard', 1, 'Inspiração de Bardo', 'Bardic Inspiration',
   'Use uma ação bônus no seu turno para escolher uma criatura diferente de você a até 18 metros que possa ouvir você. Essa criatura ganha um dado de Inspiração de Bardo. Uma vez dentro dos próximos 10 minutos, ela pode rolar o dado e adicionar o resultado a um teste de atributo, rolagem de ataque ou teste de resistência. O dado evolui: d6 (níveis 1–4), d8 (5–9), d10 (10–14), d12 (15–20). Você tem usos iguais ao seu modificador de Carisma (mínimo 1); todos recuperados após descanso longo.',
   'feature', 'srd'),

  -- Nível 2
  ('bard', 2, 'Versátil', 'Jack of All Trades',
   'A partir do 2º nível, você pode adicionar metade do seu bônus de proficiência, arredondado para baixo, a qualquer teste de atributo que já não inclua o seu bônus de proficiência.',
   'feature', 'srd'),

  ('bard', 2, 'Canção de Descanso', 'Song of Rest',
   'A partir do 2º nível, você pode usar música ou oratória suave para ajudar a revigorar aliados feridos durante um descanso curto. Criaturas aliadas que possam ouvi-lo e que recuperarem PV ao fim de um descanso curto recuperam PV extras: d6 (níveis 2–8), d8 (9–12), d10 (13–16), d12 (17–20).',
   'feature', 'srd'),

  -- Nível 3
  ('bard', 3, 'Expertise', 'Expertise',
   'No 3º nível, escolha duas das suas proficiências de perícia. Seu bônus de proficiência é dobrado para testes com essas perícias. Você pode escolher mais duas perícias no 10º nível.',
   'feature', 'srd'),

  ('bard', 3, 'Colégio de Bardo', 'Bard College',
   'No 3º nível, você se aprofunda nos estudos avançados de um colégio de bardos. Escolha o Colégio do Conhecimento ou o Colégio da Bravura. Sua escolha concede habilidades neste nível e novamente nos níveis 6 e 14.',
   'feature', 'srd'),

  -- Nível 4
  ('bard', 4, 'Melhoria de Atributo', 'Ability Score Improvement',
   'Quando você atinge o 4º nível, e novamente nos níveis 8, 12, 16 e 19, você pode aumentar um atributo em 2 pontos, ou dois atributos em 1 ponto cada. Você não pode aumentar um atributo acima de 20 com essa habilidade.',
   'asi', 'srd'),

  -- Nível 5
  ('bard', 5, 'Fonte de Inspiração', 'Font of Inspiration',
   'A partir do 5º nível, você recupera todos os seus usos de Inspiração de Bardo quando termina um descanso curto ou longo.',
   'feature', 'srd'),

  -- Nível 6
  ('bard', 6, 'Contraencanto', 'Countercharm',
   'No 6º nível, você ganha a habilidade de usar notas musicais ou palavras de poder para interromper efeitos de influência mental. Como ação, você inicia uma performance que dura até o fim do seu próximo turno. Durante esse tempo, você e criaturas aliadas a até 9 metros têm vantagem em testes de resistência contra ser assustado ou enfeitiçado. A criatura deve conseguir ouvi-lo para obter esse benefício.',
   'feature', 'srd'),

  -- Nível 8
  ('bard', 8, 'Melhoria de Atributo', 'Ability Score Improvement',
   'Quando você atinge o 8º nível, você pode aumentar um atributo em 2 pontos, ou dois atributos em 1 ponto cada. Você não pode aumentar um atributo acima de 20.',
   'asi', 'srd'),

  -- Nível 10
  ('bard', 10, 'Expertise', 'Expertise',
   'No 10º nível, escolha mais duas das suas proficiências de perícia. Seu bônus de proficiência é dobrado para testes com essas perícias.',
   'feature', 'srd'),

  ('bard', 10, 'Segredos Mágicos', 'Magical Secrets',
   'No 10º nível, você descobriu segredos mágicos de diversas tradições. Escolha duas magias de qualquer classe, de qualquer nível que você possa conjurar ou truques. Elas contam como magias de bardo e estão incluídas no número de magias que você conhece. Você aprende dois segredos adicionais no 14º nível e outros dois no 18º nível.',
   'feature', 'srd'),

  -- Nível 12
  ('bard', 12, 'Melhoria de Atributo', 'Ability Score Improvement',
   'Quando você atinge o 12º nível, você pode aumentar um atributo em 2 pontos, ou dois atributos em 1 ponto cada. Você não pode aumentar um atributo acima de 20.',
   'asi', 'srd'),

  -- Nível 14
  ('bard', 14, 'Segredos Mágicos', 'Magical Secrets',
   'No 14º nível, você aprende mais dois segredos mágicos de qualquer classe.',
   'feature', 'srd'),

  -- Nível 16
  ('bard', 16, 'Melhoria de Atributo', 'Ability Score Improvement',
   'Quando você atinge o 16º nível, você pode aumentar um atributo em 2 pontos, ou dois atributos em 1 ponto cada. Você não pode aumentar um atributo acima de 20.',
   'asi', 'srd'),

  -- Nível 18
  ('bard', 18, 'Segredos Mágicos', 'Magical Secrets',
   'No 18º nível, você aprende mais dois segredos mágicos de qualquer classe.',
   'feature', 'srd'),

  -- Nível 19
  ('bard', 19, 'Melhoria de Atributo', 'Ability Score Improvement',
   'Quando você atinge o 19º nível, você pode aumentar um atributo em 2 pontos, ou dois atributos em 1 ponto cada. Você não pode aumentar um atributo acima de 20.',
   'asi', 'srd'),

  -- Nível 20
  ('bard', 20, 'Inspiração Superior', 'Superior Inspiration',
   'No 20º nível, quando você rola iniciativa e não possui usos de Inspiração de Bardo restantes, você recupera imediatamente um uso.',
   'feature', 'srd');

-- 4. Subclasses
INSERT INTO subclasses (id, class_id, name, name_en, description, level_gained, source)
VALUES
  ('bard-lore', 'bard',
   'Colégio do Conhecimento', 'College of Lore',
   'Bardos do Colégio do Conhecimento recolhem sabedoria de todas as fontes — canções élficas, rituais acadêmicos e tradições proibidas. Vasculham bibliotecas, cortes reais e tavernas igualmente em busca de qualquer segredo que valha a pena saber. Sua magia é afiada pela inteligência e pelo conhecimento acumulado, e eles usam as fraquezas dos inimigos contra eles com astúcia.',
   3, 'srd'),

  ('bard-valor', 'bard',
   'Colégio da Bravura', 'College of Valor',
   'Bardos do Colégio da Bravura são narradores de histórias lendárias que também participam dos feitos que descrevem. Treinados em armaduras e armas, eles inspiram seus aliados em batalha com performances corajosas enquanto lutam ao seu lado. A linha entre canção e espada é tênue para eles.',
   3, 'srd');

-- 5. Habilidades de Subclasse

-- Colégio do Conhecimento
INSERT INTO subclass_features (subclass_id, level, name, name_en, description, type, source)
VALUES
  ('bard-lore', 3, 'Proficiências Bônus', 'Bonus Proficiencies',
   'Quando você ingressa no Colégio do Conhecimento no 3º nível, você ganha proficiência em três perícias de sua escolha.',
   'feature', 'srd'),

  ('bard-lore', 3, 'Palavras Cortantes', 'Cutting Words',
   'Também no 3º nível, você aprende a usar sua sagacidade para distrair, confundir e minar a confiança dos outros. Quando uma criatura que você pode ver a até 18 metros fizer uma rolagem de ataque, de habilidade ou de dano, você pode usar sua reação para gastar um uso de Inspiração de Bardo, rolar o dado e subtrair o resultado daquela rolagem. A criatura é imune se não puder ouvi-lo ou se for imune a ser enfeitiçada.',
   'feature', 'srd'),

  ('bard-lore', 6, 'Segredos Mágicos Adicionais', 'Additional Magical Secrets',
   'No 6º nível, você aprende duas magias de qualquer classe. Uma magia que você escolhe deve ser de um nível que você possa conjurar ou um truque. As magias escolhidas contam como magias de bardo para você e não contam no limite de magias conhecidas.',
   'feature', 'srd'),

  ('bard-lore', 14, 'Perfeição Incomparável', 'Peerless Skill',
   'A partir do 14º nível, quando você faz um teste de atributo, você pode gastar um uso de Inspiração de Bardo. Role um dado de Inspiração de Bardo e adicione o número ao resultado. Você pode optar por fazer isso depois de rolar o dado, mas antes de o DM dizer se você passou ou falhou.',
   'feature', 'srd');

-- Colégio da Bravura
INSERT INTO subclass_features (subclass_id, level, name, name_en, description, type, source)
VALUES
  ('bard-valor', 3, 'Proficiências de Combate', 'Combat Proficiencies',
   'Quando você ingressa no Colégio da Bravura no 3º nível, você ganha proficiência com armaduras médias, escudos e armas marciais.',
   'feature', 'srd'),

  ('bard-valor', 3, 'Inspiração de Combate', 'Combat Inspiration',
   'Também no 3º nível, você aprende a inspirar outros em combate. Uma criatura com um dado de Inspiração de Bardo seu pode rolar o dado e adicioná-lo a uma rolagem de dano de arma. Como alternativa, quando uma rolagem de ataque for feita contra essa criatura, ela pode usar sua reação para rolar o dado e adicionar o resultado à sua CA contra aquele ataque, potencialmente fazendo-o errar.',
   'feature', 'srd'),

  ('bard-valor', 6, 'Ataque Extra', 'Extra Attack',
   'A partir do 6º nível, você pode atacar duas vezes em vez de uma quando tomar a ação de Atacar no seu turno.',
   'extra_attack', 'srd'),

  ('bard-valor', 14, 'Magia de Batalha', 'Battle Magic',
   'No 14º nível, você dominou a arte de entrelaçar magia e combate. Quando você usa sua ação para conjurar uma magia de bardo, você pode fazer um ataque com arma como ação bônus.',
   'feature', 'srd');
