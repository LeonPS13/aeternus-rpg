'use client'

import type { DieType } from '@/types/dice'

interface DiceSelectorProps {
  selectedDie: DieType
  isRolling: boolean
  onSelect: (die: DieType) => void
}

const DICE: { type: DieType; label: string; shape: string }[] = [
  { type: 'd4', label: 'D4', shape: '▲' },
  { type: 'd6', label: 'D6', shape: '■' },
  { type: 'd8', label: 'D8', shape: '◆' },
  { type: 'd10', label: 'D10', shape: '◇' },
  { type: 'd12', label: 'D12', shape: '⬟' },
  { type: 'd20', label: 'D20', shape: '⬢' },
  { type: 'd100', label: 'D%', shape: '%' },
]

export default function DiceSelector({ selectedDie, isRolling, onSelect }: DiceSelectorProps) {
  return (
    <div>
      <p className="mb-3 text-xs font-semibold uppercase tracking-widest text-slate-500">
        Tipo de Dado
      </p>
      <div className="grid grid-cols-4 gap-2 sm:grid-cols-7">
        {DICE.map((die) => {
          const isSelected = selectedDie === die.type
          return (
            <button
              key={die.type}
              onClick={() => onSelect(die.type)}
              className={`group relative flex flex-col items-center justify-center gap-1 rounded-xl border py-3 transition-all duration-200 focus:outline-none ${
                isSelected
                  ? 'border-cyan-500/60 bg-cyan-500/10 shadow-lg shadow-cyan-500/20'
                  : 'border-slate-700/60 bg-slate-800/40 hover:border-slate-600 hover:bg-slate-800/80'
              }`}
            >
              <span
                className={`text-lg font-bold transition-all duration-200 ${
                  isSelected
                    ? `text-cyan-400 ${isRolling ? 'animate-[roll-spin_0.6s_cubic-bezier(0.4,0,0.2,1)]' : ''}`
                    : 'text-slate-400 group-hover:text-slate-200'
                }`}
              >
                {die.shape}
              </span>
              <span
                className={`text-[11px] font-bold tracking-wide ${
                  isSelected ? 'text-cyan-300' : 'text-slate-500 group-hover:text-slate-400'
                }`}
              >
                {die.label}
              </span>
              {isSelected && (
                <span className="absolute bottom-1 left-1/2 h-1 w-1 -translate-x-1/2 rounded-full bg-cyan-400" />
              )}
            </button>
          )
        })}
      </div>
    </div>
  )
}
