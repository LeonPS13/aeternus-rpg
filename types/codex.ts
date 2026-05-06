export type CodexType = 'weapon' | 'armor' | 'item' | 'spell' | 'rule' | 'feature'

export interface CodexEntry {
  id: string
  name: string
  type: CodexType
  subtype: string | null
  description: string | null
  data: Record<string, unknown>
  source: string
  playerId: string | null
  createdAt: string
  updatedAt: string
}
