-- ============================================================
-- PACOTE 3 — 2º Círculo restante (21) + 3º Círculo parcial (29) = 50
-- ============================================================

INSERT INTO spells (name, name_en, level, school, casting_time, range, components, duration, concentration, ritual, description, higher_levels, classes) VALUES

-- ── 2º CÍRCULO (continuação) ─────────────────────────────────

('Fechadura Arcana', 'Arcane Lock', 2, 'abjuration', '1 ação', 'Toque', 'V, S, M (ouro em pó no valor de 25 po, consumido pela magia)', 'Até ser dissipada', false, false,
 'Você toca uma porta, janela, portão, baú ou outra entrada fechável e ela se tranca magicamente. Você e as criaturas que você designar podem abri-la normalmente. Você também pode definir uma senha que suprima a magia por 1 minuto. Arrombamento ou abertura forçada requer um teste de Atletismo contra a CD de sua magia +10.',
 NULL,
 ARRAY['wizard']),

('Casca Rígida', 'Barkskin', 2, 'transmutation', '1 ação', 'Toque', 'V, S, M (punhado de casca de carvalho)', 'Concentração, até 1 hora', true, false,
 'Você toca uma criatura voluntária. Até a magia terminar, a pele do alvo fica rígida como madeira, e a CA do alvo não pode ser inferior a 16, independentemente do tipo de armadura que esteja usando.',
 NULL,
 ARRAY['druid', 'ranger']),

('Acalmar Emoções', 'Calm Emotions', 2, 'enchantment', '1 ação', '18 metros', 'V, S', 'Concentração, até 1 minuto', true, false,
 'Você tenta suprimir emoções fortes em um grupo de pessoas. Cada humanoide numa esfera de 6 metros centrada num ponto dentro do alcance deve fazer um teste de resistência de Carisma. Se fracassar, o alvo ficará indiferente a criaturas hostis e imune aos efeitos de medo e encantamento enquanto a magia durar.',
 NULL,
 ARRAY['bard', 'cleric']),

('Chama Contínua', 'Continual Flame', 2, 'evocation', '1 ação', 'Toque', 'V, S, M (rubi em pó no valor de 50 po, consumido pela magia)', 'Até ser dissipada', false, false,
 'Uma chama do tamanho de uma tocha brota de um objeto que você tocar. O efeito parece uma chama comum, mas não gera calor e não precisa de oxigênio para queimar. Uma chama contínua pode ser coberta ou oculta, mas não apagada.',
 NULL,
 ARRAY['cleric', 'wizard']),

('Entusiasmar', 'Enthrall', 2, 'enchantment', '1 ação', '18 metros', 'V, S', '1 minuto', false, false,
 'Você tece uma distrativa magia de palavras que faz criaturas te prestarem atenção. Cada criatura de sua escolha que possa ouvi-lo dentro do alcance faz um teste de resistência de Sabedoria. Se fracassar, terá desvantagem em testes de Percepção para perceber outros seres além de você.',
 NULL,
 ARRAY['bard', 'warlock']),

('Encontrar Corcel', 'Find Steed', 2, 'conjuration', '10 minutos', '9 metros', 'V, S', 'Instantâneo', false, false,
 'Você convoca um espírito que assume a forma de um corcel excepcionalmente inteligente, forte e leal, criando um vínculo duradouro. O animal aparece num espaço livre dentro do alcance. Escolha sua forma: cavalo de guerra, pônei, camelo, alce ou mastim. O corcel tem a inteligência de 6 e pode se comunicar com você em um idioma que você conheça.',
 NULL,
 ARRAY['paladin']),

('Lâmina de Chama', 'Flame Blade', 2, 'evocation', '1 ação bônus', 'Pessoal', 'V, S, M (folha de sumagre)', 'Concentração, até 10 minutos', true, false,
 'Você evoca uma lâmina de fogo em sua mão livre. Esta lâmina é semelhante a um cimitarra e dura pela duração. Você pode usar a lâmina para atacar corpo a corpo: ataque mágico, causando 3d6 de dano de fogo. A lâmina ilumina 3 metros de luz brilhante e mais 3 de penumbra.',
 '+1d6 de dano por slot acima do 4º (ou seja, slot 4 = 4d6, slot 6 = 5d6).',
 ARRAY['druid']),

