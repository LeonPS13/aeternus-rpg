'use client'

import { useState } from 'react'
import { Plus, User, Trash2, Check } from 'lucide-react'
import type { Character } from '@/types/character'

interface Props {
  characters: Character[]
  onSelect: (char: Character) => void
  onCreate: () => void
  onDelete: (id: string) => void
}

export default function CharacterList({ characters, onSelect, onCreate, onDelete }: Props) {
  const [confirmId, setConfirmId] = useState<string | null>(null)

  return (
    <div className="mx-auto w-full max-w-2xl px-6 py-8">
      <div className="mb-4">
        <h1 className="mb-1 text-3xl" style={{ color: 'var(--color-text-primary)' }}>Fichas de Personagem</h1>
        <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Sua biblioteca de personagens D&D 5e SRD.</p>
      </div>

      <button
        onClick={onCreate}
        className="arcane-btn mb-4 flex items-center gap-2 px-4 py-1.5 text-2xl"
      >
        <Plus size={16} /> Nova Ficha
      </button>

      {characters.length > 0 ? (
        <div>
          <p className="section-label mb-3">· Seus Personagens ·</p>
          <ul className="space-y-2">
            {characters.map((c) => {
              const isConfirming = confirmId === c.id
              const subtitle = [c.race, c.characterClass, c.level > 0 && `Nível ${c.level}`]
                .filter(Boolean).join(' · ')
              return (
                <li key={c.id}>
                  <div
                    className="group flex w-full items-center gap-3 rounded px-3 py-2.5 transition-all"
                    style={{ border: '1px solid var(--color-border-default)', background: 'var(--color-bg-secondary)' }}
                  >
                    <div className="flex h-9 w-9 shrink-0 items-center justify-center rounded"
                      style={{ background: 'var(--color-gold-glow)', color: 'var(--color-gold)' }}>
                      <User size={16} />
                    </div>
                    <button onClick={() => onSelect(c)} className="min-w-0 flex-1 text-left">
                      <p className="truncate text-xl" style={{ color: 'var(--color-text-primary)' }}>
                        {c.characterName || 'Sem nome'}
                      </p>
                      {subtitle && (
                        <p className="text-xs" style={{ color: 'var(--color-text-muted)' }}>{subtitle}</p>
                      )}
                    </button>

                    {isConfirming ? (
                      <div className="flex items-center gap-1">
                        <span className="text-xs" style={{ color: 'var(--color-text-muted)' }}>Excluir?</span>
                        <button
                          onClick={() => { onDelete(c.id); setConfirmId(null) }}
                          className="rounded p-1"
                          style={{ color: '#f87171' }}>
                          <Check size={13} />
                        </button>
                        <button onClick={() => setConfirmId(null)}
                          className="rounded p-1 text-xs font-bold"
                          style={{ color: 'var(--color-text-muted)' }}>✕</button>
                      </div>
                    ) : (
                      <button
                        onClick={(e) => { e.stopPropagation(); setConfirmId(c.id) }}
                        className="rounded p-1 opacity-0 transition-all group-hover:opacity-100"
                        style={{ color: 'var(--color-text-muted)' }}>
                        <Trash2 size={13} />
                      </button>
                    )}
                  </div>
                </li>
              )
            })}
          </ul>
        </div>
      ) : (
        <div className="flex flex-col items-center justify-center gap-3 rounded border border-dashed py-16 text-center"
          style={{ borderColor: 'var(--color-border-default)' }}>
          <User size={28} style={{ color: 'var(--color-text-muted)' }} />
          <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
            Nenhuma ficha criada ainda.<br />Clique em &quot;Nova Ficha&quot; para começar.
          </p>
        </div>
      )}
    </div>
  )
}
