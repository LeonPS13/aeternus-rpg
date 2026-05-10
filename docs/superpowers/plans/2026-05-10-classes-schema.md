# Classes Schema — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Criar o schema de classes D&D 5e no Supabase e adicionar as abas "Habilidades" e "Magias" na ficha de personagem.

**Architecture:** 6 novas tabelas no Supabase (`classes`, `class_levels`, `class_features`, `subclasses`, `subclass_features`, `character_spells`) + 2 colunas novas em `characters`. No frontend: `types/class.ts`, `lib/classes.ts`, `lib/characterSpells.ts`, dois novos componentes de seção e os tabs adicionados em `SheetView.tsx`.

**Tech Stack:** Next.js 16, TypeScript 5, Supabase (PostgreSQL), Tailwind CSS v4, React 19.

---

## File Map

| Ação | Arquivo |
|---|---|
| Criar | `supabase/classes_schema.sql` |
| Criar | `types/class.ts` |
| Criar | `lib/classes.ts` |
| Criar | `lib/characterSpells.ts` |
| Modificar | `types/character.ts` |
| Modificar | `lib/character.ts` |
| Criar | `components/tools/CharacterSheet/sections/AbilitiesSection.tsx` |
| Criar | `components/tools/CharacterSheet/sections/SpellsSection.tsx` |
| Modificar | `components/tools/CharacterSheet/SheetView.tsx` |

---

## Task 1: Migração Supabase

**Files:**
- Create: `supabase/classes_schema.sql`

- [ ] **Step 1: Criar o arquivo de migração**

Criar `supabase/classes_schema.sql` com o conteúdo completo abaixo:

```sql
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
```

- [ ] **Step 2: Aplicar a migração no Supabase**

Abrir o Supabase Dashboard → projeto `zgebucfjvvctunnpdijn` → SQL Editor → colar e executar o conteúdo de `supabase/classes_schema.sql`.

Se o `character_id` retornar erro de tipo incompatível, substituir `uuid` por `text` na linha de criação de `character_spells`.

- [ ] **Step 3: Commit**

```bash
git add supabase/classes_schema.sql
git commit -m "feat: migration schema de classes, subclasses e character_spells"
```

---

## Task 2: Tipos TypeScript

**Files:**
- Create: `types/class.ts`

- [ ] **Step 1: Criar `types/class.ts`**

```typescript
export type SpellcastingType = 'known' | 'prepared'
export type FeatureType = 'feature' | 'asi' | 'extra_attack' | 'spellcasting'
export type CharacterSpellStatus = 'known' | 'prepared'

export interface ClassEntry {
  id: string
  name: string
  nameEn: string | null
  description: string | null
  hitDie: number
  primaryAbility: string[]
  savingThrows: string[]
  armorProficiencies: string[]
  weaponProficiencies: string[]
  toolProficiencies: string[]
  skillChoicesCount: number
  skillChoices: string[]
  speed: number
  spellcastingAbility: string | null
  spellcastingType: SpellcastingType | null
  source: string
}

export interface ClassLevel {
  id: string
  classId: string
  level: number
  proficiencyBonus: number
  cantripsKnown: number | null
  spellsKnown: number | null
  slot1: number
  slot2: number
  slot3: number
  slot4: number
  slot5: number
  slot6: number
  slot7: number
  slot8: number
  slot9: number
  meta: Record<string, unknown> | null
}

export interface ClassFeature {
  id: string
  classId: string
  level: number
  name: string
  nameEn: string | null
  description: string | null
  type: FeatureType
  source: string
}

export interface Subclass {
  id: string
  classId: string
  name: string
  nameEn: string | null
  description: string | null
  levelGained: number
  source: string
}

export interface SubclassFeature {
  id: string
  subclassId: string
  level: number
  name: string
  nameEn: string | null
  description: string | null
  type: FeatureType
  source: string
}

export interface CharacterSpell {
  spellId: string
  status: CharacterSpellStatus
}
```

- [ ] **Step 2: Verificar build**

```powershell
$env:PATH = "C:\Program Files\nodejs;$env:PATH"; npm.cmd run build
```

Esperado: sem erros de TypeScript em `types/class.ts`.

- [ ] **Step 3: Commit**

```bash
git add types/class.ts
git commit -m "feat: tipos TypeScript para classes, subclasses e magias do personagem"
```

