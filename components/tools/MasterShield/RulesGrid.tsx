'use client'

import { useState } from 'react'
import { Plus, X, ChevronDown, ChevronUp } from 'lucide-react'
import type { CodexEntry } from '@/types/codex'
import { translateSubtype } from '@/lib/codex'

interface Props {
  pinnedRules: (string | null)[]
  codexRules: CodexEntry[]
  onPin: (i: number) => void
  onUnpin: (i: number) => void
}

function RuleCard({ entry, onUnpin }: { entry: CodexEntry; onUnpin: () => void }) {
  const [open, setOpen] = useState(false)

  const effects   = entry.data.effects as string[] | undefined
  const levels    = entry.data.levels  as { level: number; effect: string }[] | undefined
  const degrees   = entry.data.degrees as { name: string; bonus: string; examples: string }[] | undefined
  const duration  = entry.data.duration as string | undefined

  return (
    <div
      className="arcane-panel flex h-full cursor-pointer flex-col p-2.5 transition-colors"
      style={open ? { borderColor: 'var(--color-gold)' } : {}}
      onClick={() => setOpen(v => !v)}
    >
      {/* Header row */}
      <div className="flex items-start justify-between gap-1">
        <div className="min-w-0 flex-1">
          <p className="text-sm font-medium leading-tight" style={{ color: 'var(--color-text-primary)' }}>
            {entry.name}
          </p>
          {entry.subtype && (
            <span className="mt-0.5 inline-block rounded px-1.5 py-0.5 text-xs"
              style={{ background: 'var(--color-bg-tertiary)', color: 'var(--color-gold-dark)' }}>
              {translateSubtype(entry.subtype)}
            </span>
          )}
        </div>
        <div className="flex shrink-0 items-center gap-0.5">
          <span style={{ color: 'var(--color-text-muted)' }}>
            {open ? <ChevronUp size={12} /> : <ChevronDown size={12} />}
          </span>
          <button
            onClick={e => { e.stopPropagation(); onUnpin() }}
            className="rounded p-0.5"
            style={{ color: 'var(--color-text-muted)' }}
            aria-label="Desafixar"
          >
            <X size={12} />
          </button>
        </div>
      </div>

      {/* Expanded content */}
      {open && (
        <div className="mt-2 space-y-1.5 text-xs" style={{ color: 'var(--color-text-secondary)' }}>
          {entry.description && (
            <p className="leading-snug">{entry.description}</p>
          )}
          {duration && (
            <p style={{ color: 'var(--color-text-muted)' }}>Duração: {duration}</p>
          )}
          {effects && effects.length > 0 && (
            <ul className="space-y-1">
              {effects.map((ef, i) => (
                <li key={i} className="flex gap-1.5">
                  <span style={{ color: 'var(--color-gold-dark)', flexShrink: 0 }}>·</span>
                  <span>{ef}</span>
                </li>
              ))}
            </ul>
          )}
          {levels && levels.length > 0 && (
            <ul className="space-y-1">
              {levels.map(lv => (
                <li key={lv.level} className="flex gap-1.5">
                  <span style={{ color: 'var(--color-gold-dark)', flexShrink: 0 }}>Nível {lv.level}:</span>
                  <span>{lv.effect}</span>
                </li>
              ))}
            </ul>
          )}
          {degrees && degrees.length > 0 && (
            <ul className="space-y-1">
              {degrees.map(d => (
                <li key={d.name}>
                  <span style={{ color: 'var(--color-gold-dark)' }}>{d.name}:</span>{' '}
                  {d.bonus}
                </li>
              ))}
            </ul>
          )}
        </div>
      )}
    </div>
  )
}

export default function RulesGrid({ pinnedRules, codexRules, onPin, onUnpin }: Props) {
  return (
    <div className="grid grid-cols-3 gap-3">
      {pinnedRules.map((ruleId, i) => {
        const entry = ruleId ? codexRules.find(r => r.id === ruleId) : null

        if (!entry) {
          return (
            <button
              key={i}
              onClick={() => onPin(i)}
              className="flex items-center justify-center rounded transition-colors"
              style={{
                minHeight: '9rem',
                border: '1px dashed var(--color-border-default)',
                background: 'transparent',
                color: 'var(--color-text-muted)',
              }}
              aria-label="Fixar regra"
            >
              <Plus size={20} />
            </button>
          )
        }

        return (
          <RuleCard
            key={i}
            entry={entry}
            onUnpin={() => onUnpin(i)}
          />
        )
      })}
    </div>
  )
}
