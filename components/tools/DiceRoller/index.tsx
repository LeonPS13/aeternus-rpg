'use client'

import { useState, useCallback } from 'react'
import type { DieType, RollRecord } from '@/types/dice'
import { rollDice, formatNotation } from '@/lib/dice'
import DiceSelector from './DiceSelector'
import RollControls from './RollControls'
import RollResult from './RollResult'
import RollingAnimation from './RollingAnimation'
import RollHistory from './RollHistory'
import { Sparkles } from 'lucide-react'

const MAX_HISTORY = 20

export default function DiceRoller() {
  const [selectedDie, setSelectedDie] = useState<DieType>('d20')
  const [quantity, setQuantity] = useState(1)
  const [modifier, setModifier] = useState(0)
  const [lastResult, setLastResult] = useState<RollRecord | null>(null)
  const [history, setHistory] = useState<RollRecord[]>([])
  const [isRolling, setIsRolling] = useState(false)

  const handleRoll = useCallback(() => {
    if (isRolling) return
    setIsRolling(true)

    setTimeout(() => {
      const result = rollDice({ dieType: selectedDie, quantity, modifier })
      setLastResult(result)
      setHistory((prev) => [result, ...prev].slice(0, MAX_HISTORY))
      setIsRolling(false)
    }, 700)
  }, [isRolling, selectedDie, quantity, modifier])

  const handleKeyDown = useCallback(
    (e: React.KeyboardEvent) => {
      if (e.key === 'Enter' || e.key === ' ') handleRoll()
    },
    [handleRoll],
  )

  const notation = formatNotation({ dieType: selectedDie, quantity, modifier })

  return (
    <div className="mx-auto w-full max-w-3xl px-6 py-8">
      {/* Header */}
      <div className="mb-8">
        <div className="mb-1 flex items-center gap-2">
          <span className="rounded-md bg-cyan-500/10 p-1">
            <Sparkles size={14} className="text-cyan-400" />
          </span>
          <h1 className="text-2xl font-bold text-slate-100">Rolador de Dados</h1>
        </div>
        <p className="text-sm text-slate-500">
          Selecione o dado, defina a quantidade e modificador, então role.
        </p>
      </div>

      {/* Main Card */}
      <div className="mb-6 space-y-6 rounded-2xl border border-slate-800/80 bg-slate-900/60 p-6 shadow-xl shadow-black/20 backdrop-blur-sm">
        <DiceSelector
          selectedDie={selectedDie}
          isRolling={isRolling}
          onSelect={setSelectedDie}
        />

        <div className="h-px bg-slate-800" />

        <RollControls
          quantity={quantity}
          modifier={modifier}
          onQuantityChange={setQuantity}
          onModifierChange={setModifier}
        />

        {/* Roll Button */}
        <button
          onClick={handleRoll}
          onKeyDown={handleKeyDown}
          disabled={isRolling}
          className="group relative w-full overflow-hidden rounded-xl bg-gradient-to-r from-amber-600 to-orange-700 py-4 font-bold text-white shadow-lg shadow-amber-600/25 transition-all duration-200 hover:from-amber-500 hover:to-orange-600 hover:shadow-amber-500/30 hover:shadow-xl active:scale-[0.98] disabled:cursor-not-allowed disabled:opacity-60"
        >
          <span className="relative z-10 flex items-center justify-center gap-2 text-base">
            {isRolling ? (
              <>
                <span className="animate-spin text-lg">⚄</span>
                Rolando…
              </>
            ) : (
              <>
                <span className="text-lg">⚄</span>
                Rolar {notation}
              </>
            )}
          </span>
          <span className="absolute inset-0 -translate-x-full bg-white/10 transition-transform duration-500 group-hover:translate-x-full" />
        </button>
      </div>

      {/* Result / Animation */}
      {isRolling && <RollingAnimation quantity={quantity} dieType={selectedDie} />}
      {!isRolling && lastResult && <RollResult result={lastResult} />}

      {/* History */}
      <div className="mt-6">
        <RollHistory history={history} onClear={() => setHistory([])} />
      </div>
    </div>
  )
}
