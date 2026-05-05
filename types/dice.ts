export type DieType = 'd4' | 'd6' | 'd8' | 'd10' | 'd12' | 'd20' | 'd100'

export interface DiceConfig {
  dieType: DieType
  quantity: number
  modifier: number
}

export interface RollRecord {
  id: string
  dieType: DieType
  quantity: number
  modifier: number
  rolls: number[]
  total: number
  timestamp: Date
}
