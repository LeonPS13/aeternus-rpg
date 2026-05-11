export type SpellSchool =
  | 'abjuration' | 'conjuration' | 'divination' | 'enchantment'
  | 'evocation'  | 'illusion'    | 'necromancy'  | 'transmutation'

export type SpellClass =
  | 'bard' | 'cleric' | 'druid' | 'paladin'
  | 'ranger' | 'sorcerer' | 'warlock' | 'wizard'

export const SPELL_CLASSES: SpellClass[] = [
  'bard', 'cleric', 'druid', 'paladin',
  'ranger', 'sorcerer', 'warlock', 'wizard',
]

export interface SpellEntry {
  id: string
  name: string
  nameEn: string | null
  level: number               // 0 = cantrip / truque
  school: SpellSchool
  castingTime: string
  range: string
  components: string
  duration: string
  concentration: boolean
  ritual: boolean
  description: string
  higherLevels: string | null
  classes: SpellClass[]
  source: string
  createdAt: string
  updatedAt: string
}
