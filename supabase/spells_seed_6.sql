-- ============================================================
-- PACOTE 6 (FINAL) — 6º Círculo restante (13) + 7º Círculo (20) + 8º Círculo (12) + 9º Círculo (5) = 50
-- ============================================================

INSERT INTO spells (name, name_en, level, school, casting_time, range, components, duration, concentration, ritual, description, higher_levels, classes) VALUES

-- ── 6º CÍRCULO (continuação) ─────────────────────────────────

('Portal Arcano', 'Arcane Gate', 6, 'conjuration', '1 ação', '36 metros', 'V, S', 'Concentração, até 10 minutos', true, false,
 'Você cria portais circulares ligados entre dois pontos visíveis dentro do alcance. Cada portal tem 2 metros de diâmetro. Qualquer criatura ou objeto que entrar num portal sai do outro imediatamente.',
 NULL,
 ARRAY['sorcerer', 'warlock', 'wizard']),

('Convocar Fada', 'Conjure Fey', 6, 'conjuration', '1 minuto', '27 metros', 'V, S', 'Concentração, até 1 hora', true, false,
 'Você convoca uma criatura feérica de CR 6 ou menor, ou um espírito feérico que assume a forma de uma besta de CR 6 ou menor. Ele aparece num espaço livre que você possa ver e age como aliado. Se sua concentração for quebrada, a criatura fica não controlada e hostil.',
 'CR máximo da criatura aumenta 1 por slot acima do 6º.',
 ARRAY['druid', 'warlock']),

('Mordida do Olho', 'Eyebite', 6, 'necromancy', '1 ação', 'Pessoal', 'V, S', 'Concentração, até 1 minuto', true, false,
 'Por toda a duração, seus olhos tornam-se negros e cheios de terror. Quando a magia é lançada e como ação em cada turno, escolha um alvo visível a até 18 metros. Aplique um efeito: Adormecido (inconsciente até sofrer dano), Amedrontado (amedrontado por 1 minuto) ou Enjoado (desvantagem em ataques por 1 minuto).',
 NULL,
 ARRAY['bard', 'sorcerer', 'warlock', 'wizard']),

('Encontrar o Caminho', 'Find the Path', 6, 'divination', '1 minuto', 'Pessoal', 'V, S, M (conjunto de ferramentas de adivinhação no valor de 100 po — cartas, ossos ou similares)', 'Concentração, até 1 dia', true, false,
 'Esta magia lhe permite encontrar o caminho mais curto e mais direto para um local específico que você já viu. Enquanto a magia durar, você sempre sabe o caminho de onde está até o destino, mesmo que não haja uma trilha — mas não revela armadilhas ou obstáculos no caminho.',
 NULL,
 ARRAY['bard', 'cleric', 'druid']),

('Proibição', 'Forbiddance', 6, 'abjuration', '10 minutos', 'Toque', 'V, S, M (água benta e incenso fumaçante no valor de 1.000 po, consumidos)', '1 dia', false, true,
 'Você cria uma proteção contra viagem mágica numa área de até 1.350 m² com altura de 9 metros. A proteção impede teleporte, viagem entre planos e portais. Você pode designar criaturas que sofram 5d10 de dano radiante ou necrótico ao entrar na área, ou criaturas que possam entrar livremente.',
 NULL,
 ARRAY['cleric']),

('Guardas e Proteções', 'Guards and Wards', 6, 'abjuration', '10 minutos', 'Toque', 'V, S, M (incenso em chamas, uma pequena quantidade de enxofre e azeite, corda de nó e pó de rubi no valor de 10 po)', '24 horas', false, false,
 'Você cria uma série de proteções mágicas sobre uma área de até 2.700 m², distribuída por um prédio de vários andares. Os efeitos possíveis incluem: névoa de 2 metros de espessura em escadarias, portas falsas, labirinto ilusório, teias de aranha em corredores, e sugestão em criaturas em salas específicas.',
 NULL,
 ARRAY['wizard']),

