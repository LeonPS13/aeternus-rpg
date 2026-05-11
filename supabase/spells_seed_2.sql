-- ============================================================
-- PACOTE 2 — 1º Círculo restante (17) + 2º Círculo parcial (33) = 50
-- ============================================================

INSERT INTO spells (name, name_en, level, school, casting_time, range, components, duration, concentration, ritual, description, higher_levels, classes) VALUES

-- ── 1º CÍRCULO (continuação) ─────────────────────────────────

('Explosão de Cores', 'Color Spray', 1, 'illusion', '1 ação', 'Pessoal (cone de 4,5 metros)', 'V, S, M (pitada de pó colorido em pó)', 'Instantâneo', false, false,
 'Jatos de luz colorida emanam de sua mão. Role 6d10 — o total é a quantidade de pontos de vida de criaturas que esta magia pode cegar. As criaturas no cone são afetadas em ordem crescente de PV atuais, ficando cegas até o fim do seu próximo turno.',
 '+2d10 por slot acima do 1º.',
 ARRAY['sorcerer', 'wizard']),

('Comando', 'Command', 1, 'enchantment', '1 ação', '18 metros', 'V', '1 rodada', false, false,
 'Você pronuncia uma ordem de uma palavra a uma criatura visível. O alvo falha num teste de resistência de Sabedoria e obedece ao comando em seu próximo turno. Os comandos típicos são: Aproximar, Largar, Fugir, Prostrar e Parar.',
 'Cada slot acima do 1º afeta uma criatura adicional (a 9 m entre si). Cada criatura deve receber o mesmo comando.',
 ARRAY['cleric', 'paladin']),

('Compreender Idiomas', 'Comprehend Languages', 1, 'divination', '1 ação', 'Pessoal', 'V, S, M (fuligem e sal)', '1 hora', false, true,
 'Você entende o sentido literal de qualquer linguagem falada que ouça e pode ler qualquer texto visível. Você não fala as línguas, apenas as compreende. Linguagens secretas ou cifradas não são afetadas.',
 NULL,
 ARRAY['bard', 'sorcerer', 'warlock', 'wizard']),

('Enredar', 'Entangle', 1, 'conjuration', '1 ação', '27 metros', 'V, S', 'Concentração, até 1 minuto', true, false,
 'Ervas e cipós brotam do solo num quadrado de 6 metros dentro do alcance. O terreno na área se torna difícil. Cada criatura nessa área ao ser lançada deve fazer um teste de resistência de Força ou ficar restrita até a magia terminar. Uma criatura pode usar sua ação para fazer um teste de Força contra a CD para se libertar.',
 NULL,
 ARRAY['druid']),

('Encontrar Familiar', 'Find Familiar', 1, 'conjuration', '1 hora', '3 metros', 'V, S, M (10 po de carvão, incenso e ervas consumidos no fogo de latão)', 'Instantâneo', false, true,
 'Você convoca um espírito que assume a forma de um animal Miúdo de sua escolha (corvo, gato, sapo, coruja etc.) como seu familiar. Enquanto estiver num raio de 30 metros, você pode se comunicar telepáticamente com ele e usar sua ação para ver pelos seus olhos e ouvir pelos seus ouvidos. Você pode dispensar o familiar temporariamente para um bolso dimensional.',
 NULL,
 ARRAY['wizard']),

('Nuvem de Névoa', 'Fog Cloud', 1, 'conjuration', '1 ação', '36 metros', 'V, S', 'Concentração, até 1 hora', true, false,
 'Você cria uma esfera de névoa espessa de 6 metros de raio centrada num ponto dentro do alcance. A névoa bloqueia a visão; criaturas na área ficam totalmente cobertas. Ventos fortes a dispersam.',
 '+3 metros de raio para cada slot acima do 1º.',
 ARRAY['druid', 'ranger', 'sorcerer', 'wizard']),

('Identificar', 'Identify', 1, 'divination', '1 minuto', 'Toque', 'V, S, M (pérola de 100 po e pena de coruja)', 'Instantâneo', false, true,
 'Você toca um objeto mágico ou uma criatura. Se for um objeto, você aprende suas propriedades mágicas e como usá-las, quantos cargas tem (se for o caso) e se está amaldiçoado. Se for uma criatura, você aprende que magias a afetam no momento.',
 NULL,
 ARRAY['bard', 'wizard']),

