-- ============================================================
-- PACOTE 5 — 5º Círculo restante (29) + 6º Círculo parcial (21) = 50
-- ============================================================

INSERT INTO spells (name, name_en, level, school, casting_time, range, components, duration, concentration, ritual, description, higher_levels, classes) VALUES

-- ── 5º CÍRCULO (continuação) ─────────────────────────────────

('Comunhão', 'Commune', 5, 'divination', '1 minuto', 'Pessoal', 'V, S, M (incenso e uma ampola de água benta ou vinho)', '1 minuto', false, true,
 'Você entra em contato com sua divindade ou com um emissário divino e faz três perguntas que possam ser respondidas com sim, não ou indeterminado. Você deve fazer as perguntas antes do fim da magia. Um presságio enganoso ou inexato é entregue se a pergunta não for respondível pela divindade.',
 NULL,
 ARRAY['cleric']),

('Comunhão com a Natureza', 'Commune with Nature', 5, 'divination', '1 minuto', 'Pessoal', 'V, S', 'Instantâneo', false, true,
 'Você entra brevemente em comunhão com a natureza e ganha conhecimento da terra ao redor. No lado de fora, a magia fornece até três fatos sobre terreno, plantas, animais, criaturas, corpos d''água, caminhos e construções num raio de 4,5 km. Em subterrâneos, o raio se reduz a 90 metros.',
 NULL,
 ARRAY['druid', 'ranger']),

('Cone de Frio', 'Cone of Cold', 5, 'evocation', '1 ação', 'Pessoal (cone de 18 metros)', 'V, S, M (cristal ou esfera de vidro)', 'Instantâneo', false, false,
 'Uma rajada de ar gelado sai de suas mãos. Cada criatura num cone de 18 metros deve fazer um teste de resistência de Constituição, sofrendo 8d8 de dano de frio se fracassar ou metade se tiver êxito. Uma criatura morta por esta magia se torna uma estátua de gelo sólida.',
 '+1d8 de dano de frio por slot acima do 5º.',
 ARRAY['sorcerer', 'wizard']),

('Convocar Elemental', 'Conjure Elemental', 5, 'conjuration', '1 minuto', '27 metros', 'V, S, M (incenso aceso para ar; argila de rio para terra; enxofre e fósforo para fogo; água e areia para água)', 'Concentração, até 1 hora', true, false,
 'Você convoca um elemental de CR 5 ou menor de um tipo relacionado ao material que usou. O elemental aparece num espaço desocupado e serve como aliado. Se sua concentração for quebrada, o elemental fica não controlado.',
 'CR máximo do elemental aumenta 1 por slot acima do 5º.',
 ARRAY['druid', 'wizard']),

('Contatar Outro Plano', 'Contact Other Plane', 5, 'divination', '1 minuto', 'Pessoal', 'V', '1 minuto', false, true,
 'Você contata mentalmente uma semidivindade, o espírito de um sábio morto ou alguma outra entidade mística de outro plano. Você pode fazer até cinco perguntas respondíveis com sim/não/desconheço. Há 1 em 6 de chance de enlouquecer temporariamente ao fazer o contato.',
 NULL,
 ARRAY['warlock', 'wizard']),

('Contágio', 'Contagion', 5, 'necromancy', '1 ação', 'Toque', 'V, S', '7 dias', false, false,
 'Seu toque inflige doença. Faça um ataque mágico corpo a corpo. Se acertar, o alvo fica envenenado. No final de cada turno do alvo por três turnos, ele faz um teste de Constituição. Se fracassar em todos os três, a doença o afeta permanentemente (Carne Podre, Estupor, Convulsões, Cegueira, Febres Devastadoras ou Podridão das Tripas) até ser curado por Restauração Maior.',
 NULL,
 ARRAY['cleric', 'druid']),

