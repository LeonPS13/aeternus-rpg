-- ============================================================
-- FEITICEIRO (Sorcerer) — SRD 5.1 seed
-- ============================================================

-- 1. CLASS
INSERT INTO classes (
  id, name, name_en, description,
  hit_die, primary_ability, saving_throws,
  armor_proficiencies, weapon_proficiencies, tool_proficiencies,
  skill_choices_count, skill_choices,
  speed, spellcasting_ability, spellcasting_type, source
) VALUES (
  'sorcerer',
  'Feiticeiro',
  'Sorcerer',
  'Feiticeiros carregam um reservatório de magia sobrenatural dentro de si, uma força de caos latente que quer se libertar. Diferente de magos que aprendem de livros, feiticeiros extraem poder de dentro de si mesmos, moldado por uma origem mágica: uma linhagem dracônica, o toque imprevisível da magia selvagem, ou outra fonte de poder arcano inato.',
  6,
  ARRAY['charisma'],
  ARRAY['constitution','charisma'],
  ARRAY[]::text[],
  ARRAY['dagger','dart','sling','quarterstaff','light_crossbow'],
  ARRAY[]::text[],
  2,
  ARRAY['arcana','deception','insight','intimidation','persuasion','religion'],
  30,
  'charisma',
  'known',
  'srd'
);

-- 2. LEVELS
-- Conjurador completo (conhecido); pontos de feitiçaria (= nível) a partir do nível 2
INSERT INTO class_levels (
  id, class_id, level, proficiency_bonus,
  cantrips_known, spells_known,
  slot_1, slot_2, slot_3, slot_4, slot_5,
  slot_6, slot_7, slot_8, slot_9,
  meta
) VALUES
  (gen_random_uuid(),'sorcerer', 1,2, 4,2,  2,0,0,0,0,0,0,0,0, '{}'::jsonb),
  (gen_random_uuid(),'sorcerer', 2,2, 4,3,  3,0,0,0,0,0,0,0,0, '{"sorcery_points":2}'::jsonb),
  (gen_random_uuid(),'sorcerer', 3,2, 4,4,  4,2,0,0,0,0,0,0,0, '{"sorcery_points":3}'::jsonb),
  (gen_random_uuid(),'sorcerer', 4,2, 5,5,  4,3,0,0,0,0,0,0,0, '{"sorcery_points":4}'::jsonb),
  (gen_random_uuid(),'sorcerer', 5,3, 5,6,  4,3,2,0,0,0,0,0,0, '{"sorcery_points":5}'::jsonb),
  (gen_random_uuid(),'sorcerer', 6,3, 5,7,  4,3,3,0,0,0,0,0,0, '{"sorcery_points":6}'::jsonb),
  (gen_random_uuid(),'sorcerer', 7,3, 5,8,  4,3,3,1,0,0,0,0,0, '{"sorcery_points":7}'::jsonb),
  (gen_random_uuid(),'sorcerer', 8,3, 5,9,  4,3,3,2,0,0,0,0,0, '{"sorcery_points":8}'::jsonb),
  (gen_random_uuid(),'sorcerer', 9,4, 5,10, 4,3,3,3,1,0,0,0,0, '{"sorcery_points":9}'::jsonb),
  (gen_random_uuid(),'sorcerer',10,4, 6,11, 4,3,3,3,2,0,0,0,0, '{"sorcery_points":10}'::jsonb),
  (gen_random_uuid(),'sorcerer',11,4, 6,12, 4,3,3,3,2,1,0,0,0, '{"sorcery_points":11}'::jsonb),
  (gen_random_uuid(),'sorcerer',12,4, 6,12, 4,3,3,3,2,1,0,0,0, '{"sorcery_points":12}'::jsonb),
  (gen_random_uuid(),'sorcerer',13,5, 6,13, 4,3,3,3,2,1,1,0,0, '{"sorcery_points":13}'::jsonb),
  (gen_random_uuid(),'sorcerer',14,5, 6,13, 4,3,3,3,2,1,1,0,0, '{"sorcery_points":14}'::jsonb),
  (gen_random_uuid(),'sorcerer',15,5, 6,14, 4,3,3,3,2,1,1,1,0, '{"sorcery_points":15}'::jsonb),
  (gen_random_uuid(),'sorcerer',16,5, 6,14, 4,3,3,3,2,1,1,1,0, '{"sorcery_points":16}'::jsonb),
  (gen_random_uuid(),'sorcerer',17,6, 6,15, 4,3,3,3,2,1,1,1,1, '{"sorcery_points":17}'::jsonb),
  (gen_random_uuid(),'sorcerer',18,6, 6,15, 4,3,3,3,3,1,1,1,1, '{"sorcery_points":18}'::jsonb),
  (gen_random_uuid(),'sorcerer',19,6, 6,15, 4,3,3,3,3,2,1,1,1, '{"sorcery_points":19}'::jsonb),
  (gen_random_uuid(),'sorcerer',20,6, 6,15, 4,3,3,3,3,2,2,1,1, '{"sorcery_points":20}'::jsonb);