('Saltar', 'Jump', 1, 'transmutation', '1 ação', 'Toque', 'V, S, M (pata traseira de um gafanhoto)', '1 minuto', false, false,
 'Você toca uma criatura. Sua distância de salto é triplicada até a magia terminar.',
 NULL,
 ARRAY['druid', 'ranger', 'wizard']),

('Passo Largo', 'Longstrider', 1, 'transmutation', '1 ação', 'Toque', 'V, S, M (pitada de terra)', '1 hora', false, false,
 'Você toca uma criatura. Sua velocidade aumenta em 3 metros até a magia terminar.',
 'Uma criatura adicional por slot acima do 1º.',
 ARRAY['bard', 'druid', 'ranger', 'wizard']),

('Proteção contra o Mal e o Bem', 'Protection from Evil and Good', 1, 'abjuration', '1 ação', 'Toque', 'V, S, M (água benta ou pó de prata e ferro, consumidos pela magia)', 'Concentração, até 10 minutos', true, false,
 'Até a magia terminar, uma criatura voluntária que você tocar é protegida contra aberrações, celestiais, elementais, fadas, desmortos e planares. Criaturas desses tipos têm desvantagem nos testes de ataque contra o alvo, que também não pode ser encantado, amedrontado ou possuído por elas.',
 NULL,
 ARRAY['cleric', 'druid', 'paladin', 'warlock', 'wizard']),

('Raio de Doença', 'Ray of Sickness', 1, 'necromancy', '1 ação', '18 metros', 'V, S', 'Instantâneo', false, false,
 'Um raio de energia adoentada aponta em direção a uma criatura. Faça um ataque mágico à distância. Se acertar, o alvo sofre 2d8 de dano de veneno e deve fazer um teste de resistência de Constituição ou ficar envenenado até o fim do seu próximo turno.',
 '+1d8 de dano de veneno para cada slot acima do 1º.',
 ARRAY['sorcerer', 'wizard']),

('Santuário', 'Sanctuary', 1, 'abjuration', '1 ação bônus', '9 metros', 'V, S, M (um espelho de mão pequeno)', '1 minuto', false, false,
 'Você protege uma criatura dentro do alcance. Qualquer criatura que tentar atacar o alvo ou lançar uma magia prejudicial nele deve primeiro fazer um teste de resistência de Sabedoria; se fracassar, precisará escolher outro alvo ou perderá o ataque/magia. A proteção termina se o alvo atacar ou lançar uma magia prejudicial.',
 NULL,
 ARRAY['cleric']),

('Escudo da Fé', 'Shield of Faith', 1, 'abjuration', '1 ação bônus', '18 metros', 'V, S, M (fragmento de texto sagrado)', 'Concentração, até 10 minutos', true, false,
 'Um campo de energia cintilante aparece e protege uma criatura dentro do alcance, concedendo-lhe +2 de bônus na CA enquanto a magia durar.',
 NULL,
 ARRAY['cleric', 'paladin']),

('Imagem Silenciosa', 'Silent Image', 1, 'illusion', '1 ação', '18 metros', 'V, S, M (fragmento de lã de carneiro)', 'Concentração, até 10 minutos', true, false,
 'Você cria uma imagem de um objeto, criatura ou fenômeno visível numa área de no máximo 4,5 metros de cubo. A imagem é puramente visual — sem som, cheiro ou outras qualidades sensoriais. Você pode usar uma ação para mover a imagem dentro do alcance. Criaturas que examinarem a imagem com Inteligência (Investigação) contra sua CD podem reconhecê-la como ilusória.',
 NULL,
 ARRAY['bard', 'sorcerer', 'wizard']),

('Falar com Animais', 'Speak with Animals', 1, 'divination', '1 ação', 'Pessoal', 'V, S', '10 minutos', false, true,
 'Você ganha a habilidade de compreender e se comunicar verbalmente com animais durante a duração da magia. O conhecimento que um animal pode dar é limitado à sua inteligência e à sua percepção do mundo.',
 NULL,
 ARRAY['bard', 'druid', 'ranger']),

