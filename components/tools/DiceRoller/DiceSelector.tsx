'use client'

import type { DieType } from '@/types/dice'

interface DiceSelectorProps {
  selectedDie: DieType
  isRolling: boolean
  onSelect: (die: DieType) => void
}

const DICE: { type: DieType; label: string; shape: string }[] = [
  { type: 'd4',   label: 'D4',  shape: '▲' },
  { type: 'd6',   label: 'D6',  shape: '■' },
  { type: 'd8',   label: 'D8',  shape: '◆' },
  { type: 'd10',  label: 'D10', shape: '◇' },
  { type: 'd12',  label: 'D12', shape: '⬟' },
  { type: 'd20',  label: 'D20', shape: '⬢' },
  { type: 'd100', label: 'D%',  shape: '%' },
]

export default function DiceSelector({ selectedDie, isRolling, onSelect }: DiceSelectorProps) {
  return (
    <div>
      <p className="section-label mb-3">· Tipo de Dado ·</p>
      <div className="grid grid-cols-4 gap-2 sm:grid-cols-7">
        {DICE.map((die) => {
          const isSelected = selectedDie === die.type
          return (
            <button
              key={die.type}
              onClick={() => onSelect(die.type)}
              className="group relative flex flex-col items-center justify-center gap-1 rounded py-3 transition-all duration-200 focus:outline-none"
              style={isSelected ? {
                border: '1px solid var(--color-gold)',
                background: 'var(--color-gold-glow)',
                boxShadow: '0 0 12px rgba(201,168,76,0.15)',
              } : {
                border: '1px solid var(--color-border-default)',
                background: 'var(--color-bg-tertiary)',
              }}
            >
              <span
                className={`text-lg font-bold transition-all duration-200 ${
                  isSelected && isRolling ? 'animate-[roll-spin_0.6s_cubic-bezier(0.4,0,0.2,1)]' : ''
                }`}
                style={{ color: isSelected ? 'var(--color-gold)' : 'var(--color-text-muted)' }}
              >
                {die.shape}
              </span>
              <span
                className="text-[11px] font-bold tracking-wide"
                style={{ color: isSelected ? 'var(--color-gold-light)' : 'var(--color-text-muted)' }}
              >
                {die.label}
              </span>
              {isSelected && (
                <span className="absolute bottom-1 left-1/2 h-1 w-1 -translate-x-1/2 rounded-full"
                  style={{ background: 'var(--color-gold)' }} />
              )}
            </button>
          )
        })}
      </div>
    </div>
  )
}
