-- ============================================================
-- CLÉRIGO (Cleric) — SRD 5.1 seed
-- ============================================================

-- 1. CLASS
INSERT INTO classes (
  id, name, name_en, description,
  hit_die, primary_ability, saving_throws,
  armor_proficiencies, weapon_proficiencies, tool_proficiencies,
  skill_choices_count, skill_choices,
  speed, spellcasting_ability, spellcasting_type, source
) VALUES (
  'cleric',
  'Clérigo',
  'Cleric',
  'Guerreiros da luz divina, os clérigos são intermediários entre o mundo mortal e os planos distantes dos deuses. Tão diversos quanto os deuses a quem servem, os clérigos se esforçam para personificar a obra de seus deuses e são acometidos de poderes sobrenaturais.',
  8,
  ARRAY['wisdom'],
  ARRAY['wisdom','charisma'],
  ARRAY['light','medium','shields'],
  ARRAY['simple'],
  ARRAY[]::text[],
  2,
  ARRAY['history','insight','medicine','persuasion','religion'],
  30,
  'wisdom',
  'prepared',
  'srd'
);

-- 2. LEVELS
-- Meta: channel_divinity (uses per rest, starts level 2)
--       destroy_undead (CR threshold, starts level 5)
INSERT INTO class_levels (
  id, class_id, level, proficiency_bonus,
  cantrips_known, spells_known,
  slot_1, slot_2, slot_3, slot_4, slot_5,
  slot_6, slot_7, slot_8, slot_9,
  meta
) VALUES
  (gen_random_uuid(),'cleric', 1,2, 3,NULL, 2,0,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'cleric', 2,2, 3,NULL, 3,0,0,0,0,0,0,0,0, '{"channel_divinity":1}'),
  (gen_random_uuid(),'cleric', 3,2, 3,NULL, 4,2,0,0,0,0,0,0,0, '{"channel_divinity":1}'),
  (gen_random_uuid(),'cleric', 4,2, 4,NULL, 4,3,0,0,0,0,0,0,0, '{"channel_divinity":1}'),
  (gen_random_uuid(),'cleric', 5,3, 4,NULL, 4,3,2,0,0,0,0,0,0, '{"channel_divinity":1,"destroy_undead":"1/2"}'),
  (gen_random_uuid(),'cleric', 6,3, 4,NULL, 4,3,3,0,0,0,0,0,0, '{"channel_divinity":2,"destroy_undead":"1/2"}'),
  (gen_random_uuid(),'cleric', 7,3, 4,NULL, 4,3,3,1,0,0,0,0,0, '{"channel_divinity":2,"destroy_undead":"1/2"}'),
  (gen_random_uuid(),'cleric', 8,3, 4,NULL, 4,3,3,2,0,0,0,0,0, '{"channel_divinity":2,"destroy_undead":"1"}'),
  (gen_random_uuid(),'cleric', 9,4, 4,NULL, 4,3,3,3,1,0,0,0,0, '{"channel_divinity":2,"destroy_undead":"1"}'),
  (gen_random_uuid(),'cleric',10,4, 5,NULL, 4,3,3,3,2,0,0,0,0, '{"channel_divinity":2,"destroy_undead":"1"}'),
  (gen_random_uuid(),'cleric',11,4, 5,NULL, 4,3,3,3,2,1,0,0,0, '{"channel_divinity":2,"destroy_undead":"2"}'),
  (gen_random_uuid(),'cleric',12,4, 5,NULL, 4,3,3,3,2,1,0,0,0, '{"channel_divinity":2,"destroy_undead":"2"}'),
  (gen_random_uuid(),'cleric',13,5, 5,NULL, 4,3,3,3,2,1,1,0,0, '{"channel_divinity":2,"destroy_undead":"2"}'),
  (gen_random_uuid(),'cleric',14,5, 5,NULL, 4,3,3,3,2,1,1,0,0, '{"channel_divinity":2,"destroy_undead":"3"}'),
  (gen_random_uuid(),'cleric',15,5, 5,NULL, 4,3,3,3,2,1,1,1,0, '{"channel_divinity":2,"destroy_undead":"3"}'),
  (gen_random_uuid(),'cleric',16,5, 5,NULL, 4,3,3,3,2,1,1,1,0, '{"channel_divinity":2,"destroy_undead":"3"}'),
  (gen_random_uuid(),'cleric',17,6, 5,NULL, 4,3,3,3,2,1,1,1,1, '{"channel_divinity":2,"destroy_undead":"4"}'),
  (gen_random_uuid(),'cleric',18,6, 5,NULL, 4,3,3,3,3,1,1,1,1, '{"channel_divinity":3,"destroy_undead":"4"}'),
  (gen_random_uuid(),'cleric',19,6, 5,NULL, 4,3,3,3,3,2,1,1,1, '{"channel_divinity":3,"destroy_undead":"4"}'),
  (gen_random_uuid(),'cleric',20,6, 5,NULL, 4,3,3,3,3,2,2,1,1, '{"channel_divinity":3,"destroy_undead":"4"}');

