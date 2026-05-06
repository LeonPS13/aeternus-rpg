'use client'

import { Plus, X } from 'lucide-react'
import type { ShieldCard } from '@/types/master-shield'
import type { CodexEntry } from '@/types/codex'
import { translateSubtype } from '@/lib/codex'

interface Props {
  cards: ShieldCard[]
  codexRules: CodexEntry[]
  onCreateCard: (i: number) => void
  onUpdateNote: (i: number, title: string, content: string) => void
  onRemove: (i: number) => void
}

function EmptySlot({ onCreate }: { onCreate: () => void }) {
  return (
    <div
      className="flex items-center justify-center rounded"
      style={{
        minHeight: '9rem',
        border: '1px dashed var(--color-border-default)',
        background: 'transparent',
      }}
    >
      <button
        onClick={onCreate}
        className="flex items-center gap-1.5 rounded px-3 py-1.5 text-sm transition-colors"
        style={{ border: '1px solid var(--color-border-default)', color: 'var(--color-text-muted)' }}
      >
        <Plus size={13} /> Criar
      </button>
    </div>
  )
}

function NoteCard({ title, content, onChange, onRemove }: {
  title: string
  content: string
  onChange: (title: string, content: string) => void
  onRemove: () => void
}) {
  return (
    <div className="arcane-panel relative flex flex-col gap-2 p-3">
      <button
        onClick={onRemove}
        className="absolute right-1.5 top-1.5 z-10 rounded p-0.5"
        style={{ color: 'var(--color-text-muted)' }}
        aria-label="Remover nota"
      >
        <X size={12} />
      </button>
      <input
        value={title}
        onChange={e => onChange(e.target.value, content)}
        placeholder="Título..."
        className="w-full pr-5 text-xl font-medium leading-tight"
        style={{
          background: 'transparent',
          border: 'none',
          borderBottom: '1px solid var(--color-border-default)',
          outline: 'none',
          color: 'var(--color-gold-light)',
          caretColor: 'var(--color-gold)',
          paddingBottom: '6px',
        }}
      />
      <textarea
        value={content}
        onChange={e => onChange(title, e.target.value)}
        placeholder="Nota..."
        rows={6}
        className="w-full resize-none text-lg leading-relaxed"
        style={{
          background: 'transparent',
          border: 'none',
          outline: 'none',
          color: 'var(--color-text-primary)',
          caretColor: 'var(--color-gold)',
        }}
      />
    </div>
  )
}

function RuleCard({ entry, onRemove }: { entry: CodexEntry; onRemove: () => void }) {
  const effects  = entry.data.effects as string[] | undefined
  const levels   = entry.data.levels  as { level: number; effect: string }[] | undefined
  const degrees  = entry.data.degrees as { name: string; bonus: string }[] | undefined
  const duration = entry.data.duration as string | undefined

  return (
    <div
      className="arcane-panel relative flex flex-col gap-2 p-3"
      style={{ borderColor: 'var(--color-gold)' }}
    >
      <button
        onClick={onRemove}
        className="absolute right-1.5 top-1.5 z-10 rounded p-0.5"
        style={{ color: 'var(--color-text-muted)' }}
        aria-label="Remover"
      >
        <X size={12} />
      </button>

      <div>
        <p className="pr-5 text-xl font-medium leading-tight" style={{ color: 'var(--color-text-primary)' }}>
          {entry.name}
        </p>
        {entry.subtype && (
          <span className="mt-1 inline-block rounded px-1.5 py-0.5 text-sm"
            style={{ background: 'var(--color-bg-tertiary)', color: 'var(--color-gold-dark)' }}>
            {translateSubtype(entry.subtype)}
          </span>
        )}
      </div>

      <div className="space-y-1.5 text-base" style={{ color: 'var(--color-text-secondary)' }}>
        {entry.description && <p className="leading-snug">{entry.description}</p>}
        {duration && <p style={{ color: 'var(--color-text-muted)' }}>Duração: {duration}</p>}
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
            {degrees.map((d, i) => (
              <li key={i}>
                <span style={{ color: 'var(--color-gold-dark)' }}>{d.name}:</span>{' '}{d.bonus}
              </li>
            ))}
          </ul>
        )}
      </div>
    </div>
  )
}

export default function ShieldGrid({ cards, codexRules, onCreateCard, onUpdateNote, onRemove }: Props) {
  return (
    <div className="grid grid-cols-2 gap-3 sm:grid-cols-4">
      {cards.map((card, i) => {
        if (!card) {
          return <EmptySlot key={i} onCreate={() => onCreateCard(i)} />
        }
        if (card.type === 'note') {
          return (
            <NoteCard
              key={i}
              title={(card as any).title ?? ''}
              content={card.content}
              onChange={(title, content) => onUpdateNote(i, title, content)}
              onRemove={() => onRemove(i)}
            />
          )
        }
        const entry = codexRules.find(r => r.id === card.codexId)
        if (!entry) return <EmptySlot key={i} onCreate={() => onCreateCard(i)} />
        return <RuleCard key={i} entry={entry} onRemove={() => onRemove(i)} />
      })}
    </div>
  )
}
