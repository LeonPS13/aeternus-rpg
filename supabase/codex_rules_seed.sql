-- =============================================================
-- CODEX — REGRAS SRD (D&D 5e SRD, CC BY 4.0)
-- Rodar no SQL Editor do Supabase (tabela codex já deve existir)
-- =============================================================

-- ──────────────────────────────────────────────────────────────
-- CONDIÇÕES
-- subtype = 'condition'
-- data: { effects: string[], original_name: string }
-- Exaustão usa data: { levels: [{level, effect}], original_name }
-- ──────────────────────────────────────────────────────────────

INSERT INTO codex (name, type, subtype, description, data) VALUES

('Cego', 'rule', 'condition',
 'Não pode ver; falha automaticamente em testes que exijam visão. Ataques contra ela têm vantagem; os dela têm desvantagem.',
 '{"effects":["Não pode ver; falha automaticamente em testes que exijam visão.","Jogadas de ataque contra a criatura têm vantagem.","As jogadas de ataque da criatura têm desvantagem."],"original_name":"Blinded"}'),

('Encantado', 'rule', 'condition',
 'Não pode atacar o encantador. O encantador tem vantagem em testes de habilidade para interagir socialmente com a criatura.',
 '{"effects":["Não pode atacar o encantador nem alvejá-lo com habilidades ou efeitos mágicos prejudiciais.","O encantador tem vantagem em quaisquer testes de habilidade para interagir socialmente com a criatura."],"original_name":"Charmed"}'),

('Ensurdecido', 'rule', 'condition',
 'Não pode ouvir; falha automaticamente em testes que exijam audição.',
 '{"effects":["Não pode ouvir; falha automaticamente em testes que exijam audição."],"original_name":"Deafened"}'),

('Exaustão', 'rule', 'condition',
 'Condição cumulativa com 6 níveis. Cada nível adiciona um penalizador. Um descanso longo reduz o nível em 1 (se comeu e bebeu). Nível 6 = morte.',
 '{"levels":[{"level":1,"effect":"Desvantagem em testes de habilidade"},{"level":2,"effect":"Velocidade reduzida à metade"},{"level":3,"effect":"Desvantagem em jogadas de ataque e testes de salvaguarda"},{"level":4,"effect":"Pontos de vida máximos reduzidos à metade"},{"level":5,"effect":"Velocidade reduzida a 0"},{"level":6,"effect":"Morte"}],"original_name":"Exhaustion"}'),

('Amedrontado', 'rule', 'condition',
 'Desvantagem em testes e ataques enquanto a fonte do medo estiver na linha de visão. Não pode se mover em direção à fonte do medo.',
 '{"effects":["Desvantagem em testes de habilidade e jogadas de ataque enquanto a fonte do medo estiver na linha de visão.","Não pode se mover voluntariamente em direção à fonte do medo."],"original_name":"Frightened"}'),

('Agarrado', 'rule', 'condition',
 'Velocidade se torna 0. Termina se o agarrador ficar incapacitado ou se um efeito remover a criatura do alcance.',
 '{"effects":["Velocidade se torna 0; não pode se beneficiar de bônus à velocidade.","A condição termina se o agarrador ficar incapacitado.","A condição termina se um efeito remover a criatura do alcance do agarrador."],"original_name":"Grappled"}'),

('Incapacitado', 'rule', 'condition',
 'Não pode realizar ações nem reações.',
 '{"effects":["Não pode realizar ações nem reações."],"original_name":"Incapacitated"}'),

('Invisível', 'rule', 'condition',
 'Impossível de ver sem magia ou sentidos especiais. Ataques seus têm vantagem; ataques contra a criatura têm desvantagem.',
 '{"effects":["Impossível de ver sem magia ou sentidos especiais; fortemente obscurecida para fins de ocultação.","Localização detectável por barulhos ou rastros que deixar.","Jogadas de ataque contra a criatura têm desvantagem.","As jogadas de ataque da criatura têm vantagem."],"original_name":"Invisible"}'),

