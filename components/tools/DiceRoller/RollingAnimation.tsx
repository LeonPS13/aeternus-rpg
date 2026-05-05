'use client'

import { useState, useEffect, useRef } from 'react'
import type { DieType } from '@/types/dice'
import { getDieSides } from '@/lib/dice'

interface RollingAnimationProps {
  quantity: number
  dieType: DieType
}

const DIE_LABEL: Record<DieType, string> = {
  d4: 'D4', d6: 'D6', d8: 'D8', d10: 'D10',
  d12: 'D12', d20: 'D20', d100: 'D%',
}

export default function RollingAnimation({ quantity, dieType }: RollingAnimationProps) {
  const sides = getDieSides(dieType)
  const [values, setValues] = useState<number[]>(() =>
    Array.from({ length: quantity }, () => Math.floor(Math.random() * sides) + 1),
  )
  const [tick, setTick] = useState(0)
  const tickRef = useRef(0)

  useEffect(() => {
    tickRef.current = 0
    const interval = setInterval(() => {
      tickRef.current += 1
      setTick(tickRef.current)
      setValues(Array.from({ length: quantity }, () => Math.floor(Math.random() * sides) + 1))
    }, 75)
    return () => clearInterval(interval)
  }, [quantity, sides])

  return (
    <div className="animate-[fade-up_0.25s_ease-out_forwards] rounded-2xl border border-cyan-500/20 bg-slate-800/40 p-6">
      <p className="mb-4 text-xs font-semibold uppercase tracking-widest text-slate-500">
        Rolando {quantity}{dieType}…
      </p>
      <div className="flex flex-wrap gap-3">
        {values.map((val, idx) => (
          <div
            key={idx}
            className="relative flex h-14 w-14 flex-col items-center justify-center overflow-hidden rounded-xl border border-cyan-500/40 bg-cyan-500/10 shadow-md shadow-cyan-500/20"
          >
            {/* Sweep line */}
            <span className="pointer-events-none absolute inset-x-0 top-0 h-px animate-[fade-up_0.4s_ease-out_infinite] bg-gradient-to-r from-transparent via-cyan-400/60 to-transparent" />

            <span
              key={`${idx}-${tick}`}
              className="animate-[slot-tick_0.075s_ease-out_forwards] font-mono text-xl font-black tabular-nums text-cyan-300"
            >
              {val}
            </span>
            <span className="text-[9px] font-bold tracking-widest text-cyan-600">
              {DIE_LABEL[dieType]}
            </span>
          </div>
        ))}
      </div>
    </div>
  )
}
