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

export default function NewEntryModal({
  adventureId,
  authorId,
  diaryType,
  initialEntry,
  onSave,
  onClose,
}: NewEntryModalProps) {
  const isEditing = !!initialEntry

  const [date, setDate] = useState(initialEntry?.date ?? todayISO())
  const [title, setTitle] = useState(initialEntry?.title ?? '')
  const [summary, setSummary] = useState(initialEntry?.summary ?? '')
  const [tags, setTags] = useState<string[]>(initialEntry?.tags ?? [])

  useEffect(() => {
    function onKey(e: KeyboardEvent) {
      if (e.key === 'Escape') onClose()
    }
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [onClose])

  function handleSubmit(e: React.SyntheticEvent) {
    e.preventDefault()
    if (!title.trim() || !summary.trim()) return

    const now = new Date().toISOString()
    const entry: DiaryEntry = {
      id: initialEntry?.id ?? crypto.randomUUID(),
      adventureId,
      date,
      title: title.trim(),
      summary: summary.trim(),
      tags,
      authorId,
      diaryType,
      createdAt: initialEntry?.createdAt ?? now,
      updatedAt: now,
    }
    onSave(entry)
  }

  const tabLabel = diaryType === 'adventure' ? 'Diário da Aventura' : 'Meu Diário'

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 px-4 backdrop-blur-sm"
      onClick={(e) => { if (e.target === e.currentTarget) onClose() }}
    >
      <div className="animate-[fade-up_0.25s_ease-out_forwards] w-full max-w-lg rounded-2xl border border-slate-700 bg-slate-900 shadow-2xl shadow-black/40">
        {/* Header */}
        <div className="flex items-center justify-between border-b border-slate-800 px-6 py-4">
          <div>
            <h2 className="font-semibold text-slate-100">
              {isEditing ? 'Editar Sessão' : 'Nova Sessão'}
            </h2>
            <p className="text-xs text-slate-500">{tabLabel}</p>
          </div>
          <button
            onClick={onClose}
            className="rounded-lg p-1.5 text-slate-500 hover:bg-slate-800 hover:text-slate-200"
          >
            <X size={16} />
          </button>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="space-y-4 px-6 py-5">
          <div className="flex gap-3">
            <div className="w-36 shrink-0">
              <label className="mb-1.5 block text-xs font-medium text-slate-400">Data</label>
              <input
                type="date"
                value={date}
                onChange={(e) => setDate(e.target.value)}
                required
                className="w-full rounded-lg border border-slate-700 bg-slate-800/60 px-3 py-2 text-sm text-slate-200 focus:border-cyan-500/60 focus:outline-none focus:ring-1 focus:ring-cyan-500/20 [color-scheme:dark]"
              />
            </div>
            <div className="flex-1">
              <label className="mb-1.5 block text-xs font-medium text-slate-400">Título</label>
              <input
                value={title}
                onChange={(e) => setTitle(e.target.value)}
                placeholder="Ex: A chegada às ruínas"
                required
                className="w-full rounded-lg border border-slate-700 bg-slate-800/60 px-3 py-2 text-sm text-slate-200 placeholder:text-slate-600 focus:border-cyan-500/60 focus:outline-none focus:ring-1 focus:ring-cyan-500/20"
              />
            </div>
          </div>

          <div>
            <label className="mb-1.5 block text-xs font-medium text-slate-400">Resumo da Sessão</label>
            <textarea
              value={summary}
              onChange={(e) => setSummary(e.target.value)}
              placeholder="Descreva o que aconteceu nessa sessão…"
              required
              rows={5}
              className="w-full resize-y rounded-lg border border-slate-700 bg-slate-800/60 px-3 py-2 text-sm text-slate-200 placeholder:text-slate-600 focus:border-cyan-500/60 focus:outline-none focus:ring-1 focus:ring-cyan-500/20"
            />
          </div>

          <div>
            <label className="mb-1.5 block text-xs font-medium text-slate-400">Tags</label>
            <TagInput tags={tags} onChange={setTags} />
          </div>

          <div className="flex justify-end gap-2 pt-1">
            <button
              type="button"
              onClick={onClose}
              className="rounded-lg border border-slate-700 px-4 py-2 text-sm text-slate-400 hover:bg-slate-800 hover:text-slate-200"
            >
              Cancelar
            </button>
            <button
              type="submit"
              disabled={!title.trim() || !summary.trim()}
              className="rounded-lg bg-gradient-to-r from-amber-600 to-orange-700 px-5 py-2 text-sm font-semibold text-white shadow-md shadow-amber-600/25 transition-all hover:from-amber-500 hover:to-orange-600 disabled:cursor-not-allowed disabled:opacity-50"
            >
              {isEditing ? 'Salvar Alterações' : 'Salvar Sessão'}
            </button>
          </div>
        </form>
      </div>
    </div>
  )
}