('Riso Horrendo de Tasha', 'Tasha''s Hideous Laughter', 1, 'enchantment', '1 ação', '9 metros', 'V, S, M (pequenas tortas e pena agitada no ar)', 'Concentração, até 1 minuto', true, false,
 'Uma criatura visível percebe tudo absurdamente hilário e fica dominada pelo riso se fracassar num teste de resistência de Sabedoria. Criaturas com Inteligência 4 ou menos são imunes. A criatura fica na condição de prostrada e incapaz de se levantar. Pode repetir o teste no final de cada turno.',
 NULL,
 ARRAY['bard', 'wizard']),

('Raio Bruxa', 'Witch Bolt', 1, 'evocation', '1 ação', '9 metros', 'V, S, M (galho de uma árvore atingida por raio)', 'Concentração, até 1 minuto', true, false,
 'Um raio de força azulada e crepitante conecta você ao alvo visível. Faça um ataque mágico à distância. Se acertar, o alvo sofre 1d12 de dano de raio e, enquanto a magia durar, você pode usar uma ação para causar automaticamente 1d12 de dano de raio ao alvo a cada turno. A magia termina se o alvo sair do alcance ou houver cobertura total.',
 '+1d12 de dano para cada slot acima do 1º.',
 ARRAY['sorcerer', 'warlock', 'wizard']),

-- ── 2º CÍRCULO ───────────────────────────────────────────────

('Auxílio', 'Aid', 2, 'abjuration', '1 ação', '9 metros', 'V, S, M (tira de pano branco)', '8 horas', false, false,
 'Seu feitiço fortalece três criaturas de sua escolha. Os pontos de vida máximos e atuais de cada alvo aumentam em 5 pela duração.',
 '+5 pontos de vida para cada slot acima do 2º.',
 ARRAY['cleric', 'paladin']),

('Alterar-se', 'Alter Self', 2, 'transmutation', '1 ação', 'Pessoal', 'V, S', 'Concentração, até 1 hora', true, false,
 'Você assume uma forma diferente. Escolha uma das seguintes opções: Adaptação Aquática (brânquias, membranas, velocidade de natação 9 m); Mudar Aparência (alterar aspecto físico); Armas Naturais (garras, presas ou soco que causam 1d6 de dano).',
 NULL,
 ARRAY['sorcerer', 'wizard']),

('Mensageiro Animal', 'Animal Messenger', 2, 'enchantment', '1 ação', '9 metros', 'V, S, M (berinjela ou petisco)', '24 horas', false, true,
 'Pelo uso desta magia, você usa um animal Miúdo a seu alcance como mensageiro. Você especifica um local e descreve um destinatário. O animal viaja direto ao destino. Ao chegar, entrega uma mensagem de até 25 palavras que você sussurrou.',
 'A duração aumenta 48 horas para cada slot acima do 2º.',
 ARRAY['bard', 'druid', 'ranger']),

('Cegueira/Surdez', 'Blindness/Deafness', 2, 'necromancy', '1 ação', '9 metros', 'V', '1 minuto', false, false,
 'Você pode cegar ou ensurdecer um inimigo. Escolha uma criatura visível. Ela faz um teste de resistência de Constituição. Se fracassar, ficará cega ou surda (à sua escolha) pelo tempo da magia. A criatura pode repetir o teste no final de cada turno, encerrando o efeito se tiver êxito.',
 'Uma criatura adicional por slot acima do 2º.',
 ARRAY['bard', 'cleric', 'sorcerer', 'wizard']),

('Borrão', 'Blur', 2, 'illusion', '1 ação', 'Pessoal', 'V', 'Concentração, até 1 minuto', true, false,
 'Seu corpo fica desfocado e oscilante para qualquer um que olhe para você. Durante a duração, qualquer criatura tem desvantagem nos testes de ataque contra você. Um atacante imune à condição de cegueira é imune a este efeito.',
 NULL,
 ARRAY['sorcerer', 'wizard']),

('Escuridão', 'Darkness', 2, 'evocation', '1 ação', '18 metros', 'V, M (morcego morto ou gota de alcatrão misturada com gordura de pântano)', 'Concentração, até 10 minutos', true, false,
 'Sombras mágicas se expandem de um ponto num raio de 4,5 metros. As sombras se propagam por cantos. Visão no escuro não penetra a escuridão, e luzes não mágicas são apagadas. Fontes de luz mágica criadas por magias de nível menor são suprimidas.',
 NULL,
 ARRAY['sorcerer', 'warlock', 'wizard']),