('Convocação Instantânea', 'Instant Summons', 6, 'conjuration', '1 minuto', 'Toque', 'V, S, M (safira no valor de 1.000 po)', 'Até ser dissipada', false, true,
 'Você toca um objeto de até 5 kg. A qualquer momento, você pode usar uma ação para pronunciar uma palavra de comando e o objeto aparece em sua mão, independentemente de onde ele esteja — mesmo em outro plano, desde que não esteja nas mãos de outra criatura. Apenas uma vinculação pode estar ativa por vez.',
 NULL,
 ARRAY['wizard']),

('Frasco Mágico', 'Magic Jar', 6, 'necromancy', '1 minuto', 'Pessoal', 'V, S, M (gema, cristal, relicário ou item ornamental no valor de 500 po)', 'Até ser dissipada', false, false,
 'Sua alma abandona seu corpo e entra num recipiente dentro de 3 metros. Enquanto no recipiente, você pode tentar possuir humanoides a até 30 metros — o alvo faz um teste de Carisma. Você vê e ouve pelo corpo possuído. Se o recipiente for destruído enquanto você estiver nele, você morre.',
 NULL,
 ARRAY['wizard']),

('Mover a Terra', 'Move Earth', 6, 'transmutation', '1 ação', '36 metros', 'V, S, M (ferro misturado com argila)', 'Concentração, até 2 horas', true, false,
 'Escolha uma área de terreno que caiba num cubo de 12 metros dentro do alcance. Você pode moldar o terreno movendo terra (não rocha sólida) dentro da área — elevar ou abaixar colinas, criar valas, abrir passagens. Cada tentativa de moldar o terreno leva 10 minutos.',
 NULL,
 ARRAY['druid', 'sorcerer', 'wizard']),

('Ilusão Programada', 'Programmed Illusion', 6, 'illusion', '1 ação', '36 metros', 'V, S, M (fragmento de lã de carneiro e pó de jade no valor de 25 po)', 'Até ser dissipada', false, false,
 'Você cria uma ilusão de um objeto, criatura ou fenômeno que ativa quando uma condição específica ocorrer. A ilusão pode incluir sons, cheiros e temperatura. Quando ativada, ela tem a duração que você especificar (até 5 minutos) e então se apaga.',
 NULL,
 ARRAY['bard', 'wizard']),

('Transporte pelas Plantas', 'Transport via Plants', 6, 'conjuration', '1 ação', '3 metros', 'V, S', 'Rodada', false, false,
 'Esta magia cria um vínculo mágico entre uma planta grande ou maior que você toca e outra planta em qualquer lugar do mesmo plano. Você deve ter visto ou tocado a planta de destino pelo menos uma vez. Você e até oito criaturas voluntárias entram na planta e saem da planta de destino.',
 NULL,
 ARRAY['druid']),

('Parede de Gelo', 'Wall of Ice', 6, 'evocation', '1 ação', '36 metros', 'V, S, M (fragmento de quartzo branco)', 'Concentração, até 10 minutos', true, false,
 'Você cria uma parede de gelo de até dez painéis de 3 m × 3 m × 0,3 m. A parede pode assumir qualquer forma. Criaturas dentro da área fazem um teste de Destreza, sofrendo 10d6 de dano de frio se fracassarem ou metade se tiverem êxito. Destruir um painel cria uma névoa de frio de 3 metros que causa 5d6 de dano de frio.',
 '+2d6 de dano de frio por slot acima do 6º.',
 ARRAY['wizard']),

('Caminhar no Vento', 'Wind Walk', 6, 'transmutation', '1 minuto', '9 metros', 'V, S, M (fogo e água benta)', '8 horas', false, false,
 'Você e até dez criaturas voluntárias se transformam em nuvens de névoa por toda a duração. Nessa forma, cada criatura tem velocidade de voo de 90 metros e resistência a dano não mágico. Transformar-se de volta leva 1 minuto.',
 NULL,
 ARRAY['druid']),

-- ── 7º CÍRCULO ───────────────────────────────────────────────

('Convocar Celestial', 'Conjure Celestial', 7, 'conjuration', '1 minuto', '27 metros', 'V, S', 'Concentração, até 1 hora', true, false,
 'Você convoca um celestial de CR 4 ou menor. O celestial aparece num espaço livre e age como aliado. Se sua concentração for quebrada, o celestial desaparece.',
 'CR máximo do celestial aumenta 1 por slot acima do 7º.',
 ARRAY['cleric']),

