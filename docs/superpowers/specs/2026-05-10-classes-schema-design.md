# Design: Schema de Classes + Abas de Habilidades e Magias

**Data:** 2026-05-10  
**Escopo:** Tabelas de classes D&D 5e para auto-preenchimento da ficha de personagem, incluindo progressão 1–20, habilidades, subclasses e registro de magias por personagem.

---

## Contexto

O Aeternus já possui a tabela `characters` com `class` (text) e `level` (int), mas sem dados estruturados de classe. O objetivo é:

1. Armazenar dados das classes D&D 5e SRD de forma que a ficha possa ser auto-preenchida (proficiências, deslocamento, saving throws, etc.)
2. Registrar progressão completa nível 1–20 (habilidades ganhas por nível, slots de magia)
3. Suportar subclasses — estrutura criada agora, dados populados em pacotes futuros
4. Permitir que personagens selecionem e persistam suas magias conhecidas/preparadas
5. Rastrear espaços de magia gastos na sessão (consistente com `hit_dice_spent` e death saves)

---

## Arquitetura

6 novas tabelas + 2 colunas adicionadas em `characters`.

```
classes ──┬── class_levels
          ├── class_features
          └── subclasses ──┬── subclass_features
                           └── characters.subclass_id

spells ──── character_spells ──── characters
```

---

## Tabelas

### `classes`

Dados estáticos por classe. Uma linha por classe (12 classes SRD).

```sql
CREATE TABLE classes (
  id                   text PRIMARY KEY,        -- slug: 'wizard', 'fighter'
  name                 text NOT NULL,           -- Português: 'Mago'
  name_en              text,
  description          text,
  hit_die              smallint NOT NULL,       -- 6 | 8 | 10 | 12
  primary_ability      text[],                 -- ex: ['intelligence']
  saving_throws        text[],                 -- 2 atributos: ['intelligence','wisdom']
  armor_proficiencies  text[],                 -- ['light','medium','shields']
  weapon_proficiencies text[],                 -- ['simple','martial'] ou armas específicas
  tool_proficiencies   text[],                 -- [] ou ['thieves_tools']
  skill_choices_count  smallint,               -- quantas perícias o jogador escolhe (2, 3 ou 4)
  skill_choices        text[],                 -- lista de perícias disponíveis para escolha
  speed                smallint DEFAULT 30,    -- deslocamento base em pés
  spellcasting_ability text,                   -- null = não-conjurador
  spellcasting_type    text,                   -- 'known' | 'prepared' | null
  source               text DEFAULT 'srd'
);
```

---

### `class_levels`

Progressão numérica nível a nível. 20 linhas por classe (240 total quando populado).

```sql
CREATE TABLE class_levels (
  id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  class_id          text NOT NULL REFERENCES classes(id),
  level             smallint NOT NULL,          -- 1–20
  proficiency_bonus smallint NOT NULL,          -- +2 a +6
  cantrips_known    smallint,                   -- null para não-conjuradores
  spells_known      smallint,                   -- null para conjuradores de magias preparadas
  slot_1            smallint DEFAULT 0,
  slot_2            smallint DEFAULT 0,
  slot_3            smallint DEFAULT 0,
  slot_4            smallint DEFAULT 0,
  slot_5            smallint DEFAULT 0,
  slot_6            smallint DEFAULT 0,
  slot_7            smallint DEFAULT 0,
  slot_8            smallint DEFAULT 0,
  slot_9            smallint DEFAULT 0,
  meta              jsonb,                      -- dados específicos: {"rages":2,"rage_damage":2} / {"ki_points":2}
  UNIQUE (class_id, level)
);
```

O campo `meta` absorve progressões numéricas específicas de cada classe (raivas do bárbaro, pontos ki do monge, pontos de feitiçaria do feiticeiro, etc.) sem exigir colunas extras na tabela.

---

### `class_features`

Habilidades ganhas por nível. Múltiplas linhas por `(class_id, level)`.

```sql
CREATE TABLE class_features (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  class_id    text NOT NULL REFERENCES classes(id),
  level       smallint NOT NULL,
  name        text NOT NULL,                  -- Português
  name_en     text,
  description text,
  type        text DEFAULT 'feature',         -- 'feature' | 'asi' | 'extra_attack' | 'spellcasting'
  source      text DEFAULT 'srd'
);
```

O campo `type` permite tratamento especial na UI: ao subir para um nível com `type = 'asi'`, a ficha pode abrir automaticamente o seletor de atributos.

---

### `subclasses`

Uma linha por subclasse. Estrutura completa; dados populados em pacotes futuros.

```sql
CREATE TABLE subclasses (
  id           text PRIMARY KEY,              -- slug: 'champion', 'life-domain'
  class_id     text NOT NULL REFERENCES classes(id),
  name         text NOT NULL,                -- Português: 'Campeão'
  name_en      text,
  description  text,
  level_gained smallint NOT NULL,            -- nível em que o jogador escolhe (1, 2 ou 3)
  source       text DEFAULT 'srd'
);
```

---

### `subclass_features`

Espelho de `class_features`, vinculado à subclasse.

```sql
CREATE TABLE subclass_features (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  subclass_id  text NOT NULL REFERENCES subclasses(id),
  level        smallint NOT NULL,
  name         text NOT NULL,
  name_en      text,
  description  text,
  type         text DEFAULT 'feature',       -- mesmos valores de class_features
  source       text DEFAULT 'srd'
);
```

---

### `character_spells`

Uma linha por personagem. Magias como array JSONB — padrão consistente com `attacks` e `inventory` em `characters`.

```sql
CREATE TABLE character_spells (
  character_id uuid PRIMARY KEY REFERENCES characters(id) ON DELETE CASCADE,
  spells       jsonb DEFAULT '[]',
  updated_at   timestamptz DEFAULT now()
);
```

**Formato do array `spells`:**
```json
[
  { "spell_id": "uuid-...", "status": "known" },
  { "spell_id": "uuid-...", "status": "prepared" }
]
```

- `"known"`: magia conhecida permanentemente (bardo, feiticeiro, bruxo, guardião)
- `"prepared"`: magia preparada no descanso longo (clérigo, druida, paladino, mago)

---

### Alterações em `characters`

```sql
ALTER TABLE characters
  ADD COLUMN subclass_id      text REFERENCES subclasses(id),
  ADD COLUMN spell_slots_used jsonb DEFAULT '{}';
```

`spell_slots_used` rastreia espaços gastos na sessão, no formato `{"1": 2, "2": 1}` (círculo → quantidade gasta). Resetado no descanso longo, consistente com `hit_dice_spent`.

---

## Abas na ficha de personagem

### Aba "Habilidades"
- Lista `class_features` + `subclass_features` do personagem filtradas pelo nível atual
- Agrupa por nível de aquisição
- Destaque visual para `type = 'asi'` e `'extra_attack'`

### Aba "Magias"
- Mostra slots disponíveis (`class_levels.slot_1..9`) menos `characters.spell_slots_used`
- Lista magias de `character_spells` agrupadas por círculo
- Botão para adicionar magia abre o Codex filtrado pela classe do personagem
- Distinção visual entre `known` e `prepared`

---

## Fora do escopo (fase 2)

- Popular dados das 12 classes SRD (seed SQL — por pacotes)
- Popular subclasses SRD
- Tela de level-up automático com seleção de ASI e subclasse
- Lógica de magias de subclasse (ex: magias de domínio do clérigo sempre preparadas)
