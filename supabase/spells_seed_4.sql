-- ============================================================
-- PACOTE 4 — 3º Círculo restante (15) + 4º Círculo (30) + 5º Círculo início (5) = 50
-- ============================================================

INSERT INTO spells (name, name_en, level, school, casting_time, range, components, duration, concentration, ritual, description, higher_levels, classes) VALUES

-- ── 3º CÍRCULO (continuação) ─────────────────────────────────

('Criar Comida e Água', 'Create Food and Water', 3, 'conjuration', '1 ação', '9 metros', 'V, S', 'Instantâneo', false, false,
 'Você cria 45 kg de alimento e 100 litros de água no solo ou em recipientes dentro do alcance, o suficiente para sustentar até quinze humanoides ou cinco montarias por 24 horas. O alimento é insosso, mas nutritivo; ele apodrece se não consumido num dia.',
 NULL,
 ARRAY['cleric', 'paladin']),

('Glifo de Proteção', 'Glyph of Warding', 3, 'abjuration', '1 hora', 'Toque', 'V, S, M (incenso e pó de diamante no valor de 200 po, consumidos)', 'Até ser ativado ou dissipado', false, false,
 'Você inscreve um glifo num objeto ou superfície. Escolha um tipo: Glifo Explosivo (3d8 de dano de ácido, frio, fogo, raio ou trovão, teste de Destreza) ou Glifo de Magia (armazena uma magia de até 3º círculo que é lançada no gatilho). Quando a condição que você definir for cumprida, o glifo se ativa.',
 'O dano do Glifo Explosivo aumenta +1d8 e o círculo máximo armazenado +1 por slot acima do 3º.',
 ARRAY['bard', 'cleric', 'wizard']),

('Círculo Mágico', 'Magic Circle', 3, 'abjuration', '1 minuto', '3 metros', 'V, S, M (sal bento, pó de ferro e pó de safira no valor de 100 po, consumidos)', '1 hora', false, false,
 'Você cria um cilindro mágico de 3 metros de raio e 6 metros de altura centrado num ponto no chão. Escolha um ou mais tipos de criaturas: celestiais, elementais, fadas, demônios ou mortos-vivos. Esse tipo não pode entrar no cilindro voluntariamente, não pode encantar, amedrontar ou possuir criaturas lá dentro.',
 '+1 hora de duração por slot acima do 3º.',
 ARRAY['cleric', 'paladin', 'warlock', 'wizard']),

('Imagem Maior', 'Major Image', 3, 'illusion', '1 ação', '36 metros', 'V, S, M (fragmento de lã de carneiro)', 'Concentração, até 10 minutos', true, false,
 'Você cria a imagem de um objeto, criatura ou fenômeno com até 6 metros de cubo. A imagem inclui som, cheiro e temperatura. Criaturas que interagem fisicamente com ela percebem que é ilusória com um teste de Inteligência (Investigação) bem-sucedido contra a CD de sua magia.',
 'Com slot do 6º ou superior, a magia dura sem concentração.',
 ARRAY['bard', 'sorcerer', 'warlock', 'wizard']),

('Não Detecção', 'Nondetection', 3, 'abjuration', '1 ação', 'Toque', 'V, S, M (uma pitada de diamante em pó no valor de 25 po polvilhada no alvo)', '8 horas', false, false,
 'Por toda a duração, você esconde um alvo que toca de magia de adivinhação. O alvo pode ser uma criatura, local ou objeto. Ele não pode ser alvo de magia de adivinhação nem percebido por sensores mágicos.',
 NULL,
 ARRAY['bard', 'ranger', 'wizard']),

('Envio', 'Sending', 3, 'evocation', '1 ação', 'Ilimitado', 'V, S, M (um pedaço fino de fio de cobre)', '1 rodada', false, false,
 'Você envia uma curta mensagem de até 25 palavras a uma criatura com quem seja familiar. A criatura ouve a mensagem e pode responder da mesma forma. Você pode enviar a mensagem entre planos de existência.',
 NULL,
 ARRAY['bard', 'cleric', 'wizard']),

