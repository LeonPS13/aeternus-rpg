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
    <div className="arcane-panel animate-[fade-up_0.25s_ease-out_forwards] p-6">
      <p className="section-label mb-4">· Rolando {quantity}{dieType}… ·</p>
      <div className="flex flex-wrap gap-3">
        {values.map((val, idx) => (
          <div
            key={idx}
            className="relative flex h-14 w-14 flex-col items-center justify-center overflow-hidden rounded"
            style={{
              border: '1px solid rgba(201,168,76,0.4)',
              background: 'var(--color-gold-glow)',
              boxShadow: '0 0 8px rgba(201,168,76,0.1)',
            }}
          >
            <span className="pointer-events-none absolute inset-x-0 top-0 h-px animate-[fade-up_0.4s_ease-out_infinite]"
              style={{ background: 'linear-gradient(90deg, transparent, rgba(201,168,76,0.6), transparent)' }} />
            <span
              key={`${idx}-${tick}`}
              className="animate-[slot-tick_0.075s_ease-out_forwards] font-mono text-xl font-black tabular-nums"
              style={{ color: 'var(--color-gold-light)' }}
            >
              {val}
            </span>
            <span className="text-[9px] font-bold tracking-widest" style={{ color: 'var(--color-gold-dark)' }}>
              {DIE_LABEL[dieType]}
            </span>
          </div>
        ))}
      </div>
    </div>
  )
}
