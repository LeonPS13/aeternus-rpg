'use client'

import type { RollRecord } from '@/types/dice'
import { formatNotation } from '@/lib/dice'

interface RollResultProps {
  result: RollRecord
}

export default function RollResult({ result }: RollResultProps) {
  const notation = formatNotation(result)
  const isD20 = result.dieType === 'd20'
  const isCritical = isD20 && result.rolls.some((r) => r === 20)
  const isFumble = isD20 && result.quantity === 1 && result.rolls[0] === 1

  return (
    <div key={result.id} className="animate-[fade-up_0.4s_ease-out_forwards] flex flex-col items-center gap-3 text-center">

      {/* Notation + badge */}
      <div className="flex flex-col items-center gap-1.5">
        <span className="text-4xl" style={{ color: 'var(--color-text-muted)' }}>{notation}</span>
        {isCritical && (
          <span className="rounded px-2 py-0.5 text-xs font-bold"
            style={{ border: '1px solid rgba(201,168,76,0.5)', background: 'var(--color-gold-glow)', color: 'var(--color-gold-light)' }}>
            Crítico!
          </span>
        )}
        {isFumble && (
          <span className="rounded px-2 py-0.5 text-xs font-bold"
            style={{ border: '1px solid rgba(139,30,30,0.5)', background: 'rgba(139,30,30,0.15)', color: '#f87171' }}>
            Falha!
          </span>
        )}
      </div>

      {/* Individual dice chips */}
      <div className="flex flex-wrap justify-center gap-1.5">
        {result.rolls.map((roll, idx) => (
          <span
            key={idx}
            className="inline-flex min-w-[2.5rem] animate-[chip-pop_0.3s_cubic-bezier(0.34,1.56,0.64,1)_forwards] items-center justify-center rounded px-1.5 pb-1 pt-0 font-sans text-2xl leading-none"
            style={{
              background: 'var(--color-accent)',
              border: '1px solid rgba(201,168,76,0.3)',
              color: 'var(--color-gold-light)',
              animationDelay: `${idx * 60}ms`,
              opacity: 0,
            }}
          >
            {roll}
          </span>
        ))}
        {result.modifier !== 0 && (
          <span className="inline-flex items-center rounded px-1.5 pb-1 pt-0 font-sans text-2xl leading-none"
            style={{ border: '1px solid rgba(201,168,76,0.4)', background: 'var(--color-gold-glow)', color: 'var(--color-gold)' }}>
            {result.modifier > 0 ? `+${result.modifier}` : result.modifier}
          </span>
        )}
      </div>

      {/* Divider */}
      <div className="my-4 w-28" style={{ height: '1px', background: 'var(--color-border-default)' }} />

      {/* Total */}
      <div className="flex flex-col items-center gap-0.5">
        <span className="text-3xl" style={{ color: 'var(--color-text-muted)' }}>Total</span>
        <span
          className={`animate-[result-pop_0.35s_cubic-bezier(0.34,1.56,0.64,1)_forwards] bg-gradient-to-r bg-clip-text text-5xl font-black tabular-nums text-transparent ${
            isCritical
              ? 'from-[#E8C96A] to-[#F5D87A]'
              : isFumble
                ? 'from-red-400 to-orange-400'
                : 'from-[#C9A84C] to-[#E8C96A]'
          }`}
        >
          {result.total}
        </span>
      </div>

    </div>
  )
}
