-- =============================================================
-- CODEX — DDL + SEED (D&D 5e SRD, CC BY 4.0)
-- Rodar no SQL Editor do Supabase
-- =============================================================

-- ──────────────────────────────────────────────────────────────
-- TABELA
-- ──────────────────────────────────────────────────────────────
CREATE TABLE codex (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  name        TEXT        NOT NULL,
  type        TEXT        NOT NULL,       -- 'weapon' | 'armor' | 'item' | 'spell' | 'rule' | 'feature'
  subtype     TEXT,                       -- 'simple melee' | 'martial ranged' | 'light' | 'potion' | …
  description TEXT,
  data        JSONB       NOT NULL DEFAULT '{}',
  source      TEXT        NOT NULL DEFAULT 'srd',  -- 'srd' | 'custom'
  player_id   TEXT,                       -- null = conteúdo do sistema; preenchido = criado pelo jogador
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX codex_type_idx      ON codex (type);
CREATE INDEX codex_subtype_idx   ON codex (subtype);
CREATE INDEX codex_player_id_idx ON codex (player_id);
CREATE INDEX codex_source_idx    ON codex (source);
CREATE INDEX codex_data_gin      ON codex USING GIN (data);

-- Trigger updated_at (cria a função se não existir)
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER codex_updated_at
  BEFORE UPDATE ON codex
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

ALTER TABLE codex ENABLE ROW LEVEL SECURITY;
CREATE POLICY "codex_open" ON codex
  FOR ALL USING (true) WITH CHECK (true);


-- =============================================================
-- ARMAS SIMPLES — CORPO A CORPO
-- data: { damage, damage_type, properties[], range?, versatile_damage?, weight, cost }
-- =============================================================
INSERT INTO codex (name, type, subtype, description, data) VALUES
('Clava', 'weapon', 'simple melee',
 'Porrete de madeira pesada. Arma de iniciante barata e eficaz.',
 '{"damage":"1d4","damage_type":"bludgeoning","properties":["light"],"weight":2,"cost":"1 sp"}'),

('Adaga', 'weapon', 'simple melee',
 'Lâmina curta e ágil, pode ser arremessada ou usada em combate rápido.',
 '{"damage":"1d4","damage_type":"piercing","properties":["finesse","light","thrown"],"range":"20/60","weight":1,"cost":"2 gp"}'),

('Clava Grande', 'weapon', 'simple melee',
 'Tronco pesado e irregular. Difícil de manusear, mas devastador.',
 '{"damage":"1d8","damage_type":"bludgeoning","properties":["two-handed"],"weight":10,"cost":"2 sp"}'),

('Machadinha', 'weapon', 'simple melee',
 'Machado leve equilibrado para arremesso ou combate próximo.',
 '{"damage":"1d6","damage_type":"slashing","properties":["light","thrown"],"range":"20/60","weight":2,"cost":"5 gp"}'),

('Zagaia', 'weapon', 'simple melee',
 'Lança leve projetada para arremesso à distância.',
 '{"damage":"1d6","damage_type":"piercing","properties":["thrown"],"range":"30/120","weight":2,"cost":"5 sp"}'),

('Martelo Leve', 'weapon', 'simple melee',
 'Martelo pequeno e balanceado, pode ser arremessado.',
 '{"damage":"1d4","damage_type":"bludgeoning","properties":["light","thrown"],"range":"20/60","weight":2,"cost":"2 gp"}'),

('Maça', 'weapon', 'simple melee',
 'Cabo de madeira com cabeça de metal reforçado.',
 '{"damage":"1d6","damage_type":"bludgeoning","properties":[],"weight":4,"cost":"5 gp"}'),

('Cajado', 'weapon', 'simple melee',
 'Bastão longo versátil, pode ser usado com uma ou duas mãos.',
 '{"damage":"1d6","damage_type":"bludgeoning","properties":["versatile"],"versatile_damage":"1d8","weight":4,"cost":"2 sp"}'),

('Foice', 'weapon', 'simple melee',
 'Lâmina curva originalmente agrícola, eficaz e leve.',
 '{"damage":"1d4","damage_type":"slashing","properties":["light"],"weight":2,"cost":"1 gp"}'),

('Lança', 'weapon', 'simple melee',
 'Haste com ponta de metal, versátil e arremessável.',
 '{"damage":"1d6","damage_type":"piercing","properties":["thrown","versatile"],"versatile_damage":"1d8","range":"20/60","weight":3,"cost":"1 gp"}');


-- =============================================================
-- ARMAS SIMPLES — À DISTÂNCIA
-- =============================================================
INSERT INTO codex (name, type, subtype, description, data) VALUES
('Besta Leve', 'weapon', 'simple ranged',
 'Besta compacta que exige recarga após cada disparo.',
 '{"damage":"1d8","damage_type":"piercing","properties":["ammunition","loading","two-handed"],"range":"80/320","weight":5,"cost":"25 gp"}'),

('Dardo', 'weapon', 'simple ranged',
 'Projétil fino e leve arremessado à mão.',
 '{"damage":"1d4","damage_type":"piercing","properties":["finesse","thrown"],"range":"20/60","weight":0.25,"cost":"5 cp"}'),

('Arco Curto', 'weapon', 'simple ranged',
 'Arco compacto, mais fácil de manusear em espaços fechados.',
 '{"damage":"1d6","damage_type":"piercing","properties":["ammunition","two-handed"],"range":"80/320","weight":2,"cost":"25 gp"}'),

('Funda', 'weapon', 'simple ranged',
 'Tira de couro para arremessar pedras ou balas metálicas.',
 '{"damage":"1d4","damage_type":"bludgeoning","properties":["ammunition"],"range":"30/120","weight":0,"cost":"1 sp"}');


-- =============================================================
-- ARMAS MARCIAIS — CORPO A CORPO
-- =============================================================
INSERT INTO codex (name, type, subtype, description, data) VALUES
('Machadão', 'weapon', 'martial melee',
 'Machado de guerra versátil com lâmina larga.',
 '{"damage":"1d8","damage_type":"slashing","properties":["versatile"],"versatile_damage":"1d10","weight":4,"cost":"10 gp"}'),

('Mangual', 'weapon', 'martial melee',
 'Cabo com corrente e bola de metal cravejada — difícil de aparar com escudo.',
 '{"damage":"1d8","damage_type":"bludgeoning","properties":[],"weight":2,"cost":"10 gp"}'),

('Glaive', 'weapon', 'martial melee',
 'Lâmina curva montada em cabo longo. Permite ataque a criaturas a 3 m.',
 '{"damage":"1d10","damage_type":"slashing","properties":["heavy","reach","two-handed"],"weight":6,"cost":"20 gp"}'),

('Machado Grande', 'weapon', 'martial melee',
 'Machado enorme de duas mãos com poder de corte devastador.',
 '{"damage":"1d12","damage_type":"slashing","properties":["heavy","two-handed"],"weight":7,"cost":"30 gp"}'),

('Montante', 'weapon', 'martial melee',
 'Espada de duas mãos com lâmina larga. A rainha das batalhas campais.',
 '{"damage":"2d6","damage_type":"slashing","properties":["heavy","two-handed"],"weight":6,"cost":"50 gp"}'),

('Alabarda', 'weapon', 'martial melee',
 'Combinação de machado e lança em cabo longo.',
 '{"damage":"1d10","damage_type":"slashing","properties":["heavy","reach","two-handed"],"weight":6,"cost":"20 gp"}'),

('Lança de Cavalaria', 'weapon', 'martial melee',
 'Lança longa usada montado. Desvantagem em ataques corpo a corpo contra alvos adjacentes.',
 '{"damage":"1d12","damage_type":"piercing","properties":["reach","special"],"weight":6,"cost":"10 gp"}'),

('Espada Longa', 'weapon', 'martial melee',
 'Espada versátil, símbolo dos guerreiros de elite.',
 '{"damage":"1d8","damage_type":"slashing","properties":["versatile"],"versatile_damage":"1d10","weight":3,"cost":"15 gp"}'),

('Malho', 'weapon', 'martial melee',
 'Martelo de guerra enorme que esmaga qualquer defesa.',
 '{"damage":"2d6","damage_type":"bludgeoning","properties":["heavy","two-handed"],"weight":10,"cost":"10 gp"}'),

('Maça Cravejada', 'weapon', 'martial melee',
 'Maça com puas de metal, capaz de perfurar armaduras.',
 '{"damage":"1d8","damage_type":"piercing","properties":[],"weight":4,"cost":"15 gp"}'),

('Pique', 'weapon', 'martial melee',
 'Lança de 5,5 m para formações militares. Atinge inimigos a 3 m.',
 '{"damage":"1d10","damage_type":"piercing","properties":["heavy","reach","two-handed"],"weight":18,"cost":"5 gp"}'),

('Rapieira', 'weapon', 'martial melee',
 'Espada esguia de ponta afiada, favorita de duelistas e espadachins.',
 '{"damage":"1d8","damage_type":"piercing","properties":["finesse"],"weight":2,"cost":"25 gp"}'),

('Cimitarra', 'weapon', 'martial melee',
 'Espada curva e leve, excelente para golpes rápidos.',
 '{"damage":"1d6","damage_type":"slashing","properties":["finesse","light"],"weight":3,"cost":"25 gp"}'),

('Espada Curta', 'weapon', 'martial melee',
 'Lâmina curta e ágil, boa para ladrões e rangers.',
 '{"damage":"1d6","damage_type":"piercing","properties":["finesse","light"],"weight":2,"cost":"10 gp"}'),

('Tridente', 'weapon', 'martial melee',
 'Arma de três pontas versátil, pode ser arremessada.',
 '{"damage":"1d6","damage_type":"piercing","properties":["thrown","versatile"],"versatile_damage":"1d8","range":"20/60","weight":4,"cost":"5 gp"}'),

('Picareta de Guerra', 'weapon', 'martial melee',
 'Pico pesado projetado para perfurar armaduras metálicas.',
 '{"damage":"1d8","damage_type":"piercing","properties":[],"weight":2,"cost":"5 gp"}'),

('Martelo de Guerra', 'weapon', 'martial melee',
 'Martelo pesado de batalha, versátil e de alto impacto.',
 '{"damage":"1d8","damage_type":"bludgeoning","properties":["versatile"],"versatile_damage":"1d10","weight":2,"cost":"15 gp"}'),

('Chicote', 'weapon', 'martial melee',
 'Arma de alcance flexível que dificulta a aproximação inimiga.',
 '{"damage":"1d4","damage_type":"slashing","properties":["finesse","reach"],"weight":3,"cost":"2 gp"}');


-- =============================================================
-- ARMAS MARCIAIS — À DISTÂNCIA
-- =============================================================
INSERT INTO codex (name, type, subtype, description, data) VALUES
('Zarabatana', 'weapon', 'martial ranged',
 'Tubo longo para soprar dardos, frequentemente envenenados.',
 '{"damage":"1","damage_type":"piercing","properties":["ammunition","loading"],"range":"25/100","weight":1,"cost":"10 gp"}'),

('Besta de Mão', 'weapon', 'martial ranged',
 'Besta compacta para uso com uma mão, preferida por ladinos.',
 '{"damage":"1d6","damage_type":"piercing","properties":["ammunition","light","loading"],"range":"30/120","weight":3,"cost":"75 gp"}'),

('Besta Pesada', 'weapon', 'martial ranged',
 'Besta de alto poder de penetração. Lenta mas devastadora.',
 '{"damage":"1d10","damage_type":"piercing","properties":["ammunition","heavy","loading","two-handed"],"range":"100/400","weight":18,"cost":"50 gp"}'),

('Arco Longo', 'weapon', 'martial ranged',
 'Arco alto de grande alcance e poder. Exige treinamento extenso.',
 '{"damage":"1d8","damage_type":"piercing","properties":["ammunition","heavy","two-handed"],"range":"150/600","weight":2,"cost":"50 gp"}'),

('Rede', 'weapon', 'martial ranged',
 'Rede arremessada para enredar inimigos. Não causa dano; alvo Médio ou menor fica enredado (CD 10 For para escapar).',
 '{"damage":"0","damage_type":"special","properties":["special","thrown"],"range":"5/15","weight":3,"cost":"1 gp"}');


-- =============================================================
-- ARMADURAS LEVES
-- data: { ac_base, max_dex_bonus (null = sem limite), min_strength, stealth_disadvantage, weight, cost }
-- =============================================================
INSERT INTO codex (name, type, subtype, description, data) VALUES
('Armadura Acolchoada', 'armor', 'light',
 'Tecido e matelassê em camadas. CA 11 + mod. Des. Impõe desvantagem em Furtividade.',
 '{"ac_base":11,"max_dex_bonus":null,"min_strength":0,"stealth_disadvantage":true,"weight":8,"cost":"5 gp"}'),

('Armadura de Couro', 'armor', 'light',
 'Peitoral e proteções de couro endurecido. CA 11 + mod. Des.',
 '{"ac_base":11,"max_dex_bonus":null,"min_strength":0,"stealth_disadvantage":false,"weight":10,"cost":"10 gp"}'),

('Couro Cravejado', 'armor', 'light',
 'Couro reforçado com rebites de metal. CA 12 + mod. Des.',
 '{"ac_base":12,"max_dex_bonus":null,"min_strength":0,"stealth_disadvantage":false,"weight":13,"cost":"45 gp"}');


-- =============================================================
-- ARMADURAS MÉDIAS
-- max_dex_bonus: 2 = bônus de Des limitado a +2
-- =============================================================
INSERT INTO codex (name, type, subtype, description, data) VALUES
('Pelego', 'armor', 'medium',
 'Peles e couros grossos. CA 12 + mod. Des (máx +2).',
 '{"ac_base":12,"max_dex_bonus":2,"min_strength":0,"stealth_disadvantage":false,"weight":12,"cost":"10 gp"}'),

('Cota de Malha Curta', 'armor', 'medium',
 'Camisa de anéis de metal entrelaçados. CA 13 + mod. Des (máx +2).',
 '{"ac_base":13,"max_dex_bonus":2,"min_strength":0,"stealth_disadvantage":false,"weight":20,"cost":"50 gp"}'),

('Malha de Escamas', 'armor', 'medium',
 'Escamas de metal sobre couro. CA 14 + mod. Des (máx +2). Impõe desvantagem em Furtividade.',
 '{"ac_base":14,"max_dex_bonus":2,"min_strength":0,"stealth_disadvantage":true,"weight":45,"cost":"50 gp"}'),

('Peitoral', 'armor', 'medium',
 'Placa metálica moldada que cobre o tronco. CA 14 + mod. Des (máx +2).',
 '{"ac_base":14,"max_dex_bonus":2,"min_strength":0,"stealth_disadvantage":false,"weight":20,"cost":"400 gp"}'),

('Meia Armadura de Placas', 'armor', 'medium',
 'Placas metálicas cobrindo a maior parte do corpo. CA 15 + mod. Des (máx +2). Impõe desvantagem em Furtividade.',
 '{"ac_base":15,"max_dex_bonus":2,"min_strength":0,"stealth_disadvantage":true,"weight":40,"cost":"750 gp"}');


-- =============================================================
-- ARMADURAS PESADAS
-- max_dex_bonus: 0 = sem bônus de Des
-- =============================================================
INSERT INTO codex (name, type, subtype, description, data) VALUES
('Cota de Anéis', 'armor', 'heavy',
 'Couro com anéis de metal costurados externamente. CA 14. Impõe desvantagem em Furtividade.',
 '{"ac_base":14,"max_dex_bonus":0,"min_strength":0,"stealth_disadvantage":true,"weight":40,"cost":"30 gp"}'),

('Malha Completa', 'armor', 'heavy',
 'Anéis de metal entrelaçados cobrindo o corpo inteiro. CA 16. Exige For 13. Impõe desvantagem em Furtividade.',
 '{"ac_base":16,"max_dex_bonus":0,"min_strength":13,"stealth_disadvantage":true,"weight":55,"cost":"75 gp"}'),

('Armadura Laminada', 'armor', 'heavy',
 'Tiras verticais de metal sobre cota de malha. CA 17. Exige For 15. Impõe desvantagem em Furtividade.',
 '{"ac_base":17,"max_dex_bonus":0,"min_strength":15,"stealth_disadvantage":true,"weight":60,"cost":"200 gp"}'),

('Armadura de Placas', 'armor', 'heavy',
 'Placas de metal articuladas cobrindo o corpo inteiro. CA 18. Exige For 15. Impõe desvantagem em Furtividade.',
 '{"ac_base":18,"max_dex_bonus":0,"min_strength":15,"stealth_disadvantage":true,"weight":65,"cost":"1500 gp"}');


-- =============================================================
-- ESCUDO
-- ac_bonus: bônus fixo somado à CA atual
-- =============================================================
INSERT INTO codex (name, type, subtype, description, data) VALUES
('Escudo', 'armor', 'shield',
 'Peça de madeira ou metal empunhada para deflectir ataques. Concede +2 de CA.',
 '{"ac_bonus":2,"min_strength":0,"stealth_disadvantage":false,"weight":6,"cost":"10 gp"}');


-- =============================================================
-- ITENS — MUNIÇÃO
-- =============================================================
INSERT INTO codex (name, type, subtype, description, data) VALUES
('Flechas (20)', 'item', 'ammunition',
 'Munição padrão para arcos curtos e longos.',
 '{"weight":1,"cost":"1 gp","quantity":20}'),

('Virotes de Besta (20)', 'item', 'ammunition',
 'Munição para bestas leve, pesada e de mão.',
 '{"weight":1.5,"cost":"1 gp","quantity":20}'),

('Dardos de Zarabatana (50)', 'item', 'ammunition',
 'Dardos finos para zarabatana, frequentemente envenenados.',
 '{"weight":1,"cost":"1 gp","quantity":50}'),

('Balas de Funda (20)', 'item', 'ammunition',
 'Esferas de pedra ou metal para fundas.',
 '{"weight":1.5,"cost":"4 cp","quantity":20}');


-- =============================================================
-- ITENS — FONTE DE LUZ
-- =============================================================
INSERT INTO codex (name, type, subtype, description, data) VALUES
('Vela', 'item', 'light source',
 'Ilumina num raio de 1,5 m (luz plena) + 1,5 m (penumbra) por 1 hora.',
 '{"weight":0,"cost":"1 cp","duration_hours":1,"radius_ft":5}'),

('Tocha', 'item', 'light source',
 'Ilumina num raio de 6 m por 1 hora. Pode ser usada como arma improvisada (1 de dano de fogo).',
 '{"weight":1,"cost":"1 cp","duration_hours":1,"radius_ft":20}'),

('Lanterna Comum', 'item', 'light source',
 'Ilumina num raio de 9 m por 6 horas, consome 1 frasco de óleo.',
 '{"weight":2,"cost":"5 sp","duration_hours":6,"radius_ft":30}'),

('Lanterna de Foco', 'item', 'light source',
 'Cone de 18 m de comprimento e 9 m de largura por 6 horas. Ilumina apenas a frente.',
 '{"weight":2,"cost":"10 gp","duration_hours":6,"cone_length_ft":60,"cone_width_ft":30}');


-- =============================================================
-- ITENS — CONSUMÍVEIS
-- =============================================================
INSERT INTO codex (name, type, subtype, description, data) VALUES
('Óleo (frasco)', 'item', 'consumable',
 'Combustível para lanternas. Pode ser derramado no chão e incendiado (2d6 dano de fogo, CD 10 Des para evitar).',
 '{"weight":1,"cost":"1 sp"}'),

('Ácido (frasco)', 'item', 'consumable',
 'Arremessado como improviso. Acerto: 2d6 de dano ácido (CD 10 Des pelo respingo).',
 '{"weight":1,"cost":"25 gp"}'),

('Fogo de Alquimista (frasco)', 'item', 'consumable',
 'Líquido pegajoso que pega fogo ao contato com o ar. 1d4 de dano de fogo por turno até apagado (ação + CD 10 Des).',
 '{"weight":1,"cost":"50 gp","ongoing_damage":"1d4"}'),

('Antídoto (frasco)', 'item', 'consumable',
 'Concede vantagem em testes de resistência contra veneno por 1 hora.',
 '{"weight":0,"cost":"50 gp","duration_hours":1}'),

('Água Benta (frasco)', 'item', 'consumable',
 'Causa 2d6 de dano radiante a mortos-vivos e demônios que toca. Pode ser arremessada (mesmo que ácido).',
 '{"weight":1,"cost":"25 gp","damage":"2d6","damage_type":"radiant"}'),

('Veneno Básico (frasco)', 'item', 'consumable',
 'Aplicado em arma ou munição (ação bônus). Alvo faz CD 10 Con ou fica envenenado por 1 hora.',
 '{"weight":0,"cost":"100 gp","save_dc":10,"save_ability":"con","condition":"poisoned","duration_hours":1}'),

('Rações de Viagem (1 dia)', 'item', 'consumable',
 'Comida seca e compacta — carne seca, biscoitos, passas e amêndoas.',
 '{"weight":2,"cost":"5 sp","days":1}');


-- =============================================================
-- ITENS — POÇÕES
-- =============================================================
INSERT INTO codex (name, type, subtype, description, data) VALUES
('Poção de Cura', 'item', 'potion',
 'Restaura 2d4+2 pontos de vida ao beber. A poção mais comum nas lojas de aventureiros.',
 '{"weight":0.5,"cost":"50 gp","healing":"2d4+2"}'),

('Poção de Cura Superior', 'item', 'potion',
 'Restaura 4d4+4 pontos de vida ao beber.',
 '{"weight":0.5,"cost":"100 gp","healing":"4d4+4"}'),

('Poção de Cura Suprema', 'item', 'potion',
 'Restaura 8d4+8 pontos de vida ao beber.',
 '{"weight":0.5,"cost":"500 gp","healing":"8d4+8"}'),

('Poção de Cura Lendária', 'item', 'potion',
 'Restaura todos os pontos de vida ao beber.',
 '{"weight":0.5,"cost":"5000 gp","healing":"all"}'),

('Poção de Gigante da Colina', 'item', 'potion',
 'For aumenta para 21 por 1 hora (sem efeito se For já for maior).',
 '{"weight":0.5,"cost":"200 gp","stat":"str","value":21,"duration_hours":1}'),

('Poção de Resistência', 'item', 'potion',
 'Concede resistência a um tipo de dano por 1 hora.',
 '{"weight":0.5,"cost":"300 gp","duration_hours":1}'),

('Poção de Escalar', 'item', 'potion',
 'Concede velocidade de escalar igual à de caminhada por 1 hora.',
 '{"weight":0.5,"cost":"180 gp","duration_hours":1}'),

('Poção de Invisibilidade', 'item', 'potion',
 'O bebedor fica invisível por até 1 hora ou até atacar ou lançar magia.',
 '{"weight":0.5,"cost":"180 gp","duration_hours":1}'),

('Poção de Respirar Água', 'item', 'potion',
 'Permite respirar debaixo d''água por 1 hora.',
 '{"weight":0.5,"cost":"180 gp","duration_hours":1}'),

('Poção de Velocidade', 'item', 'potion',
 'Efeito idêntico à magia Acelerar por 1 minuto.',
 '{"weight":0.5,"cost":"400 gp","duration_minutes":1}');


-- =============================================================
-- ITENS — PERGAMINHOS
-- =============================================================
INSERT INTO codex (name, type, subtype, description, data) VALUES
('Pergaminho de Magia (Truque)', 'item', 'scroll',
 'Contém um truque. Qualquer pessoa pode usá-lo; sucesso automático.',
 '{"weight":0,"cost":"30 gp","spell_level":0}'),

('Pergaminho de Magia (Nível 1)', 'item', 'scroll',
 'Contém uma magia de 1.º nível. CD de resistência 13, bônus de ataque +5.',
 '{"weight":0,"cost":"50 gp","spell_level":1,"save_dc":13,"attack_bonus":5}'),

('Pergaminho de Magia (Nível 2)', 'item', 'scroll',
 'Contém uma magia de 2.º nível. CD 13, bônus de ataque +5.',
 '{"weight":0,"cost":"250 gp","spell_level":2,"save_dc":13,"attack_bonus":5}'),

('Pergaminho de Magia (Nível 3)', 'item', 'scroll',
 'Contém uma magia de 3.º nível. CD 15, bônus de ataque +7.',
 '{"weight":0,"cost":"500 gp","spell_level":3,"save_dc":15,"attack_bonus":7}'),

('Pergaminho de Magia (Nível 4)', 'item', 'scroll',
 'Contém uma magia de 4.º nível. CD 15, bônus de ataque +7.',
 '{"weight":0,"cost":"2500 gp","spell_level":4,"save_dc":15,"attack_bonus":7}'),

('Pergaminho de Magia (Nível 5)', 'item', 'scroll',
 'Contém uma magia de 5.º nível. CD 17, bônus de ataque +9.',
 '{"weight":0,"cost":"2500 gp","spell_level":5,"save_dc":17,"attack_bonus":9}');


-- =============================================================
-- ITENS — FOCOS E KITS
-- =============================================================
INSERT INTO codex (name, type, subtype, description, data) VALUES
('Foco Arcano — Varinha', 'item', 'focus',
 'Substitui componentes materiais sem custo de ouro para magias arcanas.',
 '{"weight":1,"cost":"10 gp"}'),

('Foco Arcano — Cajado', 'item', 'focus',
 'Cajado mágico que canaliza energia arcana. Pode ser usado como arma (1d6/1d8).',
 '{"weight":4,"cost":"5 gp"}'),

('Foco Arcano — Orbe', 'item', 'focus',
 'Esfera de cristal ou vidro para concentração arcana.',
 '{"weight":3,"cost":"20 gp"}'),

('Foco Arcano — Cristal', 'item', 'focus',
 'Gema lapidada usada como foco para magias arcanas.',
 '{"weight":1,"cost":"10 gp"}'),

('Símbolo Sagrado — Amuleto', 'item', 'focus',
 'Símbolo da divindade. Substitui componentes de magias divinas (clérigo, paladino).',
 '{"weight":1,"cost":"5 gp"}'),

('Símbolo Sagrado — Escudo', 'item', 'focus',
 'Símbolo gravado em escudo, liberando a outra mão.',
 '{"weight":6,"cost":"10 gp"}'),

('Bolsa de Componentes', 'item', 'focus',
 'Bolsa com componentes comuns para magias (exceto os com custo específico em PO).',
 '{"weight":2,"cost":"25 gp"}'),

('Kit de Cura', 'item', 'kit',
 '10 usos. Estabiliza criatura inconsciente sem teste. Não restaura PV.',
 '{"weight":3,"cost":"5 gp","uses":10}'),

('Ferramentas de Ladrão', 'item', 'kit',
 'Gruchos, limas e espelhinhos para arrombar fechaduras e desarmar armadilhas.',
 '{"weight":1,"cost":"25 gp"}'),

('Kit de Disfarce', 'item', 'kit',
 'Maquiagem, perucas e acessórios para alterar a aparência.',
 '{"weight":3,"cost":"25 gp"}'),

('Kit de Falsificação', 'item', 'kit',
 'Ferramentas para replicar documentos, selos e caligrafia.',
 '{"weight":5,"cost":"15 gp"}'),

('Kit de Herbalismo', 'item', 'kit',
 'Ervas e ferramentas para preparar antídotos e poções curadoras (com proficiência).',
 '{"weight":3,"cost":"5 gp"}'),

('Kit de Envenenamento', 'item', 'kit',
 'Ferramentas para extrair, preservar e aplicar venenos.',
 '{"weight":2,"cost":"50 gp"}'),

('Livro de Magias', 'item', 'gear',
 'Livro em branco para magos registrarem suas magias. 100 páginas.',
 '{"weight":3,"cost":"50 gp","pages":100}');


-- =============================================================
-- ITENS — CONTÊINERES
-- =============================================================
INSERT INTO codex (name, type, subtype, description, data) VALUES
('Mochila', 'item', 'container',
 'Carrega até 14 kg / 30 lb de equipamento.',
 '{"weight":5,"cost":"2 gp","capacity_lb":30}'),

('Bolsa', 'item', 'container',
 'Pequena bolsa de couro para itens miúdos. Carrega até 2,7 kg.',
 '{"weight":1,"cost":"5 sp","capacity_lb":6}'),

('Baú', 'item', 'container',
 'Caixa grande de madeira reforçada com fechadura. Carrega até 136 kg.',
 '{"weight":25,"cost":"5 gp","capacity_lb":300}'),

('Aljava', 'item', 'container',
 'Suporte de couro para até 20 flechas.',
 '{"weight":1,"cost":"1 gp","capacity":"20 arrows"}'),

('Estojo de Virotes', 'item', 'container',
 'Estojo rígido para até 20 virotes de besta.',
 '{"weight":1,"cost":"1 gp","capacity":"20 bolts"}');


-- =============================================================
-- ITENS — EQUIPAMENTO GERAL
-- =============================================================
INSERT INTO codex (name, type, subtype, description, data) VALUES
('Corda de Cânhamo (15 m)', 'item', 'gear',
 'Suporta até 227 kg. Pode ser usada para escalar superfícies com ponto de apoio.',
 '{"weight":10,"cost":"1 gp","length_m":15,"capacity_kg":227}'),

('Corda de Seda (15 m)', 'item', 'gear',
 'Mais leve e resistente que cânhamo. Suporta até 227 kg.',
 '{"weight":5,"cost":"10 gp","length_m":15,"capacity_kg":227}'),

('Gancho de Escalar', 'item', 'gear',
 'Fixado no topo de uma corda para escalar superfícies sem apoio (CD 15).',
 '{"weight":4,"cost":"2 gp"}'),

('Escada (3 m)', 'item', 'gear',
 'Escada portátil de madeira. Incômoda mas útil.',
 '{"weight":25,"cost":"1 sp","length_m":3}'),

('Piton', 'item', 'gear',
 'Pino de metal cravado em rocha ou madeira para fixar corda.',
 '{"weight":0.25,"cost":"5 cp"}'),

('Pé de Cabra', 'item', 'gear',
 'Concede vantagem em testes de Força para abrir portas, tampas e portões trancados.',
 '{"weight":5,"cost":"2 gp"}'),

('Marreta', 'item', 'gear',
 'Martelo pesado para cravar pitons, arrombar portas frágeis ou destruir objetos.',
 '{"weight":3,"cost":"1 gp"}'),

('Isca e Pederneira', 'item', 'gear',
 'Acende fogueiras em 1 minuto. Acender algo que já esteja preparado gasta 1 ação.',
 '{"weight":1,"cost":"5 sp"}'),

('Odre de Água', 'item', 'gear',
 'Carrega até 4 litros de líquido.',
 '{"weight":5,"cost":"2 sp","capacity_liters":4}'),

('Espelho de Aço', 'item', 'gear',
 'Espelho polido para visualizar ao redor de cantos ou verificar superfícies.',
 '{"weight":0.5,"cost":"5 gp"}'),

('Luneta', 'item', 'gear',
 'Amplia objetos distantes em 2×. Custo elevado reflete artesanato fino.',
 '{"weight":1,"cost":"1000 gp","magnification":2}'),

('Lupa', 'item', 'gear',
 'Foca a luz solar para acender fogo (equivale a isca e pederneira). Vantagem em percepção de detalhes finos.',
 '{"weight":0,"cost":"100 gp"}'),

('Armadilha de Caça', 'item', 'gear',
 'Criatura que pisar: CD 13 Des ou fica presa (velocidade 0). Escape: CD 13 For ou Ferramentas de Ladrão.',
 '{"weight":25,"cost":"5 gp","save_dc":13}'),

('Corrente (3 m)', 'item', 'gear',
 'Corrente de ferro. CA 19, 10 PV. Pode ser usada para prender criaturas.',
 '{"weight":10,"cost":"5 gp","length_m":3,"ac":19,"hp":10}'),

('Algemas', 'item', 'gear',
 'Prendem criatura Média ou menor. Escape: CD 20 Atletismo ou Ferramentas de Ladrão.',
 '{"weight":6,"cost":"2 gp","escape_dc":20}'),

('Caltrops (20)', 'item', 'gear',
 'Cobertura de 1,5 m². Criatura que caminhar: CD 15 Des ou 1 dano perfurante e vel. reduz para 2,5 m até curada.',
 '{"weight":2,"cost":"1 gp","quantity":20,"area_ft":5,"save_dc":15}'),

('Bolas de Rolamento (1000)', 'item', 'gear',
 'Cobertura de 3 m². Criatura que caminhar: CD 10 Des ou cai prostrada.',
 '{"weight":2,"cost":"1 gp","quantity":1000,"area_ft":10,"save_dc":10}'),

('Apito de Sinal', 'item', 'gear',
 'Emite som agudo audível a longa distância para sinalização.',
 '{"weight":0,"cost":"5 cp"}'),

('Giz (1 peça)', 'item', 'gear',
 'Para marcar superfícies de pedra, madeira ou tecido.',
 '{"weight":0,"cost":"1 cp"}'),

('Tinta (30 ml)', 'item', 'gear',
 'Frasco de tinta preta para escrita e cartografia.',
 '{"weight":0,"cost":"10 gp"}'),

('Pena de Escrita', 'item', 'gear',
 'Pena de ave para escrever com tinta.',
 '{"weight":0,"cost":"2 cp"}'),

('Pergaminho (1 folha)', 'item', 'gear',
 'Superfície de alta qualidade para escrita, mapas e contratos.',
 '{"weight":0,"cost":"1 sp"}'),

('Papel (1 folha)', 'item', 'gear',
 'Folha de papel comum para anotações.',
 '{"weight":0,"cost":"2 sp"}'),

('Lacre de Cera', 'item', 'gear',
 'Cera para selar envelopes e autenticar documentos.',
 '{"weight":0,"cost":"5 sp"}'),

('Anel Sinete', 'item', 'gear',
 'Anel com brasão gravado para imprimir em lacre e autenticar documentos.',
 '{"weight":0,"cost":"5 gp"}'),

('Sabão', 'item', 'gear',
 'Bloco de sabão para higiene básica e remover marcas.',
 '{"weight":0,"cost":"2 cp"}'),

('Barraca (2 pessoas)', 'item', 'gear',
 'Abrigo portátil simples para dois aventureiros.',
 '{"weight":20,"cost":"2 gp","capacity":2}'),

('Cobertor', 'item', 'gear',
 'Manta grossa para acampamentos em campo aberto.',
 '{"weight":3,"cost":"5 sp"}'),

('Saco de Dormir', 'item', 'gear',
 'Rolo de roupa acolchoada para dormir em terrenos adversos.',
 '{"weight":7,"cost":"1 gp"}'),

('Instrumentos de Navegação', 'item', 'kit',
 'Bússola, régua e cartas náuticas para navegação marítima.',
 '{"weight":2,"cost":"25 gp"}'),

('Instrumentos do Navegante', 'item', 'kit',
 'Sextante e tabelas para determinar posição pelo sol e estrelas.',
 '{"weight":2,"cost":"25 gp"}');