('Repouso Gentil', 'Gentle Repose', 2, 'necromancy', '1 ação', 'Toque', 'V, S, M (uma pitada de sal e um moeda de cobre colocada em cada olho do cadáver)', '10 dias', false, true,
 'Você toca um cadáver ou outros restos mortais. Por 10 dias, o cadáver é protegido de decomposição e não pode se tornar morto-vivo. A magia também torna eficaz qualquer magia de ressurreição lançada no cadáver durante a duração da magia.',
 NULL,
 ARRAY['cleric', 'wizard']),

('Localizar Animais ou Plantas', 'Locate Animals or Plants', 2, 'divination', '1 ação', 'Pessoal', 'V, S, M (pelo de caçador)', '1 instantâneo', false, true,
 'Descrevendo ou nomeando uma espécie específica de animal ou planta, você percebe a direção e a distância do espécimen mais próximo de sua escolha, a até 8 km de você. Se houver vários espécimens do mesmo tipo, você sabe a localização do mais próximo.',
 NULL,
 ARRAY['bard', 'cleric', 'druid', 'ranger']),

('Localizar Objeto', 'Locate Object', 2, 'divination', '1 ação', 'Pessoal', 'V, S, M (forquilha bifurcada)', 'Concentração, até 10 minutos', true, false,
 'Descreva ou nomeie um objeto que seja familiar para você. Você percebe a direção do objeto, desde que esteja a até 300 metros. Se o objeto estiver em movimento, você sabe a direção. A magia é bloqueada por chumbo.',
 NULL,
 ARRAY['bard', 'cleric', 'druid', 'paladin', 'ranger', 'wizard']),

('Boca Mágica', 'Magic Mouth', 2, 'illusion', '1 minuto', '9 metros', 'V, S, M (mel de abelha e jade em pó no valor de 10 po, consumidos pela magia)', 'Até ser dissipada', false, true,
 'Você implanta uma mensagem dentro de um objeto num espaço visível. A mensagem é pronunciada quando uma condição de gatilho ocorrer. Pode ter até 25 palavras e até 10 minutos de fala. Uma boca espectral aparece no objeto ao falar.',
 NULL,
 ARRAY['bard', 'wizard']),

('Arma Mágica', 'Magic Weapon', 2, 'transmutation', '1 ação bônus', 'Toque', 'V, S', 'Concentração, até 1 hora', true, false,
 'Você toca uma arma não mágica. Até a magia terminar, ela se torna uma arma mágica com +1 nos testes de ataque e rolagens de dano.',
 'Com slot do 4º, o bônus passa para +2. Com slot do 6º ou superior, +3.',
 ARRAY['paladin', 'wizard']),

('Ver Invisibilidade', 'See Invisibility', 2, 'divination', '1 ação', 'Pessoal', 'V, S, M (uma pitada de talco e pó de prata)', '1 hora', false, false,
 'Por toda a duração desta magia, você vê criaturas e objetos invisíveis como se fossem visíveis, e você pode ver no Plano Etéreo, até 18 metros.',
 NULL,
 ARRAY['bard', 'sorcerer', 'wizard']),

('Silêncio', 'Silence', 2, 'illusion', '1 ação', '36 metros', 'V, S', 'Concentração, até 10 minutos', true, true,
 'Durante a duração desta magia, nenhum som pode ser criado dentro ou passar por uma esfera de 6 metros de raio centrada num ponto que você escolher. Qualquer criatura ou objeto inteiramente dentro da esfera fica imune ao dano sônico e surda. Lançar uma magia com componentes verbais é impossível lá dentro.',
 NULL,
 ARRAY['bard', 'cleric', 'ranger']),

('Escalar como Aranha', 'Spider Climb', 2, 'transmutation', '1 ação', 'Toque', 'V, S, M (uma gota de betume e uma aranha)', 'Concentração, até 1 hora', true, false,
 'Até a magia terminar, uma criatura voluntária que você tocar ganha a habilidade de se mover por superfícies verticais e tetos de cabeça para baixo, mantendo as mãos livres. A velocidade de escalada do alvo é igual à sua velocidade de caminhada.',
 NULL,
 ARRAY['druid', 'ranger', 'sorcerer', 'warlock', 'wizard']),

('Arma Espiritual', 'Spiritual Weapon', 2, 'evocation', '1 ação bônus', '18 metros', 'V, S', '1 minuto', false, false,
 'Você cria uma arma espectral flutuante no espaço de uma criatura visível. Como ação bônus, você pode mover a arma até 6 metros e realizar um ataque mágico corpo a corpo contra uma criatura a até 1,5 m dela, causando 1d8 + modificador de conjuração de dano de força.',
 '+1d8 de dano por dois slots acima do 2º (slot 4 = 2d8, slot 6 = 3d8).',
 ARRAY['cleric']),

