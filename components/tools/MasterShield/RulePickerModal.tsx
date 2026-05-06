'use client'

import { useState, useEffect } from 'react'
import { X, Search } from 'lucide-react'
import type { CodexEntry } from '@/types/codex'
import type { ShieldCard } from '@/types/master-shield'
import { translateSubtype } from '@/lib/codex'

interface Props {
  rules: CodexEntry[]
  onConfirm: (card: Exclude<ShieldCard, null>) => void
  onClose: () => void
}

type Tab = 'codex' | 'note'

const RULE_SUBTYPE_ORDER = [
  'condition', 'action', 'combat', 'cover',
  'concentration', 'rest', 'death', 'reaction',
]

const inputStyle = {
  background: 'var(--color-bg-tertiary)',
  border: '1px solid var(--color-border-default)',
  color: 'var(--color-text-primary)',
  borderRadius: '4px',
  outline: 'none',
  caretColor: 'var(--color-gold)',
}

export default function CreateCardModal({ rules, onConfirm, onClose }: Props) {
  const [tab, setTab]             = useState<Tab>('codex')
  const [selectedId, setSelectedId] = useState('')
  const [search, setSearch]       = useState('')
  const [noteTitle, setNoteTitle]     = useState('')
  const [noteContent, setNoteContent] = useState('')

  useEffect(() => {
    document.body.style.overflow = 'hidden'
    return () => { document.body.style.overflow = '' }
  }, [])

  const query    = search.toLowerCase()
  const filtered = query
    ? rules.filter(r =>
        r.name.toLowerCase().includes(query) ||
        translateSubtype(r.subtype).toLowerCase().includes(query)
      )
    : rules

  const grouped = RULE_SUBTYPE_ORDER
    .map(sub => ({ label: translateSubtype(sub), entries: filtered.filter(r => r.subtype === sub) }))
    .filter(g => g.entries.length > 0)

  const selected      = rules.find(r => r.id === selectedId) ?? null
  const effects       = selected?.data.effects as string[] | undefined
  const previewEffects = effects?.slice(0, 3)

  function handleConfirm() {
    if (tab === 'codex' && selectedId) {
      onConfirm({ type: 'rule', codexId: selectedId })
    } else if (tab === 'note') {
      onConfirm({ type: 'note', title: noteTitle, content: noteContent })
    }
  }

  const canConfirm = tab === 'note' || (tab === 'codex' && !!selectedId)

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-4"
      style={{ background: 'rgba(0,0,0,0.75)' }}
      onClick={onClose}
    >
      <div
        className="arcane-panel relative flex w-full max-w-md flex-col p-6"
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

        <h2 className="mb-4 text-2xl" style={{ color: 'var(--color-text-primary)' }}>
          Criar Card
        </h2>

        {/* Tabs */}
        <div className="mb-4 flex gap-1 rounded p-1" style={{ background: 'var(--color-bg-tertiary)' }}>
          {(['codex', 'note'] as Tab[]).map(t => (
            <button
              key={t}
              onClick={() => setTab(t)}
              className="flex-1 rounded py-1.5 text-sm transition-colors"
              style={tab === t ? {
                background: 'var(--color-bg-secondary)',
                color: 'var(--color-gold-light)',
                border: '1px solid var(--color-border-default)',
              } : {
                background: 'transparent',
                color: 'var(--color-text-muted)',
                border: '1px solid transparent',
              }}
            >
              {t === 'codex' ? 'Codex' : 'Personalizado'}
            </button>
          ))}
        </div>

        {/* Codex tab */}
        {tab === 'codex' && (
          <>
            <div className="relative mb-3">
              <Search size={14} className="absolute left-3 top-1/2 -translate-y-1/2"
                style={{ color: 'var(--color-text-muted)' }} />
              <input
                value={search}
                onChange={e => setSearch(e.target.value)}
                placeholder="Buscar regra..."
                className="w-full py-2 pl-8 pr-3 text-sm"
                style={inputStyle}
                autoFocus
              />
            </div>

            <div className="scrollbar-thin mb-4 flex-1 overflow-y-auto space-y-3" style={{ minHeight: 0, maxHeight: '28rem' }}>
              {grouped.map(g => (
                <div key={g.label}>
                  <p className="mb-1 px-1 text-xs font-medium uppercase tracking-wider"
                    style={{ color: 'var(--color-text-muted)' }}>
                    {g.label}
                  </p>
                  <div className="space-y-0.5">
                    {g.entries.map(r => (
                      <button
                        key={r.id}
                        onClick={() => setSelectedId(r.id)}
                        className="w-full rounded px-3 py-1.5 text-left text-sm transition-colors"
                        style={selectedId === r.id ? {
                          background: 'var(--color-gold-glow)',
                          border: '1px solid var(--color-border-default)',
                          color: 'var(--color-gold-light)',
                        } : {
                          background: 'transparent',
                          border: '1px solid transparent',
                          color: 'var(--color-text-secondary)',
                        }}
                      >
                        {r.name}
                      </button>
                    ))}
                  </div>
                </div>
              ))}
              {grouped.length === 0 && (
                <p className="py-4 text-center text-sm" style={{ color: 'var(--color-text-muted)' }}>
                  Nenhuma regra encontrada.
                </p>
              )}
            </div>

            {selected && (
              <div className="mb-4 rounded px-3 py-2.5 text-sm"
                style={{ background: 'var(--color-bg-tertiary)', border: '1px solid var(--color-border-default)' }}>
                {selected.description && (
                  <p className="mb-1.5 leading-snug" style={{ color: 'var(--color-text-secondary)' }}>
                    {selected.description}
                  </p>
                )}
                {previewEffects && previewEffects.length > 0 && (
                  <ul className="space-y-0.5">
                    {previewEffects.map((ef, i) => (
                      <li key={i} className="flex gap-1.5 text-xs" style={{ color: 'var(--color-text-muted)' }}>
                        <span style={{ color: 'var(--color-gold-dark)' }}>·</span> {ef}
                      </li>
                    ))}
                    {(effects?.length ?? 0) > 3 && (
                      <li className="text-xs" style={{ color: 'var(--color-text-muted)' }}>
                        + {(effects?.length ?? 0) - 3} mais…
                      </li>
                    )}
                  </ul>
                )}
              </div>
            )}
          </>
        )}

        {/* Personalizado tab */}
        {tab === 'note' && (
          <div className="mb-4 flex flex-col gap-2">
            <input
              value={noteTitle}
              onChange={e => setNoteTitle(e.target.value)}
              placeholder="Título..."
              autoFocus
              className="w-full text-base font-medium"
              style={{ ...inputStyle, padding: '8px 12px' }}
            />
            <textarea
              value={noteContent}
              onChange={e => setNoteContent(e.target.value)}
              placeholder="Escreva sua nota aqui..."
              className="scrollbar-thin w-full resize-none text-base leading-relaxed"
              rows={7}
              style={{
                ...inputStyle,
                padding: '10px 12px',
                color: 'var(--color-text-primary)',
              }}
            />
          </div>
        )}

        {/* Buttons */}
        <div className="flex gap-2">
          <button
            onClick={handleConfirm}
            disabled={!canConfirm}
            className="arcane-btn flex-1 py-2 text-base disabled:opacity-40"
          >
            Confirmar
          </button>
          <button
            onClick={onClose}
            className="rounded px-4 py-2 text-base"
            style={{ border: '1px solid var(--color-border-default)', color: 'var(--color-text-muted)' }}
          >
            Cancelar
          </button>
        </div>
      </div>
    </div>
  )
}