('Criação', 'Creation', 5, 'illusion', '1 minuto', '9 metros', 'V, S, M (fragmento de material Sematerial e pó de ouro no valor de 100 po)', 'Especial', false, false,
 'Você puxa fragmentos de matéria-sombra do Sematerial e cria um objeto inanimado de material vegetal — tecido, corda, madeira — dentro de uma área de 1,5 m³. A criação dura com base no material: matéria vegetal = 1 dia; pedra/metal = 12 horas; metais preciosos = 10 minutos; gemas = 1 minuto. Não pode criar objetos mágicos.',
 '+1,5 m³ de tamanho máximo por slot acima do 5º.',
 ARRAY['sorcerer', 'wizard']),

('Dissipar o Mal e o Bem', 'Dispel Evil and Good', 5, 'abjuration', '1 ação', 'Pessoal', 'V, S, M (água benta e pó de prata e ferro)', 'Concentração, até 1 minuto', true, false,
 'Uma energia cintilante envolve e protege você de fadas, desmortos e criaturas de outros planos. Enquanto ativa: essas criaturas têm desvantagem em ataques contra você; você não pode ser encantado, amedrontado ou possuído por elas. Você também pode usar a ação para dissipar a possessão ou encantamento de um aliado ou banir um extraplanar.',
 NULL,
 ARRAY['cleric', 'paladin']),

('Dominar Pessoa', 'Dominate Person', 5, 'enchantment', '1 ação', '18 metros', 'V, S', 'Concentração, até 1 minuto', true, false,
 'Você tenta dobrar a vontade de um humanoide visível. Ele faz um teste de Sabedoria. Se fracassar, fica encantado; você tem vínculo telepático com ele enquanto no mesmo plano. Pode emitir comandos (sem ação), que ele obedece. Um ataque sofrido permite novo teste de resistência.',
 'Duração aumenta: slot 6 = 10 minutos; slot 7 = 1 hora; slot 8 = 8 horas.',
 ARRAY['bard', 'sorcerer', 'wizard']),

('Sonho', 'Dream', 5, 'illusion', '1 minuto', 'Especial', 'V, S, M (punhado de areia, fragmento de tinta preta e pena de pena de corvo)', '8 horas', false, false,
 'Você ou uma criatura voluntária entra em estado de transe, atuando como mensageira. Enquanto o alvo dorme, você molda seus sonhos e pode transmitir uma mensagem de até 10 minutos. Se o alvo for mantido acordado, não recebe a mensagem. Pode usar a magia para causar pesadelos — alvo acorda exausto sem recuperar recursos de descanso.',
 NULL,
 ARRAY['bard', 'warlock', 'wizard']),

('Golpe de Chama', 'Flame Strike', 5, 'evocation', '1 ação', '18 metros', 'V, S, M (pitada de enxofre)', 'Instantâneo', false, false,
 'Uma coluna vertical de fogo divino ruge para baixo de cima num local que você especificar. Cada criatura num cilindro de 3 metros de raio e 12 metros de altura centrado no ponto escolhido deve fazer um teste de resistência de Destreza. Uma criatura sofre 4d6 de dano de fogo e 4d6 de dano radiante se fracassar, ou metade se tiver êxito.',
 '+1d6 de fogo e +1d6 radiante por slot acima do 5º.',
 ARRAY['cleric']),

('Geas', 'Geas', 5, 'enchantment', '1 minuto', '18 metros', 'V', '30 dias', false, false,
 'Você ordena a um humanoide visível que realize ou evite alguma ação. O alvo faz um teste de Sabedoria. Se fracassar, deve obedecer. Cada vez que age diretamente contra sua ordem, sofre 5d10 de dano psíquico. A criatura pode tomar ações que não violem a ordem. A magia não controla mortos-vivos, construtos ou plantas.',
 'Duração: slot 7 = 1 ano; slot 9 = permanente.',
 ARRAY['bard', 'cleric', 'druid', 'paladin', 'wizard']),