-- 3. CLASS FEATURES
INSERT INTO class_features (id, class_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'sorcerer', 1,
   'Conjuração', 'Spellcasting',
   'Um evento em sua história passada infundiu-o com magia arcana. Carisma é sua habilidade de conjuração para magias de feiticeiro. Você conhece 4 truques e 2 magias de feiticeiro. Ao subir de nível, você pode substituir uma magia conhecida por outra da lista de feiticeiro.',
   'spellcasting','srd'),

  (gen_random_uuid(),'sorcerer', 1,
   'Origem Feiticeira', 'Sorcerous Origin',
   'No 1º nível, escolha uma origem feiticeira que descreve a fonte do seu poder arcano inato: Linhagem Dracônica ou Magia Selvagem. Sua escolha lhe concede recursos no 1º nível e novamente no 6º, 14º e 18º nível.',
   'subclass_choice','srd'),

  (gen_random_uuid(),'sorcerer', 2,
   'Fonte de Magia', 'Font of Magic',
   'No 2º nível, você toca a magia profunda dentro de si. Você tem pontos de feitiçaria iguais ao seu nível de feiticeiro, que se recuperam ao terminar um descanso longo.\n\nConversão de Magia: você pode converter espaços de magia em pontos (1 ponto por nível do espaço) ou criar espaços com pontos: 1º (2 pts), 2º (3 pts), 3º (5 pts), 4º (6 pts), 5º (7 pts). Você não pode criar espaços de 6º nível ou superior.',
   'feature','srd'),

  (gen_random_uuid(),'sorcerer', 3,
   'Metamagia', 'Metamagic',
   'No 3º nível, você ganha a habilidade de torcer suas magias para atender às suas necessidades. Você aprende 2 opções de Metamagia (mais 1 no 10º nível e mais 1 no 17º nível):\n• Magia Cuidadosa (1 ponto): criaturas escolhidas passam automaticamente nos testes de resistência da magia.\n• Magia Distante (1 ponto): dobra o alcance da magia ou aumenta de toque para 9 m.\n• Magia Potencializada (1 ponto, ou gratuita se já usou outra metamagia): relance até o mod. de Carisma nos dados de dano.\n• Magia Estendida (1 ponto): dobra a duração da magia (máx. 24 h).\n• Magia Intensificada (3 pontos): o alvo tem desvantagem no primeiro teste de resistência.\n• Magia Acelerada (2 pontos): muda o tempo de conjuração de 1 ação para ação bônus.\n• Magia Sutil (1 ponto): conjura sem componentes verbais ou somáticos.\n• Magia Geminada (pontos = nível da magia, mín. 1): uma magia de alvo único atinge um segundo alvo.',
   'feature','srd'),

  (gen_random_uuid(),'sorcerer', 4,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'sorcerer', 8,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'sorcerer',10,
   'Metamagia Adicional', 'Additional Metamagic',
   'No 10º nível, você aprende mais uma opção de Metamagia.',
   'feature','srd'),

  (gen_random_uuid(),'sorcerer',12,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'sorcerer',16,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'sorcerer',17,
   'Metamagia Adicional', 'Additional Metamagic',
   'No 17º nível, você aprende mais uma opção de Metamagia.',
   'feature','srd'),

  (gen_random_uuid(),'sorcerer',19,
   'Aprimoramento de Atributo', 'Ability Score Improvement',
   'Você pode aumentar um valor de atributo de sua escolha em 2, ou dois valores de atributo em 1 cada. Você não pode aumentar um valor de atributo acima de 20 usando esse recurso.',
   'asi','srd'),

  (gen_random_uuid(),'sorcerer',20,
   'Restauração Feiticeira', 'Sorcerous Restoration',
   'No 20º nível, você recupera 4 pontos de feitiçaria gastos sempre que terminar um descanso curto.',
   'feature','srd');

-- 4. SUBCLASSES
INSERT INTO subclasses (id, class_id, name, name_en, description, level_gained, source) VALUES
  ('sorcerer-draconic',
   'sorcerer',
   'Linhagem Dracônica',
   'Draconic Bloodline',
   'Sua magia inata vem da magia dracônica que foi misturada ao sangue de seus antepassados. Na maioria das vezes, feiticeiros com essa origem rastreiam sua descendência de volta a um poderoso feiticeiro dos tempos antigos que fez um acordo com um dragão ou que pode ter tido um dragão como ascendente.',
   1,'srd'),

  ('sorcerer-wildmagic',
   'sorcerer',
   'Magia Selvagem',
   'Wild Magic',
   'Seu poder arcano inato surge de uma força turbulenta de magia dentro de você. Essa magia pode ter surgido do contato com algum artefato arcano ou entidade, da exposição a bruta magia primeva, ou de algum favor divino que trouxe consequências imprevisíveis.',
   1,'srd');

-- 5. SUBCLASS FEATURES