('Vínculo Protetor', 'Warding Bond', 2, 'abjuration', '1 ação', 'Toque', 'V, S, M (par de anéis de platina no valor de 50 po cada, usados por você e pelo alvo)', '1 hora', false, false,
 'Você cria um vínculo de proteção com uma criatura voluntária que você tocar. Até a magia terminar, o alvo ganha +1 na CA e nos testes de resistência, e tem resistência a todos os tipos de dano. Mas cada vez que ele sofrer dano, você sofre a mesma quantidade.',
 NULL,
 ARRAY['cleric']),

('Teia', 'Web', 2, 'conjuration', '1 ação', '18 metros', 'V, S, M (fragmento de teia de aranha)', 'Concentração, até 1 hora', true, false,
 'Você conjura uma massa de teias espessas e adesivas num cubo de 6 metros a partir de um ponto dentro do alcance. Criaturas que comecem o turno na teia devem fazer um teste de Força ou ficarem restringidas. A teia é terreno difícil e pode ser incendiada.',
 NULL,
 ARRAY['sorcerer', 'wizard']),

('Zona da Verdade', 'Zone of Truth', 2, 'enchantment', '1 ação', '18 metros', 'V, S', '10 minutos', false, false,
 'Você cria uma zona mágica que protege contra enganação numa esfera de 4,5 metros de raio centrada num ponto dentro do alcance. Criaturas que entrem na área fazem um teste de resistência de Carisma. Se fracassarem, não podem mentir deliberadamente enquanto estiverem na área.',
 NULL,
 ARRAY['bard', 'cleric', 'paladin']),

('Aura Mágica de Nystul', 'Nystul''s Magic Aura', 2, 'illusion', '1 ação', 'Toque', 'V, S, M (um pedaço de seda coberto de ouro em pó no valor de 25 po)', '24 horas', false, false,
 'Você coloca uma ilusão num objeto ou criatura que você tocar para que detecções de magia apresentem informações falsas. Escolha um efeito: Falsa Aura (muda o que feitiços como Detectar Magia revelam) ou Máscara (faz a criatura parecer ser de outro tipo para efeitos mágicos de detecção).',
 NULL,
 ARRAY['wizard']),

('Truque da Corda', 'Rope Trick', 2, 'transmutation', '1 ação', 'Toque', 'V, S, M (pó de milho e um fragmento de casca de árvore torcida)', '1 hora', false, false,
 'Você toca uma corda de até 18 metros. Uma extremidade sobe no ar e a corda fica rígida na vertical. O topo da corda abre para um espaço extradimensional invisível que pode conter até oito criaturas de tamanho Médio. Criaturas lá dentro ficam invisíveis e imperceptíveis, e não podem ser alcançadas de fora.',
 NULL,
 ARRAY['wizard']),

-- ── 3º CÍRCULO ───────────────────────────────────────────────

('Animar Mortos', 'Animate Dead', 3, 'necromancy', '1 minuto', '3 metros', 'V, S, M (uma gota de sangue, um pedaço de carne e uma pitada de osso em pó)', 'Instantâneo', false, false,
 'Esta magia cria um servo morto-vivo. Escolha um montículo de ossos ou um cadáver de criatura humanoide de tamanho Médio ou Pequeno dentro do alcance. A magia o transforma em esqueleto (se ossos) ou zumbi (se cadáver). O morto-vivo obedece às suas ordens verbais. Você pode ter até quatro mortos-vivos ao mesmo tempo; criações extras substituem as mais antigas.',
 '+2 mortos-vivos por slot acima do 3º.',
 ARRAY['cleric', 'wizard']),

('Farol de Esperança', 'Beacon of Hope', 3, 'abjuration', '1 ação', '9 metros', 'V, S', 'Concentração, até 1 minuto', true, false,
 'Esta magia concede esperança e vitalidade. Escolha qualquer número de criaturas dentro do alcance. Até a magia terminar, cada alvo tem vantagem nos testes de resistência de Sabedoria e nos testes de morte, e recupera o máximo possível de pontos de vida de qualquer cura.',
 NULL,
 ARRAY['cleric']),