---

## Task 3: Lib — dados de classe

**Files:**
- Create: `lib/classes.ts`

- [ ] **Step 1: Criar `lib/classes.ts`**

```typescript
import { getSupabase } from './supabase'
import type { ClassEntry, ClassLevel, ClassFeature, Subclass, SubclassFeature } from '@/types/class'

type ClassRow = {
  id: string; name: string; name_en: string | null; description: string | null
  hit_die: number; primary_ability: string[]; saving_throws: string[]
  armor_proficiencies: string[]; weapon_proficiencies: string[]; tool_proficiencies: string[]
  skill_choices_count: number; skill_choices: string[]; speed: number
  spellcasting_ability: string | null; spellcasting_type: string | null; source: string
}

type ClassLevelRow = {
  id: string; class_id: string; level: number; proficiency_bonus: number
  cantrips_known: number | null; spells_known: number | null
  slot_1: number; slot_2: number; slot_3: number; slot_4: number; slot_5: number
  slot_6: number; slot_7: number; slot_8: number; slot_9: number
  meta: Record<string, unknown> | null
}

type ClassFeatureRow = {
  id: string; class_id: string; level: number; name: string
  name_en: string | null; description: string | null; type: string; source: string
}

type SubclassRow = {
  id: string; class_id: string; name: string; name_en: string | null
  description: string | null; level_gained: number; source: string
}

type SubclassFeatureRow = {
  id: string; subclass_id: string; level: number; name: string
  name_en: string | null; description: string | null; type: string; source: string
}

function classFromRow(r: ClassRow): ClassEntry {
  return {
    id: r.id, name: r.name, nameEn: r.name_en, description: r.description,
    hitDie: r.hit_die, primaryAbility: r.primary_ability ?? [],
    savingThrows: r.saving_throws ?? [], armorProficiencies: r.armor_proficiencies ?? [],
    weaponProficiencies: r.weapon_proficiencies ?? [], toolProficiencies: r.tool_proficiencies ?? [],
    skillChoicesCount: r.skill_choices_count, skillChoices: r.skill_choices ?? [],
    speed: r.speed, spellcastingAbility: r.spellcasting_ability,
    spellcastingType: r.spellcasting_type as ClassEntry['spellcastingType'],
    source: r.source,
  }
}

function levelFromRow(r: ClassLevelRow): ClassLevel {
  return {
    id: r.id, classId: r.class_id, level: r.level, proficiencyBonus: r.proficiency_bonus,
    cantripsKnown: r.cantrips_known, spellsKnown: r.spells_known,
    slot1: r.slot_1, slot2: r.slot_2, slot3: r.slot_3, slot4: r.slot_4, slot5: r.slot_5,
    slot6: r.slot_6, slot7: r.slot_7, slot8: r.slot_8, slot9: r.slot_9,
    meta: r.meta,
  }
}

function featureFromRow(r: ClassFeatureRow): ClassFeature {
  return {
    id: r.id, classId: r.class_id, level: r.level, name: r.name,
    nameEn: r.name_en, description: r.description,
    type: r.type as ClassFeature['type'], source: r.source,
  }
}

function subclassFromRow(r: SubclassRow): Subclass {
  return {
    id: r.id, classId: r.class_id, name: r.name, nameEn: r.name_en,
    description: r.description, levelGained: r.level_gained, source: r.source,
  }
}

function subclassFeatureFromRow(r: SubclassFeatureRow): SubclassFeature {
  return {
    id: r.id, subclassId: r.subclass_id, level: r.level, name: r.name,
    nameEn: r.name_en, description: r.description,
    type: r.type as SubclassFeature['type'], source: r.source,
  }
}

export async function getClassById(id: string): Promise<ClassEntry | null> {
  const { data } = await getSupabase().from('classes').select('*').eq('id', id).single()
  return data ? classFromRow(data as ClassRow) : null
}

export async function getClassLevel(classId: string, level: number): Promise<ClassLevel | null> {
  const { data } = await getSupabase()
    .from('class_levels').select('*').eq('class_id', classId).eq('level', level).single()
  return data ? levelFromRow(data as ClassLevelRow) : null
}

export async function getClassFeatures(classId: string): Promise<ClassFeature[]> {
  const { data } = await getSupabase()
    .from('class_features').select('*').eq('class_id', classId).order('level')
  return (data ?? []).map(r => featureFromRow(r as ClassFeatureRow))
}

export async function getSubclass(id: string): Promise<Subclass | null> {
  const { data } = await getSupabase().from('subclasses').select('*').eq('id', id).single()
  return data ? subclassFromRow(data as SubclassRow) : null
}

export async function getSubclassFeatures(subclassId: string): Promise<SubclassFeature[]> {
  const { data } = await getSupabase()
    .from('subclass_features').select('*').eq('subclass_id', subclassId).order('level')
  return (data ?? []).map(r => subclassFeatureFromRow(r as SubclassFeatureRow))
}
```

