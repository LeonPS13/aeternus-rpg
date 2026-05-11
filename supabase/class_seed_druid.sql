-- ============================================================
-- DRUIDA (Druid) — SRD 5.1 seed
-- ============================================================

-- 1. CLASS
INSERT INTO classes (
  id, name, name_en, description,
  hit_die, primary_ability, saving_throws,
  armor_proficiencies, weapon_proficiencies, tool_proficiencies,
  skill_choices_count, skill_choices,
  speed, spellcasting_ability, spellcasting_type, source
) VALUES (
  'druid',
  'Druida',
  'Druid',
  'Seja convocando as chamas de uma bola de fogo ou se transformando na forma de um crocodilo, os druidas são a encarnação da resiliência, astúcia e raiva da natureza. Não adoram a natureza, mas se veem como extensões da vontade implacável da natureza.',
  8,
  ARRAY['wisdom'],
  ARRAY['intelligence','wisdom'],
  ARRAY['light','medium','shields'],
  ARRAY['club','dagger','dart','javelin','mace','quarterstaff','scimitar','sickle','sling','spear'],
  ARRAY['herbalism_kit'],
  2,
  ARRAY['arcana','animal_handling','insight','medicine','nature','perception','religion','survival'],
  30,
  'wisdom',
  'prepared',
  'srd'
);

-- 2. LEVELS
-- Meta: wild_shape_cr — CR máximo da Forma Selvagem (começa no nível 2)
INSERT INTO class_levels (
  id, class_id, level, proficiency_bonus,
  cantrips_known, spells_known,
  slot_1, slot_2, slot_3, slot_4, slot_5,
  slot_6, slot_7, slot_8, slot_9,
  meta
) VALUES
  (gen_random_uuid(),'druid', 1,2, 2,NULL, 2,0,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'druid', 2,2, 2,NULL, 3,0,0,0,0,0,0,0,0, '{"wild_shape_cr":"1/4"}'),
  (gen_random_uuid(),'druid', 3,2, 2,NULL, 4,2,0,0,0,0,0,0,0, '{"wild_shape_cr":"1/4"}'),
  (gen_random_uuid(),'druid', 4,2, 3,NULL, 4,3,0,0,0,0,0,0,0, '{"wild_shape_cr":"1/2"}'),
  (gen_random_uuid(),'druid', 5,3, 3,NULL, 4,3,2,0,0,0,0,0,0, '{"wild_shape_cr":"1/2"}'),
  (gen_random_uuid(),'druid', 6,3, 3,NULL, 4,3,3,0,0,0,0,0,0, '{"wild_shape_cr":"1/2"}'),
  (gen_random_uuid(),'druid', 7,3, 3,NULL, 4,3,3,1,0,0,0,0,0, '{"wild_shape_cr":"1/2"}'),
  (gen_random_uuid(),'druid', 8,3, 3,NULL, 4,3,3,2,0,0,0,0,0, '{"wild_shape_cr":"1"}'),
  (gen_random_uuid(),'druid', 9,4, 3,NULL, 4,3,3,3,1,0,0,0,0, '{"wild_shape_cr":"1"}'),
  (gen_random_uuid(),'druid',10,4, 4,NULL, 4,3,3,3,2,0,0,0,0, '{"wild_shape_cr":"1"}'),
  (gen_random_uuid(),'druid',11,4, 4,NULL, 4,3,3,3,2,1,0,0,0, '{"wild_shape_cr":"1"}'),
  (gen_random_uuid(),'druid',12,4, 4,NULL, 4,3,3,3,2,1,0,0,0, '{"wild_shape_cr":"1"}'),
  (gen_random_uuid(),'druid',13,5, 4,NULL, 4,3,3,3,2,1,1,0,0, '{"wild_shape_cr":"1"}'),
  (gen_random_uuid(),'druid',14,5, 4,NULL, 4,3,3,3,2,1,1,0,0, '{"wild_shape_cr":"1"}'),
  (gen_random_uuid(),'druid',15,5, 4,NULL, 4,3,3,3,2,1,1,1,0, '{"wild_shape_cr":"1"}'),
  (gen_random_uuid(),'druid',16,5, 4,NULL, 4,3,3,3,2,1,1,1,0, '{"wild_shape_cr":"1"}'),
  (gen_random_uuid(),'druid',17,6, 4,NULL, 4,3,3,3,2,1,1,1,1, '{"wild_shape_cr":"1"}'),
  (gen_random_uuid(),'druid',18,6, 4,NULL, 4,3,3,3,3,1,1,1,1, '{"wild_shape_cr":"1"}'),
  (gen_random_uuid(),'druid',19,6, 4,NULL, 4,3,3,3,3,2,1,1,1, '{"wild_shape_cr":"1"}'),
  (gen_random_uuid(),'druid',20,6, 4,NULL, 4,3,3,3,3,2,2,1,1, '{"wild_shape_cr":"1"}');