('Restauração Superior', 'Greater Restoration', 5, 'abjuration', '1 ação', 'Toque', 'V, S, M (pó de diamante no valor de 100 po, consumido pela magia)', 'Instantâneo', false, false,
 'Você infunde uma criatura tocada com energia positiva para desfazer um efeito debilitante. Pode reduzir o nível de exaustão em 1; encerrar efeito de encantamento ou petrificação; encerrar um feitiço de redução de atributos; encerrar um efeito que reduza os PV máximos.',
 NULL,
 ARRAY['bard', 'cleric', 'druid']),

('Imobilizar Monstro', 'Hold Monster', 5, 'enchantment', '1 ação', '18 metros', 'V, S, M (pedaço de ferro)', 'Concentração, até 1 minuto', true, false,
 'Escolha uma criatura visível (qualquer tipo, exceto mortos-vivos). O alvo faz um teste de Sabedoria ou fica paralisado. A criatura pode repetir o teste no final de cada turno para encerrar o efeito.',
 'Uma criatura adicional por slot acima do 5º (a 9 m entre si).',
 ARRAY['bard', 'sorcerer', 'warlock', 'wizard']),

('Lore Lendário', 'Legend Lore', 5, 'divination', '10 minutos', 'Pessoal', 'V, S, M (incenso no valor de 250 po e quatro tarjas de marfim no valor de 50 po cada, todos consumidos)', 'Instantâneo', false, false,
 'Nomeie ou descreva uma pessoa, lugar ou objeto lendário. A magia traz à mente um breve resumo de conhecimento significativo sobre aquilo que você nomeou. O lore pode incluir histórias atuais, tradições esquecidas ou segredos perdidos.',
 NULL,
 ARRAY['bard', 'cleric', 'wizard']),

('Curar Ferimentos em Massa', 'Mass Cure Wounds', 5, 'evocation', '1 ação', '18 metros', 'V, S', 'Instantâneo', false, false,
 'Uma onda de energia curativa emana de um ponto que você escolher dentro do alcance. Escolha até seis criaturas nesse ponto ou a até 9 metros dele. Cada alvo recupera 3d8 + seu modificador de conjuração em pontos de vida. Esta magia não tem efeito em mortos-vivos e construtos.',
 '+1d8 de cura por slot acima do 5º.',
 ARRAY['bard', 'cleric', 'druid']),

('Enganar', 'Mislead', 5, 'illusion', '1 ação', 'Pessoal', 'S', 'Concentração, até 1 hora', true, false,
 'Você se torna invisível e ao mesmo tempo uma cópia ilusória de você aparece no seu espaço. A invisibilidade termina se você atacar ou lançar uma magia. Você pode usar sua ação para mover o duplo até 12 metros e fazer gestos e sons. Pode ver e ouvir pelos sentidos do duplo (não pelos seus).',
 NULL,
 ARRAY['bard', 'wizard']),

('Modificar Memória', 'Modify Memory', 5, 'enchantment', '1 ação', '9 metros', 'V, S', 'Concentração, até 1 minuto', true, false,
 'Você tenta reformular as memórias de outra criatura. O alvo faz um teste de Sabedoria. Se fracassar, fica incapacitado e alheio ao ambiente — você tem 1 minuto para implantar uma memória falsa de um evento que durou até 24 horas e ocorreu nos últimos 30 dias.',
 'Com slot do 6º: últimos 30 dias. 7º: 1 ano. 8º: 10 anos. 9º: qualquer tempo.',
 ARRAY['bard', 'wizard']),

('Passagem pela Parede', 'Passwall', 5, 'transmutation', '1 ação', '9 metros', 'V, S, M (pitada de pó de sésamo)', '1 hora', false, false,
 'Uma passagem aparece em uma superfície de madeira, gesso ou pedra dentro do alcance. A abertura pode ter até 1,5 m de largura, 2,5 m de altura e 6 m de profundidade. A passagem não destabiliza a estrutura. Quando a magia termina, a abertura se fecha e quem estiver dentro é expelido.',
 NULL,
 ARRAY['wizard']),