- [ ] **Step 2: Verificar build**

```powershell
$env:PATH = "C:\Program Files\nodejs;$env:PATH"; npm.cmd run build
```

Esperado: sem erros em `lib/classes.ts`.

- [ ] **Step 3: Commit**

```bash
git add lib/classes.ts
git commit -m "feat: lib/classes.ts — fetch de classe, nível, habilidades e subclasses"
```

---

## Task 4: Lib — magias do personagem

**Files:**
- Create: `lib/characterSpells.ts`

- [ ] **Step 1: Criar `lib/characterSpells.ts`**

```typescript
import { getSupabase } from './supabase'
import type { CharacterSpell } from '@/types/class'

export async function getCharacterSpells(characterId: string): Promise<CharacterSpell[]> {
  const { data } = await getSupabase()
    .from('character_spells')
    .select('spells')
    .eq('character_id', characterId)
    .single()
  if (!data) return []
  return (data as { spells: CharacterSpell[] }).spells ?? []
}

export async function saveCharacterSpells(
  characterId: string,
  spells: CharacterSpell[],
): Promise<void> {
  await getSupabase()
    .from('character_spells')
    .upsert({ character_id: characterId, spells, updated_at: new Date().toISOString() })
}
```

- [ ] **Step 2: Verificar build**

```powershell
$env:PATH = "C:\Program Files\nodejs;$env:PATH"; npm.cmd run build
```

- [ ] **Step 3: Commit**

```bash
git add lib/characterSpells.ts
git commit -m "feat: lib/characterSpells.ts — get/save magias do personagem"
```

---

## Task 5: Atualizar tipo Character e lib/character.ts

**Files:**
- Modify: `types/character.ts`
- Modify: `lib/character.ts`

- [ ] **Step 1: Adicionar campos em `types/character.ts`**

Adicionar ao final da interface `Character` (após `flaws: string`):

```typescript
  // Section 10: Class system
  subclassId: string | null
  spellSlotsUsed: Record<string, number>
```

- [ ] **Step 2: Atualizar `toRow` em `lib/character.ts`**

Adicionar ao final do objeto retornado por `toRow`, após `flaws: c.flaws,`:

```typescript
    subclass_id: c.subclassId,
    spell_slots_used: c.spellSlotsUsed,
```

- [ ] **Step 3: Atualizar `fromRow` em `lib/character.ts`**

Adicionar ao final do objeto retornado por `fromRow`, após `flaws: r.flaws ?? '',`:

```typescript
    subclassId: r.subclass_id ?? null,
    spellSlotsUsed: (r.spell_slots_used as Record<string, number>) ?? {},
```

- [ ] **Step 4: Verificar build**

```powershell
$env:PATH = "C:\Program Files\nodejs;$env:PATH"; npm.cmd run build
```

Esperado: TypeScript deve reclamar de qualquer uso de `Character` que não tenha os novos campos — corrija os eventuais erros de spread/destructuring se aparecerem (improvável, pois `fromRow` já provê defaults).

- [ ] **Step 5: Commit**

```bash
git add types/character.ts lib/character.ts
git commit -m "feat: adiciona subclassId e spellSlotsUsed ao tipo Character"
```

---

## Task 6: Aba Habilidades

**Files:**
- Create: `components/tools/CharacterSheet/sections/AbilitiesSection.tsx`

- [ ] **Step 1: Criar `AbilitiesSection.tsx`**

