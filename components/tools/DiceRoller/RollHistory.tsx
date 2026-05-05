'use client'

import type { RollRecord } from '@/types/dice'
import { formatNotation, getTimeAgo } from '@/lib/dice'
import { Trash2, History } from 'lucide-react'

interface RollHistoryProps {
  history: RollRecord[]
  onClear: () => void
}

export default function RollHistory({ history, onClear }: RollHistoryProps) {
  if (history.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center gap-3 rounded border border-dashed py-10 text-center"
        style={{ borderColor: 'var(--color-border-default)' }}>
        <History size={24} style={{ color: 'var(--color-text-muted)' }} />
        <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Nenhuma rolagem ainda</p>
      </div>
    )
  }

  return (
    <div>
      <div className="mb-3 flex items-center justify-between">
        <p className="section-label">· Histórico da Sessão ·</p>
        <button
          onClick={onClear}
          className="flex items-center gap-1.5 rounded px-2.5 py-1.5 text-xs transition-all"
          style={{ color: 'var(--color-text-muted)' }}
        >
          <Trash2 size={12} />
          Limpar
        </button>
      </div>
      <ul className="scrollbar-thin max-h-72 space-y-1.5 overflow-y-auto pr-1">
        {history.map((record, idx) => {
          const isD20 = record.dieType === 'd20'
          const isCritical = isD20 && record.rolls.some((r) => r === 20)
          const isFumble = isD20 && record.quantity === 1 && record.rolls[0] === 1

          return (
            <li
              key={record.id}
              className="flex items-center justify-between rounded px-4 py-2.5 transition-opacity"
              style={{
                border: '1px solid var(--color-border-default)',
                background: idx === 0 ? 'var(--color-bg-tertiary)' : 'var(--color-bg-secondary)',
                opacity: idx === 0 ? 1 : 0.75,
              }}
            >
              <div className="flex items-center gap-3">
                <span className="font-mono text-xs" style={{ color: 'var(--color-text-muted)' }}>
                  {formatNotation(record)}
                </span>
                {isCritical && <span className="text-[10px] font-bold" style={{ color: 'var(--color-gold-light)' }}>CRÍTICO</span>}
                {isFumble   && <span className="text-[10px] font-bold text-red-400">FALHA</span>}
              </div>
              <div className="flex items-center gap-3">
                <span className="font-mono text-base font-bold"
                  style={{ color: isCritical ? 'var(--color-gold-light)' : isFumble ? '#f87171' : 'var(--color-text-primary)' }}>
                  {record.total}
                </span>
                <span className="w-16 text-right text-[10px]" style={{ color: 'var(--color-text-muted)' }}>
                  {getTimeAgo(record.timestamp)}
                </span>
              </div>
            </li>
          )
        })}
      </ul>
    </div>
  )
}