('Vinculação Planar', 'Planar Binding', 5, 'abjuration', '1 hora', '18 metros', 'V, S, M (joias no valor de 1.000 po, consumidas pela magia)', '24 horas', false, false,
 'Com esta magia, você tenta vincular um celestial, elemental, fada ou demônio convocado a seu serviço. A criatura faz um teste de Carisma. Se fracassar, deve obedecer a seus comandos pelo tempo da magia. Se você lançar esta magia toda vez que recaem os 24 horas de duração, a obrigação se estende.',
 'Duração: slot 6 = 10 dias; 7 = 30 dias; 8 = 180 dias; 9 = 1 ano.',
 ARRAY['bard', 'cleric', 'druid', 'wizard']),

('Ressuscitar', 'Raise Dead', 5, 'necromancy', '1 hora', 'Toque', 'V, S, M (diamante no valor de 500 po, consumido pela magia)', 'Instantâneo', false, false,
 'Você devolve à vida uma criatura morta há até 10 dias. O alvo retorna com 1 PV. Partes do corpo ausentes não são restauradas. O alvo sofre penalidades de ressurreição que desaparecem após 4 dias de descanso: -4 em testes de ataque, resistência e habilidade. Não ressuscita mortos-vivos.',
 NULL,
 ARRAY['bard', 'cleric', 'paladin']),

('Reencarnação', 'Reincarnate', 5, 'transmutation', '1 hora', 'Toque', 'V, S, M (óleos raros e unguentos no valor de 1.000 po, consumidos)', 'Instantâneo', false, false,
 'Você toca um humanoide morto há até 10 dias e o envolve em fragmentos de uma alma vagante. A criatura renasce num novo corpo adulto com memórias intactas. Role d100 na tabela de raças (humano, elfo, anão etc.) para determinar a nova forma. Partes ausentes não impedem a reencarnação.',
 NULL,
 ARRAY['druid']),

('Escrutinar', 'Scrying', 5, 'divination', '10 minutos', 'Pessoal', 'V, S, M (esfera de cristal, espelho de prata ou bacia de água benta no valor de 1.000 po)', 'Concentração, até 10 minutos', true, false,
 'Você vê e ouve uma criatura específica de sua escolha em qualquer lugar do mesmo plano. O alvo faz um teste de Sabedoria modificado por quão bem você o conhece. A CD varia: ouviu falar = -5; viu = 0; conhece bem = +5; tem objeto pessoal = +10. Um sensor invisível aparece próximo ao alvo.',
 NULL,
 ARRAY['bard', 'cleric', 'druid', 'warlock', 'wizard']),

('Aparência', 'Seeming', 5, 'illusion', '1 ação', '9 metros', 'V, S', '8 horas', false, false,
 'Esta magia permite que você altere a aparência de qualquer número de criaturas visíveis dentro do alcance. Cada alvo parece até 1 metro mais alto/mais baixo e parece magro, gordo ou estiver em qualquer ponto intermediário. A magia pode mudar roupas e equipamentos aparentes. A ilusão resiste ao toque.',
 NULL,
 ARRAY['bard', 'sorcerer', 'wizard']),

('Telecinese', 'Telekinesis', 5, 'transmutation', '1 ação', '18 metros', 'V, S', 'Concentração, até 10 minutos', true, false,
 'Você ganha a habilidade de mover ou manipular criaturas e objetos com a mente. Quando lança e como ação nos turnos seguintes: mova um objeto de até 500 kg até 9 metros; ou tente mover uma criatura — ela faz teste de Força contra sua CD ou é movida até 9 metros e fica restrita por sua ação seguinte.',
 NULL,
 ARRAY['sorcerer', 'wizard']),

('Vínculo Telepático', 'Rary''s Telepathic Bond', 5, 'divination', '1 ação', '9 metros', 'V, S, M (ovos de cascavel esbocetados com gesso)', '1 hora', false, true,
 'Você forja um vínculo telepático entre até oito criaturas voluntárias. As criaturas vinculadas podem se comunicar telepaticamente, independentemente do idioma. A comunicação é possível a qualquer distância, mas não entre planos.',
 NULL,
 ARRAY['wizard']),