```typescript
'use client'

import { useState, useEffect } from 'react'
import type { Character } from '@/types/character'
import type { ClassFeature, SubclassFeature, FeatureType } from '@/types/class'
import { getClassFeatures, getSubclassFeatures } from '@/lib/classes'

function FeatureBadge({ type }: { type: FeatureType }) {
  if (type === 'asi') return (
    <span className="rounded px-1.5 py-0.5 text-xs leading-none"
      style={{ background: 'rgba(201,168,76,0.15)', color: 'var(--color-gold)', border: '1px solid rgba(201,168,76,0.3)' }}>
      Melhoria de Atributo
    </span>
  )
  if (type === 'extra_attack') return (
    <span className="rounded px-1.5 py-0.5 text-xs leading-none"
      style={{ background: 'rgba(220,60,60,0.15)', color: '#f87171', border: '1px solid rgba(220,60,60,0.3)' }}>
      Ataque Extra
    </span>
  )
  if (type === 'spellcasting') return (
    <span className="rounded px-1.5 py-0.5 text-xs leading-none"
      style={{ background: 'rgba(100,40,140,0.15)', color: '#c084fc', border: '1px solid rgba(100,40,140,0.3)' }}>
      Conjuração
    </span>
  )
  return null
}

function FeatureItem({ feature, charLevel }: { feature: ClassFeature | SubclassFeature; charLevel: number }) {
  const [open, setOpen] = useState(false)
  const acquired = feature.level <= charLevel

  return (
    <div
      className="rounded p-3 transition-opacity"
      style={{
        background: 'var(--color-bg-secondary)',
        border: '1px solid var(--color-border-default)',
        opacity: acquired ? 1 : 0.4,
      }}
    >
      <button
        className="flex w-full items-start justify-between gap-2 text-left"
        onClick={() => setOpen(o => !o)}
      >
        <div className="flex flex-wrap items-center gap-2">
          <span className="text-base" style={{ color: 'var(--color-text-primary)' }}>
            {feature.name}
          </span>
          <FeatureBadge type={feature.type} />
        </div>
        <span className="shrink-0 rounded px-1.5 py-0.5 text-xs leading-none"
          style={{ background: 'var(--color-bg-tertiary)', color: 'var(--color-text-muted)', border: '1px solid var(--color-border-default)' }}>
          Nível {feature.level}
        </span>
      </button>
      {open && feature.description && (
        <p className="mt-2 whitespace-pre-line text-sm leading-relaxed"
          style={{ color: 'var(--color-text-secondary)' }}>
          {feature.description}
        </p>
      )}
    </div>
  )
}

interface Props {
  char: Character
}

export default function AbilitiesSection({ char }: Props) {
  const [classFeatures, setClassFeatures] = useState<ClassFeature[]>([])
  const [subFeatures, setSubFeatures] = useState<SubclassFeature[]>([])
  const [loading, setLoading] = useState(false)

  const classId = char.characterClass.toLowerCase().trim()

  useEffect(() => {
    if (!classId) return
    setLoading(true)
    Promise.all([
      getClassFeatures(classId),
      char.subclassId ? getSubclassFeatures(char.subclassId) : Promise.resolve([]),
    ]).then(([cf, sf]) => {
      setClassFeatures(cf)
      setSubFeatures(sf)
      setLoading(false)
    })
  }, [classId, char.subclassId])

  if (!classId) {
    return (
      <div className="flex flex-col items-center justify-center py-16 text-center">
        <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
          Defina a classe do personagem para ver as habilidades.
        </p>
      </div>
    )
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center py-16">
        <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Carregando habilidades…</p>
      </div>
    )
  }

  if (classFeatures.length === 0 && subFeatures.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center py-16 text-center">
        <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
          Nenhuma habilidade cadastrada para esta classe ainda.
        </p>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      {classFeatures.length > 0 && (
        <div>
          <p className="section-label mb-3">· Habilidades de Classe ·</p>
          <div className="space-y-2">
            {classFeatures.map(f => (
              <FeatureItem key={f.id} feature={f} charLevel={char.level} />
            ))}
          </div>
        </div>
      )}
      {subFeatures.length > 0 && (
        <div>
          <p className="section-label mb-3">· Habilidades de Subclasse ·</p>
          <div className="space-y-2">
            {subFeatures.map(f => (
              <FeatureItem key={f.id} feature={f} charLevel={char.level} />
            ))}
          </div>
        </div>
      )}
    </div>
  )
}
```

