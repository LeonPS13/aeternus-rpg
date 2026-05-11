'use client'

import { useEffect } from 'react'
import { X } from 'lucide-react'
import type { SpellEntry } from '@/types/spell'
import { translateSchool, translateSpellClass, spellLevelShort, SCHOOL_COLORS } from '@/lib/spells'

interface Props {
  spell: SpellEntry
  onClose: () => void
}

function Row({ label, value }: { label: string; value: React.ReactNode }) {
  return (
    <div className="flex items-start justify-between gap-4 py-2"
      style={{ borderBottom: '1px solid var(--color-border-default)' }}>
      <span className="shrink-0 text-base" style={{ color: 'var(--color-text-muted)' }}>{label}</span>
      <span className="text-right text-base" style={{ color: 'var(--color-text-primary)' }}>{value}</span>
    </div>
  )
}

export default function SpellDetail({ spell, onClose }: Props) {
  const color = SCHOOL_COLORS[spell.school] ?? SCHOOL_COLORS.evocation

  useEffect(() => {
    document.body.style.overflow = 'hidden'
    return () => { document.body.style.overflow = '' }
  }, [])

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-4"
      style={{ background: 'rgba(0,0,0,0.75)' }}
      onClick={onClose}
    >
      <div
        className="arcane-panel relative w-full max-w-lg overflow-y-auto p-6"
        style={{ maxHeight: '90vh' }}
        onClick={e => e.stopPropagation()}
      >
        <button
          onClick={onClose}
          className="absolute right-4 top-4 rounded p-1"
          style={{ color: 'var(--color-text-muted)' }}
          aria-label="Fechar"
        >
          <X size={16} />
        </button>

        {/* Chips row */}
        <div className="mb-2 flex flex-wrap items-center gap-2">
          <span className="rounded px-2 py-0.5 text-sm"
            style={{ background: color.bg, color: color.color, border: `1px solid ${color.border}` }}>
            {spellLevelShort(spell.level)}
          </span>
          <span className="rounded px-2 py-0.5 text-sm"
            style={{ background: color.bg, color: color.color, border: `1px solid ${color.border}` }}>
            {translateSchool(spell.school)}
          </span>
          {spell.concentration && (
            <span className="rounded px-2 py-0.5 text-sm"
              style={{ background: 'rgba(201,168,76,0.1)', color: 'var(--color-gold)', border: '1px solid rgba(201,168,76,0.3)' }}>
              Concentração
            </span>
          )}
          {spell.ritual && (
            <span className="rounded px-2 py-0.5 text-sm"
              style={{ background: 'var(--color-bg-tertiary)', color: 'var(--color-text-muted)', border: '1px solid var(--color-border-default)' }}>
              Ritual
            </span>
          )}
          {spell.source === 'srd' && (
            <span className="rounded px-2 py-0.5 text-sm"
              style={{ background: 'var(--color-gold-glow)', color: 'var(--color-gold-dark)', border: '1px solid rgba(201,168,76,0.3)' }}>
              SRD
            </span>
          )}
        </div>

        <h2 className="mb-1 text-3xl" style={{ color: 'var(--color-text-primary)' }}>
          {spell.name}
        </h2>
        {spell.nameEn && (
          <p className="mb-3 text-sm" style={{ color: 'var(--color-text-muted)' }}>{spell.nameEn}</p>
        )}

        <div className="ornament-divider my-4">
          <div className="ornament-line" /><div className="ornament-diamond" /><div className="ornament-line" />
        </div>

        {/* Stats */}
        <div className="mb-4">
          <Row label="Tempo de Conjuração" value={spell.castingTime} />
          <Row label="Alcance"              value={spell.range} />
          <Row label="Componentes"          value={spell.components} />
          <Row label="Duração"              value={spell.duration} />
        </div>

        {/* Description */}
        <p className="mb-4 whitespace-pre-line text-base leading-relaxed"
          style={{ color: 'var(--color-text-secondary)' }}>
          {spell.description}
        </p>

        {/* Higher levels */}
        {spell.higherLevels && (
          <div className="mb-4 rounded p-3"
            style={{ background: 'var(--color-bg-tertiary)', border: '1px solid var(--color-border-default)' }}>
            <p className="mb-1 text-sm font-medium" style={{ color: 'var(--color-gold)' }}>
              Em Níveis Superiores
            </p>
            <p className="text-base leading-relaxed" style={{ color: 'var(--color-text-secondary)' }}>
              {spell.higherLevels}
            </p>
          </div>
        )}

        {/* Classes */}
        {spell.classes.length > 0 && (
          <div>
            <p className="mb-2 text-sm" style={{ color: 'var(--color-text-muted)' }}>Classes</p>
            <div className="flex flex-wrap gap-1.5">
              {spell.classes.map(cls => (
                <span key={cls} className="rounded px-2 py-0.5 text-sm"
                  style={{ background: 'var(--color-bg-tertiary)', color: 'var(--color-text-secondary)', border: '1px solid var(--color-border-default)' }}>
                  {translateSpellClass(cls)}
                </span>
              ))}
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