-- 3. CLASS FEATURES
INSERT INTO class_features (id, class_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'cleric', 1,
   'Conjuração', 'Spellcasting',
   'Como conduto para o poder divino, você pode lançar magias de clérigo. Você prepara a lista de magias de clérigo que estão disponíveis para você. Para fazer isso, escolha um número de magias de clérigo igual ao seu modificador de Sabedoria + seu nível de clérigo (mínimo de uma magia). Ao terminar um descanso longo, você pode mudar sua lista de magias preparadas.',
   'spellcasting','srd'),

  (gen_random_uuid(),'cleric', 1,
   'Domínio Divino', 'Divine Domain',
   'Escolha um domínio relacionado à sua divindade. Cada domínio é detalhado no final da descrição da classe e cada um fornece exemplos de deuses associados a ele. Sua escolha lhe concede magias de domínio e outros recursos quando você a faz no 1º nível.',
   'subclass_choice','srd'),

  (gen_random_uuid(),'cleric', 2,
   'Canalizar Divindade', 'Channel Divinity',
   'Você ganha a habilidade de canalizar energia divina diretamente de sua divindade. Você possui 1 uso de Canalizar Divindade entre descansos (aumenta para 2 no nível 6, e 3 no nível 18). Você começa com dois usos: Afastar Mortos-Vivos e um uso definido pelo seu Domínio Divino.',
   'feature','srd'),

  (gen_random_uuid(),'cleric', 2,
   'Canalizar Divindade: Afastar Mortos-Vivos', 'Channel Divinity: Turn Undead',
   'Como ação, você apresenta seu símbolo sagrado e profere uma prece de censura aos mortos-vivos. Cada morto-vivo que puder ver ou ouvir você a até 30 pés de você deve fazer um teste de resistência de Sabedoria. Se o morto-vivo falhar no teste de resistência, ele é afastado por 1 minuto ou até receber dano.',
   'feature','srd'),

  (gen_random_uuid(),'cleric', 4,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'cleric', 5,
   'Destruir Mortos-Vivos', 'Destroy Undead',
   'Quando um morto-vivo falha em seu teste de resistência contra seu recurso Afastar Mortos-Vivos, a criatura é instantaneamente destruída se o seu índice de desafio for 1/2 ou inferior. A partir do 8º nível esse limiar aumenta: CR 1 (nível 8), CR 2 (nível 11), CR 3 (nível 14), CR 4 (nível 17).',
   'feature','srd'),

  (gen_random_uuid(),'cleric', 6,
   'Canalizar Divindade (2/Descanso)', 'Channel Divinity (2/Rest)',
   'Você pode usar o Canalizar Divindade duas vezes entre descansos.',
   'feature','srd'),

  (gen_random_uuid(),'cleric', 8,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'cleric',10,
   'Intervenção Divina', 'Divine Intervention',
   'Você pode apelar para sua divindade para intervir em seu nome quando sua necessidade for grande. Implore pela ajuda de sua divindade com uma ação. Role percentuais. Se você rolar um número menor ou igual ao seu nível de clérigo, sua divindade intervém. O DM escolhe a natureza da intervenção.',
   'feature','srd'),

  (gen_random_uuid(),'cleric',12,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'cleric',16,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'cleric',18,
   'Canalizar Divindade (3/Descanso)', 'Channel Divinity (3/Rest)',
   'Você pode usar o Canalizar Divindade três vezes entre descansos.',
   'feature','srd'),

  (gen_random_uuid(),'cleric',19,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'cleric',20,
   'Intervenção Divina Aprimorada', 'Improved Divine Intervention',
   'Começando no 20º nível, sua chamada por intervenção tem sucesso automaticamente, não sendo necessário rolar os dados.',
   'feature','srd');

