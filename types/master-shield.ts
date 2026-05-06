export type ShieldCard =
  | { type: 'note'; title: string; content: string }
  | { type: 'rule'; codexId: string }
  | null

export interface ShieldData {
  cards: ShieldCard[]  // length 12
}