('Tempestade de Granizo', 'Sleet Storm', 3, 'conjuration', '1 ação', '45 metros', 'V, S, M (pó de mica e pó de poeira)', 'Concentração, até 1 minuto', true, false,
 'Até a magia terminar, granizo e chuva congelante caem num cilindro de 12 metros de raio e 6 metros de altura centrado num ponto dentro do alcance. A área fica totalmente obscurecida e o terreno se torna difícil. Criaturas que se movam na área devem ter êxito num teste de Destreza ou cair prostradas.',
 NULL,
 ARRAY['druid', 'sorcerer', 'wizard']),

('Desacelerar', 'Slow', 3, 'transmutation', '1 ação', '36 metros', 'V, S, M (melado de cana de açúcar)', 'Concentração, até 1 minuto', true, false,
 'Você altera o tempo ao redor de até seis criaturas visíveis num cubo de 12 metros. Cada alvo faz um teste de Sabedoria. Se fracassar: velocidade cortada à metade, -2 na CA e nos testes de Destreza, não pode usar reações, pode tomar apenas uma ação ou ação bônus (não ambas). A criatura pode repetir o teste no final de cada turno.',
 NULL,
 ARRAY['sorcerer', 'wizard']),

('Falar com Mortos', 'Speak with Dead', 3, 'necromancy', '1 ação', '3 metros', 'V, S, M (incenso em chamas)', '10 minutos', false, false,
 'Você concede aos restos mortais de um cadáver (com boca) a semblância de vida e inteligência, permitindo-lhe responder a perguntas. O cadáver pode responder cinco perguntas. Não está obrigado a revelar informações e pode ser evasivo. Não pode responder o que não sabia em vida.',
 NULL,
 ARRAY['bard', 'cleric']),

('Falar com Plantas', 'Speak with Plants', 3, 'transmutation', '1 ação', 'Pessoal (raio de 9 metros)', 'V, S', '10 minutos', false, false,
 'Você imbuiu plantas dentro do alcance com uma consciência limitada, permitindo que se comuniquem com você. Você pode questionar plantas sobre eventos nos últimos dia no local, convencê-las a abrir passagem ou dificultar o terreno para perseguidores.',
 NULL,
 ARRAY['bard', 'druid', 'ranger']),

('Nuvem Fétida', 'Stinking Cloud', 3, 'conjuration', '1 ação', '27 metros', 'V, S, M (ovo podre ou vários skunks mortos)', 'Concentração, até 1 minuto', true, false,
 'Você cria uma nuvem de gás amarelo-esverdeado fedorento numa esfera de 6 metros de raio centrada num ponto dentro do alcance. A área fica fortemente obscurecida. Criaturas que comecem o turno na nuvem devem fazer um teste de Constituição ou ficarem enjoadas até o início do próximo turno.',
 NULL,
 ARRAY['bard', 'sorcerer', 'wizard']),

('Línguas', 'Tongues', 3, 'divination', '1 ação', 'Toque', 'V, M (miniatura de zigurate de argila)', '1 hora', false, false,
 'Esta magia concede à criatura que você toca a capacidade de entender qualquer idioma falado que ouça. Além disso, quando a criatura fala, qualquer criatura que conheça pelo menos um idioma que ouça a compreende.',
 NULL,
 ARRAY['bard', 'cleric', 'sorcerer', 'warlock', 'wizard']),

('Respirar na Água', 'Water Breathing', 3, 'transmutation', '1 ação', '9 metros', 'V, S, M (junco curto de cana ou palha)', '24 horas', false, true,
 'Esta magia concede a até dez criaturas voluntárias visíveis dentro do alcance a capacidade de respirar na água até a magia terminar. As criaturas afetadas também retêm a capacidade de respirar no ar.',
 NULL,
 ARRAY['druid', 'ranger', 'sorcerer', 'wizard']),

('Caminhar nas Águas', 'Water Walk', 3, 'transmutation', '1 ação', '9 metros', 'V, S, M (pedaço de cortiça)', '1 hora', false, true,
 'Esta magia concede a capacidade de mover-se sobre qualquer superfície líquida — como água, ácido, lama, neve, areia movediça ou lava — como se fosse terreno sólido (criaturas sobre lava ainda sofrem dano de calor). Até dez criaturas voluntárias dentro do alcance ganham este benefício.',
 NULL,
 ARRAY['cleric', 'druid', 'ranger', 'sorcerer']),