('Visão no Escuro', 'Darkvision', 2, 'transmutation', '1 ação', 'Toque', 'V, S, M (uma pitada de cenoura seca ou ágata)',
 '8 horas', false, false,
 'Você toca uma criatura voluntária. Até a magia terminar, ela tem visão no escuro com alcance de 18 metros.',
 NULL,
 ARRAY['druid', 'ranger', 'sorcerer', 'wizard']),

('Detectar Pensamentos', 'Detect Thoughts', 2, 'divination', '1 ação', 'Pessoal', 'V, S, M (moeda de cobre)', 'Concentração, até 1 minuto', true, false,
 'Você lê os pensamentos de criaturas. Foque em uma criatura visível a até 9 metros: ela faz um teste de Sabedoria ou você lê seus pensamentos superficiais. Você pode aprofundar para pensamentos mais ocultos; a criatura percebe e pode fazer um novo teste. Também pode usar como detector de presença (raio de 9 metros).',
 NULL,
 ARRAY['bard', 'sorcerer', 'wizard']),

('Ampliar Habilidade', 'Enhance Ability', 2, 'transmutation', '1 ação', 'Toque', 'V, S, M (pelos de animal)', 'Concentração, até 1 hora', true, false,
 'Você toca uma criatura e lhe concede um aprimoramento mágico. Escolha um: Força do Urso (+2d6 PV temporários, vantagem em testes de Força); Graça do Gato (vantagem em Destreza, não sofre dano de queda de 6 m ou menos); Resiliência do Urso (vantagem em Constituição); Astúcia do Raposo (vantagem em Inteligência); Resiliência da Coruja (vantagem em Sabedoria); Eloquência da Águia (vantagem em Carisma).',
 'Uma criatura adicional por slot acima do 2º.',
 ARRAY['bard', 'cleric', 'druid', 'ranger', 'sorcerer', 'wizard']),

('Aumentar/Diminuir', 'Enlarge/Reduce', 2, 'transmutation', '1 ação', '9 metros', 'V, S, M (grão de areia e pequena fragmento de ferro)', 'Concentração, até 1 minuto', true, false,
 'Você causa o crescimento ou encolhimento de uma criatura ou objeto dentro do alcance. Aumentar: o alvo dobra de tamanho em todas as dimensões; testes de Força com vantagem; +1d4 de dano com armas. Diminuir: o alvo é reduzido à metade; testes de Força com desvantagem; -1d4 de dano com armas.',
 NULL,
 ARRAY['sorcerer', 'wizard']),

('Encontrar Armadilhas', 'Find Traps', 2, 'divination', '1 ação', '36 metros', 'V, S', 'Instantâneo', false, false,
 'Você percebe a presença de qualquer armadilha dentro do alcance na linha de visão. Uma armadilha, para fins desta magia, inclui qualquer coisa que infligir um efeito súbito ou inesperado que você considere prejudicial. Você não aprende a localização precisa de cada armadilha, mas sabe a natureza geral do perigo.',
 NULL,
 ARRAY['cleric', 'druid', 'ranger']),

('Esfera de Chamas', 'Flaming Sphere', 2, 'conjuration', '1 ação', '18 metros', 'V, S, M (sebo, fósforo e pó de ferro)', 'Concentração, até 1 minuto', true, false,
 'Uma esfera de fogo do tamanho de um barril aparece num espaço desocupado de sua escolha. Criaturas a até 1,5 m dela sofrem 2d6 de dano de fogo (Destreza CD sua para metade). Como ação bônus, você pode rolar a esfera até 9 metros. Ela ilumina 6 metros de luz brilhante e mais 6 de penumbra.',
 '+1d6 de dano por slot acima do 2º.',
 ARRAY['druid', 'wizard']),

