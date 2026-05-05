'use client'

import { Minus, Plus } from 'lucide-react'

interface RollControlsProps {
  quantity: number
  modifier: number
  onQuantityChange: (val: number) => void
  onModifierChange: (val: number) => void
}

export default function RollControls({ quantity, modifier, onQuantityChange, onModifierChange }: RollControlsProps) {
  const btnStyle = {
    border: '1px solid var(--color-border-default)',
    background: 'var(--color-bg-tertiary)',
    color: 'var(--color-text-secondary)',
  }

  return (
    <div className="grid grid-cols-2 gap-4">
      <div>
        <p className="section-label mb-3">· Quantidade ·</p>
        <div className="flex items-center gap-2">
          <button onClick={() => onQuantityChange(Math.max(1, quantity - 1))}
            disabled={quantity <= 1}
            className="flex h-9 w-9 items-center justify-center rounded transition-all active:scale-95 disabled:opacity-40"
            style={btnStyle}>
            <Minus size={14} />
          </button>
          <span className="w-12 text-center text-xl font-bold tabular-nums"
            style={{ color: 'var(--color-text-primary)' }}>
            {quantity}
          </span>
          <button onClick={() => onQuantityChange(Math.min(10, quantity + 1))}
            disabled={quantity >= 10}
            className="flex h-9 w-9 items-center justify-center rounded transition-all active:scale-95 disabled:opacity-40"
            style={btnStyle}>
            <Plus size={14} />
          </button>
        </div>
      </div>

      <div>
        <p className="section-label mb-3">· Modificador ·</p>
        <div className="flex items-center gap-2">
          <button onClick={() => onModifierChange(Math.max(-20, modifier - 1))}
            disabled={modifier <= -20}
            className="flex h-9 w-9 items-center justify-center rounded transition-all active:scale-95 disabled:opacity-40"
            style={btnStyle}>
            <Minus size={14} />
          </button>
          <span className="w-12 text-center text-xl font-bold tabular-nums"
            style={{ color: 'var(--color-text-primary)' }}>
            {modifier === 0 ? '0' : modifier > 0 ? `+${modifier}` : `${modifier}`}
          </span>
          <button onClick={() => onModifierChange(Math.min(20, modifier + 1))}
            disabled={modifier >= 20}
            className="flex h-9 w-9 items-center justify-center rounded transition-all active:scale-95 disabled:opacity-40"
            style={btnStyle}>
            <Plus size={14} />
          </button>
        </div>
      </div>
    </div>
  )
}