- [ ] **Step 2: Verificar build**

```powershell
$env:PATH = "C:\Program Files\nodejs;$env:PATH"; npm.cmd run build
```

- [ ] **Step 3: Commit**

```bash
git add components/tools/CharacterSheet/sections/AbilitiesSection.tsx
git commit -m "feat: AbilitiesSection — habilidades de classe e subclasse por nível"
```

---

## Task 7: Aba Magias

**Files:**
- Create: `components/tools/CharacterSheet/sections/SpellsSection.tsx`

- [ ] **Step 1: Criar `SpellsSection.tsx`**

```typescript
'use client'

import { useState, useEffect } from 'react'
import { Plus, X } from 'lucide-react'
import type { Character } from '@/types/character'
import type { CharacterSpell, ClassLevel } from '@/types/class'
import type { SpellEntry } from '@/types/spell'
import { getCharacterSpells, saveCharacterSpells } from '@/lib/characterSpells'
import { getClassLevel } from '@/lib/classes'
import { getSpellEntries, spellLevelLabel, spellLevelShort, translateSchool, SCHOOL_COLORS } from '@/lib/spells'

const SLOT_KEYS: (keyof ClassLevel)[] = [
  'slot1','slot2','slot3','slot4','slot5','slot6','slot7','slot8','slot9',
]

function SlotPips({ total, used, onToggle }: {
  total: number
  used: number
  onToggle: (idx: number) => void
}) {
  return (
    <div className="flex flex-wrap gap-1.5">
      {Array.from({ length: total }).map((_, i) => (
        <button
          key={i}
          onClick={() => onToggle(i)}
          className="h-4 w-4 rounded-full border transition-all"
          style={{
            background: i < used ? 'var(--color-bg-tertiary)' : 'var(--color-gold-glow)',
            borderColor: i < used ? 'var(--color-border-default)' : 'var(--color-gold)',
          }}
        />
      ))}
    </div>
  )
}

interface Props {
  char: Character
  onChange: (updates: Partial<Character>) => void
}

export default function SpellsSection({ char, onChange }: Props) {
  const [charSpells, setCharSpells] = useState<CharacterSpell[]>([])
  const [allSpells, setAllSpells]   = useState<SpellEntry[]>([])
  const [classLevel, setClassLevel] = useState<ClassLevel | null>(null)
  const [loading, setLoading]       = useState(true)
  const [showPicker, setShowPicker] = useState(false)
  const [pickerSearch, setPickerSearch] = useState('')

  const classId = char.characterClass.toLowerCase().trim()

  useEffect(() => {
    if (!classId) { setLoading(false); return }
    Promise.all([
      getCharacterSpells(char.id),
      getSpellEntries(),
      getClassLevel(classId, char.level),
    ]).then(([cs, spells, cl]) => {
      setCharSpells(cs)
      setAllSpells(spells)
      setClassLevel(cl)
      setLoading(false)
    })
  }, [char.id, classId, char.level])

  const spellMap = new Map(allSpells.map(s => [s.id, s]))

  function toggleSlot(circle: number, idx: number) {
    const key = String(circle)
    const current = char.spellSlotsUsed[key] ?? 0
    const total = classLevel ? (classLevel[SLOT_KEYS[circle - 1]] as number) : 0
    const newUsed = idx < current ? idx : Math.min(idx + 1, total)
    onChange({ spellSlotsUsed: { ...char.spellSlotsUsed, [key]: newUsed } })
  }

  async function removeSpell(spellId: string) {
    const updated = charSpells.filter(s => s.spellId !== spellId)
    setCharSpells(updated)
    await saveCharacterSpells(char.id, updated)
  }

  async function addSpell(spell: SpellEntry) {
    if (charSpells.some(s => s.spellId === spell.id)) return
    const updated: CharacterSpell[] = [...charSpells, { spellId: spell.id, status: 'known' }]
    setCharSpells(updated)
    await saveCharacterSpells(char.id, updated)
    setShowPicker(false)
    setPickerSearch('')
  }

  const isSpellcaster = !!classLevel && SLOT_KEYS.some(k => (classLevel[k] as number) > 0)

  const grouped = new Map<number, { entry: SpellEntry; cs: CharacterSpell }[]>()
  for (const cs of charSpells) {
    const entry = spellMap.get(cs.spellId)
    if (!entry) continue
    if (!grouped.has(entry.level)) grouped.set(entry.level, [])
    grouped.get(entry.level)!.push({ entry, cs })
  }
  const sortedGroups = Array.from(grouped.entries()).sort(([a], [b]) => a - b)

  const pickerSpells = allSpells.filter(s => {
    if (charSpells.some(cs => cs.spellId === s.id)) return false
    if (classId && !(s.classes as string[]).includes(classId)) return false
    const q = pickerSearch.toLowerCase()
    if (q && !s.name.toLowerCase().includes(q) && !translateSchool(s.school).toLowerCase().includes(q)) return false
    return true
  })

  if (!classId) {
    return (
      <div className="flex flex-col items-center justify-center py-16 text-center">
        <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
          Defina a classe do personagem para ver as magias.
        </p>
      </div>
    )
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center py-16">
        <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Carregando magias…</p>
      </div>
    )
  }

  if (!isSpellcaster && classLevel) {
    return (
      <div className="flex flex-col items-center justify-center py-16 text-center">
        <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
          Esta classe não possui conjuração neste nível.
        </p>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      {/* Spell slot tracker */}
      {isSpellcaster && classLevel && (
        <div>
          <p className="section-label mb-3">· Espaços de Magia ·</p>
          <div className="arcane-panel p-4 space-y-3">
            {SLOT_KEYS.map((key, i) => {
              const circle = i + 1
              const total = classLevel[key] as number
              if (total === 0) return null
              const used = char.spellSlotsUsed[String(circle)] ?? 0
              return (
                <div key={circle} className="flex items-center gap-3">
                  <span className="w-20 shrink-0 text-sm" style={{ color: 'var(--color-text-muted)' }}>
                    {circle}º círculo
                  </span>
                  <SlotPips
                    total={total}
                    used={used}
                    onToggle={(idx) => toggleSlot(circle, idx)}
                  />
                  <span className="text-sm tabular-nums" style={{ color: 'var(--color-text-muted)' }}>
                    {total - used}/{total}
                  </span>
                </div>
              )
            })}
          </div>
        </div>
      )}

      {/* Spell list */}
      <div>
        <div className="mb-3 flex items-center justify-between">
          <p className="section-label">· Magias Conhecidas ·</p>
          <button
            onClick={() => setShowPicker(true)}
            className="arcane-btn flex items-center gap-1.5 px-3 py-1.5 text-sm"
          >
            <Plus size={14} /> Adicionar
          </button>
        </div>

        {sortedGroups.length === 0 ? (
          <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
            Nenhuma magia adicionada ainda.
          </p>
        ) : (
          <div className="space-y-4">
            {sortedGroups.map(([level, items]) => (
              <div key={level}>
                <p className="mb-2 text-sm" style={{ color: 'var(--color-text-muted)' }}>
                  {spellLevelLabel(level)}
                </p>
                <div className="space-y-1.5">
                  {items.map(({ entry, cs }) => {
                    const color = SCHOOL_COLORS[entry.school] ?? SCHOOL_COLORS.evocation
                    return (
                      <div
                        key={entry.id}
                        className="flex items-center justify-between rounded p-2.5"
                        style={{ background: 'var(--color-bg-secondary)', border: '1px solid var(--color-border-default)' }}
                      >
                        <div className="flex min-w-0 items-center gap-2">
                          <span className="shrink-0 rounded px-1.5 py-0.5 text-xs leading-none"
                            style={{ background: color.bg, color: color.color, border: `1px solid ${color.border}` }}>
                            {translateSchool(entry.school)}
                          </span>
                          <span className="truncate text-base" style={{ color: 'var(--color-text-primary)' }}>
                            {entry.name}
                          </span>
                          <span className="shrink-0 text-xs" style={{ color: 'var(--color-text-muted)' }}>
                            {cs.status === 'prepared' ? 'Preparada' : 'Conhecida'}
                          </span>
                        </div>
                        <button
                          onClick={() => removeSpell(entry.id)}
                          className="ml-2 shrink-0 rounded p-1"
                          style={{ color: 'var(--color-text-muted)' }}
                        >
                          <X size={14} />
                        </button>
                      </div>
                    )
                  })}
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Spell picker modal */}
      {showPicker && (
        <div
          className="fixed inset-0 z-50 flex items-center justify-center p-4"
          style={{ background: 'rgba(0,0,0,0.75)' }}
          onClick={() => { setShowPicker(false); setPickerSearch('') }}
        >
          <div
            className="arcane-panel relative w-full max-w-lg overflow-hidden"
            style={{ maxHeight: '80vh' }}
            onClick={e => e.stopPropagation()}
          >
            <div className="border-b p-4" style={{ borderColor: 'var(--color-border-default)' }}>
              <h3 className="mb-2 text-lg" style={{ color: 'var(--color-text-primary)' }}>
                Adicionar Magia
              </h3>
              <input
                type="text"
                placeholder="Buscar magia…"
                value={pickerSearch}
                onChange={e => setPickerSearch(e.target.value)}
                autoFocus
                className="w-full rounded py-2 px-3 text-base outline-none"
                style={{
                  background: 'var(--color-bg-tertiary)',
                  border: '1px solid var(--color-border-default)',
                  color: 'var(--color-text-primary)',
                }}
              />
            </div>
            <div className="overflow-y-auto" style={{ maxHeight: 'calc(80vh - 120px)' }}>
              {pickerSpells.length === 0 ? (
                <p className="p-4 text-sm" style={{ color: 'var(--color-text-muted)' }}>
                  Nenhuma magia disponível.
                </p>
              ) : (
                pickerSpells.map(spell => {
                  const color = SCHOOL_COLORS[spell.school] ?? SCHOOL_COLORS.evocation
                  return (
                    <button
                      key={spell.id}
                      onClick={() => addSpell(spell)}
                      className="flex w-full items-center gap-3 p-3 text-left transition-opacity hover:opacity-80"
                      style={{ borderBottom: '1px solid var(--color-border-default)' }}
                    >
                      <span className="shrink-0 rounded px-1.5 py-0.5 text-xs leading-none"
                        style={{ background: color.bg, color: color.color, border: `1px solid ${color.border}` }}>
                        {spellLevelShort(spell.level)}
                      </span>
                      <span className="flex-1 text-base" style={{ color: 'var(--color-text-primary)' }}>
                        {spell.name}
                      </span>
                      <span className="text-xs" style={{ color: 'var(--color-text-muted)' }}>
                        {translateSchool(spell.school)}
                      </span>
                    </button>
                  )
                })
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
```