('Passo pela Árvore', 'Tree Stride', 5, 'conjuration', '1 ação', 'Pessoal', 'V, S', 'Concentração, até 1 minuto', true, false,
 'Você ganha a habilidade de entrar em uma árvore e mover-se de dentro dela para outra árvore do mesmo tipo que esteja a até 150 metros. As duas árvores devem estar vivas. Você passa 1,5 m de movimento para entrar e pode sair de qualquer árvore do mesmo tipo no alcance.',
 NULL,
 ARRAY['druid', 'ranger']),

('Parede de Força', 'Wall of Force', 5, 'evocation', '1 ação', '36 metros', 'V, S, M (pó de safira no valor de 150 po)', 'Concentração, até 10 minutos', true, false,
 'Uma parede invisível de força surge em qualquer forma que você escolher dentro do alcance. A parede pode ter até dez painéis de 3 m × 3 m × 0,5 cm. Ela é imune a dano, impermeável a qualquer tipo de energia e bloqueia teleporte e movimento extradimensional. Dissipar Magia não funciona nela, mas Desintegrar a destrói.',
 NULL,
 ARRAY['wizard']),

('Parede de Pedra', 'Wall of Stone', 5, 'evocation', '1 ação', '36 metros', 'V, S, M (granito pequeno)', 'Concentração, até 10 minutos', true, false,
 'Uma parede de pedra não mágica surge num ponto visível dentro do alcance. A parede tem 6 metros de altura e espessura de 15 cm, com até dez painéis de 3 m × 3 m. Se a parede corta o espaço de uma criatura, ela é empurrada de lado. Quando a concentração terminar, a parede permanece no lugar permanentemente.',
 NULL,
 ARRAY['cleric', 'druid', 'sorcerer', 'wizard']),

-- ── 6º CÍRCULO ───────────────────────────────────────────────

('Barreira de Lâminas', 'Blade Barrier', 6, 'evocation', '1 ação', '27 metros', 'V, S', 'Concentração, até 10 minutos', true, false,
 'Você cria uma parede vertical giratória de lâminas feitas de energia mágica. A parede pode ter até 18 metros de comprimento e 6 de altura, ou ser circular com até 6 metros de raio. Criaturas que atravessem a parede fazem um teste de Destreza, sofrendo 6d10 de dano cortante se fracassarem ou metade se tiverem êxito.',
 NULL,
 ARRAY['cleric']),

('Relâmpago em Cadeia', 'Chain Lightning', 6, 'evocation', '1 ação', '45 metros', 'V, S, M (fragmento de pele de genasi do relâmpago, âmbar, vidro ou cristal)', 'Instantâneo', false, false,
 'Você cria um relâmpago que se bifurca para alvos adicionais. Escolha um alvo primário e até três secundários a até 9 metros um do outro. O alvo primário sofre 10d8 de dano de raio (Destreza para metade). Os secundários sofrem metade do dano do primário.',
 '+1d8 de dano e +1 alvo secundário por slot acima do 6º.',
 ARRAY['sorcerer', 'wizard']),

('Círculo da Morte', 'Circle of Death', 6, 'necromancy', '1 ação', '45 metros', 'V, S, M (pó de osso de cadáver)', 'Instantâneo', false, false,
 'Uma esfera de energia negativa se expande de um ponto que você escolher. Criaturas numa esfera de 18 metros centrada no ponto fazem um teste de Constituição, sofrendo 8d6 de dano necrótico se fracassarem ou metade se tiverem êxito.',
 '+2d6 de dano necrótico por slot acima do 6º.',
 ARRAY['sorcerer', 'warlock', 'wizard']),

('Contingência', 'Contingency', 6, 'evocation', '10 minutos', 'Pessoal', 'V, S, M (estatueta de marfim de si mesmo no valor de 1.500 po e um grão de poeira de esmeralda)', '10 dias', false, false,
 'Você escolhe uma magia de 5º círculo ou menor que possa lançar sobre si mesmo, com tempo de conjuração de 1 ação. Você define uma circunstância (ex: ficar a 0 PV). Quando essa condição se cumprir, a magia armazenada é lançada automaticamente. Apenas uma contingência pode ser ativa por vez.',
 NULL,
 ARRAY['wizard']),

