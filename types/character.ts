export const CLASSES = [
  'Barbarian', 'Bard', 'Cleric', 'Druid', 'Fighter',
  'Monk', 'Paladin', 'Ranger', 'Rogue', 'Sorcerer', 'Warlock', 'Wizard',
] as const

export const RACES = [
  'Dwarf', 'Elf', 'Halfling', 'Human', 'Dragonborn',
  'Gnome', 'Half-Elf', 'Half-Orc', 'Tiefling',
] as const

export const ALIGNMENTS = [
  'Leal e Bom', 'Neutro e Bom', 'Caótico e Bom',
  'Leal e Neutro', 'Neutro', 'Caótico e Neutro',
  'Leal e Mau', 'Neutro e Mau', 'Caótico e Mau',
] as const

export const ARMOR_TYPES = ['none', 'light', 'medium', 'heavy'] as const
export type ArmorType = (typeof ARMOR_TYPES)[number]

export const SKILL_NAMES = [
  'acrobatics', 'arcana', 'athletics', 'performance', 'deception',
  'stealth', 'history', 'intimidation', 'insight', 'investigation',
  'animalHandling', 'medicine', 'nature', 'perception', 'persuasion',
  'sleightOfHand', 'religion', 'survival',
] as const
export type SkillName = (typeof SKILL_NAMES)[number]

export interface CharacterSkill {
  proficient: boolean
  expert: boolean
}
export type Skills = Record<SkillName, CharacterSkill>

export function defaultSkills(): Skills {
  return Object.fromEntries(
    SKILL_NAMES.map((s) => [s, { proficient: false, expert: false }])
  ) as Skills
}

export type AttackStat = 'str' | 'dex' | 'con' | 'int' | 'wis' | 'cha'

export interface CharacterAttack {
  id: string
  name: string
  attackBonus: string
  damage: string
  damageType: string
  stat?: AttackStat
  damageDice?: string   // base dice without modifier (e.g. "1d8"); when set + stat set, modifier is computed live
  magicBonus?: number   // magic weapon bonus applied to both attack and damage
}

export interface InventoryItem {
  id: string
  name: string
  quantity: number
  weight: number
  description?: string
}

export interface Character {
  id: string
  playerId: string
  createdAt: string
  updatedAt: string
  // Section 1: Header
  characterName: string
  playerName: string
  characterClass: string
  level: number
  race: string
  background: string
  alignment: string
  xp: number
  // Section 2: Core Stats
  strScore: number
  dexScore: number
  conScore: number
  intScore: number
  wisScore: number
  chaScore: number
  // Section 3: Core Mechanics
  inspiration: boolean
  acArmorEquipped: number
  acShieldBonus: number
  acExtraBonus: number
  acArmorType: ArmorType
  speed: number
  initiativeBonus: number
  // Section 4: Saving Throws
  saveStrProficient: boolean
  saveDexProficient: boolean
  saveConProficient: boolean
  saveIntProficient: boolean
  saveWisProficient: boolean
  saveChaProficient: boolean
  // Section 5: Skills
  skills: Skills
  // Section 6: Vitality
  maxHp: number
  currentHp: number
  tempHp: number
  hitDiceSpent: number
  deathSavesSuccess: number
  deathSavesFailure: number
  // Section 7: Attacks
  attacks: CharacterAttack[]
  // Section 8: Equipment
  cp: number
  sp: number
  ep: number
  gp: number
  pp: number
  inventory: InventoryItem[]
  // Section 9: Traits
  otherProficiencies: string
  featuresTraits: string
  personalityTraits: string
  ideals: string
  bonds: string
  flaws: string
}
