'use client'

import { useState, useEffect } from 'react'
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

const inputBase = {
  background: 'transparent',
  border: 'none',
  outline: 'none',
  caretColor: 'var(--color-gold)',
}

function EmptySlot({ onCreate }: { onCreate: () => void }) {
  return (
    <div
      className="flex items-center justify-center rounded"
      style={{
        minHeight: '7rem',
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

function NoteCard({ title, onOpen, onRemove }: {
  title: string
  onOpen: () => void
  onRemove: () => void
}) {
  return (
    <div
      className="arcane-panel relative flex cursor-pointer items-center justify-center p-3 transition-colors"
      style={{ minHeight: '7rem' }}
      onClick={onOpen}
    >
      <button
        onClick={e => { e.stopPropagation(); onRemove() }}
        className="absolute right-1.5 top-1.5 rounded p-0.5"
        style={{ color: 'var(--color-text-muted)' }}
        aria-label="Remover nota"
      >
        <X size={12} />
      </button>
      <p className="text-center text-xl font-medium leading-tight"
        style={{ color: title ? 'var(--color-text-primary)' : 'var(--color-text-muted)' }}>
        {title || 'Título...'}
      </p>
    </div>
  )
}

function RuleCard({ entry, onOpen, onRemove }: {
  entry: CodexEntry
  onOpen: () => void
  onRemove: () => void
}) {
  return (
    <div
      className="arcane-panel relative flex cursor-pointer flex-col items-center justify-center gap-1 p-3 transition-colors"
      style={{ minHeight: '7rem' }}
      onClick={onOpen}
    >
      <button
        onClick={e => { e.stopPropagation(); onRemove() }}
        className="absolute right-1.5 top-1.5 rounded p-0.5"
        style={{ color: 'var(--color-text-muted)' }}
        aria-label="Remover"
      >
        <X size={12} />
      </button>
      <p className="text-center text-xl font-medium leading-tight" style={{ color: 'var(--color-text-primary)' }}>
        {entry.name}
      </p>
      {entry.subtype && (
        <span className="inline-block rounded px-1.5 py-0.5 text-sm"
          style={{ background: 'var(--color-bg-tertiary)', color: 'var(--color-gold-dark)' }}>
          {translateSubtype(entry.subtype)}
        </span>
      )}
    </div>
  )
}

function NoteModal({ title, content, onChange, onClose }: {
  title: string
  content: string
  onChange: (title: string, content: string) => void
  onClose: () => void
}) {
  useEffect(() => {
    document.body.style.overflow = 'hidden'
    return () => { document.body.style.overflow = '' }
  }, [])

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-4"
      style={{ background: 'rgba(0,0,0,0.75)' }}
      onClick={onClose}
    >
      <div
        className="arcane-panel relative flex w-full max-w-lg flex-col gap-3 p-6"
        style={{ maxHeight: '85vh' }}
        onClick={e => e.stopPropagation()}
      >
        <button
          onClick={onClose}
          className="absolute right-4 top-4 rounded p-1"
          style={{ color: 'var(--color-text-muted)' }}
          aria-label="Fechar"
        >
          <X size={16} />
        </button>

        <input
          value={title}
          onChange={e => onChange(e.target.value, content)}
          placeholder="Título..."
          autoFocus
          className="w-full pr-8 text-2xl font-medium leading-tight"
          style={{
            ...inputBase,
            borderBottom: '1px solid var(--color-border-default)',
            color: 'var(--color-gold-light)',
            paddingBottom: '8px',
          }}
        />
        <textarea
          value={content}
          onChange={e => onChange(title, e.target.value)}
          placeholder="Nota..."
          rows={12}
          className="scrollbar-thin w-full resize-none text-lg leading-relaxed"
          style={{ ...inputBase, color: 'var(--color-text-primary)' }}
        />
      </div>
    </div>
  )
}

function RuleModal({ entry, onClose }: { entry: CodexEntry; onClose: () => void }) {
  const effects  = entry.data.effects as string[] | undefined
  const levels   = entry.data.levels  as { level: number; effect: string }[] | undefined
  const degrees  = entry.data.degrees as { name: string; bonus: string }[] | undefined
  const duration = entry.data.duration as string | undefined

  useEffect(() => {
    document.body.style.overflow = 'hidden'
    return () => { document.body.style.overflow = '' }
  }, [])

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-4"
      style={{ background: 'rgba(0,0,0,0.75)' }}
      onClick={onClose}
    >
      <div
        className="arcane-panel scrollbar-thin relative w-full max-w-lg overflow-y-auto p-6"
        style={{ maxHeight: '85vh' }}
        onClick={e => e.stopPropagation()}
      >
        <button
          onClick={onClose}
          className="absolute right-4 top-4 rounded p-1"
          style={{ color: 'var(--color-text-muted)' }}
          aria-label="Fechar"
        >
          <X size={16} />
        </button>

        <h2 className="mb-1 pr-8 text-2xl font-medium leading-tight" style={{ color: 'var(--color-text-primary)' }}>
          {entry.name}
        </h2>
        {entry.subtype && (
          <span className="mb-4 inline-block rounded px-1.5 py-0.5 text-sm"
            style={{ background: 'var(--color-bg-tertiary)', color: 'var(--color-gold-dark)' }}>
            {translateSubtype(entry.subtype)}
          </span>
        )}

        <div className="mt-3 space-y-2 text-base" style={{ color: 'var(--color-text-secondary)' }}>
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
    </div>
  )
}

export default function ShieldGrid({ cards, codexRules, onCreateCard, onUpdateNote, onRemove }: Props) {
  const [openIdx, setOpenIdx] = useState<number | null>(null)

  const openCard  = openIdx !== null ? cards[openIdx] : null
  const openEntry = openCard?.type === 'rule'
    ? codexRules.find(r => r.id === openCard.codexId) ?? null
    : null

  return (
    <>
      <div className="grid grid-cols-2 gap-3 sm:grid-cols-4">
        {cards.map((card, i) => {
          if (!card) return <EmptySlot key={i} onCreate={() => onCreateCard(i)} />
          if (card.type === 'note') return (
            <NoteCard
              key={i}
              title={(card as any).title ?? ''}
              onOpen={() => setOpenIdx(i)}
              onRemove={() => onRemove(i)}
            />
          )
          const entry = codexRules.find(r => r.id === card.codexId)
          if (!entry) return <EmptySlot key={i} onCreate={() => onCreateCard(i)} />
          return <RuleCard key={i} entry={entry} onOpen={() => setOpenIdx(i)} onRemove={() => onRemove(i)} />
        })}
      </div>

      {openIdx !== null && openCard?.type === 'note' && (
        <NoteModal
          title={(openCard as any).title ?? ''}
          content={openCard.content}
          onChange={(title, content) => onUpdateNote(openIdx, title, content)}
          onClose={() => setOpenIdx(null)}
        />
      )}
      {openIdx !== null && openCard?.type === 'rule' && openEntry && (
        <RuleModal entry={openEntry} onClose={() => setOpenIdx(null)} />
      )}
    </>
  )
}