('Criar Mortos-Vivos', 'Create Undead', 6, 'necromancy', '1 minuto', '3 metros', 'V, S, M (argila, sal, mel e componentes negros no valor total de 150 po, consumidos)', 'Instantâneo', false, false,
 'Você pode transformar até três cadáveres de humanoides em ghouls. A criatura serve como aliada se você lhe der ordens verbais. Ao fim de cada descanso longo você precisa reafirmar controle sobre as criaturas ou elas ficam não controladas.',
 'Com slot do 7º: cria um ghast ou 2 ghouls; slot 8 = 1 wight ou 3 ghouls; slot 9 = 2 wights ou 4 ghouls.',
 ARRAY['cleric', 'warlock', 'wizard']),

('Desintegrar', 'Disintegrate', 6, 'transmutation', '1 ação', '18 metros', 'V, S, M (magnésio e pó de pó de esmeralda no valor de 150 po)', 'Instantâneo', false, false,
 'Um fino raio verde brilhante aponta para um alvo visível. O alvo faz um teste de Destreza, sofrendo 10d6+40 de dano de força se fracassar ou 5d6+20 se tiver êxito. Se este dano reduzir o alvo a 0 PV, ele é desintegrado — criatura vira pó, objeto vira fragmentos. Apenas Restauração de Desejo pode reverter isso.',
 '+3d6 de dano de força por slot acima do 6º.',
 ARRAY['sorcerer', 'wizard']),

('Carne para Pedra', 'Flesh to Stone', 6, 'transmutation', '1 ação', '18 metros', 'V, S, M (pitada de calcário, argila e água)', 'Concentração, até 1 minuto', true, false,
 'Você tenta transformar uma criatura visível em pedra. O alvo faz um teste de Constituição. Se fracassar, fica restringido — seu tecido começa a endurecer. Deve repetir o teste no final de cada turno. Três fracassos seguidos a petrificam permanentemente. Três sucessos seguidos encerram o efeito.',
 NULL,
 ARRAY['warlock', 'wizard']),

('Globo de Invulnerabilidade', 'Globe of Invulnerability', 6, 'abjuration', '1 ação', 'Pessoal (raio de 3 metros)', 'V, S, M (pérola de vidro que explode quando a magia termina)', 'Concentração, até 1 minuto', true, false,
 'Uma barreira imóvel e brilhante se levanta ao seu redor. Qualquer magia de 5º círculo ou menor lançada de fora não pode afetar criaturas ou objetos dentro do globo, mesmo que seja usada com um espaço de magia de nível mais alto.',
 'O globo bloqueia magias de um círculo acima por slot acima do 6º.',
 ARRAY['sorcerer', 'wizard']),

('Ferir', 'Harm', 6, 'necromancy', '1 ação', '18 metros', 'V, S', 'Instantâneo', false, false,
 'Você desencadeia uma doença virulenta numa criatura visível. O alvo faz um teste de Constituição. Se fracassar, sofre 14d6 de dano necrótico e seus PV máximos são reduzidos pela quantidade do dano sofrido (mínimo de 1). A redução dura até o alvo terminar um descanso longo. A magia não pode reduzir os PV máximos de um alvo para 0.',
 NULL,
 ARRAY['cleric']),

('Curar', 'Heal', 6, 'evocation', '1 ação', '18 metros', 'V, S', 'Instantâneo', false, false,
 'Escolha uma criatura visível. Ela recupera 70 PV. Esta magia também encerra a condição de cegueira, surdez e qualquer doença que afete o alvo.',
 '+10 PV de cura por slot acima do 6º.',
 ARRAY['cleric', 'druid']),