('Paralisado', 'rule', 'condition',
 'Incapacitado; não pode se mover nem falar. Falha em testes de For e Des. Ataques contra ela têm vantagem; acertos a até 1,5 m são críticos.',
 '{"effects":["Está incapacitada; não pode se mover nem falar.","Falha automaticamente em testes de Força e Destreza.","Jogadas de ataque contra a criatura têm vantagem.","Qualquer acerto é crítico se o atacante estiver a até 1,5 m da criatura."],"original_name":"Paralyzed"}'),

('Petrificado', 'rule', 'condition',
 'Transformada em substância sólida inanimada. Incapacitada; sem consciência dos arredores. Resistência a todos os danos; imune a veneno e doenças.',
 '{"effects":["Transformada em substância sólida inanimada (peso ×10; para de envelhecer).","Incapacitada; não pode se mover, falar ou ter consciência dos arredores.","Falha automaticamente em testes de Força e Destreza.","Jogadas de ataque contra a criatura têm vantagem.","Resistência a todos os danos.","Imune a veneno e doenças (existentes são suspensos, não neutralizados)."],"original_name":"Petrified"}'),

('Envenenado', 'rule', 'condition',
 'Desvantagem em jogadas de ataque e testes de habilidade.',
 '{"effects":["Desvantagem em jogadas de ataque e testes de habilidade."],"original_name":"Poisoned"}'),

('Caído', 'rule', 'condition',
 'Só pode engatinhar (ou gastar metade da velocidade para se levantar). Desvantagem em ataques. Ataques contra ela têm vantagem a até 1,5 m; desvantagem a distâncias maiores.',
 '{"effects":["Só pode engatinhar; levantar custa metade da velocidade.","Desvantagem em jogadas de ataque.","Ataques contra a criatura têm vantagem se o atacante estiver a até 1,5 m; caso contrário, têm desvantagem."],"original_name":"Prone"}'),

('Contido', 'rule', 'condition',
 'Velocidade se torna 0. Ataques contra ela têm vantagem; os dela têm desvantagem. Desvantagem em salvaguardas de Destreza.',
 '{"effects":["Velocidade se torna 0; não pode se beneficiar de bônus à velocidade.","Jogadas de ataque contra a criatura têm vantagem.","As jogadas de ataque da criatura têm desvantagem.","Desvantagem em testes de salvaguarda de Destreza."],"original_name":"Restrained"}'),

('Atordoado', 'rule', 'condition',
 'Incapacitado; não pode se mover; fala apenas de forma hesitante. Falha em testes de For e Des. Ataques contra ela têm vantagem.',
 '{"effects":["Incapacitada; não pode se mover; fala apenas de forma hesitante.","Falha automaticamente em testes de Força e Destreza.","Jogadas de ataque contra a criatura têm vantagem."],"original_name":"Stunned"}'),

('Inconsciente', 'rule', 'condition',
 'Incapacitado; não pode se mover, falar ou ter consciência dos arredores. Cai ao chão. Falha em For e Des. Ataques têm vantagem; acertos a até 1,5 m são críticos.',
 '{"effects":["Incapacitada; não pode se mover, falar ou ter consciência dos arredores.","Larga tudo o que estiver segurando e cai no chão.","Falha automaticamente em testes de Força e Destreza.","Jogadas de ataque contra a criatura têm vantagem.","Qualquer acerto é crítico se o atacante estiver a até 1,5 m."],"original_name":"Unconscious"}');


-- ──────────────────────────────────────────────────────────────
-- AÇÕES DE COMBATE
-- subtype = 'action'
-- data: { effects: string[], action_type: 'action'|'bonus_action'|'reaction'|'special_attack', original_name }
-- ──────────────────────────────────────────────────────────────

INSERT INTO codex (name, type, subtype, description, data) VALUES

('Atacar', 'rule', 'action',
 'Realize uma ou mais jogadas de ataque corpo a corpo ou à distância. Com Ataque Extra, pode atacar mais de uma vez por ação.',
 '{"effects":["Realize uma ou mais jogadas de ataque corpo a corpo ou à distância.","Com a característica Ataque Extra, pode atacar mais de uma vez por ação.","Ataques especiais (Agarrar, Empurrar) substituem um dos ataques disponíveis."],"action_type":"action","original_name":"Attack"}'),