('Bola de Fogo de Explosão Tardia', 'Delayed Blast Fireball', 7, 'evocation', '1 ação', '45 metros', 'V, S, M (uma minúscula bola de guano de morcego e enxofre)', 'Concentração, até 1 minuto', true, false,
 'Um raio de luz amarela sai de seu dedo indicador e para num ponto visível, depois cresce como uma esfera de baixo brilho de 1,5 m. Quando a magia termina (voluntariamente ou ao fim da concentração), a bola explode num raio de 6 metros causando 12d6 de fogo (Destreza para metade). A cada turno que a bola não explodir, +1d6 de dano acumulado.',
 '+1d6 de dano base por slot acima do 7º.',
 ARRAY['sorcerer', 'wizard']),

('Palavra Divina', 'Divine Word', 7, 'evocation', '1 ação bônus', '9 metros', 'V', 'Instantâneo', false, false,
 'Você pronuncia uma palavra divina imbuída de poder. Cada criatura não celestial, não construto e não morto-vivo visível falha automaticamente o efeito baseado em seus PV atuais: 50+ PV = ensurdecida; 40+ = cega e ensurdecida; 30+ = atordoada, cega e ensurdecida; 20 ou menos = morre instantaneamente. Criaturas extraplanares são banidas se fracassarem num teste de Carisma.',
 NULL,
 ARRAY['cleric']),

('Forma Etérea', 'Etherealness', 7, 'transmutation', '1 ação', 'Pessoal', 'V, S', '8 horas', false, false,
 'Você entra no Plano Etéreo. Você permanece lá pelo tempo da magia ou até usar uma ação para retornar. Enquanto no Plano Etéreo, você pode se mover em qualquer direção, ver e ouvir o Plano Material mas tudo aparece acinzentado, e não pode afetar ou ser afetado por coisas nele.',
 'Com slot do 8º ou superior: até 3 criaturas voluntárias adicionais são afetadas.',
 ARRAY['bard', 'cleric', 'sorcerer', 'warlock', 'wizard']),

('Dedo da Morte', 'Finger of Death', 7, 'necromancy', '1 ação', '18 metros', 'V, S', 'Instantâneo', false, false,
 'Você envia energia negativa para uma criatura visível, causando-lhe dor aguda. O alvo faz um teste de Constituição, sofrendo 7d8+30 de dano necrótico se fracassar ou metade se tiver êxito. Um humanoide morto por esta magia se levanta no início do seu próximo turno como um zumbi permanentemente sob seu controle.',
 NULL,
 ARRAY['sorcerer', 'warlock', 'wizard']),

('Tempestade de Fogo', 'Fire Storm', 7, 'evocation', '1 ação', '45 metros', 'V, S', 'Instantâneo', false, false,
 'Uma tempestade de chamas aparece numa área composta de até dez cubos de 3 metros que você arranjar livremente dentro do alcance. Cada criatura na área faz um teste de Destreza, sofrendo 7d10 de dano de fogo se fracassar ou metade se tiver êxito. Plantas e objetos flamáveis pegam fogo. Você pode optar por deixar plantas não inflamáveis ilesas.',
 NULL,
 ARRAY['cleric', 'druid', 'sorcerer']),

('Gaiola de Força', 'Forcecage', 7, 'evocation', '1 ação', '27 metros', 'V, S, M (rubi em pó no valor de 1.500 po)', '1 hora', false, false,
 'Uma prisão imóvel e invisível de força mágica surge ao redor de uma área de sua escolha. Escolha um cubo de 4,5 metros formado por painéis de força (uma gaiola com aberturas de 1 cm) ou um cubo sólido de 3 metros de força. Criaturas dentro não podem sair por meios mágicos ou mundanos.',
 NULL,
 ARRAY['bard', 'warlock', 'wizard']),

('Miragem Arcana', 'Mirage Arcane', 7, 'illusion', '10 minutos', 'Visão', 'V, S', '10 dias', false, false,
 'Você transforma o terreno de uma área de até 1,5 km² para parecer com outro terreno — tundra vira floresta, deserto vira pântano, etc. A ilusão inclui aparência, sons, temperatura e cheiros. Criaturas que atravessem a ilusão podem detectá-la com Inteligência (Investigação) contra sua CD.',
 NULL,
 ARRAY['bard', 'druid', 'wizard']),

