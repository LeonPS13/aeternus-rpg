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