('Rajada de Vento', 'Gust of Wind', 2, 'evocation', '1 ação', 'Pessoal (linha de 18 metros)', 'V, S, M (semente de leguminosa)', 'Concentração, até 1 minuto', true, false,
 'Uma linha de forte vento de 18 metros de comprimento e 3 de largura sopra de você. Cada criatura que começa o turno na linha deve fazer um teste de Força ou ser empurrada 4,5 metros para longe de você. A linha cria terreno difícil. Você pode alterar a direção do vento como ação bônus.',
 NULL,
 ARRAY['druid', 'sorcerer', 'wizard']),

('Imobilizar Pessoa', 'Hold Person', 2, 'enchantment', '1 ação', '18 metros', 'V, S, M (pequeno reto de ferro)', 'Concentração, até 1 minuto', true, false,
 'Escolha um humanoide visível. Ele faz um teste de resistência de Sabedoria ou fica paralisado. A criatura pode repetir o teste no final de cada turno para encerrar o efeito.',
 'Um humanoide adicional por slot acima do 2º (a 9 m entre si).',
 ARRAY['bard', 'cleric', 'druid', 'sorcerer', 'warlock', 'wizard']),

('Invisibilidade', 'Invisibility', 2, 'illusion', '1 ação', 'Toque', 'V, S, M (pestana enrolada em resina de araucária)', 'Concentração, até 1 hora', true, false,
 'Uma criatura que você tocar fica invisível até a magia terminar. Qualquer coisa que o alvo use ou carregue fica invisível. A invisibilidade termina se o alvo atacar ou lançar uma magia.',
 'Uma criatura adicional por slot acima do 2º.',
 ARRAY['bard', 'sorcerer', 'warlock', 'wizard']),

('Destravar', 'Knock', 2, 'transmutation', '1 ação', '18 metros', 'V', 'Instantâneo', false, false,
 'Escolha um objeto visível que seja fechado por meios mundanos ou mágicos — uma porta, uma caixa, um cofre, algemas, um cadeado ou outro objeto. Um alvo preso por fechadura arcana tem o feitiço suprimido por 10 minutos. Quando você lança esta magia, um som alto e audível ecoará a até 90 metros.',
 NULL,
 ARRAY['sorcerer', 'wizard']),

('Restauração Menor', 'Lesser Restoration', 2, 'abjuration', '1 ação', 'Toque', 'V, S', 'Instantâneo', false, false,
 'Você toca uma criatura e encerra uma doença ou uma condição que a afete: cega, ensurdecida, paralisada ou envenenada.',
 NULL,
 ARRAY['bard', 'cleric', 'druid', 'paladin', 'ranger']),

('Levitar', 'Levitate', 2, 'transmutation', '1 ação', '18 metros', 'V, S, M (corrente dourada no valor de pelo menos 1 po)', 'Concentração, até 10 minutos', true, false,
 'Uma criatura ou objeto de até 225 kg sobe verticalmente até 6 metros e permanece suspenso. No turno do alvo, ele pode se mover verticalmente até 6 metros. Criaturas involuntárias podem fazer teste de Constituição para resistir.',
 NULL,
 ARRAY['sorcerer', 'wizard']),

('Imagem Espelhada', 'Mirror Image', 2, 'illusion', '1 ação', 'Pessoal', 'V, S', '1 minuto', false, false,
 'Três cópias ilusórias surgem ao seu redor. Quando uma criatura te ataca, role um d20 para determinar se o ataque acerta você ou uma das cópias (CA de 10 + seu bônus de Destreza). Com 3 cópias use 6+; com 2 use 8+; com 1 use 11+. Uma cópia atingida é destruída.',
 NULL,
 ARRAY['sorcerer', 'warlock', 'wizard']),

('Passo Enevoado', 'Misty Step', 2, 'conjuration', '1 ação bônus', 'Pessoal', 'V', 'Instantâneo', false, false,
 'Brevemente envolto em névoa prateada, você se teleporta até 9 metros para um espaço desocupado que possa ver.',
 NULL,
 ARRAY['sorcerer', 'warlock', 'wizard']),