('Mansão Magnífica', 'Magnificent Mansion', 7, 'conjuration', '1 minuto', '90 metros', 'V, S, M (miniatura de portal de marfim no valor de 10 po, pedra de mármore e uma colher de prata minúscula)', '24 horas', false, false,
 'Você conjura um domínio extradimensional atrás de um portal invisível. O espaço interior pode ter até 64 cubos de 3 metros. O portal é visível somente para você, e só entra quem você designar. No interior há serventes fantasmagóricos, comida abundante e camas. Quando a magia termina, todos os que estiverem dentro são expelidos.',
 NULL,
 ARRAY['wizard']),

('Espada Flutuante', 'Mordenkainen''s Sword', 7, 'evocation', '1 ação', '18 metros', 'V, S, M (miniatura de platina de espada no valor de 250 po)', 'Concentração, até 1 minuto', true, false,
 'Você cria uma espada planar flutuante e brilhante num espaço visível dentro do alcance. Quando lança e como ação bônus nos turnos seguintes, você pode mover a espada até 6 metros e fazer um ataque mágico corpo a corpo com ela contra uma criatura a até 1,5 m, causando 3d10 de dano de força se acertar.',
 NULL,
 ARRAY['bard', 'wizard']),

('Deslocamento Planar', 'Plane Shift', 7, 'conjuration', '1 ação', 'Toque', 'V, S, M (forquilha de metal sintonizada ao plano de destino no valor de 250 po)', 'Instantâneo', false, false,
 'Você e até oito criaturas voluntárias que se agarrem a você são transportados para um plano diferente de existência. Alternativamente, você pode usar a magia como ataque: o alvo faz um teste de Carisma ou é banido para um plano aleatório.',
 NULL,
 ARRAY['cleric', 'druid', 'sorcerer', 'warlock', 'wizard']),

('Borrifada Prismática', 'Prismatic Spray', 7, 'evocation', '1 ação', 'Pessoal (cone de 18 metros)', 'V, S', 'Instantâneo', false, false,
 'Oito raios de luz colorida emanam de sua mão. Cada criatura no cone é atingida por um raio aleatório (d8): Vermelho = 10d6 fogo; Laranja = 10d6 ácido; Amarelo = 10d6 raio; Verde = 10d6 veneno; Azul = 10d6 frio; Anil = petrificado; Violeta = cegado; Especial = dois raios.',
 NULL,
 ARRAY['sorcerer', 'wizard']),

('Projetar Imagem', 'Project Image', 7, 'illusion', '1 ação', '750 km', 'V, S, M (boneco de si mesmo no valor de 5 po)', 'Concentração, até 1 dia', true, false,
 'Você cria uma cópia ilusória de si mesmo em qualquer lugar que você tenha visto, a até 750 km. A cópia parece idêntica a você. Você pode ver e ouvir pelos sentidos do duplo. Criaturas que interajam com ele percebem que é ilusório com um teste de Inteligência (Investigação) contra sua CD.',
 NULL,
 ARRAY['bard', 'wizard']),

('Regenerar', 'Regenerate', 7, 'transmutation', '1 minuto', 'Toque', 'V, S, M (oração e visco)', '1 hora', false, false,
 'Você toca uma criatura e estimula sua recuperação natural. O alvo recupera 4d8+15 PV. Por toda a duração, o alvo recupera 1 PV no início de cada turno. Partes de membros cortados se regeneram: após 2 minutos um membro cortado rebrota.',
 NULL,
 ARRAY['bard', 'cleric', 'druid']),

('Ressurreição', 'Resurrection', 7, 'necromancy', '1 hora', 'Toque', 'V, S, M (diamante no valor de 1.000 po, consumido pela magia)', 'Instantâneo', false, false,
 'Você toca uma criatura morta há até 100 anos que não morreu de velhice. Ela retorna à vida com todos os seus PV. A magia neutraliza todos os venenos e doenças e fecha todas as feridas mortais. Se a criatura não tinha um corpo ou foi destruída, a magia cria um novo corpo. Partes ausentes são restauradas.',
 NULL,
 ARRAY['bard', 'cleric']),

