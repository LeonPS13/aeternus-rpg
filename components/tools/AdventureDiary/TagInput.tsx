'use client'

import { useState } from 'react'
import { X } from 'lucide-react'

interface TagInputProps {
  tags: string[]
  onChange: (tags: string[]) => void
}

export default function TagInput({ tags, onChange }: TagInputProps) {
  const [input, setInput] = useState('')

  function commitWord(word: string) {
    const tag = word.trim().toLowerCase()
    if (tag && !tags.includes(tag)) onChange([...tags, tag])
  }

  function handleChange(e: React.ChangeEvent<HTMLInputElement>) {
    const val = e.target.value
    const words = val.split(' ')
    const completed = words.slice(0, -1)
    const remaining = words[words.length - 1]
    if (completed.length > 0) {
      const next = [...tags]
      for (const w of completed) {
        const tag = w.trim().toLowerCase()
        if (tag && !next.includes(tag)) next.push(tag)
      }
      onChange(next)
    }
    setInput(remaining)
  }

  function handleKeyDown(e: React.KeyboardEvent<HTMLInputElement>) {
    if (e.key === 'Backspace' && input === '' && tags.length > 0) onChange(tags.slice(0, -1))
    if (e.key === 'Enter') {
      e.preventDefault()
      if (input.trim()) { commitWord(input); setInput('') }
    }
  }

  return (
    <div className="flex min-h-[2.5rem] flex-wrap gap-1.5 rounded px-2.5 py-1.5"
      style={{ border: '1px solid var(--color-border-default)', background: 'var(--color-bg-tertiary)' }}>
      {tags.map((tag) => (
        <span key={tag} className="inline-flex items-center gap-1 rounded px-2 py-0.5 text-xs font-medium"
          style={{ border: '1px solid rgba(201,168,76,0.3)', background: 'var(--color-gold-glow)', color: 'var(--color-gold-light)' }}>
          {tag}
          <button type="button" onClick={() => onChange(tags.filter((t) => t !== tag))}
            style={{ color: 'var(--color-gold-dark)' }}>
            <X size={10} />
          </button>
        </span>
      ))}
      <input
        value={input}
        onChange={handleChange}
        onKeyDown={handleKeyDown}
        onBlur={() => { if (input.trim()) { commitWord(input); setInput('') } }}
        placeholder={tags.length === 0 ? 'Digite palavras separadas por espaço…' : ''}
        className="min-w-[120px] flex-1 bg-transparent text-sm outline-none"
        style={{ color: 'var(--color-text-primary)', caretColor: 'var(--color-gold)' }}
      />
    </div>
  )
}
