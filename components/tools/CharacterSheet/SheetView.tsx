'use client'

import { useState } from 'react'
import { ArrowLeft, Save, Trash2 } from 'lucide-react'
import type { Character } from '@/types/character'
import IdentitySection from './sections/IdentitySection'
import StatsSection from './sections/StatsSection'
import CombatSection from './sections/CombatSection'
import EquipmentSection from './sections/EquipmentSection'
import TraitsSection from './sections/TraitsSection'

const TABS = [
  { key: 'identity',   label: 'Identidade'  },
  { key: 'attributes', label: 'Atributos'   },
  { key: 'combat',     label: 'Combate'     },
  { key: 'equipment',  label: 'Equipamento' },
  { key: 'traits',     label: 'Traços'      },
] as const
type TabKey = (typeof TABS)[number]['key']

interface Props {
  char: Character
  onChange: (updates: Partial<Character>) => void
  onSave: () => Promise<void>
  onBack: () => void
  onDelete: () => void
}

export default function SheetView({ char, onChange, onSave, onBack, onDelete }: Props) {
  const [activeTab, setActiveTab] = useState<TabKey>('identity')
  const [saving, setSaving] = useState(false)
  const [confirmDelete, setConfirmDelete] = useState(false)

  async function handleSave() {
    setSaving(true)
    await onSave()
    setSaving(false)
  }

  return (
    <div className="mx-auto w-full max-w-3xl px-4 py-6 sm:px-6 sm:py-8">
      {/* Header */}
      <div className="mb-6 flex items-start justify-between gap-3">
        <div>
          <button
            onClick={onBack}
            className="mb-3 flex items-center gap-1.5 text-xs transition-colors"
            style={{ color: 'var(--color-text-muted)' }}>
            <ArrowLeft size={13} /> Voltar à ficha
          </button>
          <h1 className="text-2xl" style={{ color: 'var(--color-text-primary)' }}>
            {char.characterName || 'Sem nome'}
          </h1>
          {(char.race || char.characterClass) && (
            <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
              {[char.race, char.characterClass, char.level > 0 && `Nível ${char.level}`]
                .filter(Boolean).join(' · ')}
            </p>
          )}
        </div>

        <div className="flex items-center gap-2 pt-7">
          {confirmDelete ? (
            <>
              <span className="text-xs" style={{ color: 'var(--color-text-muted)' }}>Excluir ficha?</span>
              <button onClick={onDelete} className="rounded px-2 py-1 text-xs"
                style={{ background: 'rgba(248,113,113,0.1)', color: '#f87171', border: '1px solid rgba(248,113,113,0.3)' }}>
                Confirmar
              </button>
              <button onClick={() => setConfirmDelete(false)} className="text-xs"
                style={{ color: 'var(--color-text-muted)' }}>Cancelar</button>
            </>
          ) : (
            <>
              <button
                onClick={handleSave}
                disabled={saving}
                className="flex items-center gap-1.5 rounded px-3 py-1.5 text-sm transition-all disabled:opacity-50"
                style={{ background: 'var(--color-gold-glow)', border: '1px solid var(--color-border-default)', color: 'var(--color-gold-light)' }}>
                <Save size={13} /> {saving ? 'Salvando…' : 'Salvar'}
              </button>
              <button
                onClick={() => setConfirmDelete(true)}
                className="rounded p-1.5 transition-colors"
                style={{ color: 'var(--color-text-muted)' }}>
                <Trash2 size={14} />
              </button>
            </>
          )}
        </div>
      </div>

      {/* Tabs */}
      <div className="mb-6 overflow-x-auto">
        <div className="flex min-w-max gap-1 rounded p-1"
          style={{ border: '1px solid var(--color-border-default)', background: 'var(--color-bg-secondary)' }}>
          {TABS.map(({ key, label }) => (
            <button
              key={key}
              onClick={() => setActiveTab(key)}
              className="rounded px-3 py-2 text-sm font-medium transition-all whitespace-nowrap"
              style={activeTab === key ? {
                background: 'var(--color-bg-tertiary)',
                color: 'var(--color-gold-light)',
                border: '1px solid var(--color-border-default)',
              } : {
                color: 'var(--color-text-muted)',
              }}
            >
              {label}
            </button>
          ))}
        </div>
      </div>

      {/* Section content */}
      {activeTab === 'identity'   && <IdentitySection  char={char} onChange={onChange} />}
      {activeTab === 'attributes' && <StatsSection     char={char} onChange={onChange} />}
      {activeTab === 'combat'     && <CombatSection    char={char} onChange={onChange} />}
      {activeTab === 'equipment'  && <EquipmentSection char={char} onChange={onChange} />}
      {activeTab === 'traits'     && <TraitsSection    char={char} onChange={onChange} />}
    </div>
  )
}
