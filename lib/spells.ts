import { getSupabase } from './supabase'
import type { SpellEntry } from '@/types/spell'

type SpellRow = {
  id: string
  name: string
  name_en: string | null
  level: number
  school: string
  casting_time: string
  range: string
  components: string
  duration: string
  concentration: boolean
  ritual: boolean
  description: string
  higher_levels: string | null
  classes: string[]
  source: string
  created_at: string
  updated_at: string
}

function fromRow(r: SpellRow): SpellEntry {
  return {
    id:            r.id,
    name:          r.name,
    nameEn:        r.name_en,
    level:         r.level,
    school:        r.school as SpellEntry['school'],
    castingTime:   r.casting_time,
    range:         r.range,
    components:    r.components,
    duration:      r.duration,
    concentration: r.concentration,
    ritual:        r.ritual,
    description:   r.description,
    higherLevels:  r.higher_levels,
    classes:       r.classes as SpellEntry['classes'],
    source:        r.source,
    createdAt:     r.created_at,
    updatedAt:     r.updated_at,
  }
}

export async function getSpellEntries(): Promise<SpellEntry[]> {
  const { data, error } = await getSupabase()
    .from('spells')
    .select('*')
    .order('level')
    .order('name')
  if (error || !data) return []
  return (data as SpellRow[]).map(fromRow)
}

export function translateSchool(school: string): string {
  const map: Record<string, string> = {
    abjuration:    'Abjuração',
    conjuration:   'Conjuração',
    divination:    'Adivinhação',
    enchantment:   'Encantamento',
    evocation:     'Evocação',
    illusion:      'Ilusão',
    necromancy:    'Necromancia',
    transmutation: 'Transmutação',
  }
  return map[school] ?? school
}

export function translateSpellClass(cls: string): string {
  const map: Record<string, string> = {
    bard:     'Bardo',
    cleric:   'Clérigo',
    druid:    'Druida',
    paladin:  'Paladino',
    ranger:   'Guardião',
    sorcerer: 'Feiticeiro',
    warlock:  'Bruxo',
    wizard:   'Mago',
  }
  return map[cls] ?? cls
}

export function spellLevelLabel(level: number): string {
  if (level === 0) return 'Truques'
  const ord = ['', '1º', '2º', '3º', '4º', '5º', '6º', '7º', '8º', '9º']
  return `${ord[level]} Círculo`
}

export function spellLevelShort(level: number): string {
  if (level === 0) return 'Truque'
  return `${level}º círculo`
}

export const SCHOOL_COLORS: Record<string, { bg: string; color: string; border: string }> = {
  abjuration:    { bg: 'rgba(40,80,160,0.2)',  color: '#7eb8f7', border: 'rgba(40,80,160,0.4)'  },
  conjuration:   { bg: 'rgba(100,40,140,0.2)', color: '#c084fc', border: 'rgba(100,40,140,0.4)' },
  divination:    { bg: 'rgba(40,120,100,0.2)', color: '#6ee7b7', border: 'rgba(40,120,100,0.4)' },
  enchantment:   { bg: 'rgba(160,40,100,0.2)', color: '#f9a8d4', border: 'rgba(160,40,100,0.4)' },
  evocation:     { bg: 'rgba(180,60,20,0.2)',  color: '#fb923c', border: 'rgba(180,60,20,0.4)'  },
  illusion:      { bg: 'rgba(60,40,140,0.2)',  color: '#a78bfa', border: 'rgba(60,40,140,0.4)'  },
  necromancy:    { bg: 'rgba(30,80,30,0.2)',   color: '#86efac', border: 'rgba(30,80,30,0.4)'   },
  transmutation: { bg: 'rgba(140,120,20,0.2)', color: '#fde047', border: 'rgba(140,120,20,0.4)' },
}
