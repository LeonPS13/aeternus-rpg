'use client'

import { useEffect } from 'react'
import { X } from 'lucide-react'
import type { CodexEntry } from '@/types/codex'
import { translateSubtype, translateDamageType, translateProperty } from '@/lib/codex'

interface Props {
  entry: CodexEntry
  onClose: () => void
}

function DataRow({ label, value }: { label: string; value: React.ReactNode }) {
  return (
    <div className="flex items-start justify-between gap-4 py-2"
      style={{ borderBottom: '1px solid var(--color-border-default)' }}>
      <span className="shrink-0 text-base" style={{ color: 'var(--color-text-muted)' }}>{label}</span>
      <span className="text-right text-base" style={{ color: 'var(--color-text-primary)' }}>{value}</span>
    </div>
  )
}

function WeaponData({ d }: { d: Record<string, unknown> }) {
  const damage   = d.damage as string
  const dmgType  = translateDamageType(d.damage_type as string)
  const props    = (d.properties as string[]) ?? []
  const versatile = d.versatile_damage as string | undefined
  const range    = d.range as string | undefined

  return (
    <>
      {damage && damage !== '0' && (
        <DataRow label="Dano" value={`${damage} ${dmgType}`} />
      )}
      {versatile && (
        <DataRow label="Versátil (2 mãos)" value={`${versatile} ${dmgType}`} />
      )}
      {range && (
        <DataRow label="Alcance" value={`${range} pés`} />
      )}
      {props.length > 0 && (
        <DataRow label="Propriedades" value={
          <div className="flex flex-wrap justify-end gap-1">
            {props.map(p => (
              <span key={p} className="rounded px-1.5 py-0.5 text-sm"
                style={{ background: 'var(--color-bg-tertiary)', color: 'var(--color-text-secondary)' }}>
                {translateProperty(p)}
              </span>
            ))}
          </div>
        } />
      )}
      <DataRow label="Peso" value={`${d.weight} lb`} />
      <DataRow label="Custo" value={d.cost as string} />
    </>
  )
}

function ArmorData({ d, isShield }: { d: Record<string, unknown>; isShield: boolean }) {
  if (isShield) {
    return (
      <>
        <DataRow label="Bônus de CA" value={`+${d.ac_bonus}`} />
        <DataRow label="Furtividade"  value={d.stealth_disadvantage ? 'Desvantagem' : 'Normal'} />
        <DataRow label="Peso"         value={`${d.weight} lb`} />
        <DataRow label="Custo"        value={d.cost as string} />
      </>
    )
  }

  const maxDex = d.max_dex_bonus
  const dexNote = maxDex === null  ? ' + mod. Des'
    : maxDex === 0                 ? ' (sem bônus de Des)'
    :                                ` + mod. Des (máx +${maxDex})`

  return (
    <>
      <DataRow label="CA"            value={`${d.ac_base}${dexNote}`} />
      {(d.min_strength as number) > 0 && (
        <DataRow label="For mínima"  value={String(d.min_strength)} />
      )}
      <DataRow label="Furtividade"   value={d.stealth_disadvantage ? 'Desvantagem' : 'Normal'} />
      <DataRow label="Peso"          value={`${d.weight} lb`} />
      <DataRow label="Custo"         value={d.cost as string} />
    </>
  )
}

const ITEM_LABELS: Record<string, string> = {
  healing:         'Cura',
  damage:          'Dano',
  damage_type:     'Tipo de Dano',
  ongoing_damage:  'Dano Contínuo',
  save_dc:         'CD',
  save_ability:    'Atributo',
  attack_bonus:    'Bônus de Ataque',
  condition:       'Condição',
  stat:            'Atributo',
  value:           'Valor',
  duration_hours:  'Duração (h)',
  duration_minutes:'Duração (min)',
  spell_level:     'Nível da Magia',
  uses:            'Usos',
  quantity:        'Quantidade',
  days:            'Dias',
  pages:           'Páginas',
  capacity_lb:     'Capacidade (lb)',
  capacity_liters: 'Capacidade (L)',
  capacity:        'Capacidade',
  capacity_kg:     'Capacidade (kg)',
  length_m:        'Comprimento (m)',
  radius_ft:       'Raio (pés)',
  cone_length_ft:  'Alcance (pés)',
  cone_width_ft:   'Largura (pés)',
  area_ft:         'Área (pés)',
  magnification:   'Ampliação',
  ac:              'CA',
  hp:              'PV',
  escape_dc:       'CD de Fuga',
  weight:          'Peso',
  cost:            'Custo',
}

const ITEM_FIELD_ORDER = [
  'healing', 'damage', 'damage_type', 'ongoing_damage',
  'save_dc', 'save_ability', 'attack_bonus', 'condition', 'stat', 'value',
  'duration_hours', 'duration_minutes', 'spell_level',
  'uses', 'quantity', 'days', 'pages',
  'capacity_lb', 'capacity_liters', 'capacity', 'capacity_kg',
  'length_m', 'radius_ft', 'cone_length_ft', 'cone_width_ft', 'area_ft',
  'magnification', 'ac', 'hp', 'escape_dc',
  'weight', 'cost',
]