('Parede de Vento', 'Wind Wall', 3, 'evocation', '1 ação', '36 metros', 'V, S, M (um pequeno leque e uma pena exótica)', 'Concentração, até 1 minuto', true, false,
 'Uma parede de vento forte surge do chão num ponto visível dentro do alcance. A parede pode ter até 15 metros de comprimento, 4,5 metros de altura e 30 cm de espessura. Criaturas na área sofrem 3d8 de dano de contusão (Força para metade). Projéteis e objetos leves são desviados; gases e névoas são dispersos.',
 NULL,
 ARRAY['druid', 'ranger']),

-- ── 4º CÍRCULO ───────────────────────────────────────────────

('Olho Arcano', 'Arcane Eye', 4, 'divination', '1 ação', '9 metros', 'V, S, M (pelo de morcego)', 'Concentração, até 1 hora', true, false,
 'Você cria um olho mágico invisível num ponto visível que flutua pelo ar. Como ação, você pode mover o olho até 9 metros em qualquer direção. O olho vê em todas as direções com visão no escuro até 18 metros. Você pode ver o que o olho vê durante a magia.',
 NULL,
 ARRAY['wizard']),

('Banimento', 'Banishment', 4, 'abjuration', '1 ação', '18 metros', 'V, S, M (item que repugna o alvo)', 'Concentração, até 1 minuto', true, false,
 'Você tenta enviar uma criatura visível a outro plano de existência. O alvo faz um teste de resistência de Carisma. Se fracassar, será banido. Se for nativo deste plano, ficará incapacitado num espaço extradimensional até a magia terminar, retornando então ao espaço original. Criaturas de outros planos são enviadas de volta ao seu plano de origem.',
 'Uma criatura adicional por slot acima do 4º.',
 ARRAY['cleric', 'paladin', 'sorcerer', 'warlock', 'wizard']),

('Praga', 'Blight', 4, 'necromancy', '1 ação', '9 metros', 'V, S', 'Instantâneo', false, false,
 'Energia necrótica envolve e consome uma criatura visível. O alvo faz um teste de resistência de Constituição, sofrendo 8d8 de dano necrótico se fracassar ou metade se tiver êxito. Plantas e criaturas do tipo Planta têm desvantagem no teste e sofrem o máximo de dano.',
 '+1d8 de dano necrótico por slot acima do 4º.',
 ARRAY['druid', 'sorcerer', 'warlock', 'wizard']),

('Compulsão', 'Compulsion', 4, 'enchantment', '1 ação', '9 metros', 'V, S', 'Concentração, até 1 minuto', true, false,
 'Criaturas de sua escolha que você possa ver dentro do alcance devem fazer um teste de resistência de Sabedoria. Um alvo que fracassar fica afetado por esta magia. Você pode usar uma ação bônus para designar uma direção. Cada alvo afetado deve usar o máximo de movimento possível em direção à direção designada no próximo turno.',
 NULL,
 ARRAY['bard']),

('Confusão', 'Confusion', 4, 'enchantment', '1 ação', '27 metros', 'V, S, M (três nozes em casca)', 'Concentração, até 1 minuto', true, false,
 'Esta magia ataca a mente de uma ou mais criaturas, criando imagens ilusórias e turvando o raciocínio. Cada criatura numa esfera de 3 metros de raio centrada num ponto que você escolher deve fazer um teste de Sabedoria. Se fracassar, fica confusa: age de forma aleatória a cada turno (role d10: 1 = nada; 2-6 = anda aleatoriamente; 7-8 = ataca criatura mais próxima; 9-10 = age normalmente).',
 '+1 metro de raio por slot acima do 4º.',
 ARRAY['bard', 'druid', 'sorcerer', 'wizard']),

('Convocar Elementais Menores', 'Conjure Minor Elementals', 4, 'conjuration', '1 minuto', '27 metros', 'V, S', 'Concentração, até 1 hora', true, false,
 'Você convoca elementais que aparecem em espaços desocupados que você possa ver. Escolha uma opção: um elemental CR 2 ou menor; dois elementais CR 1 ou menor; quatro elementais CR 1/2 ou menor; oito elementais CR 1/4 ou menor. Cada elemental obedece às suas ordens verbais.',
 'Você pode convocar o dobro de elementais por slot acima do 4º.',
 ARRAY['druid', 'wizard']),

