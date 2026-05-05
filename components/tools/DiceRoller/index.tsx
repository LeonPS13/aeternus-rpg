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
    (e: React.KeyboardEvent) => { if (e.key === 'Enter' || e.key === ' ') handleRoll() },
    [handleRoll],
  )

  const notation = formatNotation({ dieType: selectedDie, quantity, modifier })

  return (
    <div className="mx-auto w-full max-w-3xl px-6 py-8">
      {/* Header */}
      <div className="mb-8">
        <div className="mb-1 flex items-center gap-2">
          <span className="rounded p-1" style={{ background: 'var(--color-gold-glow)' }}>
            <Sparkles size={14} style={{ color: 'var(--color-gold)' }} />
          </span>
          <h1 className="text-3xl" style={{ color: 'var(--color-text-primary)' }}>Rolador de Dados</h1>
        </div>
        <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
          Selecione o dado, defina a quantidade e modificador, então role.
        </p>
      </div>

      {/* Main Card */}
      <div className="arcane-panel mb-6 space-y-6 p-6">
        <DiceSelector selectedDie={selectedDie} isRolling={isRolling} onSelect={setSelectedDie} />

        <div className="ornament-divider" />

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
          className="arcane-btn w-full py-4 font-bold"
        >
          <span className="flex items-center justify-center gap-2 text-base">
            {isRolling ? (
              <><span className="animate-spin text-lg">⚄</span> Rolando…</>
            ) : (
              <><span className="text-lg">⚄</span> Rolar {notation}</>
            )}
          </span>
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