function ItemData({ d }: { d: Record<string, unknown> }) {
  return (
    <>
      {ITEM_FIELD_ORDER.map(key => {
        if (!(key in d)) return null
        const label = ITEM_LABELS[key] ?? key
        let val: React.ReactNode = String(d[key])
        if (key === 'weight')      val = `${d[key]} lb`
        if (key === 'damage_type') val = translateDamageType(d[key] as string)
        return <DataRow key={key} label={label} value={val} />
      })}
    </>
  )
}

function RuleData({ d }: { d: Record<string, unknown> }) {
  const effects  = d.effects  as string[] | undefined
  const levels   = d.levels   as { level: number; effect: string }[] | undefined
  const degrees  = d.degrees  as { name: string; bonus: string; examples: string }[] | undefined
  const duration = d.duration as string | undefined

  return (
    <div className="space-y-3">
      {duration && (
        <div className="flex items-start justify-between gap-4 py-2"
          style={{ borderBottom: '1px solid var(--color-border-default)' }}>
          <span className="shrink-0 text-base" style={{ color: 'var(--color-text-muted)' }}>Duração</span>
          <span className="text-right text-base" style={{ color: 'var(--color-text-primary)' }}>{duration}</span>
        </div>
      )}

      {effects && effects.length > 0 && (
        <ul className="space-y-1.5">
          {effects.map((e, i) => (
            <li key={i} className="flex items-start gap-2 text-base" style={{ color: 'var(--color-text-secondary)' }}>
              <span className="mt-1.5 h-1 w-1 shrink-0 rounded-full" style={{ background: 'var(--color-gold)' }} />
              {e}
            </li>
          ))}
        </ul>
      )}

      {levels && levels.length > 0 && (
        <div className="space-y-1">
          {levels.map(l => (
            <div key={l.level} className="flex items-start gap-3 py-1.5"
              style={{ borderBottom: '1px solid var(--color-border-default)' }}>
              <span className="shrink-0 rounded px-1.5 py-0.5 text-xs font-medium"
                style={{ background: 'var(--color-bg-tertiary)', color: 'var(--color-gold)', minWidth: '4rem', textAlign: 'center' }}>
                Nível {l.level}
              </span>
              <span className="text-base" style={{ color: 'var(--color-text-primary)' }}>{l.effect}</span>
            </div>
          ))}
        </div>
      )}

      {degrees && degrees.length > 0 && (
        <div className="space-y-2">
          {degrees.map(deg => (
            <div key={deg.name} className="rounded p-3" style={{ background: 'var(--color-bg-tertiary)', border: '1px solid var(--color-border-default)' }}>
              <div className="mb-1 flex items-center justify-between gap-2">
                <span className="text-base font-medium" style={{ color: 'var(--color-text-primary)' }}>{deg.name}</span>
                <span className="text-base" style={{ color: 'var(--color-gold)' }}>{deg.bonus}</span>
              </div>
              <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>{deg.examples}</p>
            </div>
          ))}
        </div>
      )}
    </div>
  )
}

export default function CodexDetail({ entry, onClose }: Props) {
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
        className="arcane-panel relative w-full max-w-lg p-6"
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

        {/* Chips */}
        <div className="mb-2 flex flex-wrap items-center gap-2">
          {entry.subtype && (
            <span className="rounded px-2 py-0.5 text-sm"
              style={{ background: 'var(--color-bg-tertiary)', color: 'var(--color-text-muted)' }}>
              {translateSubtype(entry.subtype)}
            </span>
          )}
          {entry.source === 'srd' && (
            <span className="rounded px-2 py-0.5 text-sm"
              style={{ background: 'var(--color-gold-glow)', color: 'var(--color-gold-dark)', border: '1px solid rgba(201,168,76,0.3)' }}>
              SRD
            </span>
          )}
        </div>

        <h2 className="mb-3 text-3xl" style={{ color: 'var(--color-text-primary)' }}>
          {entry.name}
        </h2>

        {entry.description && (
          <p className="mb-4 text-base leading-relaxed" style={{ color: 'var(--color-text-secondary)' }}>
            {entry.description}
          </p>
        )}

        <div className="ornament-divider my-4">
          <div className="ornament-line" />
          <div className="ornament-diamond" />
          <div className="ornament-line" />
        </div>

        <div>
          {entry.type === 'weapon' && <WeaponData d={entry.data} />}
          {entry.type === 'armor'  && <ArmorData  d={entry.data} isShield={entry.subtype === 'shield'} />}
          {entry.type === 'item'   && <ItemData   d={entry.data} />}
          {entry.type === 'rule'   && <RuleData   d={entry.data} />}
        </div>
      </div>
    </div>
  )
}
