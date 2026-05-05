'use client'

import { useState } from 'react'
import { X } from 'lucide-react'
import type { Adventure } from '@/types/adventure'
import { IconPicker } from './adventureIcons'

interface EditAdventureModalProps {
  adventure: Adventure
  onSave: (updated: Adventure) => void
  onClose: () => void
}

export default function EditAdventureModal({ adventure, onSave, onClose }: EditAdventureModalProps) {
  const [name, setName]     = useState(adventure.name)
  const [iconId, setIconId] = useState(adventure.icon ?? 'BookOpen')

  function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault()
    const trimmed = name.trim()
    if (!trimmed) return
    onSave({ ...adventure, name: trimmed, icon: iconId })
  }

  const inputStyle = {
    background: 'var(--color-bg-tertiary)',
    border: '1px solid var(--color-border-default)',
    color: 'var(--color-text-primary)',
    borderRadius: '4px',
    caretColor: 'var(--color-gold)',
  }

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-4"
      style={{ background: 'rgba(0,0,0,0.75)' }}
      onClick={onClose}
    >
      <div className="arcane-panel w-full max-w-sm p-5" onClick={(e) => e.stopPropagation()}>
        <div className="mb-4 flex items-center justify-between">
          <h2 className="text-lg" style={{ color: 'var(--color-text-primary)' }}>Editar Aventura</h2>
          <button onClick={onClose} style={{ color: 'var(--color-text-muted)' }}>
            <X size={16} />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="flex flex-col gap-4">
          <div>
            <p className="section-label mb-2">· Nome ·</p>
            <input
              value={name}
              onChange={(e) => setName(e.target.value)}
              className="w-full px-3 py-2 text-sm outline-none"
              style={inputStyle}
            />
          </div>

          <div>
            <p className="section-label mb-2">· Ícone ·</p>
            <IconPicker value={iconId} onChange={setIconId} />
          </div>

          <div className="flex gap-2 pt-1">
            <button
              type="submit"
              disabled={!name.trim()}
              className="arcane-btn flex-1 py-2 text-sm font-semibold disabled:opacity-50"
            >
              Salvar
            </button>
            <button
              type="button"
              onClick={onClose}
              className="flex-1 rounded py-2 text-sm transition-all"
              style={{ border: '1px solid var(--color-border-default)', color: 'var(--color-text-secondary)' }}
            >
              Cancelar
            </button>
          </div>
        </form>
      </div>
    </div>
  )
}