-- 4. SUBCLASSES
INSERT INTO subclasses (id, class_id, name, name_en, description, level_gained, source) VALUES
  ('cleric-life',
   'cleric',
   'Domínio da Vida',
   'Life Domain',
   'O domínio da Vida foca-se na vibrante energia positiva — uma das forças fundamentais do universo — que sustenta toda vida. Os deuses da vida promovem a vitalidade e a saúde através da cura dos feridos e doentes, cuidando dos necessitados e expulsando as forças da morte e os mortos-vivos.',
   1,'srd'),

  ('cleric-light',
   'cleric',
   'Domínio da Luz',
   'Light Domain',
   'Deuses da luz — incluindo Helm, Lathander, Pholtus, Branchala e o Sol de Ouro — promovem os ideais do nascimento e renovação, verdade, vigilância e beleza, muitas vezes usando o símbolo do sol.',
   1,'srd'),

  ('cleric-war',
   'cleric',
   'Domínio da Guerra',
   'War Domain',
   'A guerra tem muitas manifestações. Ela pode tornar os heróis comuns extraordinários. E pode ser completamente destrutiva. Deuses da guerra incluem campeões da honra e cavalaria (como São Cuthbert e Tem) assim como deuses da violência e conquista (como Erythnul e Hextor).',
   1,'srd');

-- 5. SUBCLASS FEATURES

-- Life Domain
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'cleric-life', 1,
   'Discípulo da Vida', 'Disciple of Life',
   'A partir do 1º nível, suas magias de cura são mais eficazes. Sempre que você usar uma magia de 1º nível ou superior para restaurar pontos de vida a uma criatura, a criatura recupera pontos de vida adicionais iguais a 2 + o nível da magia.',
   'feature','srd'),

  (gen_random_uuid(),'cleric-life', 2,
   'Canalizar Divindade: Preservar Vida', 'Channel Divinity: Preserve Life',
   'A partir do 2º nível, você pode usar seu Canalizar Divindade para curar os feridos graves. Como ação, você apresenta seu símbolo sagrado e evoca a energia curativa que pode restaurar um número de pontos de vida igual a cinco vezes seu nível de clérigo. Escolha quaisquer criaturas a até 30 pés de você e divida esses pontos de vida entre elas. Essa habilidade não pode restaurar uma criatura a mais da metade de seus pontos de vida máximos.',
   'feature','srd'),

  (gen_random_uuid(),'cleric-life', 6,
   'Curador Abençoado', 'Blessed Healer',
   'A partir do 6º nível, as magias de cura que você lança em outros também curam você. Quando você lança uma magia de 1º nível ou superior que restaure pontos de vida a uma criatura diferente de você, você recupera pontos de vida iguais a 2 + o nível da magia.',
   'feature','srd'),

  (gen_random_uuid(),'cleric-life', 8,
   'Toque Divino', 'Divine Strike',
   'No 8º nível, você ganha a habilidade de infundir seus ataques com energia divina. Uma vez em cada um de seus turnos, quando você acertar uma criatura com um ataque de arma, você pode causar 1d8 de dano radiante adicional ao alvo. Quando você atingir o 14º nível, o dano extra aumenta para 2d8.',
   'feature','srd'),

  (gen_random_uuid(),'cleric-life',17,
   'Cura Suprema', 'Supreme Healing',
   'A partir do 17º nível, quando você normalmente rolaria um ou mais dados para restaurar pontos de vida com uma magia, ao invés disso você usa o número mais alto possível para cada dado. Por exemplo, ao invés de restaurar 2d6 pontos de vida a uma criatura, você restaura 12.',
   'feature','srd');

