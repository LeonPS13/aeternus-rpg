export type AsiKey = 'str' | 'dex' | 'con' | 'int' | 'wis' | 'cha'
export type RacialAsi = Partial<Record<AsiKey, number>>

export interface RaceTraits {
  traits: string[]
  languages: string[]
  weaponProficiencies?: string[]
  toolProficiencies?: string[]
  armorProficiencies?: string[]
}

export interface RaceSubentry {
  id: string
  name: string
  nameEn: string
  asi: RacialAsi
  extraTraits?: string[]
}

export interface RaceEntry {
  id: string
  name: string
  nameEn: string
  speed: number
  traits: RaceTraits
  subraces?: RaceSubentry[]
  asi?: RacialAsi   // only for races without subraces
}
