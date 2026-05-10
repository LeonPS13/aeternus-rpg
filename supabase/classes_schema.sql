-- =============================================
-- CLASSES SCHEMA
-- =============================================

CREATE TABLE IF NOT EXISTS classes (
  id                   text PRIMARY KEY,
  name                 text NOT NULL,
  name_en              text,
  description          text,
  hit_die              smallint NOT NULL,
  primary_ability      text[],
  saving_throws        text[],
  armor_proficiencies  text[],
  weapon_proficiencies text[],
  tool_proficiencies   text[],
  skill_choices_count  smallint,
  skill_choices        text[],
  speed                smallint NOT NULL DEFAULT 30,
  spellcasting_ability text,
  spellcasting_type    text,
  source               text NOT NULL DEFAULT 'srd'
);

ALTER TABLE classes ENABLE ROW LEVEL SECURITY;
CREATE POLICY "open" ON classes FOR ALL USING (true) WITH CHECK (true);

-- =============================================

CREATE TABLE IF NOT EXISTS class_levels (
  id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  class_id          text NOT NULL REFERENCES classes(id),
  level             smallint NOT NULL,
  proficiency_bonus smallint NOT NULL,
  cantrips_known    smallint,
  spells_known      smallint,
  slot_1            smallint NOT NULL DEFAULT 0,
  slot_2            smallint NOT NULL DEFAULT 0,
  slot_3            smallint NOT NULL DEFAULT 0,
  slot_4            smallint NOT NULL DEFAULT 0,
  slot_5            smallint NOT NULL DEFAULT 0,
  slot_6            smallint NOT NULL DEFAULT 0,
  slot_7            smallint NOT NULL DEFAULT 0,
  slot_8            smallint NOT NULL DEFAULT 0,
  slot_9            smallint NOT NULL DEFAULT 0,
  meta              jsonb,
  UNIQUE (class_id, level)
);

ALTER TABLE class_levels ENABLE ROW LEVEL SECURITY;
CREATE POLICY "open" ON class_levels FOR ALL USING (true) WITH CHECK (true);

-- =============================================

CREATE TABLE IF NOT EXISTS class_features (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  class_id    text NOT NULL REFERENCES classes(id),
  level       smallint NOT NULL,
  name        text NOT NULL,
  name_en     text,
  description text,
  type        text NOT NULL DEFAULT 'feature',
  source      text NOT NULL DEFAULT 'srd'
);

ALTER TABLE class_features ENABLE ROW LEVEL SECURITY;
CREATE POLICY "open" ON class_features FOR ALL USING (true) WITH CHECK (true);

-- =============================================

CREATE TABLE IF NOT EXISTS subclasses (
  id           text PRIMARY KEY,
  class_id     text NOT NULL REFERENCES classes(id),
  name         text NOT NULL,
  name_en      text,
  description  text,
  level_gained smallint NOT NULL,
  source       text NOT NULL DEFAULT 'srd'
);

ALTER TABLE subclasses ENABLE ROW LEVEL SECURITY;
CREATE POLICY "open" ON subclasses FOR ALL USING (true) WITH CHECK (true);

-- =============================================

CREATE TABLE IF NOT EXISTS subclass_features (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  subclass_id  text NOT NULL REFERENCES subclasses(id),
  level        smallint NOT NULL,
  name         text NOT NULL,
  name_en      text,
  description  text,
  type         text NOT NULL DEFAULT 'feature',
  source       text NOT NULL DEFAULT 'srd'
);

ALTER TABLE subclass_features ENABLE ROW LEVEL SECURITY;
CREATE POLICY "open" ON subclass_features FOR ALL USING (true) WITH CHECK (true);

-- =============================================
-- character_spells: uma linha por personagem, spells como JSONB
-- Formato de cada item: { "spell_id": "uuid", "status": "known" | "prepared" }
-- =============================================

CREATE TABLE IF NOT EXISTS character_spells (
  -- IMPORTANTE: verificar se characters.id é uuid ou text no Supabase.
  -- Se character_id der erro de tipo, mudar para text.
  character_id uuid PRIMARY KEY REFERENCES characters(id) ON DELETE CASCADE,
  spells       jsonb NOT NULL DEFAULT '[]',
  updated_at   timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE character_spells ENABLE ROW LEVEL SECURITY;
CREATE POLICY "open" ON character_spells FOR ALL USING (true) WITH CHECK (true);

-- =============================================
-- Alterações em characters
-- =============================================

ALTER TABLE characters
  ADD COLUMN IF NOT EXISTS subclass_id      text REFERENCES subclasses(id),
  ADD COLUMN IF NOT EXISTS spell_slots_used jsonb NOT NULL DEFAULT '{}';
