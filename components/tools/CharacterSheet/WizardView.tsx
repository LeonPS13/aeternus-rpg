'use client'

import { useState } from 'react'
import { ArrowLeft, ArrowRight, Save } from 'lucide-react'
import type { Character } from '@/types/character'
import IdentitySection from './sections/IdentitySection'
import StatsSection from './sections/StatsSection'
import CombatSection from './sections/CombatSection'
import EquipmentSection from './sections/EquipmentSection'
import TraitsSection from './sections/TraitsSection'

const STEPS = [
  { key: 'identity',   label: 'Identidade'  },
  { key: 'attributes', label: 'Atributos'   },
  { key: 'combat',     label: 'Combate'     },
  { key: 'equipment',  label: 'Equipamento' },
  { key: 'traits',     label: 'Traços'      },
] as const

interface Props {
  draft: Character
  onDraftChange: (u: Partial<Character>) => void
  onSave: (char: Character) => Promise<void>
  onCancel: () => void
}

export default function WizardView({ draft, onDraftChange, onSave, onCancel }: Props) {
  const [step, setStep] = useState(0)
  const [saving, setSaving] = useState(false)
  const isLast = step === STEPS.length - 1
  const current = STEPS[step]

  async function handleSave() {
    setSaving(true)
    await onSave(draft)
    setSaving(false)
  }

  return (
    <div className="mx-auto w-full max-w-3xl px-4 py-6 sm:px-6 sm:py-8">
      {/* Header */}
      <div className="mb-6">
        <button
          onClick={onCancel}
          className="mb-3 flex items-center gap-1.5 text-xs"
          style={{ color: 'var(--color-text-muted)' }}>
          <ArrowLeft size={13} /> Cancelar
        </button>
        <h1 className="text-3xl" style={{ color: 'var(--color-text-primary)' }}>Nova Ficha</h1>
      </div>

      {/* Step progress */}
      <div className="mb-6 flex items-center gap-2 overflow-x-auto pb-1">
        {STEPS.map((s, i) => (
          <div key={s.key} className="flex items-center gap-2 shrink-0">
            <div
              className="flex h-6 w-6 items-center justify-center rounded-full text-xs font-bold"
              style={i < step ? {
                background: 'var(--color-gold)',
                color: 'var(--color-bg-primary)',
              } : i === step ? {
                background: 'var(--color-gold-glow)',
                border: '1px solid var(--color-gold)',
                color: 'var(--color-gold-light)',
              } : {
                background: 'var(--color-bg-tertiary)',
                border: '1px solid var(--color-border-default)',
                color: 'var(--color-text-muted)',
              }}
            >
              {i + 1}
            </div>
            <span
              className="text-sm whitespace-nowrap"
              style={{ color: i === step ? 'var(--color-gold-light)' : 'var(--color-text-muted)' }}>
              {s.label}
            </span>
            {i < STEPS.length - 1 && (
              <div className="h-px w-4"
                style={{ background: i < step ? 'var(--color-gold)' : 'var(--color-border-default)' }} />
            )}
          </div>
        ))}
      </div>

      {/* Current step label */}
      <p className="section-label mb-6">· {current.label} — {step + 1} de {STEPS.length} ·</p>

      {/* Section content */}
      <div className="mb-8">
        {step === 0 && <IdentitySection  char={draft} onChange={onDraftChange} />}
        {step === 1 && <StatsSection     char={draft} onChange={onDraftChange} />}
        {step === 2 && <CombatSection    char={draft} onChange={onDraftChange} />}
        {step === 3 && <EquipmentSection char={draft} onChange={onDraftChange} />}
        {step === 4 && <TraitsSection    char={draft} onChange={onDraftChange} />}
      </div>

      {/* Navigation bar */}
      <div className="flex items-center justify-between gap-3">
        <button
          onClick={() => step === 0 ? onCancel() : setStep(step - 1)}
          className="flex items-center gap-1.5 rounded px-4 py-2 text-sm transition-all"
          style={{ border: '1px solid var(--color-border-default)', color: 'var(--color-text-muted)' }}>
          <ArrowLeft size={14} />
          {step === 0 ? 'Cancelar' : 'Anterior'}
        </button>

        {isLast ? (
          <button
            onClick={handleSave}
            disabled={saving}
            className="arcane-btn flex items-center gap-2 px-5 py-2 text-sm font-semibold disabled:opacity-50">
            {saving ? 'Salvando…' : <><Save size={14} /> Salvar Ficha</>}
          </button>
        ) : (
          <button
            onClick={() => setStep(step + 1)}
            className="flex items-center gap-1.5 rounded px-4 py-2 text-sm transition-all"
            style={{ background: 'var(--color-gold-glow)', border: '1px solid var(--color-border-default)', color: 'var(--color-gold-light)' }}>
            Próximo <ArrowRight size={14} />
          </button>
        )}
      </div>
    </div>
  )
}