('Controlar Água', 'Control Water', 4, 'transmutation', '1 ação', '90 metros', 'V, S, M (gota de água e uma pitada de pó)', 'Concentração, até 10 minutos', true, false,
 'Até a magia terminar, você controla água em qualquer formato num cubo de 30 metros. Escolha um efeito: Cheia (eleva o nível da água); Redirecionar o Fluxo (muda a direção de correnteza); Vórtice (cria redemoinho de 9 m de raio); Dividir (abre passagem pelo meio de corpos d''água).',
 NULL,
 ARRAY['cleric', 'druid', 'wizard']),

('Barreira contra a Morte', 'Death Ward', 4, 'abjuration', '1 ação', 'Toque', 'V, S', '8 horas', false, false,
 'Você toca uma criatura e lhe concede certa proteção contra a morte. Na primeira vez que o alvo seria reduzido a 0 PV por dano, ele em vez disso cai para 1 PV e a magia termina. Alternativamente, se o alvo for sujeito a um efeito que o mataria instantaneamente sem causar dano, o efeito é ignorado e a magia termina.',
 NULL,
 ARRAY['cleric', 'paladin']),

('Porta Dimensional', 'Dimension Door', 4, 'conjuration', '1 ação', '500 metros', 'V', 'Instantâneo', false, false,
 'Você se teleporta de seu local atual para qualquer local dentro do alcance. Você chega exatamente ao local desejado ou, se o espaço estiver ocupado, num espaço adjacente. Você pode trazer uma criatura voluntária de tamanho Médio ou menor que esteja a até 1,5 m de você.',
 NULL,
 ARRAY['bard', 'sorcerer', 'warlock', 'wizard']),

('Adivinhação', 'Divination', 4, 'divination', '1 ação', 'Pessoal', 'V, S, M (incenso e oferenda no valor de 25 po, consumidos)', 'Instantâneo', false, true,
 'Seu magia e uma oferenda colocam você em contato com um deus ou um emissário divino. Você faz uma única pergunta sobre um objetivo, evento ou atividade específica a ocorrer nos próximos 7 dias. O MJ oferece um presságio verdadeiro na forma de uma frase curta, um verso críptico ou um presságio.',
 NULL,
 ARRAY['cleric']),

('Dominar Besta', 'Dominate Beast', 4, 'enchantment', '1 ação', '18 metros', 'V, S', 'Concentração, até 1 minuto', true, false,
 'Você tenta dobrar a vontade de uma besta visível. A criatura faz um teste de Sabedoria. Se fracassar, ficará encantada; você tem um vínculo telepático com ela enquanto estiver no mesmo plano. Pode emitir comandos (sem ação), e ela age de acordo.',
 'Duração aumenta: slot 5 = 10 minutos; slot 6 = 1 hora; slot 7 = 8 horas.',
 ARRAY['druid', 'ranger', 'sorcerer']),

('Escudo de Fogo', 'Fire Shield', 4, 'evocation', '1 ação', 'Pessoal', 'V, S, M (um pouco de fósforo ou de vaga-lume)', '10 minutos', false, false,
 'Chamas delgadas envolvem seu corpo, emitindo luz brilhante num raio de 3 metros. Escolha escudo quente (resistência a frio) ou escudo frio (resistência a fogo). Quando uma criatura a até 1,5 m atacar você em combate corpo a corpo, o escudo emite uma explosão de chamas causando 2d8 de dano de fogo (quente) ou de frio.',
 NULL,
 ARRAY['wizard']),

('Liberdade de Movimento', 'Freedom of Movement', 4, 'abjuration', '1 ação', 'Toque', 'V, S, M (um pedaço de couro curtido)', '1 hora', false, false,
 'Você toca uma criatura voluntária. Até a magia terminar, o movimento do alvo não é afetado por terreno difícil mágico ou não mágico. Magias e outros efeitos mágicos não podem reduzir sua velocidade ou fazê-la ficar paralisada ou restrita. O alvo pode gastar 1,5 m de movimento para escapar de restrições não mágicas.',
 NULL,
 ARRAY['bard', 'cleric', 'druid', 'ranger']),

