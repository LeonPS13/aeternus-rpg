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
      <div className="flex flex-col items-center justify-center gap-3 rounded-2xl border border-dashed border-slate-800 py-10 text-center">
        <History size={24} className="text-slate-700" />
        <p className="text-sm text-slate-600">Nenhuma rolagem ainda</p>
      </div>
    )
  }

  return (
    <div>
      <div className="mb-3 flex items-center justify-between">
        <p className="text-xs font-semibold uppercase tracking-widest text-slate-500">
          Histórico da Sessão
        </p>
        <button
          onClick={onClear}
          className="flex items-center gap-1.5 rounded-lg px-2.5 py-1.5 text-xs text-slate-500 transition-all hover:bg-slate-800 hover:text-red-400"
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
              className={`flex items-center justify-between rounded-xl border px-4 py-2.5 transition-opacity ${
                idx === 0
                  ? 'border-slate-700/80 bg-slate-800/60'
                  : 'border-slate-800/60 bg-slate-900/40 opacity-80'
              }`}
            >
              <div className="flex items-center gap-3">
                <span className="font-mono text-xs text-slate-500">
                  {formatNotation(record)}
                </span>
                {isCritical && (
                  <span className="text-[10px] font-bold text-emerald-500">CRÍTICO</span>
                )}
                {isFumble && (
                  <span className="text-[10px] font-bold text-red-500">FALHA</span>
                )}
              </div>
              <div className="flex items-center gap-3">
                <span
                  className={`font-mono text-base font-bold ${
                    isCritical
                      ? 'text-emerald-400'
                      : isFumble
                        ? 'text-red-400'
                        : 'text-slate-200'
                  }`}
                >
                  {record.total}
                </span>
                <span className="w-16 text-right text-[10px] text-slate-600">
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
