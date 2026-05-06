'use client'

import { X } from 'lucide-react'

interface Props {
  notes: string[]
  onChange: (i: number, text: string) => void
}

export default function NotesGrid({ notes, onChange }: Props) {
  return (
    <div className="grid grid-cols-3 gap-3">
      {notes.map((note, i) => (
        <div key={i} className="arcane-panel relative p-2" style={{ minHeight: '9rem' }}>
          {note !== '' && (
            <button
              onClick={() => onChange(i, '')}
              className="absolute right-1.5 top-1.5 rounded p-0.5 z-10"
              style={{ color: 'var(--color-text-muted)' }}
              aria-label="Limpar nota"
            >
              <X size={12} />
            </button>
          )}
          <textarea
            value={note}
            onChange={(e) => onChange(i, e.target.value)}
            placeholder="Nota..."
            className="h-full w-full resize-none text-sm leading-relaxed"
            style={{
              background: 'transparent',
              border: 'none',
              outline: 'none',
              color: 'var(--color-text-primary)',
              caretColor: 'var(--color-gold)',
              minHeight: '8rem',
            }}
          />
        </div>
      ))}
    </div>
  )
}