('Infligir Maldição', 'Bestow Curse', 3, 'necromancy', '1 ação', 'Toque', 'V, S', 'Concentração, até 1 minuto', true, false,
 'Você toca uma criatura, que deve fazer um teste de resistência de Sabedoria. Se fracassar, ficará amaldiçoada. Escolha um efeito: desvantagem em testes de habilidade de um atributo; desvantagem em ataques contra você; teste de Sabedoria CD sua ao iniciar cada turno ou perder a ação; +1d8 de dano necrótico em seus ataques contra o alvo.',
 'Com slot do 4º, duração sobe para 10 minutos (sem concentração); 5º = 8 horas; 7º ou mais = 24 horas.',
 ARRAY['bard', 'cleric', 'wizard']),

('Piscar', 'Blink', 3, 'transmutation', '1 ação', 'Pessoal', 'V, S', '1 minuto', false, false,
 'Role um d20 no final de cada um dos seus turnos. Com 11 ou mais, você desaparece deste plano de existência e aparece no Plano Etéreo. No início do seu próximo turno, você retorna ao mesmo espaço ou ao mais próximo disponível.',
 NULL,
 ARRAY['sorcerer', 'wizard']),

('Invocar Raio', 'Call Lightning', 3, 'conjuration', '1 ação', '36 metros', 'V, S', 'Concentração, até 10 minutos', true, false,
 'Uma nuvem de tempestade de 3 metros de espessura e 18 metros de raio aparece. Você pode usar uma ação para fazer um raio cair num ponto diretamente abaixo da nuvem. Cada criatura a 1,5 m do ponto faz um teste de Destreza, sofrendo 3d10 de dano de raio se fracassar ou metade se tiver êxito.',
 '+1d10 de dano por slot acima do 3º.',
 ARRAY['druid']),

('Clarividência', 'Clairvoyance', 3, 'divination', '10 minutos', '1,5 km', 'V, S, M (um pequeno corno e cristal no valor de 100 po)', 'Concentração, até 10 minutos', true, false,
 'Você cria um sensor invisível num local familiar ou em algum lugar óbvio a que você nunca foi. O sensor permanece pelo tempo da magia. Você pode olhar através do sensor como se estivesse lá e pode alternar entre visão e audição a qualquer momento.',
 NULL,
 ARRAY['bard', 'cleric', 'sorcerer', 'wizard']),

('Convocar Animais', 'Conjure Animals', 3, 'conjuration', '1 ação', '18 metros', 'V, S', 'Concentração, até 1 hora', true, false,
 'Você convoca espíritos feéricos que assumem a forma de animais e aparecem em espaços desocupados visíveis. Escolha uma opção: um animal CR 2 ou menor; dois animais CR 1 ou menor; quatro animais CR 1/2 ou menor; oito animais CR 1/4 ou menor. Os animais desaparecem quando chegam a 0 PV.',
 'Você pode invocar o dobro de animais por slot acima do 3º.',
 ARRAY['druid', 'ranger']),

('Contramagia', 'Counterspell', 3, 'abjuration', '1 reação, ao ver uma criatura a até 18 m lançar uma magia', '18 metros', 'S', 'Instantâneo', false, false,
 'Você tenta interromper uma criatura enquanto ela lança uma magia. Se a magia for de 3º círculo ou menor, ela falha automaticamente. Se for de 4º círculo ou superior, faça um teste de habilidade de conjuração CD 10 + o nível da magia. Se tiver êxito, a magia do alvo falha.',
 'Você cancela automaticamente magias de nível igual ou inferior ao slot usado.',
 ARRAY['sorcerer', 'warlock', 'wizard']),

('Luz do Dia', 'Daylight', 3, 'evocation', '1 ação', '18 metros', 'V, S', '1 hora', false, false,
 'Uma esfera de luz de 18 metros de raio irradia de um ponto que você escolher. A esfera ilumina completamente e suprime toda escuridão criada por magias de nível menor. Objetos com a magia ativa emitem a luz e podem ser cobertos para bloquear o brilho.',
 NULL,
 ARRAY['cleric', 'druid', 'paladin', 'ranger', 'sorcerer']),

('Dissipar Magia', 'Dispel Magic', 3, 'abjuration', '1 ação', '36 metros', 'V, S', 'Instantâneo', false, false,
 'Escolha uma criatura, objeto ou efeito mágico dentro do alcance. Qualquer magia de 3º círculo ou menor no alvo termina. Para cada magia de 4º círculo ou maior, faça um teste de habilidade de conjuração CD 10 + o nível da magia.',
 'Magias de nível igual ou inferior ao slot usado são automaticamente dissipadas.',
 ARRAY['bard', 'cleric', 'druid', 'paladin', 'sorcerer', 'warlock', 'wizard']),

