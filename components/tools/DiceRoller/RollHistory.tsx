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
              className="flex items-center gap-3 rounded px-4 py-2.5 transition-opacity"
              style={{
                border: '1px solid var(--color-border-default)',
                background: idx === 0 ? 'var(--color-bg-tertiary)' : 'var(--color-bg-secondary)',
                opacity: idx === 0 ? 1 : 0.75,
              }}
            >
              {/* Notation + badge */}
              <div className="flex w-20 shrink-0 flex-col gap-0.5">
                <span className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
                  {formatNotation(record)}
                </span>
                {isCritical && <span className="text-xs font-bold" style={{ color: 'var(--color-gold-light)' }}>Crítico</span>}
                {isFumble   && <span className="text-xs font-bold text-red-400">Falha</span>}
              </div>

              {/* Chips */}
              <div className="flex flex-1 flex-wrap items-center gap-1">
                {record.rolls.map((roll, i) => (
                  <span key={i}
                    className="inline-flex items-center justify-center rounded px-1 py-0 text-base"
                    style={{
                      background: 'var(--color-accent)',
                      border: '1px solid rgba(201,168,76,0.3)',
                      color: 'var(--color-gold-light)',
                    }}>
                    {roll}
                  </span>
                ))}
                {record.modifier !== 0 && (
                  <span className="inline-flex items-center justify-center rounded px-1 py-0 text-base"
                    style={{
                      border: '1px solid rgba(201,168,76,0.4)',
                      background: 'var(--color-gold-glow)',
                      color: 'var(--color-gold)',
                    }}>
                    {record.modifier > 0 ? `+${record.modifier}` : record.modifier}
                  </span>
                )}
              </div>

              {/* Total + timestamp */}
              <div className="flex shrink-0 flex-col items-end gap-0.5">
                <span className="text-2xl leading-none"
                  style={{ color: isCritical ? 'var(--color-gold-light)' : isFumble ? '#f87171' : 'var(--color-text-primary)' }}>
                  {record.total}
                </span>
                <span className="text-xs" style={{ color: 'var(--color-text-muted)' }}>
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