('Inseto Gigante', 'Giant Insect', 4, 'transmutation', '1 ação', '9 metros', 'V, S', 'Concentração, até 10 minutos', true, false,
 'Você transforma até dez besouros, três vespas, cinco centopeias ou um escorpião dentro do alcance em versões gigantes por toda a duração. Um besouro gigante tem as estatísticas de um besouro gigante, e assim por diante. Você pode usar uma ação bônus para comandar os insetos mentalmente.',
 NULL,
 ARRAY['druid']),

('Invisibilidade Superior', 'Greater Invisibility', 4, 'illusion', '1 ação', 'Toque', 'V, S', 'Concentração, até 1 minuto', true, false,
 'Você ou uma criatura que você tocar ficam invisíveis até a magia terminar. Qualquer coisa que o alvo use ou carregue também fica invisível. Ao contrário de Invisibilidade, esta versão não termina quando o alvo ataca ou lança uma magia.',
 NULL,
 ARRAY['bard', 'sorcerer', 'wizard']),

('Guardião da Fé', 'Guardian of Faith', 4, 'conjuration', '1 ação', '9 metros', 'V', '8 horas', false, false,
 'Um guardião espectral grande de forma vagamente humanoide aparece num espaço desocupado de sua escolha visível. Qualquer criatura hostil que se mova para um espaço a até 1,5 m do guardião deve ser bem-sucedida num teste de resistência de Destreza. Se fracassar, sofre 20 de dano radiante ou necrótico (sua escolha). Após causar 60 de dano total, a magia termina.',
 NULL,
 ARRAY['cleric']),

('Tempestade de Gelo', 'Ice Storm', 4, 'evocation', '1 ação', '90 metros', 'V, S, M (um pouco de pó de quartzo e água)', 'Instantâneo', false, false,
 'Granizo do tamanho de punho vem de cima num cilindro de 6 metros de raio e 12 metros de altura centrado num ponto dentro do alcance. Cada criatura na área faz um teste de Destreza, sofrendo 2d8 de dano de contusão e 4d6 de dano de frio se fracassar, ou metade se tiver êxito. O terreno coberto pela tempestade fica difícil até o final do próximo turno.',
 '+1d8 de dano de contusão por slot acima do 4º.',
 ARRAY['druid', 'sorcerer', 'wizard']),

('Localizar Criatura', 'Locate Creature', 4, 'divination', '1 ação', 'Pessoal', 'V, S, M (pelo do animal ou criatura que você busca)', 'Concentração, até 1 hora', true, false,
 'Você percebe a direção da criatura mais próxima de um tipo específico a até 300 metros, desde que não haja água corrente entre vocês. Se você descrever um indivíduo, a magia funciona apenas para aquela criatura.',
 NULL,
 ARRAY['bard', 'cleric', 'druid', 'paladin', 'ranger', 'wizard']),

('Polimorfar', 'Polymorph', 4, 'transmutation', '1 ação', '18 metros', 'V, S, M (lagarta-casulo)', 'Concentração, até 1 hora', true, false,
 'Esta magia transforma uma criatura visível em uma nova forma. Uma criatura involuntária faz um teste de Sabedoria para resistir. A transformação dura até a magia terminar ou o alvo chegar a 0 PV. A nova forma não pode ter CR maior do que o nível do alvo. Equipamentos são absorvidos ou caem.',
 NULL,
 ARRAY['bard', 'druid', 'sorcerer', 'wizard']),

('Moldar Pedra', 'Stone Shape', 4, 'transmutation', '1 ação', 'Toque', 'V, S, M (argila mole, que deve tomar a forma que a pedra vai assumir)', 'Instantâneo', false, false,
 'Você toca um objeto de pedra de tamanho Médio ou menor ou uma seção de pedra que não seja maior que 1,5 m em qualquer dimensão e a molda em qualquer forma que você desejar. Por exemplo, você pode moldar uma pedra em arma, ídolo ou caixão. A pedra moldada pode ter até dois encaixes ou dobradiças.',
 NULL,
 ARRAY['cleric', 'druid', 'wizard']),

('Pele de Pedra', 'Stoneskin', 4, 'abjuration', '1 ação', 'Toque', 'V, S, M (pó de diamante no valor de 100 po, consumido pela magia)', 'Concentração, até 1 hora', true, false,
 'Esta magia torna a carne do alvo voluntário duro como pedra. Até a magia terminar, o alvo tem resistência a dano não mágico de corte, contusão e perfuração.',
 NULL,
 ARRAY['druid', 'ranger', 'sorcerer', 'wizard']),

