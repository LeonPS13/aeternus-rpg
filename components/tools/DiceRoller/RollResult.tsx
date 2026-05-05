'use client'

import type { RollRecord } from '@/types/dice'
import { getDieSides, getRollColor, formatNotation } from '@/lib/dice'

interface RollResultProps {
  result: RollRecord
}

export default function RollResult({ result }: RollResultProps) {
  const maxValue = getDieSides(result.dieType)
  const notation = formatNotation(result)
  const isD20 = result.dieType === 'd20'
  const isCritical = isD20 && result.rolls.some((r) => r === 20)
  const isFumble = isD20 && result.quantity === 1 && result.rolls[0] === 1

  return (
    <div
      key={result.id}
      className="animate-[fade-up_0.4s_ease-out_forwards] rounded-2xl border border-slate-700/60 bg-slate-800/40 p-6"
    >
      {/* Notation + badges */}
      <div className="mb-4 flex items-center justify-between">
        <span className="font-mono text-sm text-slate-400">{notation}</span>
        <div className="flex gap-2">
          {isCritical && (
            <span className="rounded-full border border-emerald-500/40 bg-emerald-500/10 px-2 py-0.5 text-[10px] font-bold uppercase tracking-wider text-emerald-400">
              Crítico!
            </span>
          )}
          {isFumble && (
            <span className="rounded-full border border-red-500/40 bg-red-500/10 px-2 py-0.5 text-[10px] font-bold uppercase tracking-wider text-red-400">
              Falha!
            </span>
          )}
        </div>
      </div>

      {/* Individual dice */}
      <div className="mb-5 flex flex-wrap gap-2">
        {result.rolls.map((roll, idx) => {
          const colorClasses = getRollColor(roll, maxValue)
          return (
            <span
              key={idx}
              className={`inline-flex min-w-[2.5rem] items-center justify-center rounded-lg border px-2.5 py-1.5 font-mono text-base font-bold ${colorClasses}`}
            >
              {roll}
            </span>
          )
        })}
        {result.modifier !== 0 && (
          <span className="inline-flex items-center rounded-lg border border-amber-500/40 bg-amber-500/10 px-2.5 py-1.5 font-mono text-base font-bold text-amber-400">
            {result.modifier > 0 ? `+${result.modifier}` : result.modifier}
          </span>
        )}
      </div>

      {/* Total */}
      <div className="flex items-end gap-2">
        <span className="text-sm text-slate-500">Total</span>
        <span
          className={`animate-[result-pop_0.35s_cubic-bezier(0.34,1.56,0.64,1)_forwards] bg-gradient-to-r bg-clip-text text-5xl font-black tabular-nums text-transparent ${
            isCritical
              ? 'from-emerald-400 to-cyan-400'
              : isFumble
                ? 'from-red-400 to-orange-400'
                : 'from-amber-400 to-orange-400'
          }`}
        >
          {result.total}
        </span>
      </div>
    </div>
  )
}