-- 3. CLASS FEATURES
INSERT INTO class_features (id, class_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'druid', 1,
   'Druídico', 'Druidic',
   'Você conhece o Druídico, a linguagem secreta dos druidas. Você pode falar a língua e usá-la para deixar mensagens escondidas. Você e outros que conhecem essa língua notam automaticamente essas mensagens. Outros percebem a presença da mensagem com uma verificação bem-sucedida de Percepção CD 15, mas não podem decifrá-la sem magia.',
   'feature','srd'),

  (gen_random_uuid(),'druid', 1,
   'Conjuração', 'Spellcasting',
   'Aproveitando a essência divina da natureza em si, você pode lançar magias para modelar essa essência de acordo com sua vontade. Você prepara uma lista de magias de druida disponíveis para você, escolhendo um número de magias de druida igual ao seu modificador de Sabedoria + seu nível de druida (mínimo de uma magia). Ao terminar um descanso longo, você pode mudar sua lista de magias preparadas.',
   'spellcasting','srd'),

  (gen_random_uuid(),'druid', 2,
   'Forma Selvagem', 'Wild Shape',
   'A partir do 2º nível, você pode usar sua ação para se transformar magicamente em uma besta que você viu antes. Você pode usar esse recurso duas vezes. Você recupera os usos gastos ao terminar um descanso curto ou longo.\n\nSeu nível de druida determina as bestas nas quais você pode se transformar: CR 1/4 (nível 2, sem velocidade de voo ou natação), CR 1/2 (nível 4, sem velocidade de voo), CR 1 (nível 8).\n\nVocê pode permanecer na forma de besta por um número de horas igual à metade do seu nível de druida (arredondado para baixo).',
   'feature','srd'),

  (gen_random_uuid(),'druid', 2,
   'Círculo Druídico', 'Druid Circle',
   'No 2º nível, você se afilia a um círculo de druidas. Escolha entre o Círculo da Terra ou o Círculo da Lua. Sua escolha lhe concede recursos no 2º nível e novamente no 6º, 10º e 14º nível.',
   'subclass_choice','srd'),

  (gen_random_uuid(),'druid', 4,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'druid', 8,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'druid',12,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'druid',16,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'druid',18,
   'Corpo Atemporal', 'Timeless Body',
   'A partir do 18º nível, a magia primeva que você usa lhe concede sobrenatural resistência. Para cada 10 anos que passam, seu corpo envelhece apenas 1 ano.',
   'feature','srd'),

  (gen_random_uuid(),'druid',18,
   'Feitiços de Besta', 'Beast Spells',
   'A partir do 18º nível, você pode lançar muitas de suas magias de druida em qualquer forma que assumir usando a Forma Selvagem. Você pode executar os componentes somáticos e verbais de uma magia de druida enquanto está em uma forma de besta, mas não pode fornecer componentes materiais.',
   'feature','srd'),

  (gen_random_uuid(),'druid',19,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'druid',20,
   'Arquidruida', 'Archdruid',
   'No 20º nível, você pode usar sua Forma Selvagem um número ilimitado de vezes. Além disso, você pode ignorar os componentes verbais e somáticos de suas magias de druida, bem como quaisquer componentes materiais que não tenham custo e não sejam consumidos por uma magia. Você ganha esse benefício tanto em sua forma normal como em sua forma de besta da Forma Selvagem.',
   'feature','srd');

-- 4. SUBCLASSES
INSERT INTO subclasses (id, class_id, name, name_en, description, level_gained, source) VALUES
  ('druid-land',
   'druid',
   'Círculo da Terra',
   'Circle of the Land',
   'O Círculo da Terra é composto por místicos e sábios que protegem o conhecimento e os rituais antigos por meio de uma vasta tradição oral. Esses druidas se reúnem em círculos sagrados de árvores ou pedras em pé para sussurrar segredos primevos em Druídico.',
   2,'srd'),

  ('druid-moon',
   'druid',
   'Círculo da Lua',
   'Circle of the Moon',
   'Druidas do Círculo da Lua são guardiões ferozes das terras selvagens. Sua ordem se reúne durante as luas cheias para compartilhar notícias e fazer vigília. Eles se preocupam principalmente em proteger as terras selvagens e os vêm buscando ameaças malignas nas terras do mundo material.',
   2,'srd');