('Feixe de Luar', 'Moonbeam', 2, 'evocation', '1 ação', '36 metros', 'V, S, M (vários grãos de pó lunar e uma pena de pássaro noturno)', 'Concentração, até 1 minuto', true, false,
 'Um feixe prateado de luz pálida brilha num cilindro de 1,5 m de raio e 12 m de altura centrado num ponto dentro do alcance. Criaturas que entrem ou comecem o turno na área fazem teste de Constituição, sofrendo 2d10 de dano radiante se fracassarem ou metade se tiverem êxito. Metamorfos têm desvantagem no teste. Como ação bônus, você pode mover o feixe até 18 metros.',
 '+1d10 de dano por slot acima do 2º.',
 ARRAY['druid']),

('Passar sem Rastro', 'Pass Without Trace', 2, 'abjuration', '1 ação', 'Pessoal', 'V, S, M (cinzas de visco queimado e agulhas de pinheiro)', 'Concentração, até 1 hora', true, false,
 'Uma sombra e um silêncio saem de você, envolvendo você e seus companheiros. Cada criatura de sua escolha num raio de 9 metros (inclusive você) ganha +10 em testes de Destreza (Furtividade) e não pode ser rastreada por meios não mágicos enquanto a magia durar.',
 NULL,
 ARRAY['druid', 'ranger']),

('Oração de Cura', 'Prayer of Healing', 2, 'evocation', '10 minutos', '9 metros', 'V', 'Instantâneo', false, false,
 'Até seis criaturas de sua escolha visíveis recuperam pontos de vida iguais a 2d8 + seu modificador de conjuração. Sem efeito em mortos-vivos e construtos.',
 '+1d8 de cura por slot acima do 2º.',
 ARRAY['cleric']),

('Proteção contra Veneno', 'Protection from Poison', 2, 'abjuration', '1 ação', 'Toque', 'V, S', '1 hora', false, false,
 'Você toca uma criatura. Se ela estiver envenenada, você neutraliza o veneno. Se mais de um veneno a afetar, todos são neutralizados. Enquanto a magia durar, o alvo tem vantagem em testes de resistência contra ser envenenado e tem resistência a dano de veneno.',
 NULL,
 ARRAY['cleric', 'druid', 'paladin', 'ranger']),

('Raio de Fraqueza', 'Ray of Enfeeblement', 2, 'necromancy', '1 ação', '18 metros', 'V, S', 'Concentração, até 1 minuto', true, false,
 'Um raio negro aponta para uma criatura visível. Faça um ataque mágico à distância. Se acertar, o alvo causa apenas metade do dano com ataques com armas usando Força até a magia terminar. A criatura pode fazer um teste de resistência de Constituição no final de cada turno para encerrar o efeito.',
 NULL,
 ARRAY['warlock', 'wizard']),

('Raio Escaldante', 'Scorching Ray', 2, 'evocation', '1 ação', '36 metros', 'V, S', 'Instantâneo', false, false,
 'Você cria três raios de fogo e os dispara a um ou mais alvos dentro do alcance. Faça um ataque mágico à distância para cada raio. Se acertar, o alvo sofre 2d6 de dano de fogo.',
 '+1 raio por slot acima do 2º.',
 ARRAY['sorcerer', 'wizard']),

('Estilhaçar', 'Shatter', 2, 'evocation', '1 ação', '18 metros', 'V, S, M (fragmento de mica)', 'Instantâneo', false, false,
 'Um estrondo repentino e retumbante irrompe de um ponto de sua escolha. Cada criatura numa esfera de 3 metros centrada nesse ponto deve fazer um teste de Constituição, sofrendo 3d8 de dano de trovão se fracassar, ou metade se tiver êxito. Criaturas feitas de material inorgânico têm desvantagem. Objetos não mágicos também sofrem o dano.',
 '+1d8 de dano de trovão por slot acima do 2º.',
 ARRAY['bard', 'sorcerer', 'warlock', 'wizard']),

('Sugestão', 'Suggestion', 2, 'enchantment', '1 ação', '9 metros', 'V, M (língua de serpente e mel ou azeite)', 'Concentração, até 8 horas', true, false,
 'Você sugere um curso de ação a uma criatura visível capaz de ouvi-lo e entendê-lo. A sugestão deve ser formulada de modo a parecer razoável. A criatura faz um teste de resistência de Sabedoria ou segue o curso sugerido da melhor forma possível. A magia termina quando a tarefa for concluída.',
 NULL,
 ARRAY['bard', 'sorcerer', 'warlock', 'wizard']);
