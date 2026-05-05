'use client'

import { Search, X } from 'lucide-react'

interface SearchBarProps {
  value: string
  onChange: (v: string) => void
  placeholder?: string
}

export default function SearchBar({ value, onChange, placeholder = 'Buscar por título, resumo ou tag…' }: SearchBarProps) {
  return (
    <div className="relative">
      <Search size={14} className="absolute left-3 top-1/2 -translate-y-1/2"
        style={{ color: 'var(--color-text-muted)' }} />
      <input
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder={placeholder}
        className="w-full rounded py-2 pl-9 pr-8 text-sm outline-none"
        style={{
          border: '1px solid var(--color-border-default)',
          background: 'var(--color-bg-tertiary)',
          color: 'var(--color-text-primary)',
          caretColor: 'var(--color-gold)',
        }}
      />
      {value && (
        <button onClick={() => onChange('')}
          className="absolute right-2.5 top-1/2 -translate-y-1/2 transition-colors"
          style={{ color: 'var(--color-text-muted)' }}>
          <X size={13} />
        </button>
      )}
    </div>
  )
}