('Medo', 'Fear', 3, 'illusion', '1 ação', 'Pessoal (cone de 9 metros)', 'V, S, M (pena branca ou ovo de galinha)', 'Concentração, até 1 minuto', true, false,
 'Você projeta uma imagem fantasmagórica dos piores medos de cada criatura num cone de 9 metros. Cada criatura na área faz um teste de resistência de Sabedoria. Se fracassar, ficará amedrontada pelo tempo da magia. Uma criatura amedrontada deve usar o turno para se afastar de você.',
 NULL,
 ARRAY['bard', 'sorcerer', 'warlock', 'wizard']),

('Bola de Fogo', 'Fireball', 3, 'evocation', '1 ação', '36 metros', 'V, S, M (uma minúscula bola de guano de morcego e enxofre)', 'Instantâneo', false, false,
 'Um ponto brilhante explode em um rugido de chamas. Cada criatura numa esfera de 6 metros de raio centrada no ponto escolhido deve fazer um teste de resistência de Destreza, sofrendo 8d6 de dano de fogo se fracassar ou metade se tiver êxito. O fogo se espalha por cantos.',
 '+1d6 de dano de fogo por slot acima do 3º.',
 ARRAY['sorcerer', 'wizard']),

('Voar', 'Fly', 3, 'transmutation', '1 ação', 'Toque', 'V, S, M (pena de pássaro)', 'Concentração, até 10 minutos', true, false,
 'Você toca uma criatura voluntária. O alvo ganha velocidade de voo de 18 metros pelo tempo da magia. Quando a magia terminar, o alvo cai se ainda estiver no ar, a menos que possa parar a queda.',
 'Uma criatura adicional por slot acima do 3º.',
 ARRAY['sorcerer', 'warlock', 'wizard']),

('Forma Gasosa', 'Gaseous Form', 3, 'transmutation', '1 ação', 'Toque', 'V, S, M (fragmento de gaze e fumaça)', 'Concentração, até 1 hora', true, false,
 'Você transforma uma criatura voluntária que tocar, juntamente com tudo que estiver carregando e usando, em uma nuvem gasosa mística. Nessa forma, o alvo tem velocidade de voo de 3 metros, pode passar por espaços minúsculos e tem resistência a dano não mágico. Não pode atacar nem lançar magias.',
 NULL,
 ARRAY['sorcerer', 'warlock', 'wizard']),

('Pressa', 'Haste', 3, 'transmutation', '1 ação', '9 metros', 'V, S, M (um fragmento de alcaçuz)', 'Concentração, até 1 minuto', true, false,
 'Escolha uma criatura voluntária visível. Até a magia terminar, a velocidade do alvo dobra, ele ganha +2 na CA, tem vantagem nos testes de resistência de Destreza e ganha uma ação adicional a cada turno (apenas Atacar com uma arma, Correr, Desengajar, Esconder ou Usar Objeto). Quando a magia terminar, o alvo fica letárgico e não pode se mover ou agir até seu próximo turno.',
 NULL,
 ARRAY['sorcerer', 'wizard']),

('Fome de Hadar', 'Hunger of Hadar', 3, 'conjuration', '1 ação', '45 metros', 'V, S, M (tentáculo em conserva)', 'Concentração, até 1 minuto', true, false,
 'Você abre um portal para o espaço entre estrelas, um lugar de escuridão onde entidades inexplicáveis vagam. Uma esfera de 6 metros de raio de trevas e sons incessantes surge centrada num ponto dentro do alcance. Criaturas que comecem o turno lá sofrendo 2d6 de dano de frio; criaturas que terminarem o turno lá devem fazer um teste de Destreza ou sofrer 2d6 de dano de ácido.',
 NULL,
 ARRAY['warlock']),

('Padrão Hipnótico', 'Hypnotic Pattern', 3, 'illusion', '1 ação', '36 metros', 'V, S, M (bastão de incenso ou um cristal cintilante)', 'Concentração, até 1 minuto', true, false,
 'Você cria um padrão sinuoso de cores cintilantes num cubo de 9 metros dentro do alcance. Cada criatura que ver o padrão deve fazer um teste de Sabedoria ou ficará enfeitiçada. Uma criatura enfeitiçada fica incapacitada e com velocidade 0. O efeito termina se a criatura for sacudida ou sofrer dano.',
 NULL,
 ARRAY['bard', 'sorcerer', 'warlock', 'wizard']),