-- 5. SUBCLASS FEATURES

-- Circle of the Land
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'druid-land', 2,
   'Magia Natural', 'Natural Recovery',
   'A partir do 2º nível, você pode recuperar parte de sua energia mágica sentando-se em meditação e comunhão com a natureza. Durante um descanso curto, você escolhe espaços de magia gastos para recuperar. Os espaços de magia podem ter um nível combinado que é igual ou inferior à metade do seu nível de druida (arredondado para cima), e nenhum dos espaços pode ser do 6º nível ou superior. Você não pode usar esse recurso novamente até terminar um descanso longo.',
   'feature','srd'),

  (gen_random_uuid(),'druid-land', 2,
   'Magia do Círculo', 'Circle Spells',
   'Sua conexão mística com a terra infunde você com a capacidade de lançar certas magias. No 3º, 5º, 7º e 9º nível, você ganha acesso a magias de círculo conectadas ao tipo de terra onde você se tornou um druida. Escolha esse tipo de terra — ártico, costeiro, deserto, floresta, prado, montanha, pântano ou Subterrâneo. Uma vez que você ganha acesso a uma magia de círculo, ela é sempre preparada para você e não conta contra o número de magias que você pode preparar por dia.',
   'feature','srd'),

  (gen_random_uuid(),'druid-land', 6,
   'Passo das Terras', 'Land''s Stride',
   'A partir do 6º nível, mover-se através de terreno difícil não mágico não custa movimento extra. Você também pode passar por plantas não mágicas sem ser desacelerado por elas e sem sofrer dano delas se elas tiverem espinhos, espinheiros ou perigos similares. Além disso, você tem vantagem em testes de resistência contra plantas criadas magicamente ou manipuladas para impedir o movimento.',
   'feature','srd'),

  (gen_random_uuid(),'druid-land',10,
   'Manto da Natureza', 'Nature''s Ward',
   'Quando você atingir o 10º nível, você não pode ser encantado nem amedrontado por elementais ou fadas, e você é imune a veneno e doença.',
   'feature','srd'),

  (gen_random_uuid(),'druid-land',14,
   'Santuário da Natureza', 'Nature''s Sanctuary',
   'Quando você atingir o 14º nível, criaturas do mundo natural sentem a sua afinidade com a natureza e hesitam em atacá-lo. Quando uma besta ou planta ataca você, ela deve fazer um teste de resistência de Sabedoria contra a CD de resistência de sua magia de druida. Em um teste falho, a criatura deve escolher um alvo diferente, ou o ataque automaticamente erra. Se tiver sucesso, a criatura estará imune a esse efeito por 24 horas.',
   'feature','srd');

-- Circle of the Moon
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'druid-moon', 2,
   'Forma Selvagem de Combate', 'Combat Wild Shape',
   'Quando você escolhe esse círculo no 2º nível, você ganha a capacidade de usar a Forma Selvagem como ação bônus em seu turno, em vez de uma ação. Adicionalmente, enquanto estiver transformado, você pode usar uma ação bônus para gastar um espaço de magia e recuperar 1d8 pontos de vida por nível do espaço de magia gasto.',
   'feature','srd'),

  (gen_random_uuid(),'druid-moon', 2,
   'Formas Aprimoradas', 'Circle Forms',
   'O rito dos druidas do Círculo da Lua permite que você se transforme em bestas mais perigosas. A partir do 2º nível, você pode usar sua Forma Selvagem para se transformar em uma besta com um índice de desafio tão alto quanto o seu nível de druida dividido por 3 (arredondado para baixo), com um mínimo de 1.',
   'feature','srd'),

  (gen_random_uuid(),'druid-moon', 6,
   'Golpe Primevo', 'Primal Strike',
   'A partir do 6º nível, seus ataques em forma de besta contam como mágicos para os fins de superar a resistência e imunidade a ataques e danos não mágicos.',
   'feature','srd'),

  (gen_random_uuid(),'druid-moon',10,
   'Formas Elementais', 'Elemental Wild Shape',
   'No 10º nível, você pode gastar dois usos da sua Forma Selvagem ao mesmo tempo para se transformar em um elemental de ar, elemental de terra, elemental de fogo ou elemental de água.',
   'feature','srd'),

  (gen_random_uuid(),'druid-moon',14,
   'Mil Formas', 'Thousand Forms',
   'No 14º nível, você aprendeu a usar a magia para alterar sua forma física de maneiras mais sutis. Você pode lançar a magia Alterar-se à vontade.',
   'feature','srd');