('Lançar Magia', 'rule', 'action',
 'Lança uma magia cujo tempo de conjuração seja 1 ação. Magias de reação ou ação bônus usam a ação correspondente.',
 '{"effects":["Lança uma magia com tempo de conjuração de 1 ação.","Magias de reação ou ação bônus usam sua ação correspondente.","Não é possível lançar uma magia de 1° nível ou superior como ação E como ação bônus no mesmo turno."],"action_type":"action","original_name":"Cast a Spell"}'),

('Disparada', 'rule', 'action',
 'Dobra a velocidade de movimento neste turno. Pode se mover antes e depois da ação.',
 '{"effects":["Dobra a velocidade de movimento no turno atual.","Pode ser combinada com movimento antes e depois da ação.","Não concede imunidade a ataques de oportunidade por si só."],"action_type":"action","original_name":"Dash"}'),

('Desengajar', 'rule', 'action',
 'O movimento restante do turno não provoca ataques de oportunidade.',
 '{"effects":["O movimento restante do turno não provoca ataques de oportunidade."],"action_type":"action","original_name":"Disengage"}'),

('Esquivar', 'rule', 'action',
 'Até o início do próximo turno: ataques contra você têm desvantagem (se puder ver o atacante) e você tem vantagem em salvaguardas de Destreza.',
 '{"effects":["Jogadas de ataque contra você têm desvantagem (se puder ver o atacante).","Vantagem em testes de salvaguarda de Destreza.","Benefício perdido se ficar incapacitado ou com velocidade 0.","Dura até o início do seu próximo turno."],"action_type":"action","original_name":"Dodge"}'),

('Ajudar', 'rule', 'action',
 'Concede vantagem no próximo teste de habilidade de um aliado para a tarefa, ou no próximo ataque de aliado contra criatura a até 1,5 m de você.',
 '{"effects":["Concede vantagem no próximo teste de habilidade de um aliado para a tarefa escolhida.","Ou concede vantagem no próximo ataque de um aliado contra uma criatura a até 1,5 m de você.","A vantagem deve ser usada antes do início do seu próximo turno."],"action_type":"action","original_name":"Help"}'),

('Esconder', 'rule', 'action',
 'Tente se esconder. Faça um teste de Des (Furtividade) contra a Percepção Passiva dos inimigos. Bem-sucedido: sua localização é desconhecida.',
 '{"effects":["Faça um teste de Destreza (Furtividade).","Deve haver obscurecimento suficiente para se ocultar.","Se bem-sucedido: localização desconhecida; seus ataques têm vantagem e ataques contra você têm desvantagem.","Revelado ao atacar, ao falhar no teste oposto de Percepção ou ao ser detectado por outros sentidos."],"action_type":"action","original_name":"Hide"}'),

('Preparar', 'rule', 'action',
 'Declare uma ação e um gatilho perceptível. Quando o gatilho ocorrer, execute a ação como reação (ou ignore-a).',
 '{"effects":["Declare uma ação e um gatilho perceptível.","Quando o gatilho ocorrer, execute a ação como reação — ou ignore-a.","Magias preparadas requerem concentração até a reação ser usada.","Se a concentração for quebrada, a magia preparada é perdida."],"action_type":"action","original_name":"Ready"}'),

('Buscar', 'rule', 'action',
 'Foque em localizar algo. O DM pode pedir um teste de Percepção (Sab) ou Investigação (Int).',
 '{"effects":["Faça um teste de Sabedoria (Percepção) ou Inteligência (Investigação), a critério do DM.","Usado para detectar criaturas ocultas, armadilhas ou objetos escondidos."],"action_type":"action","original_name":"Search"}'),

('Usar Objeto', 'rule', 'action',
 'Use quando um objeto requer uma ação para ser ativado. Interações simples (sacar arma, abrir porta) são feitas livremente durante o turno.',
 '{"effects":["Use quando um objeto requer uma ação para ser ativado (ex: poções para outros, itens especiais).","Interações simples — sacar arma, abrir porta — são feitas livremente (uma por turno, durante o movimento)."],"action_type":"action","original_name":"Use an Object"}'),

