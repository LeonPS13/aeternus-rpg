'use client'

import { useState, useCallback } from 'react'
import type { DieType, RollRecord } from '@/types/dice'
import { rollDice, formatNotation } from '@/lib/dice'
import DiceSelector from './DiceSelector'
import RollControls from './RollControls'
import RollResult from './RollResult'
import RollingAnimation from './RollingAnimation'
import RollHistory from './RollHistory'

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
        <h1 className="mb-1 text-3xl" style={{ color: 'var(--color-text-primary)' }}>Rolador de Dados</h1>
        <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
          Selecione o dado, defina a quantidade e modificador, então role.
        </p>
      </div>

      {/* Combined Panel: controls (left/top) + current result (right/bottom) */}
      <div className="arcane-panel mb-6 p-6">
        <div className="flex flex-col gap-8 lg:flex-row">

          {/* Left: selector + controls + button */}
          <div className="flex min-w-0 flex-1 flex-col gap-4">
            <DiceSelector selectedDie={selectedDie} isRolling={isRolling} onSelect={setSelectedDie} />

            <div className="ornament-divider">
              <div className="ornament-line" />
              <div className="ornament-diamond" />
              <div className="ornament-line" />
            </div>

            <RollControls
              quantity={quantity}
              modifier={modifier}
              onQuantityChange={setQuantity}
              onModifierChange={setModifier}
            />

            <button
              onClick={handleRoll}
              onKeyDown={handleKeyDown}
              disabled={isRolling}
              className="arcane-btn w-full py-2.5"
            >
              <span className="flex items-center justify-center gap-2 text-3xl leading-none">
                {isRolling ? 'Rolando…' : `Rolar ${notation}`}
              </span>
            </button>
          </div>

          {/* Horizontal divider (mobile) / Vertical divider (desktop) */}
          <div className="h-px w-full lg:h-auto lg:w-px lg:self-stretch"
            style={{ background: 'var(--color-border-default)' }} />

          {/* Right/Bottom: current result */}
          <div className="flex w-full flex-col items-center justify-center lg:w-48 lg:shrink-0">
            {isRolling ? (
              <RollingAnimation quantity={quantity} dieType={selectedDie} />
            ) : lastResult ? (
              <RollResult result={lastResult} />
            ) : (
              <div className="flex flex-col items-center gap-3 py-8 text-center">
                <span className="text-5xl" style={{ color: 'var(--color-gold)', opacity: 0.15 }}>⚄</span>
                <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
                  Role os dados para ver o resultado
                </p>
              </div>
            )}
          </div>

        </div>
      </div>

      {/* History */}
      <div className="mt-6">
        <RollHistory history={history} onClear={() => setHistory([])} />
      </div>
    </div>
  )
}
