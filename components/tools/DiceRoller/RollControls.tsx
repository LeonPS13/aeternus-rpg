'use client'

import { Minus, Plus } from 'lucide-react'

interface RollControlsProps {
  quantity: number
  modifier: number
  onQuantityChange: (val: number) => void
  onModifierChange: (val: number) => void
}

export default function RollControls({
  quantity,
  modifier,
  onQuantityChange,
  onModifierChange,
}: RollControlsProps) {
  return (
    <div className="grid grid-cols-2 gap-4">
      {/* Quantity */}
      <div>
        <p className="mb-3 text-xs font-semibold uppercase tracking-widest text-slate-500">
          Quantidade
        </p>
        <div className="flex items-center gap-2">
          <button
            onClick={() => onQuantityChange(Math.max(1, quantity - 1))}
            className="flex h-9 w-9 items-center justify-center rounded-lg border border-slate-700 bg-slate-800/60 text-slate-400 transition-all hover:border-slate-600 hover:bg-slate-700 hover:text-slate-200 active:scale-95 disabled:opacity-40"
            disabled={quantity <= 1}
          >
            <Minus size={14} />
          </button>
          <span className="w-12 text-center text-xl font-bold tabular-nums text-slate-100">
            {quantity}
          </span>
          <button
            onClick={() => onQuantityChange(Math.min(10, quantity + 1))}
            className="flex h-9 w-9 items-center justify-center rounded-lg border border-slate-700 bg-slate-800/60 text-slate-400 transition-all hover:border-slate-600 hover:bg-slate-700 hover:text-slate-200 active:scale-95 disabled:opacity-40"
            disabled={quantity >= 10}
          >
            <Plus size={14} />
          </button>
        </div>
      </div>

      {/* Modifier */}
      <div>
        <p className="mb-3 text-xs font-semibold uppercase tracking-widest text-slate-500">
          Modificador
        </p>
        <div className="flex items-center gap-2">
          <button
            onClick={() => onModifierChange(Math.max(-20, modifier - 1))}
            className="flex h-9 w-9 items-center justify-center rounded-lg border border-slate-700 bg-slate-800/60 text-slate-400 transition-all hover:border-slate-600 hover:bg-slate-700 hover:text-slate-200 active:scale-95 disabled:opacity-40"
            disabled={modifier <= -20}
          >
            <Minus size={14} />
          </button>
          <span className="w-12 text-center text-xl font-bold tabular-nums text-slate-100">
            {modifier === 0 ? '0' : modifier > 0 ? `+${modifier}` : `${modifier}`}
          </span>
          <button
            onClick={() => onModifierChange(Math.min(20, modifier + 1))}
            className="flex h-9 w-9 items-center justify-center rounded-lg border border-slate-700 bg-slate-800/60 text-slate-400 transition-all hover:border-slate-600 hover:bg-slate-700 hover:text-slate-200 active:scale-95 disabled:opacity-40"
            disabled={modifier >= 20}
          >
            <Plus size={14} />
          </button>
        </div>
      </div>
    </div>
  )
}
