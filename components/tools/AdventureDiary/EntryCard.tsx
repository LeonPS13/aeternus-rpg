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
      <mark key={i} className="rounded not-italic"
        style={{ background: 'rgba(201,168,76,0.2)', color: 'var(--color-gold-light)' }}>
        {part}
      </mark>
    ) : part,
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
    <div className="arcane-panel animate-[fade-up_0.3s_ease-out_forwards] p-5 transition-colors">
      {/* Header */}
      <div className="mb-3 flex items-start justify-between gap-3">
        <div className="flex-1">
          <h3 className="font-semibold" style={{ color: 'var(--color-text-primary)' }}>
            {highlight(entry.title, searchQuery)}
          </h3>
          <div className="mt-0.5 flex items-center gap-1.5 text-xs" style={{ color: 'var(--color-text-muted)' }}>
            <Calendar size={11} />
            <span>{formatDate(entry.date)}</span>
          </div>
        </div>
        {canEdit && (
          <div className="flex items-center gap-1">
            <button onClick={() => onEdit(entry)}
              className="rounded p-1.5 transition-colors"
              style={{ color: 'var(--color-text-muted)' }}
              title="Editar">
              <Pencil size={13} />
            </button>
            <button onClick={() => onDelete(entry.id)}
              className="rounded p-1.5 transition-colors"
              style={{ color: 'var(--color-text-muted)' }}
              title="Excluir">
              <Trash2 size={13} />
            </button>
          </div>
        )}
      </div>

      {/* Tags */}
      {entry.tags.length > 0 && (
        <div className="mb-3 flex flex-wrap gap-1.5">
          {entry.tags.map((tag) => {
            const isMatch = searchQuery && tag.toLowerCase().includes(searchQuery.toLowerCase())
            return (
              <span key={tag} className="rounded px-2 py-0.5 text-[11px] font-medium"
                style={isMatch ? {
                  border: '1px solid rgba(201,168,76,0.5)',
                  background: 'rgba(201,168,76,0.15)',
                  color: 'var(--color-gold-light)',
                } : {
                  border: '1px solid var(--color-border-default)',
                  background: 'var(--color-bg-tertiary)',
                  color: 'var(--color-text-secondary)',
                }}>
                {tag}
              </span>
            )
          })}
        </div>
      )}

      {/* Summary */}
      <p className={`text-sm leading-relaxed ${!expanded && isLong ? 'line-clamp-3' : ''}`}
        style={{ color: 'var(--color-text-secondary)' }}>
        {highlight(entry.summary, searchQuery)}
      </p>

      {isLong && (
        <button onClick={() => setExpanded((v) => !v)}
          className="mt-2 flex items-center gap-1 text-xs transition-colors"
          style={{ color: 'var(--color-text-muted)' }}>
          {expanded ? <><ChevronUp size={12} /> ver menos</> : <><ChevronDown size={12} /> ver mais</>}
        </button>
      )}
    </div>
  )
}