-- Light Domain
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'cleric-light', 1,
   'Truque Bônus', 'Bonus Cantrip',
   'Quando você escolhe este domínio no 1º nível, você ganha o truque Luz se você ainda não o souber.',
   'feature','srd'),

  (gen_random_uuid(),'cleric-light', 1,
   'Flama Protetora', 'Warding Flare',
   'Também no 1º nível, você pode interpor uma luz divina entre si mesmo e um inimigo que o ataca. Quando você é atacado por uma criatura a até 30 pés de você que você possa ver, você pode usar sua reação para impor desvantagem no teste de ataque, fazendo que a luz piscante distraia o atacante antes de atingi-lo. Você pode usar esse recurso um número de vezes igual ao seu modificador de Sabedoria (mínimo de uma vez). Você recupera todos os usos gastos ao terminar um descanso longo.',
   'feature','srd'),

  (gen_random_uuid(),'cleric-light', 2,
   'Canalizar Divindade: Luz Radiante', 'Channel Divinity: Radiance of the Dawn',
   'A partir do 2º nível, você pode usar seu Canalizar Divindade para dissipar a escuridão mágica e queimar seus inimigos com luz divina. Como ação, você apresenta seu símbolo sagrado e quaisquer trevas mágicas a até 30 pés de você são dispersas. Além disso, cada criatura hostil a até 30 pés de você deve fazer um teste de resistência de Constituição. Uma criatura leva dano radiante igual a 2d10 + seu nível de clérigo em um teste falho, e metade desse dano em um teste bem-sucedido. Mortos-vivos têm desvantagem nesse teste de resistência.',
   'feature','srd'),

  (gen_random_uuid(),'cleric-light', 6,
   'Flama Aprimorada', 'Improved Flare',
   'A partir do 6º nível, você também pode usar seu recurso Flama Protetora quando uma criatura que você possa ver a até 30 pés de você atacar uma criatura que não seja você.',
   'feature','srd'),

  (gen_random_uuid(),'cleric-light', 8,
   'Potência da Conjuração', 'Potent Spellcasting',
   'A partir do 8º nível, você adiciona seu modificador de Sabedoria ao dano causado por quaisquer truques de clérigo.',
   'feature','srd'),

  (gen_random_uuid(),'cleric-light',17,
   'Corona de Luz', 'Corona of Light',
   'A partir do 17º nível, você pode usar sua ação para ativar uma aura de luz solar que dura por 1 minuto ou até você desativar usando outra ação. Você emite luz brilhante a um raio de 60 pés e luz tênue a mais 30 pés. Seus inimigos na luz brilhante têm desvantagem em testes de resistência contra qualquer magia que cause dano de fogo ou radiante.',
   'feature','srd');

-- War Domain
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'cleric-war', 1,
   'Proficiências de Combate', 'Bonus Proficiencies',
   'No 1º nível, você ganha proficiência com armaduras pesadas e armas marciais.',
   'feature','srd'),

  (gen_random_uuid(),'cleric-war', 1,
   'Sacerdote de Guerra', 'War Priest',
   'Também no 1º nível, seu deus lhe entrega inspiração divina quando você está envolvido em combate. Quando você usa a ação de Atacar, você pode fazer um ataque com arma como ação bônus. Você pode usar esse recurso um número de vezes igual ao seu modificador de Sabedoria (mínimo de uma vez). Você recupera todos os usos gastos ao terminar um descanso longo.',
   'feature','srd'),

  (gen_random_uuid(),'cleric-war', 2,
   'Canalizar Divindade: Golpe Guiado', 'Channel Divinity: Guided Strike',
   'A partir do 2º nível, você pode usar seu Canalizar Divindade para acertar seus golpes com poder divino. Quando você faz um teste de ataque, você pode usar seu Canalizar Divindade para ganhar um bônus +10 no teste. Você pode escolher usar esse recurso depois de rolar o dado, mas antes que o DM diga se o ataque acertou ou errou.',
   'feature','srd'),

  (gen_random_uuid(),'cleric-war', 6,
   'Canalizar Divindade: Bênção do Deus da Guerra', 'Channel Divinity: War God''s Blessing',
   'No 6º nível, quando uma criatura a até 30 pés de você fizer um teste de ataque, você pode usar sua reação para conceder a essa criatura um bônus +10 no teste, usando seu Canalizar Divindade. Você pode escolher usar esse recurso depois que a criatura rolar o dado, mas antes que o DM diga se o ataque acertou ou errou.',
   'feature','srd'),

  (gen_random_uuid(),'cleric-war', 8,
   'Toque Divino', 'Divine Strike',
   'No 8º nível, você ganha a habilidade de infundir seus ataques com energia divina. Uma vez em cada um de seus turnos, quando você acertar uma criatura com um ataque de arma, você pode causar 1d8 de dano adicional do mesmo tipo causado pela arma. Quando você atingir o 14º nível, o dano extra aumenta para 2d8.',
   'feature','srd'),

  (gen_random_uuid(),'cleric-war',17,
   'Avatar da Batalha', 'Avatar of Battle',
   'No 17º nível, você ganha resistência a dano de perfuração, corte e impacto de ataques não mágicos.',
   'feature','srd');