- [ ] **Step 2: Verificar build**

```powershell
$env:PATH = "C:\Program Files\nodejs;$env:PATH"; npm.cmd run build
```

- [ ] **Step 3: Commit**

```bash
git add components/tools/CharacterSheet/sections/SpellsSection.tsx
git commit -m "feat: SpellsSection — tracker de espaços e lista de magias do personagem"
```

---

## Task 8: Adicionar tabs em SheetView

**Files:**
- Modify: `components/tools/CharacterSheet/SheetView.tsx`

- [ ] **Step 1: Adicionar imports e tabs**

Substituir o bloco de imports e o array `TABS` atual:

```typescript
// De (linhas 1-18 atuais):
'use client'

import { useState } from 'react'
import { ArrowLeft, Save, Trash2 } from 'lucide-react'
import type { Character } from '@/types/character'
import IdentitySection from './sections/IdentitySection'
import StatsSection from './sections/StatsSection'
import CombatSection from './sections/CombatSection'
import EquipmentSection from './sections/EquipmentSection'
import TraitsSection from './sections/TraitsSection'

const TABS = [
  { key: 'identity',   label: 'Identidade'  },
  { key: 'attributes', label: 'Atributos'   },
  { key: 'combat',     label: 'Combate'     },
  { key: 'equipment',  label: 'Equipamento' },
  { key: 'traits',     label: 'Traços'      },
] as const
type TabKey = (typeof TABS)[number]['key']
```