('Parede de Fogo', 'Wall of Fire', 4, 'evocation', '1 ação', '36 metros', 'V, S, M (um pequeno pedaço de fósforo)', 'Concentração, até 1 minuto', true, false,
 'Você cria uma parede de fogo num plano sólido dentro do alcance. A parede pode ter até 18 metros de comprimento, 1,5 metro de espessura e 6 metros de altura, ou um anel de até 6 metros de diâmetro e 6 metros de altura. A parede bloqueia visão. Criaturas que entrarem ou começarem o turno no lado escolhido sofrem 5d8 de dano de fogo.',
 '+1d8 de dano de fogo por slot acima do 4º.',
 ARRAY['druid', 'sorcerer', 'wizard']),

-- ── 5º CÍRCULO (início) ──────────────────────────────────────

('Animar Objetos', 'Animate Objects', 5, 'transmutation', '1 ação', '36 metros', 'V, S', 'Concentração, até 1 minuto', true, false,
 'Objetos ganham vida sob seu comando. Escolha até dez objetos não mágicos dentro do alcance que não estejam sendo carregados ou usados. Alvos Miúdos contam como 1; Pequenos contam como 2; Médios contam como 4; Grandes contam como 8. Os objetos animados usam as estatísticas de objetos animados do tipo correspondente e obedecem às suas ordens verbais.',
 '+2 objetos animados por slot acima do 5º.',
 ARRAY['bard', 'sorcerer', 'wizard']),

('Escudo Antivida', 'Antilife Shell', 5, 'abjuration', '1 ação', 'Pessoal (raio de 3 metros)', 'V, S', 'Concentração, até 1 hora', true, false,
 'Um escudo cintilante se estende de você num raio de 3 metros, impedindo que animais, bestas, fadas, humanoides, mortos-vivos e outras criaturas vivas entrem na área. Criaturas afetadas não podem se mover para o interior da barreira. Elas podem usar ações, ataques ou magias à distância a partir de fora.',
 NULL,
 ARRAY['druid']),

('Mão Arcana', 'Arcane Hand', 5, 'evocation', '1 ação', '36 metros', 'V, S, M (casca de luva)', 'Concentração, até 1 minuto', true, false,
 'Você cria uma mão enorme brilhante de força mágica. A mão tem CA 20, PV iguais ao seu máximo e Força 26. Escolha um dos seguintes efeitos como ação bônus: Mão Agarradora (agarra e restringe um alvo); Mão Bloqueadora (+4 CA contra ataques de um lado); Mão Empurradora (empurra alvo 1,5 m); Mão Esmagadora (3d6 de dano por rodada em alvo agarrado).',
 'Causa +2d6 de dano adicional por slot acima do 5º.',
 ARRAY['wizard']),

('Despertar', 'Awaken', 5, 'transmutation', '8 horas', 'Toque', 'V, S, M (ágata no valor de 1.000 po, consumida pela magia)', 'Instantâneo', false, false,
 'Após gastar o tempo de conjuração encantando uma besta ou planta, você toca a criatura. Se ela tiver Inteligência 3 ou menor, sua Inteligência se torna 10. A criatura também ganha a habilidade de falar um idioma que você conheça. O alvo fica encantado por você por 30 dias ou até ser prejudicado por você ou seus companheiros.',
 NULL,
 ARRAY['bard', 'druid']),

('Nuvem Mortal', 'Cloudkill', 5, 'conjuration', '1 ação', '36 metros', 'V, S', 'Concentração, até 10 minutos', true, false,
 'Você cria uma esfera de névoa verde-amarelada venenosa de 6 metros de raio. A névoa se espalha por cantos e fortemente obscurece a área. Criaturas que comecem o turno na névoa fazem um teste de Constituição, sofrendo 5d8 de dano de veneno se fracassarem ou metade se tiverem êxito. A nuvem se move 3 metros para longe de você no início de cada turno.',
 '+1d8 de dano de veneno por slot acima do 5º.',
 ARRAY['sorcerer', 'wizard']);
