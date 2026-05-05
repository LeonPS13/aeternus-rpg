'use client'

import { useState, useEffect } from 'react'
import { X } from 'lucide-react'
import type { DiaryEntry, ActiveTab } from '@/types/adventure'
import TagInput from './TagInput'

interface NewEntryModalProps {
  adventureId: string
  authorId: string
  diaryType: ActiveTab
  initialEntry?: DiaryEntry
  onSave: (entry: DiaryEntry) => void
  onClose: () => void
}

function todayISO(): string {
  return new Date().toISOString().split('T')[0]
}

export default function NewEntryModal({ adventureId, authorId, diaryType, initialEntry, onSave, onClose }: NewEntryModalProps) {
  const isEditing = !!initialEntry

  const [date, setSummary_date]   = useState(initialEntry?.date ?? todayISO())
  const [title, setTitle]         = useState(initialEntry?.title ?? '')
  const [summary, setSummary]     = useState(initialEntry?.summary ?? '')
  const [tags, setTags]           = useState<string[]>(initialEntry?.tags ?? [])

  useEffect(() => {
    function onKey(e: KeyboardEvent) { if (e.key === 'Escape') onClose() }
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [onClose])

  function handleSubmit(e: React.SyntheticEvent) {
    e.preventDefault()
    if (!title.trim() || !summary.trim()) return
    const now = new Date().toISOString()
    const entry: DiaryEntry = {
      id: initialEntry?.id ?? crypto.randomUUID(),
      adventureId, date, title: title.trim(), summary: summary.trim(), tags,
      authorId, diaryType,
      createdAt: initialEntry?.createdAt ?? now,
      updatedAt: now,
    }
    onSave(entry)
  }

  const tabLabel = diaryType === 'adventure' ? 'Diário da Aventura' : 'Meu Diário'

  const inputStyle = {
    background: 'var(--color-bg-tertiary)',
    border: '1px solid var(--color-border-default)',
    color: 'var(--color-text-primary)',
    borderRadius: '4px',
    outline: 'none',
  }

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center px-4"
      style={{ background: 'rgba(0,0,0,0.75)', backdropFilter: 'blur(4px)' }}
      onClick={(e) => { if (e.target === e.currentTarget) onClose() }}
    >
      <div className="arcane-panel animate-[fade-up_0.25s_ease-out_forwards] w-full max-w-lg shadow-2xl">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4"
          style={{ borderBottom: '1px solid var(--color-border-default)' }}>
          <div>
            <h2 className="font-semibold" style={{ color: 'var(--color-text-primary)' }}>
              {isEditing ? 'Editar Sessão' : 'Nova Sessão'}
            </h2>
            <p className="text-xs" style={{ color: 'var(--color-text-muted)' }}>{tabLabel}</p>
          </div>
          <button onClick={onClose} className="rounded p-1.5 transition-colors"
            style={{ color: 'var(--color-text-muted)' }}>
            <X size={16} />
          </button>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="space-y-4 px-6 py-5">
          <div className="flex gap-3">
            <div className="w-36 shrink-0">
              <label className="mb-1.5 block text-xs font-medium" style={{ color: 'var(--color-text-muted)' }}>Data</label>
              <input
                type="date"
                value={date}
                onChange={(e) => setSummary_date(e.target.value)}
                required
                className="w-full px-3 py-2 text-sm [color-scheme:dark]"
                style={inputStyle}
              />
            </div>
            <div className="flex-1">
              <label className="mb-1.5 block text-xs font-medium" style={{ color: 'var(--color-text-muted)' }}>Título</label>
              <input
                value={title}
                onChange={(e) => setTitle(e.target.value)}
                placeholder="Ex: A chegada às ruínas"
                required
                className="w-full px-3 py-2 text-sm"
                style={{ ...inputStyle, caretColor: 'var(--color-gold)' }}
              />
            </div>
          </div>

          <div>
            <label className="mb-1.5 block text-xs font-medium" style={{ color: 'var(--color-text-muted)' }}>Resumo da Sessão</label>
            <textarea
              value={summary}
              onChange={(e) => setSummary(e.target.value)}
              placeholder="Descreva o que aconteceu nessa sessão…"
              required
              rows={5}
              className="w-full resize-y px-3 py-2 text-sm"
              style={{ ...inputStyle, caretColor: 'var(--color-gold)' }}
            />
          </div>

          <div>
            <label className="mb-1.5 block text-xs font-medium" style={{ color: 'var(--color-text-muted)' }}>Tags</label>
            <TagInput tags={tags} onChange={setTags} />
          </div>

          <div className="flex justify-end gap-2 pt-1">
            <button type="button" onClick={onClose}
              className="rounded px-4 py-2 text-sm transition-colors"
              style={{ border: '1px solid var(--color-border-default)', color: 'var(--color-text-secondary)' }}>
              Cancelar
            </button>
            <button type="submit" disabled={!title.trim() || !summary.trim()}
              className="arcane-btn px-5 py-2 text-sm font-semibold">
              {isEditing ? 'Salvar Alterações' : 'Salvar Sessão'}
            </button>
          </div>
        </form>
      </div>
    </div>
  )
}
