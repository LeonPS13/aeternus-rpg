'use client'

import { useState } from 'react'
import { Trash2, Pencil, ChevronDown, ChevronUp, Calendar } from 'lucide-react'
import type { DiaryEntry } from '@/types/adventure'

interface EntryCardProps {
  entry: DiaryEntry
  canEdit: boolean
  searchQuery: string
  onDelete: (id: string) => void
  onEdit: (entry: DiaryEntry) => void
}

function highlight(text: string, query: string): React.ReactNode {
  if (!query.trim()) return text
  const regex = new RegExp(`(${query.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')})`, 'gi')
  const parts = text.split(regex)
  return parts.map((part, i) =>
    regex.test(part) ? (
      <mark key={i} className="rounded bg-cyan-500/20 text-cyan-300 not-italic">
        {part}
      </mark>
    ) : (
      part
    ),
  )
}

function formatDate(iso: string): string {
  const [y, m, d] = iso.split('-')
  return `${d}/${m}/${y}`
}

export default function EntryCard({ entry, canEdit, searchQuery, onDelete, onEdit }: EntryCardProps) {
  const [expanded, setExpanded] = useState(false)
  const isLong = entry.summary.length > 240

  return (
    <div className="animate-[fade-up_0.3s_ease-out_forwards] rounded-xl border border-slate-700/60 bg-slate-800/40 p-5 transition-colors hover:border-slate-600/80">
      {/* Header */}
      <div className="mb-3 flex items-start justify-between gap-3">
        <div className="flex-1">
          <h3 className="font-semibold text-slate-100">
            {highlight(entry.title, searchQuery)}
          </h3>
          <div className="mt-0.5 flex items-center gap-1.5 text-xs text-slate-500">
            <Calendar size={11} />
            <span>{formatDate(entry.date)}</span>
          </div>
        </div>
        {canEdit && (
          <div className="flex items-center gap-1">
            <button
              onClick={() => onEdit(entry)}
              className="rounded-lg p-1.5 text-slate-600 transition-colors hover:bg-cyan-500/10 hover:text-cyan-400"
              title="Editar"
            >
              <Pencil size={13} />
            </button>
            <button
              onClick={() => onDelete(entry.id)}
              className="rounded-lg p-1.5 text-slate-600 transition-colors hover:bg-red-500/10 hover:text-red-400"
              title="Excluir"
            >
              <Trash2 size={13} />
            </button>
          </div>
        )}
      </div>

      {/* Tags */}
      {entry.tags.length > 0 && (
        <div className="mb-3 flex flex-wrap gap-1.5">
          {entry.tags.map((tag) => (
            <span
              key={tag}
              className={`rounded-md border px-2 py-0.5 text-[11px] font-medium ${
                searchQuery && tag.toLowerCase().includes(searchQuery.toLowerCase())
                  ? 'border-cyan-500/50 bg-cyan-500/15 text-cyan-300'
                  : 'border-slate-700 bg-slate-800 text-slate-400'
              }`}
            >
              {tag}
            </span>
          ))}
        </div>
      )}

      {/* Summary */}
      <p className={`text-sm leading-relaxed text-slate-300 ${!expanded && isLong ? 'line-clamp-3' : ''}`}>
        {highlight(entry.summary, searchQuery)}
      </p>

      {isLong && (
        <button
          onClick={() => setExpanded((v) => !v)}
          className="mt-2 flex items-center gap-1 text-xs text-slate-500 hover:text-cyan-400"
        >
          {expanded ? <><ChevronUp size={12} /> ver menos</> : <><ChevronDown size={12} /> ver mais</>}
        </button>
      )}
    </div>
  )
}