('Inverter Gravidade', 'Reverse Gravity', 7, 'transmutation', '1 ação', '27 metros', 'V, S, M (pedra magnética e ferro em pó)', 'Concentração, até 1 minuto', true, false,
 'Esta magia inverte a gravidade numa área de 18 metros de raio e 30 metros de altura centrada num ponto dentro do alcance. Criaturas e objetos que não estejam de alguma forma seguros ao chão caem para cima até o topo da área e ficam lá pelo tempo da magia. Quando a magia termina, os objetos caem.',
 NULL,
 ARRAY['druid', 'sorcerer', 'wizard']),

('Sequestrar', 'Sequester', 7, 'transmutation', '1 ação', 'Toque', 'V, S, M (pó de diamante, rubi, esmeralda e safira no valor de 5.000 po, consumidos)', 'Até ser dissipada', false, false,
 'Ao tocar um objeto ou criatura voluntária, você oculta o alvo de adivinhação e o coloca em estado de animação suspensa. O alvo fica invisível, imperceptível a magia de adivinhação e pode ser programado para despertar quando uma condição específica ocorrer.',
 NULL,
 ARRAY['wizard']),

('Simulacro', 'Simulacrum', 7, 'illusion', '12 horas', 'Toque', 'V, S, M (neve ou gelo em quantidade suficiente para fazer uma figura do tamanho da criatura, mais cabelo, unhas ou outros fragmentos do corpo da criatura no valor de 1.500 po, mais pó de rubi no valor de 1.500 po, consumidos)', 'Até ser dissipado', false, false,
 'Você molda uma figura de neve ou gelo na forma de uma criatura que toca ou de si mesmo. O simulacro é uma criatura ilusória com metade dos PV máximos do original e dos espaços de magia. Ele obedece suas ordens e não pode lançar Simulacro. Se for destruído, desaparece permanentemente.',
 NULL,
 ARRAY['wizard']),

('Símbolo', 'Symbol', 7, 'abjuration', '1 minuto', 'Toque', 'V, S, M (mercúrio, fósforo e pó de diamante e opala no valor de 1.000 po, consumidos)', 'Até ser ativado ou dissipado', false, false,
 'Quando lançada, você inscreve um símbolo nocivo numa superfície ou objeto. Escolha um efeito: Morte (5d10 de necrótico), Discórdia (brigas por 1 minuto), Medo (amedrontado), Imobilização (paralisado), Insanidade (encantado agindo aleatoriamente), Sono (inconsciente), Atordoamento (atordoado), ou Dor (desvantagem).',
 NULL,
 ARRAY['bard', 'cleric', 'wizard']),

('Teleportar', 'Teleport', 7, 'conjuration', '1 ação', '3 metros', 'V', 'Instantâneo', false, false,
 'Esta magia teleporta instantaneamente você e até oito criaturas voluntárias a até 3 metros de você para um destino que você possa descrever. A precisão depende de quão bem você conhece o destino. Um destino desconhecido pode causar um erro de localização ou um acidente.',
 NULL,
 ARRAY['bard', 'sorcerer', 'wizard']),

-- ── 8º CÍRCULO ───────────────────────────────────────────────

('Campo Antimágico', 'Antimagic Field', 8, 'abjuration', '1 ação', 'Pessoal (esfera de 3 metros)', 'V, S, M (pitada de pó de ferro e pó de safira)', 'Concentração, até 1 hora', true, false,
 'Uma esfera invisível de antimagia de 3 metros de raio se expande de você. A área suprime toda a magia e impede a passagem de efeitos mágicos. Criaturas e objetos não são afetados pela magia enquanto estão dentro da esfera.',
 NULL,
 ARRAY['cleric', 'wizard']),

('Antipatia/Simpatia', 'Antipathy/Sympathy', 8, 'enchantment', '1 hora', 'Toque', 'V, S, M (vinagre de maçã para antipatia, ou mel e flores para simpatia)', '10 dias', false, false,
 'Esta magia atrai ou repele criaturas de sua escolha. Escolha um tipo de criatura inteligente. Antipatia: ela sente forte compulsão para fugir do objeto ou área afetada. Simpatia: ela sente forte compulsão para se aproximar e permanecer. Uma criatura pode fazer um teste de Sabedoria para resistir.',
 NULL,
 ARRAY['druid', 'wizard']),