('Agarrar', 'rule', 'action',
 'Substitui um ataque. Teste oposto: sua For (Atletismo) vs. For (Atletismo) ou Des (Acrobacia) do alvo. Se vencer: alvo ganha a condição Agarrado.',
 '{"effects":["Substitui um ataque na ação Atacar.","Teste oposto: Força (Atletismo) vs. Força (Atletismo) ou Destreza (Acrobacia) do alvo.","Se vencer: alvo ganha a condição Agarrado (velocidade 0).","O alvo deve estar a até um tamanho maior que você.","Requer uma mão livre."],"action_type":"special_attack","original_name":"Grapple"}'),

('Empurrar', 'rule', 'action',
 'Substitui um ataque. Teste oposto: sua For (Atletismo) vs. For (Atletismo) ou Des (Acrobacia) do alvo. Se vencer: derrube o alvo ou empurre-o 1,5 m.',
 '{"effects":["Substitui um ataque na ação Atacar.","Teste oposto: Força (Atletismo) vs. Força (Atletismo) ou Destreza (Acrobacia) do alvo.","Se vencer: derrube o alvo (condição Caído) ou empurre-o 1,5 m para longe.","O alvo deve estar a até um tamanho maior que você."],"action_type":"special_attack","original_name":"Shove"}'),

('Ataque de Oportunidade', 'rule', 'action',
 'Reação automática: quando uma criatura hostil visível sai do seu alcance, você pode atacá-la imediatamente antes que o movimento se complete.',
 '{"effects":["Acionado quando criatura hostil visível sai do seu alcance.","Usa sua reação; feito imediatamente antes do movimento que aciona sair do alcance.","Pode ser evitado com a ação Desengajar.","Teletransporte não aciona ataques de oportunidade."],"action_type":"reaction","original_name":"Opportunity Attack"}');


-- ──────────────────────────────────────────────────────────────
-- REGRAS GERAIS DE COMBATE
-- subtypes: 'cover', 'concentration', 'rest', 'death', 'combat'
-- ──────────────────────────────────────────────────────────────

INSERT INTO codex (name, type, subtype, description, data) VALUES

('Cobertura', 'rule', 'cover',
 'Metade: +2 em CA e salvaguardas de Des. Três quartos: +5 em CA e salvaguardas de Des. Total: não pode ser alvo direto.',
 '{"degrees":[{"name":"Metade","bonus":"+2 em CA e salvaguardas de Destreza","examples":"Muro baixo, mobília, criaturas aliadas"},{"name":"Três Quartos","bonus":"+5 em CA e salvaguardas de Destreza","examples":"Parapeito, fresta de janela"},{"name":"Total","bonus":"Não pode ser alvo direto de ataques e magias","examples":"Completamente atrás de obstáculo sólido"}],"original_name":"Cover"}'),

('Concentração', 'rule', 'concentration',
 'Lançar outra magia de concentração encerra a anterior. Sofrer dano exige salvaguarda de Con (CD 10 ou metade do dano, o que for maior).',
 '{"effects":["Lançar outra magia de concentração encerra a concentração na magia atual.","Sofrer dano: salvaguarda de Constituição (CD 10 ou metade do dano recebido, o que for maior).","Ficar incapacitado ou morrer encerra a concentração automaticamente.","O DM pode exigir o teste em condições ambientais adversas."],"original_name":"Concentration"}'),

('Descanso Curto', 'rule', 'rest',
 'Período de relaxamento de pelo menos 1 hora. Permite gastar Dados de Vida para recuperar PV (roll + mod. Con por dado).',
 '{"duration":"Mínimo 1 hora","effects":["Gaste um ou mais Dados de Vida para recuperar PV (resultado do dado + modificador de Con por dado).","Algumas classes recuperam recursos no descanso curto (ex.: Fôlego de Guerreiro, Imposição de Mãos de Paladino).","Não pode ser interrompido por combate, lançamento de magias ou atividade extenuante."],"original_name":"Short Rest"}'),

