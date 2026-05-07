import type { Character, SkillName, AttackStat } from '@/types/character'

export const ATTR_DEFS = [
  { key: 'strScore' as const, abbr: 'FOR', label: 'Força' },
  { key: 'dexScore' as const, abbr: 'DES', label: 'Destreza' },
  { key: 'conScore' as const, abbr: 'CON', label: 'Constituição' },
  { key: 'intScore' as const, abbr: 'INT', label: 'Inteligência' },
  { key: 'wisScore' as const, abbr: 'SAB', label: 'Sabedoria' },
  { key: 'chaScore' as const, abbr: 'CAR', label: 'Carisma' },
] as const

export type AttrKey = (typeof ATTR_DEFS)[number]['key']

export const SAVE_DEFS = [
  { profKey: 'saveStrProficient' as const, scoreKey: 'strScore' as const, label: 'Força' },
  { profKey: 'saveDexProficient' as const, scoreKey: 'dexScore' as const, label: 'Destreza' },
  { profKey: 'saveConProficient' as const, scoreKey: 'conScore' as const, label: 'Constituição' },
  { profKey: 'saveIntProficient' as const, scoreKey: 'intScore' as const, label: 'Inteligência' },
  { profKey: 'saveWisProficient' as const, scoreKey: 'wisScore' as const, label: 'Sabedoria' },
  { profKey: 'saveChaProficient' as const, scoreKey: 'chaScore' as const, label: 'Carisma' },
] as const

export const SKILL_ATTR_MAP: Record<SkillName, AttrKey> = {
  acrobatics: 'dexScore',    arcana: 'intScore',      athletics: 'strScore',
  performance: 'chaScore',   deception: 'chaScore',   stealth: 'dexScore',
  history: 'intScore',       intimidation: 'chaScore', insight: 'wisScore',
  investigation: 'intScore', animalHandling: 'wisScore', medicine: 'wisScore',
  nature: 'intScore',        perception: 'wisScore',  persuasion: 'chaScore',
  sleightOfHand: 'dexScore', religion: 'intScore',    survival: 'wisScore',
}

export const SKILL_LABELS: Record<SkillName, string> = {
  acrobatics: 'Acrobacia',    arcana: 'Arcanismo',       athletics: 'Atletismo',
  performance: 'Atuação',    deception: 'Enganação',    stealth: 'Furtividade',
  history: 'História',       intimidation: 'Intimidação', insight: 'Intuição',
  investigation: 'Investigação', animalHandling: 'Adestrar Animais', medicine: 'Medicina',
  nature: 'Natureza',        perception: 'Percepção',   persuasion: 'Persuasão',
  sleightOfHand: 'Prestidigitação', religion: 'Religião', survival: 'Sobrevivência',
}

export const SKILL_ATTR_ABBR: Record<SkillName, string> = {
  acrobatics: 'DES', arcana: 'INT', athletics: 'FOR', performance: 'CAR',
  deception: 'CAR',  stealth: 'DES', history: 'INT', intimidation: 'CAR',
  insight: 'SAB',    investigation: 'INT', animalHandling: 'SAB', medicine: 'SAB',
  nature: 'INT',     perception: 'SAB', persuasion: 'CAR', sleightOfHand: 'DES',
  religion: 'INT',   survival: 'SAB',
}

export const HIT_DICE_BY_CLASS: Record<string, string> = {
  Barbarian: 'd12',
  Fighter: 'd10', Paladin: 'd10', Ranger: 'd10',
  Bard: 'd8', Cleric: 'd8', Druid: 'd8', Monk: 'd8', Rogue: 'd8', Warlock: 'd8',
  Sorcerer: 'd6', Wizard: 'd6',
}

export function mod(score: number): number {
  return Math.floor((score - 10) / 2)
}

export function profBonus(level: number): number {
  return Math.ceil(level / 4) + 1
}

export function fmtMod(n: number): string {
  return n >= 0 ? `+${n}` : `${n}`
}

export function calcAC(c: Character): number {
  const dexMod = mod(c.dexScore)
  const dexContrib =
    c.acArmorType === 'heavy' ? 0 :
    c.acArmorType === 'medium' ? Math.min(dexMod, 2) :
    dexMod
  const base = c.acArmorType === 'none' ? 10 : (c.acArmorEquipped || 10)
  return base + dexContrib + c.acShieldBonus + c.acExtraBonus
}

export function calcInitiative(c: Character): number {
  return mod(c.dexScore) + c.initiativeBonus
}

export function calcPassivePerception(c: Character): number {
  const pb = profBonus(c.level)
  const s = c.skills.perception
  return 10 + mod(c.wisScore) + (s.proficient ? pb : 0) + (s.expert ? pb : 0)
}

export function calcSkillValue(c: Character, skill: SkillName): number {
  const pb = profBonus(c.level)
  const s = c.skills[skill]
  return mod(c[SKILL_ATTR_MAP[skill]] as number) + (s.proficient ? pb : 0) + (s.expert ? pb : 0)
}

export function calcSaveValue(c: Character, scoreKey: AttrKey, profKey: keyof Character): number {
  return mod(c[scoreKey] as number) + (c[profKey] ? profBonus(c.level) : 0)
}

export const STAT_TO_ATTR: Record<AttackStat, AttrKey> = {
  str: 'strScore', dex: 'dexScore', con: 'conScore',
  int: 'intScore', wis: 'wisScore', cha: 'chaScore',
}

export function calcAttackBonus(c: Character, stat: AttackStat): string {
  return fmtMod(mod(c[STAT_TO_ATTR[stat]] as number) + profBonus(c.level))
}