('Controlar o Tempo', 'Control Weather', 8, 'transmutation', '10 minutos', 'Pessoal (raio de 8 km)', 'V, S, M (incenso em chamas e terra e madeira misturadas com água)', 'Concentração, até 8 horas', true, false,
 'Você assume controle sobre o clima num raio de 8 km. Deve estar ao ar livre para lançar a magia. Você pode alterar as condições meteorológicas: temperatura, intensidade do vento e precipitação. Cada mudança leva de 1d4 × 10 minutos para ocorrer.',
 NULL,
 ARRAY['cleric', 'druid', 'wizard']),

('Dominar Monstro', 'Dominate Monster', 8, 'enchantment', '1 ação', '18 metros', 'V, S', 'Concentração, até 1 hora', true, false,
 'Você tenta dobrar a vontade de qualquer criatura visível. Ela faz um teste de Sabedoria. Se fracassar, fica encantada; você tem vínculo telepático com ela. Pode emitir comandos sem ação. Criaturas que sofrerem dano durante a magia podem repetir o teste de resistência.',
 NULL,
 ARRAY['bard', 'sorcerer', 'warlock', 'wizard']),

('Terremoto', 'Earthquake', 8, 'evocation', '1 ação', '300 metros', 'V, S, M (terra, rocha e argila)', 'Concentração, até 1 minuto', true, false,
 'Você cria um tremor sísmico num ponto no chão. A área afetada é um círculo de 30 metros de raio. O chão fica terreno difícil; estruturas e concentração são interrompidos. Criaturas que caírem prostradas no início do turno fazem um teste de Constituição CD 15 ou ficam incapacitadas até o fim do turno.',
 NULL,
 ARRAY['cleric', 'druid', 'sorcerer']),

('Idiotia', 'Feeblemind', 8, 'enchantment', '1 ação', '45 metros', 'V, S, M (um punhado de argila, cristal, vidro ou mineral esférico)', 'Instantâneo', false, false,
 'Você assalta e arruína a mente de uma criatura visível. O alvo sofre 4d6 de dano psíquico e faz um teste de Inteligência. Se fracassar, sua pontuação de Inteligência e Carisma se tornam 1. O alvo não pode lançar magias, ativar itens mágicos, entender linguagem nem se comunicar articuladamente. Pode repetir o teste a cada 30 dias.',
 NULL,
 ARRAY['bard', 'druid', 'warlock', 'wizard']),

('Aura Sagrada', 'Holy Aura', 8, 'abjuration', '1 ação', '9 metros', 'V, S, M (pedaço de pano abençoado no valor de 1.000 po)', 'Concentração, até 1 minuto', true, false,
 'Luz divina envolve até cinco criaturas de sua escolha visíveis. Cada alvo emite luz brilhante de 1,5 metro e penumbra por mais 1,5 metro, tem vantagem nos testes de resistência, criaturas que atacam o alvo corpo a corpo ficam cegas até o fim de seus turnos e o alvo não pode ser possuído.',
 NULL,
 ARRAY['cleric']),

('Labirinto', 'Maze', 8, 'conjuration', '1 ação', '18 metros', 'V, S', 'Concentração, até 10 minutos', true, false,
 'Você bane uma criatura visível para um labirinto extradimensional. O alvo pode usar sua ação para tentar escapar com um teste de Inteligência CD 20. Minótiuros escapam automaticamente em 1 rodada. Quando a magia termina, o alvo retorna ao espaço mais próximo disponível.',
 NULL,
 ARRAY['wizard']),

('Mente em Branco', 'Mind Blank', 8, 'abjuration', '1 ação', 'Toque', 'V, S', '24 horas', false, false,
 'Até a magia terminar, um alvo voluntário é imune a dano psíquico, a qualquer efeito que leia seus pensamentos ou emoções, a adivinhação, ao estado de encantado e à magia Modificar Memória.',
 NULL,
 ARRAY['bard', 'wizard']),