('Descanso Longo', 'rule', 'rest',
 'Período de pelo menos 8 horas de atividade leve. Recupera todos os PV e metade dos Dados de Vida gastos. Máximo de um por período de 24 horas.',
 '{"duration":"Mínimo 8 horas (máx. 2h de atividade leve)","effects":["Recupera todos os pontos de vida.","Recupera metade dos Dados de Vida gastos (mínimo 1).","Recupera todos os espaços de magia e recursos que resetam no descanso longo.","Reduz o nível de exaustão em 1 (se comeu e bebeu adequadamente).","Máximo de um descanso longo por período de 24 horas."],"original_name":"Long Rest"}'),

('Testes Contra a Morte', 'rule', 'death',
 'A 0 PV: fica inconsciente. No início de cada turno faça um teste (sem atributo). 3 sucessos = estabilizado. 3 falhas = morte. 1 natural = 2 falhas. 20 natural = recupera 1 PV.',
 '{"effects":["Cair a 0 PV: fica inconsciente (condição Inconsciente).","No início de cada turno: teste de salvaguarda contra a morte (sem atributo, CD 10).","Três sucessos (não precisam ser consecutivos): estabilizado (0 PV, inconsciente, sem mais testes).","Três falhas: morte.","1 natural: conta como duas falhas.","20 natural: recupera 1 PV e retorna à consciência.","Sofrer qualquer dano a 0 PV: uma falha automática (dano crítico: duas falhas).","Sofrer dano enquanto estabilizado: recomeça a fazer testes."],"original_name":"Death Saving Throws"}'),

('Acerto Crítico', 'rule', 'combat',
 '20 natural na jogada de ataque = acerto crítico. Role todos os dados de dano duas vezes e some os modificadores normalmente (apenas uma vez).',
 '{"effects":["20 natural na jogada de ataque = acerto crítico automático (independente de CA ou modificadores).","Role todos os dados de dano duas vezes (não apenas um dado extra).","Adicione os modificadores de dano normalmente (apenas uma vez).","Algumas características concedem crítico com resultados menores que 20 (ex.: Campeão nível 3).","Ataque contra criatura Inconsciente ou Paralisada a até 1,5 m também é crítico automático."],"original_name":"Critical Hit"}'),

('Flanquear', 'rule', 'combat',
 'Regra opcional. Quando dois aliados estão em lados opostos de um inimigo (cada um a até 1,5 m), ambos têm vantagem nos ataques corpo a corpo contra ele.',
 '{"effects":["Regra opcional do DM (não faz parte do SRD base).","Dois aliados em lados opostos de uma criatura (cada um a até 1,5 m) ganham vantagem nos ataques corpo a corpo contra ela.","A criatura deve estar dentro do alcance de ambos os flanqueadores.","Não se aplica a ataques à distância."],"original_name":"Flanking"}'),

('Iniciativa', 'rule', 'combat',
 'No início do combate, todos rolam 1d20 + modificador de Destreza. A ordem de iniciativa determina a sequência de turnos durante o combate.',
 '{"effects":["Todos rolam 1d20 + modificador de Destreza ao início do combate.","Em caso de empate: jogadores têm prioridade sobre monstros; entre jogadores, o DM decide ou rolam novamente.","A ordem de iniciativa é mantida durante todo o encontro.","Criaturas surpreendidas não podem agir no primeiro turno de combate."],"original_name":"Initiative"}'),

('Surpresa', 'rule', 'combat',
 'Se um grupo surpreende o outro, as criaturas surpreendidas não podem se mover, realizar ações nem reações no primeiro turno de combate.',
 '{"effects":["O DM decide se há surpresa comparando Furtividade dos atacantes com Percepção Passiva dos alvos.","Criaturas surpreendidas não podem se mover, realizar ações nem reações no primeiro turno.","Um membro do grupo pode ser surpreendido sem que os outros sejam.","Após o primeiro turno, a surpresa termina para todos."],"original_name":"Surprise"}');