```typescript
// Para:
'use client'

import { useState } from 'react'
import { ArrowLeft, Save, Trash2 } from 'lucide-react'
import type { Character } from '@/types/character'
import IdentitySection from './sections/IdentitySection'
import StatsSection from './sections/StatsSection'
import CombatSection from './sections/CombatSection'
import EquipmentSection from './sections/EquipmentSection'
import TraitsSection from './sections/TraitsSection'
import AbilitiesSection from './sections/AbilitiesSection'
import SpellsSection from './sections/SpellsSection'

const TABS = [
  { key: 'identity',   label: 'Identidade'  },
  { key: 'attributes', label: 'Atributos'   },
  { key: 'combat',     label: 'Combate'     },
  { key: 'equipment',  label: 'Equipamento' },
  { key: 'traits',     label: 'Traços'      },
  { key: 'abilities',  label: 'Habilidades' },
  { key: 'spells',     label: 'Magias'      },
] as const
type TabKey = (typeof TABS)[number]['key']
```

- [ ] **Step 2: Adicionar rendering das novas abas**

Substituir o bloco de section content (linhas 116-121 atuais):

```typescript
// De:
      {activeTab === 'identity'   && <IdentitySection  char={char} onChange={onChange} />}
      {activeTab === 'attributes' && <StatsSection     char={char} onChange={onChange} />}
      {activeTab === 'combat'     && <CombatSection    char={char} onChange={onChange} />}
      {activeTab === 'equipment'  && <EquipmentSection char={char} onChange={onChange} />}
      {activeTab === 'traits'     && <TraitsSection    char={char} onChange={onChange} />}
```

