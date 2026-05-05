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
    if (tag && !tags.includes(tag)) {
      onChange([...tags, tag])
    }
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
    if (e.key === 'Backspace' && input === '' && tags.length > 0) {
      onChange(tags.slice(0, -1))
    }
    if (e.key === 'Enter') {
      e.preventDefault()
      if (input.trim()) { commitWord(input); setInput('') }
    }
  }

  return (
    <div className="flex min-h-[2.5rem] flex-wrap gap-1.5 rounded-lg border border-slate-700 bg-slate-800/60 px-2.5 py-1.5 focus-within:border-cyan-500/60 focus-within:ring-1 focus-within:ring-cyan-500/20">
      {tags.map((tag) => (
        <span
          key={tag}
          className="inline-flex items-center gap-1 rounded-md border border-cyan-500/30 bg-cyan-500/10 px-2 py-0.5 text-xs font-medium text-cyan-300"
        >
          {tag}
          <button
            type="button"
            onClick={() => onChange(tags.filter((t) => t !== tag))}
            className="text-cyan-500 hover:text-cyan-200"
          >
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
        className="min-w-[120px] flex-1 bg-transparent text-sm text-slate-200 placeholder:text-slate-600 focus:outline-none"
      />
    </div>
  )
}