('Raio', 'Lightning Bolt', 3, 'evocation', '1 ação', 'Pessoal (linha de 30 metros)', 'V, S, M (pelo de pele de roedores e um cristal de vidro)', 'Instantâneo', false, false,
 'Um raio de relâmpago forma uma linha de 30 metros de comprimento e 1,5 metro de largura saindo de você. Cada criatura na linha deve fazer um teste de resistência de Destreza, sofrendo 8d6 de dano de raio se fracassar, ou metade se tiver êxito. O raio incendeia objetos flamáveis que não estejam sendo carregados.',
 '+1d6 de dano de raio por slot acima do 3º.',
 ARRAY['sorcerer', 'wizard']),

('Palavra de Cura em Massa', 'Mass Healing Word', 3, 'evocation', '1 ação bônus', '18 metros', 'V', 'Instantâneo', false, false,
 'Enquanto pronuncia palavras de restauração, até seis criaturas visíveis de sua escolha dentro do alcance recuperam pontos de vida iguais a 1d4 + seu modificador de habilidade de conjuração. Sem efeito em mortos-vivos e construtos.',
 '+1d4 de cura por slot acima do 3º.',
 ARRAY['cleric']),

('Crescimento de Plantas', 'Plant Growth', 3, 'transmutation', '1 ação ou 8 horas', '45 metros', 'V, S', 'Instantâneo', false, false,
 'Esta magia canaliza magia vital para as plantas. Com uma ação: numa área de 30 metros de raio, toda vegetação fica densamente emaranhada, tornando o terreno extremamente difícil. Com 8 horas de conjuração: fertiliza a terra para um raio de 800 metros, rendendo o dobro da colheita normal por 1 ano.',
 NULL,
 ARRAY['bard', 'druid', 'ranger']),

('Proteção contra Energia', 'Protection from Energy', 3, 'abjuration', '1 ação', 'Toque', 'V, S', 'Concentração, até 1 hora', true, false,
 'Por toda a duração desta magia, a criatura voluntária que você tocar tem resistência a um tipo de dano de sua escolha: ácido, fogo, frio, raio ou trovão.',
 NULL,
 ARRAY['cleric', 'druid', 'ranger', 'sorcerer', 'wizard']),

('Remover Maldição', 'Remove Curse', 3, 'abjuration', '1 ação', 'Toque', 'V, S', 'Instantâneo', false, false,
 'Com um toque, você encerra todas as maldições que afetam uma criatura ou objeto. Se o objeto for uma arma ou escudo amaldiçoado, a maldição permanece, mas a magia quebra o vínculo de atunamento entre o portador e o item, permitindo que seja descartado.',
 NULL,
 ARRAY['cleric', 'paladin', 'warlock', 'wizard']),

('Reviver', 'Revivify', 3, 'necromancy', '1 ação', 'Toque', 'V, S, M (diamante no valor de 300 po, consumido pela magia)', 'Instantâneo', false, false,
 'Você toca uma criatura que morreu no último minuto. Ela retorna à vida com 1 ponto de vida. Esta magia não pode ressuscitar uma criatura morta por velhice, nem restaurar partes do corpo que estiverem faltando.',
 NULL,
 ARRAY['cleric', 'druid', 'paladin']),

('Guardiões Espirituais', 'Spirit Guardians', 3, 'conjuration', '1 ação', 'Pessoal (raio de 4,5 metros)', 'V, S, M (um símbolo sagrado)', 'Concentração, até 10 minutos', true, false,
 'Você invoca espíritos para protegê-lo. Eles ficam ao seu redor num raio de 4,5 metros. Criaturas hostis que entrem ou comecem o turno na área fazem um teste de Sabedoria, sofrendo 3d8 de dano radiante (ou necrótico) se fracassarem ou metade se tiverem êxito. A área é terreno difícil para elas.',
 '+1d8 de dano por slot acima do 3º.',
 ARRAY['cleric']),

('Toque Vampírico', 'Vampiric Touch', 3, 'necromancy', '1 ação', 'Pessoal', 'V, S', 'Concentração, até 1 minuto', true, false,
 'A magia lhe dá um toque que drena vida. Faça um ataque mágico corpo a corpo. Se acertar, o alvo sofre 3d6 de dano necrótico e você recupera pontos de vida iguais à metade do dano causado. Você pode usar o ataque novamente a cada turno enquanto a magia durar.',
 '+1d6 de dano necrótico por slot acima do 3º.',
 ARRAY['warlock', 'wizard']);