```typescript
// Para:
      {activeTab === 'identity'   && <IdentitySection  char={char} onChange={onChange} />}
      {activeTab === 'attributes' && <StatsSection     char={char} onChange={onChange} />}
      {activeTab === 'combat'     && <CombatSection    char={char} onChange={onChange} />}
      {activeTab === 'equipment'  && <EquipmentSection char={char} onChange={onChange} />}
      {activeTab === 'traits'     && <TraitsSection    char={char} onChange={onChange} />}
      {activeTab === 'abilities'  && <AbilitiesSection char={char} />}
      {activeTab === 'spells'     && <SpellsSection    char={char} onChange={onChange} />}
```

- [ ] **Step 3: Verificar build**

```powershell
$env:PATH = "C:\Program Files\nodejs;$env:PATH"; npm.cmd run build
```

Esperado: build sem erros. O TypeScript vai confirmar que `AbilitiesSection` recebe `{ char }` e `SpellsSection` recebe `{ char, onChange }`.

- [ ] **Step 4: Verificação manual**

Iniciar o servidor de desenvolvimento:

```powershell
$env:PATH = "C:\Program Files\nodejs;$env:PATH"; npm.cmd run dev
```

Navegar até uma ficha de personagem em modo de edição e verificar:
- Os tabs "Habilidades" e "Magias" aparecem na barra de tabs
- Aba Habilidades: exibe "Nenhuma habilidade cadastrada para esta classe ainda" (tabelas vazias por enquanto)
- Aba Magias: exibe "Esta classe não possui conjuração neste nível" se class_levels vazio, ou lista vazia com botão "Adicionar" se a classe for de conjuração
- Nenhuma regressão nas outras abas

- [ ] **Step 5: Commit**

```bash
git add components/tools/CharacterSheet/SheetView.tsx
git commit -m "feat: tabs Habilidades e Magias na ficha de personagem"
```

---

## Self-Review

### Cobertura do spec

| Requisito do spec | Task |
|---|---|
| 6 tabelas Supabase | Task 1 |
| RLS aberto em todas as tabelas | Task 1 |
| `characters.subclass_id` e `spell_slots_used` | Task 1 + Task 5 |
| `types/class.ts` com todos os tipos | Task 2 |
| `lib/classes.ts` com get functions | Task 3 |
| `lib/characterSpells.ts` com upsert | Task 4 |
| Character type atualizado | Task 5 |
| Aba Habilidades — features por nível, opacidade pré-requisito | Task 6 |
| Aba Magias — slot tracker + lista + picker filtrado por classe | Task 7 |
| Tabs integrados ao SheetView | Task 8 |

### Consistência de tipos

- `ClassLevel.slot1..slot9` usados como `SLOT_KEYS` em `SpellsSection` ✓
- `CharacterSpell.spellId` consistente entre `lib/characterSpells.ts` e `SpellsSection` ✓
- `char.characterClass.toLowerCase()` como classId em ambas as sections ✓
- `char.spellSlotsUsed` tipado como `Record<string, number>` e usado com `String(circle)` como chave ✓