('Palavra de Poder: Atordoar', 'Power Word Stun', 8, 'enchantment', '1 ação', '18 metros', 'V', 'Especial', false, false,
 'Você pronuncia uma palavra de poder que sobrecarrega a mente de uma criatura visível com 150 PV ou menos, deixando-a perplexa. O alvo fica atordoado. No final de cada turno, o alvo faz um teste de Constituição. Com êxito, o atordoamento termina. Criaturas com mais de 150 PV são imunes.',
 NULL,
 ARRAY['bard', 'sorcerer', 'warlock', 'wizard']),

('Explosão Solar', 'Sunburst', 8, 'evocation', '1 ação', '45 metros', 'V, S, M (fogo e pó de heliodoro no valor de 150 po)', 'Instantâneo', false, false,
 'Uma luz brilhante de energia solar rasga numa explosão de 18 metros de raio centrada em um ponto visível. Cada criatura na área faz um teste de Constituição, sofrendo 12d6 de dano radiante se fracassar (e ficando cega por 1 minuto) ou metade se tiver êxito. Mortos-vivos e fungos têm desvantagem. A luz dura 1 rodada como luz brilhante.',
 NULL,
 ARRAY['cleric', 'druid', 'sorcerer', 'wizard']),

-- ── 9º CÍRCULO ───────────────────────────────────────────────

('Presciência', 'Foresight', 9, 'divination', '1 minuto', 'Toque', 'V, S, M (pena de corvo)', '8 horas', false, false,
 'Você toca uma criatura voluntária e lhe concede percepção do futuro imediato. Até a magia terminar, o alvo não pode ser surpreendido e tem vantagem em testes de ataque, verificações de habilidade e testes de resistência. Criaturas que atacam o alvo têm desvantagem nos testes de ataque contra ele.',
 NULL,
 ARRAY['bard', 'druid', 'warlock', 'wizard']),

('Portal', 'Gate', 9, 'conjuration', '1 ação', '18 metros', 'V, S, M (diamante no valor de 5.000 po)', 'Concentração, até 1 minuto', true, false,
 'Você conjura um portal conectando um espaço desocupado a um plano de existência diferente. O portal é um anel circular de até 6 metros. Você pode nomear uma criatura específica para ser puxada através do portal se fracassar num teste de Carisma.',
 NULL,
 ARRAY['cleric', 'sorcerer', 'wizard']),

('Enxame de Meteoros', 'Meteor Swarm', 9, 'evocation', '1 ação', '1,5 km', 'V, S', 'Instantâneo', false, false,
 'Bolas de fogo explodem em quatro pontos diferentes que você especificar dentro do alcance. Cada ponto fica no centro de uma explosão de 18 metros de raio. Criaturas numa explosão fazem um teste de Destreza, sofrendo 20d6 de fogo e 20d6 de contusão se fracassarem ou metade se tiverem êxito. Um alvo numa zona de sobreposição pode ser afetado por mais de uma explosão.',
 NULL,
 ARRAY['sorcerer', 'wizard']),

('Palavra de Poder: Matar', 'Power Word Kill', 9, 'enchantment', '1 ação', '18 metros', 'V', 'Instantâneo', false, false,
 'Você pronuncia uma palavra de poder que compele uma criatura visível com 100 PV ou menos a morrer instantaneamente. Se a criatura tiver mais de 100 PV, ela fica atordoada até o início do seu próximo turno.',
 NULL,
 ARRAY['bard', 'sorcerer', 'warlock', 'wizard']),

('Desejo', 'Wish', 9, 'conjuration', '1 ação', 'Pessoal', 'V', 'Instantâneo', false, false,
 'Desejo é a magia mais poderosa que existe para mortais. Ao lançá-la, você pode duplicar qualquer magia de 8º círculo ou inferior sem custo. Ou pode pedir algo fora do escopo normal das magias: restaurar mortos de qualquer época, criar um objeto de valor inferior a 25.000 po, conceder 10 PT a 20 criaturas, ou outros efeitos a critério do Mestre. Lançar Desejo para qualquer coisa além de duplicar outra magia causa 1d10 × 1d10 de dano necrótico irredutível e 33% de chance de nunca mais poder lançá-la.',
 NULL,
 ARRAY['sorcerer', 'wizard']);
