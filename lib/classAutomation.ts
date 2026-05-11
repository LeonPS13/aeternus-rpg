import type { Character, SkillName } from '@/types/character'
import type { ClassEntry } from '@/types/class'
import type { AsiKey, RaceEntry, RaceSubentry } from '@/types/race'
import { SKILL_NAMES } from '@/types/character'

export const WEAPON_PROF_TO_NAMES: Record<string, string[]> = {
  'club':           ['Clava'],
  'dagger':         ['Adaga'],
  'dart':           ['Dardo'],
  'javelin':        ['Zagaia'],
  'mace':           ['Maça'],
  'quarterstaff':   ['Cajado'],
  'scimitar':       ['Cimitarra'],
  'sickle':         ['Foice'],
  'sling':          ['Funda'],
  'spear':          ['Lança'],
  'shortsword':     ['Espada Curta'],
  'longsword':      ['Espada Longa'],
  'rapier':         ['Rapieira'],
  'hand_crossbow':  ['Besta de Mão'],
  'light_crossbow': ['Besta Leve'],
}

export function dbSkillToTs(key: string): SkillName | null {
  if ((SKILL_NAMES as readonly string[]).includes(key)) return key as SkillName
  const camel = key.replace(/_([a-z])/g, (_, c: string) => c.toUpperCase())
  if ((SKILL_NAMES as readonly string[]).includes(camel)) return camel as SkillName
  return null
}

const ATTR_TO_SAVE_KEY: Record<string, keyof Character> = {
  strength:     'saveStrProficient',
  dexterity:    'saveDexProficient',
  constitution: 'saveConProficient',
  intelligence: 'saveIntProficient',
  wisdom:       'saveWisProficient',
  charisma:     'saveChaProficient',
}

const CLASS_EXTRA_LANGUAGES: Record<string, string> = {
  druid: 'Druídico',
  rogue: 'Jargão dos Ladrões',
}

function translateArmorProf(p: string): string {
  const map: Record<string, string> = {
    light: 'Leve', medium: 'Média', heavy: 'Pesada', shields: 'Escudos',
  }
  return map[p] ?? p
}

function translateWeaponProf(p: string): string {
  const map: Record<string, string> = {
    simple: 'Simples', martial: 'Marciais',
  }
  return map[p] ?? p
}

function translateAttrPt(attr: string): string {
  const map: Record<string, string> = {
    strength: 'Força', dexterity: 'Destreza', constitution: 'Constituição',
    intelligence: 'Inteligência', wisdom: 'Sabedoria', charisma: 'Carisma',
  }
  return map[attr] ?? attr
}

export function buildProficienciesText(cls: ClassEntry): string {
  const parts: string[] = []
  if (cls.armorProficiencies.length > 0)
    parts.push(`Armaduras: ${cls.armorProficiencies.map(translateArmorProf).join(', ')}`)
  if (cls.weaponProficiencies.length > 0)
    parts.push(`Armas: ${cls.weaponProficiencies.map(translateWeaponProf).join(', ')}`)
  if (cls.toolProficiencies.length > 0)
    parts.push(`Ferramentas: ${cls.toolProficiencies.join(', ')}`)
  if (cls.savingThrows.length > 0)
    parts.push(`Resistências: ${cls.savingThrows.map(translateAttrPt).join(', ')}`)
  const lang = CLASS_EXTRA_LANGUAGES[cls.id]
  if (lang) parts.push(`Idiomas: ${lang}`)
  return parts.join('\n')
}

export function applyClassDefaults(cls: ClassEntry): Partial<Character> {
  const saveUpdates: Partial<Character> = {
    saveStrProficient: false, saveDexProficient: false, saveConProficient: false,
    saveIntProficient: false, saveWisProficient: false, saveChaProficient: false,
  }
  for (const attr of cls.savingThrows) {
    const key = ATTR_TO_SAVE_KEY[attr]
    if (key) (saveUpdates as Record<string, unknown>)[key as string] = true
  }
  return {
    ...saveUpdates,
    speed: cls.speed,
    subclassId: null,
    otherProficiencies: buildProficienciesText(cls),
  }
}

const ASI_TO_SCORE: Record<AsiKey, keyof Character> = {
  str: 'strScore', dex: 'dexScore', con: 'conScore',
  int: 'intScore', wis: 'wisScore', cha: 'chaScore',
}

type RaceApplyEntry = { speed: number; asi: Partial<Record<AsiKey, number>> }
type ScoreSnapshot = Pick<Character, 'strScore' | 'dexScore' | 'conScore' | 'intScore' | 'wisScore' | 'chaScore'>

export function applyRaceDefaults(
  entry: RaceApplyEntry | null,
  prevRacialAsi: Partial<Record<string, number>>,
  scores: ScoreSnapshot,
): Partial<Character> {
  const scoreUpdates: Record<string, number> = {
    strScore: scores.strScore, dexScore: scores.dexScore, conScore: scores.conScore,
    intScore: scores.intScore, wisScore: scores.wisScore, chaScore: scores.chaScore,
  }

  // Revert previous racial ASI
  for (const [k, v] of Object.entries(prevRacialAsi) as [AsiKey, number][]) {
    const key = ASI_TO_SCORE[k]
    if (key) scoreUpdates[key as string] -= v
  }

  if (!entry) {
    return { ...(scoreUpdates as Partial<Character>), racialAsi: {}, speed: 30 }
  }

  // Apply new racial ASI
  const newAsi = entry.asi
  for (const [k, v] of Object.entries(newAsi) as [AsiKey, number][]) {
    const key = ASI_TO_SCORE[k]
    if (key) scoreUpdates[key as string] += v
  }

  return {
    ...(scoreUpdates as Partial<Character>),
    speed: entry.speed,
    racialAsi: newAsi,
  }
}

export function buildFeaturesTraitsText(
  raceEntry: RaceEntry | null,
  activeSubrace: RaceSubentry | null,
): string {
  if (!raceEntry) return ''
  const raceName = raceEntry.name + (activeSubrace ? ` — ${activeSubrace.name}` : '')
  const allTraits = [...raceEntry.traits.traits, ...(activeSubrace?.extraTraits ?? [])]
  const traitsText = allTraits.map(t => `· ${t}`).join('\n')
  const langLine = `Idiomas: ${raceEntry.traits.languages.join(', ')}`
  return `— ${raceName} —\n${traitsText}\n${langLine}`
}