-- Draconic Bloodline
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'sorcerer-draconic', 1,
   'Ancestral Dracônico', 'Dragon Ancestor',
   'No 1º nível, você tem um dragão como ancestral distante. Escolha um tipo: Negro (ácido), Azul (relâmpago), Bronze (relâmpago), Cobre (ácido), Dourado (fogo), Prata (frio), Vermelho (fogo), Branco (frio), Verde (veneno). Você pode falar, ler e escrever Dracônico. Em testes de Carisma ao interagir com dragões, seu bônus de proficiência é dobrado se aplicável.',
   'feature','srd'),

  (gen_random_uuid(),'sorcerer-draconic', 1,
   'Resiliência Dracônica', 'Draconic Resilience',
   'A magia flui pelo seu corpo causando mudanças físicas que lembram sua ascendência dracônica. Seus pontos de vida máximos aumentam em 1 e aumentam em 1 novamente a cada nível de feiticeiro.\n\nAlém disso, partes do seu corpo são cobertas por finas escamas. Quando não estiver usando armadura, sua CA é igual a 13 + seu modificador de Destreza.',
   'feature','srd'),

  (gen_random_uuid(),'sorcerer-draconic', 6,
   'Afinidade Elemental', 'Elemental Affinity',
   'No 6º nível, quando você lançar uma magia que causar dano do tipo associado ao seu ancestral dracônico, adicione seu modificador de Carisma a esse dano. Você também pode gastar 1 ponto de feitiçaria para ganhar resistência a esse tipo de dano por 1 hora.',
   'feature','srd'),

  (gen_random_uuid(),'sorcerer-draconic',14,
   'Asas Dracônicas', 'Dragon Wings',
   'No 14º nível, como ação bônus, você pode fazer asas de dragão brotar das suas costas, ganhando velocidade de voo igual à sua velocidade atual. Você pode dispensá-las como ação bônus. Você não pode manifestar as asas enquanto usa armadura, a menos que ela seja feita para acomodá-las.',
   'feature','srd'),

  (gen_random_uuid(),'sorcerer-draconic',18,
   'Presença Dracônica', 'Draconic Presence',
   'No 18º nível, como ação, gaste 5 pontos de feitiçaria para envolver-se em uma aura de encanto ou medo por 1 minuto (concentração). Cada criatura hostil visível a até 18 m que iniciar seu turno deve ser bem-sucedida em um teste de Sabedoria (CD de sua magia) ou ficará encantada ou amedrontada por 1 minuto.',
   'feature','srd');

-- Wild Magic
INSERT INTO subclass_features (id, subclass_id, level, name, name_en, description, type, source) VALUES
  (gen_random_uuid(),'sorcerer-wildmagic', 1,
   'Surto de Magia Selvagem', 'Wild Magic Surge',
   'A partir do 1º nível, sua feitiçaria pode se descontrolar. Quando você lança uma magia de feiticeiro de 1º nível ou superior, o Mestre pode pedir que você role um d20. Se você rolar um 1, role na tabela de Surto de Magia Selvagem para criar um efeito mágico aleatório que pode ser benéfico ou prejudicial.',
   'feature','srd'),

  (gen_random_uuid(),'sorcerer-wildmagic', 1,
   'Marés do Caos', 'Tides of Chaos',
   'A partir do 1º nível, você pode manipular as forças do acaso para ganhar vantagem em uma jogada de ataque, teste de habilidade ou teste de resistência. Você deve terminar um descanso longo antes de usá-lo novamente. Antes de recuperar o uso, o Mestre pode acionar um Surto de Magia Selvagem após qualquer magia de 1º nível ou superior que você lançar, e então você recupera Marés do Caos.',
   'feature','srd'),

  (gen_random_uuid(),'sorcerer-wildmagic', 6,
   'Dobrar o Destino', 'Bend Luck',
   'No 6º nível, quando outra criatura visível fizer uma jogada de ataque, teste de habilidade ou teste de resistência, você pode usar sua reação e gastar 2 pontos de feitiçaria para rolar 1d4 e aplicar o resultado como bônus ou penalidade à jogada dessa criatura.',
   'feature','srd'),

  (gen_random_uuid(),'sorcerer-wildmagic',14,
   'Caos Controlado', 'Controlled Chaos',
   'No 14º nível, você ganha um fragmento de controle sobre os surtos de magia selvagem. Sempre que você rolar na tabela de Surto de Magia Selvagem, você pode rolar o dado duas vezes e escolher qual dos dois efeitos usar.',
   'feature','srd'),

  (gen_random_uuid(),'sorcerer-wildmagic',18,
   'Bombardeio de Magias', 'Spell Bombardment',
   'No 18º nível, quando você rolar dano para uma magia e rolar o número mais alto possível em qualquer dado de dano, escolha um desses dados, role-o novamente e adicione o resultado extra ao dano da magia. Você pode usar esse recurso apenas uma vez por turno.',
   'feature','srd');