('Festim dos Heróis', 'Heroes'' Feast', 6, 'conjuration', '10 minutos', '9 metros', 'V, S, M (gem-encrusted bowl no valor de 1.000 po, consumida pela magia)', 'Instantâneo', false, false,
 'Você produz um grande banquete com comida e bebida mágicas para até doze criaturas. Cada uma que comer deve gastar 1 hora na refeição. Ao terminar: fica curada de todas as doenças e venenos, imune a veneno e ao medo por 24 horas, ganha +2d10 de PV máximos e atuais temporários e tem vantagem em testes de Sabedoria.',
 NULL,
 ARRAY['cleric', 'druid']),

('Dança Irresistível', 'Otto''s Irresistible Dance', 6, 'enchantment', '1 ação', '9 metros', 'V', 'Concentração, até 1 minuto', true, false,
 'Escolha um humanoide visível. Ele começa a dançar de forma ridícula: dá passadas, pés batem no chão e braços balançam. O alvo usa sua ação para dançar e não pode fazer outras ações. A CA dele tem -4 e os testes de Destreza têm desvantagem. A criatura pode fazer um teste de Sabedoria por turno para encerrar o efeito.',
 NULL,
 ARRAY['bard', 'wizard']),

('Sugestão em Massa', 'Mass Suggestion', 6, 'enchantment', '1 ação', '18 metros', 'V, M (língua de serpente e mel ou azeite)', '24 horas', false, false,
 'Você sugere um curso de ação a até doze criaturas visíveis que possam ouvi-lo. Criaturas que fracassarem num teste de Sabedoria obedecem à sugestão pelo tempo da magia. A sugestão deve ser razoável e não diretamente prejudicial ao alvo.',
 'Duração: slot 7 = 10 dias; slot 8 = 30 dias; slot 9 = 1 ano.',
 ARRAY['bard', 'sorcerer', 'warlock', 'wizard']),

('Raio de Sol', 'Sunbeam', 6, 'evocation', '1 ação', 'Pessoal (linha de 18 metros)', 'V, S, M (lente de vidro ou cristal)', 'Concentração, até 1 minuto', true, false,
 'Um feixe brilhante de luz intensa sai de sua mão. Cada criatura na linha faz um teste de Constituição, sofrendo 6d8 de dano radiante se fracassar (e ficando cega) ou metade e não cega se tiver êxito. Mortos-vivos e fungos têm desvantagem. Você pode lançar novamente como ação por turno.',
 NULL,
 ARRAY['cleric', 'druid', 'sorcerer', 'wizard']),

('Visão Verdadeira', 'True Seeing', 6, 'divination', '1 ação', 'Toque', 'V, S, M (ungüento de cogumelo, açafrão e gordura de porco no valor de 25 po)', '1 hora', false, false,
 'Você dá à criatura tocada a capacidade de ver as coisas como elas realmente são. Até a magia terminar, o alvo tem visão verdadeira, nota portas secretas ocultas por magia, enxerga no Plano Etéreo — tudo dentro de um raio de 36 metros.',
 NULL,
 ARRAY['bard', 'cleric', 'sorcerer', 'warlock', 'wizard']),

('Parede de Espinhos', 'Wall of Thorns', 6, 'conjuration', '1 ação', '36 metros', 'V, S, M (fragmento de casca e espinho)', 'Concentração, até 10 minutos', true, false,
 'Você cria uma parede de matagal grosso e espinhoso num sólido plano dentro do alcance. A parede pode ter até 18 metros de comprimento, 3 de altura e 1,5 de espessura. A área é terreno difícil. Criaturas que entrem ou comecem o turno na parede sofrem 7d8 de dano perfurante (Destreza para metade).',
 '+1d8 de dano por slot acima do 6º.',
 ARRAY['druid']),

('Palavra de Regresso', 'Word of Recall', 6, 'conjuration', '1 ação', '1,5 metro', 'V', 'Instantâneo', false, false,
 'Você e até cinco criaturas voluntárias dentro do alcance se teleportam instantaneamente para um santuário predefinido. Você deve designar o santuário lançando esta magia naquele local antes de usá-la desta forma. Só pode ter um santuário ativo por vez.',
 NULL,
 ARRAY['cleric']);
