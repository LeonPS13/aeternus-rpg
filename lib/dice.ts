import type { DieType, DiceConfig, RollRecord } from '@/types/dice'

const DIE_SIDES: Record<DieType, number> = {
  d4: 4,
  d6: 6,
  d8: 8,
  d10: 10,
  d12: 12,
  d20: 20,
  d100: 100,
}

export function rollDie(sides: number): number {
  // crypto.getRandomValues usa entropia real do SO (não PRNG).
  // Rejection sampling elimina modulo bias: descartamos valores fora
  // do maior múltiplo de `sides` que cabe em 32 bits.
  const limit = Math.floor(0x100000000 / sides) * sides
  const buf = new Uint32Array(1)
  do {
    crypto.getRandomValues(buf)
  } while (buf[0] >= limit)
  return (buf[0] % sides) + 1
}

export function rollDice(config: DiceConfig): RollRecord {
  const sides = DIE_SIDES[config.dieType]
  const rolls = Array.from({ length: config.quantity }, () => rollDie(sides))
  const sum = rolls.reduce((acc, v) => acc + v, 0)

  return {
    id: crypto.randomUUID(),
    dieType: config.dieType,
    quantity: config.quantity,
    modifier: config.modifier,
    rolls,
    total: sum + config.modifier,
    timestamp: new Date(),
  }
}

export function formatNotation(record: Pick<RollRecord, 'dieType' | 'quantity' | 'modifier'>): string {
  const mod = record.modifier
  if (mod === 0) return `${record.quantity}${record.dieType}`
  return `${record.quantity}${record.dieType}${mod > 0 ? '+' : ''}${mod}`
}

export function getDieSides(dieType: DieType): number {
  return DIE_SIDES[dieType]
}

export function getRollColor(value: number, maxValue: number): string {
  const ratio = value / maxValue
  if (ratio <= 0.25) return 'text-red-400 border-red-500/40 bg-red-500/10'
  if (ratio <= 0.5) return 'text-orange-400 border-orange-500/40 bg-orange-500/10'
  if (ratio <= 0.75) return 'text-yellow-400 border-yellow-500/40 bg-yellow-500/10'
  return 'text-emerald-400 border-emerald-500/40 bg-emerald-500/10'
}

export function getTimeAgo(timestamp: Date): string {
  const seconds = Math.floor((Date.now() - timestamp.getTime()) / 1000)
  if (seconds < 5) return 'agora'
  if (seconds < 60) return `${seconds}s atrás`
  const minutes = Math.floor(seconds / 60)
  if (minutes < 60) return `${minutes}min atrás`
  return `${Math.floor(minutes / 60)}h atrás`
}
