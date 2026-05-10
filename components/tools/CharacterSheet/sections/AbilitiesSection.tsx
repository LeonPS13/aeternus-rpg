'use client'

import { useState, useEffect } from 'react'
import type { Character } from '@/types/character'
import type { ClassFeature, SubclassFeature, FeatureType } from '@/types/class'
import { getClassFeatures, getSubclassFeatures } from '@/lib/classes'

function FeatureBadge({ type }: { type: FeatureType }) {
  if (type === 'asi') return (
    <span className="rounded px-1.5 py-0.5 text-xs leading-none"
      style={{ background: 'rgba(201,168,76,0.15)', color: 'var(--color-gold)', border: '1px solid rgba(201,168,76,0.3)' }}>
      Melhoria de Atributo
    </span>
  )
  if (type === 'extra_attack') return (
    <span className="rounded px-1.5 py-0.5 text-xs leading-none"
      style={{ background: 'rgba(220,60,60,0.15)', color: '#f87171', border: '1px solid rgba(220,60,60,0.3)' }}>
      Ataque Extra
    </span>
  )
  if (type === 'spellcasting') return (
    <span className="rounded px-1.5 py-0.5 text-xs leading-none"
      style={{ background: 'rgba(100,40,140,0.15)', color: '#c084fc', border: '1px solid rgba(100,40,140,0.3)' }}>
      Conjuração
    </span>
  )
  return null
}

function FeatureItem({ feature, charLevel }: { feature: ClassFeature | SubclassFeature; charLevel: number }) {
  const [open, setOpen] = useState(false)
  const acquired = feature.level <= charLevel

  return (
    <div
      className="rounded p-3 transition-opacity"
      style={{
        background: 'var(--color-bg-secondary)',
        border: '1px solid var(--color-border-default)',
        opacity: acquired ? 1 : 0.4,
      }}
    >
      <button
        className="flex w-full items-start justify-between gap-2 text-left"
        onClick={() => setOpen(o => !o)}
      >
        <div className="flex flex-wrap items-center gap-2">
          <span className="text-base" style={{ color: 'var(--color-text-primary)' }}>
            {feature.name}
          </span>
          <FeatureBadge type={feature.type} />
        </div>
        <span className="shrink-0 rounded px-1.5 py-0.5 text-xs leading-none"
          style={{ background: 'var(--color-bg-tertiary)', color: 'var(--color-text-muted)', border: '1px solid var(--color-border-default)' }}>
          Nível {feature.level}
        </span>
      </button>
      {open && feature.description && (
        <p className="mt-2 whitespace-pre-line text-sm leading-relaxed"
          style={{ color: 'var(--color-text-secondary)' }}>
          {feature.description}
        </p>
      )}
    </div>
  )
}

interface Props {
  char: Character
}

export default function AbilitiesSection({ char }: Props) {
  const [classFeatures, setClassFeatures] = useState<ClassFeature[]>([])
  const [subFeatures, setSubFeatures] = useState<SubclassFeature[]>([])
  const [loading, setLoading] = useState(false)

  const classId = char.characterClass.toLowerCase().trim()

  useEffect(() => {
    if (!classId) return
    setLoading(true)
    Promise.all([
      getClassFeatures(classId),
      char.subclassId ? getSubclassFeatures(char.subclassId) : Promise.resolve([]),
    ]).then(([cf, sf]) => {
      setClassFeatures(cf)
      setSubFeatures(sf)
      setLoading(false)
    })
  }, [classId, char.subclassId])

  if (!classId) {
    return (
      <div className="flex flex-col items-center justify-center py-16 text-center">
        <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
          Defina a classe do personagem para ver as habilidades.
        </p>
      </div>
    )
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center py-16">
        <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Carregando habilidades…</p>
      </div>
    )
  }

  if (classFeatures.length === 0 && subFeatures.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center py-16 text-center">
        <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
          Nenhuma habilidade cadastrada para esta classe ainda.
        </p>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      {classFeatures.length > 0 && (
        <div>
          <p className="section-label mb-3">· Habilidades de Classe ·</p>
          <div className="space-y-2">
            {classFeatures.map(f => (
              <FeatureItem key={f.id} feature={f} charLevel={char.level} />
            ))}
          </div>
        </div>
      )}
      {subFeatures.length > 0 && (
        <div>
          <p className="section-label mb-3">· Habilidades de Subclasse ·</p>
          <div className="space-y-2">
            {subFeatures.map(f => (
              <FeatureItem key={f.id} feature={f} charLevel={char.level} />
            ))}
          </div>
        </div>
      )}
    </div>
  )
}
