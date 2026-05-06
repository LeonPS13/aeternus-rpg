'use client'

import {
  Sword, Shield, Package,
  Target, Flame, Droplets, FlaskConical, ScrollText,
  Sparkles, Briefcase, Archive, Hammer, Crosshair,
  AlertTriangle, Zap, Layers, Moon, Skull, Swords, BookOpen,
} from 'lucide-react'
import type { CodexEntry } from '@/types/codex'
import { translateSubtype, translateDamageType } from '@/lib/codex'

interface Props {
  entry: CodexEntry
  onClick: () => void
}

function getPrimaryStat(entry: CodexEntry): string {
  const d = entry.data
  if (entry.type === 'weapon') {
    const dmg = d.damage as string
    if (!dmg || dmg === '0') return (d.cost as string) || ''
    return `${dmg} ${translateDamageType(d.damage_type as string)}`
  }
  if (entry.type === 'armor') {
    if (entry.subtype === 'shield') return `+${d.ac_bonus} CA`
    const maxDex = d.max_dex_bonus
    const dex = maxDex === null ? ' + Des'
              : maxDex === 0   ? ''
              : ` + Des (máx +${maxDex})`
    return `CA ${d.ac_base}${dex}`
  }
  return (d.cost as string) || ''
}

function getIcon(type: string, subtype: string | null) {
  if (type === 'weapon') {
    return subtype === 'simple ranged' || subtype === 'martial ranged'
      ? <Crosshair size={13} />
      : <Sword size={13} />
  }
  if (type === 'armor') return <Shield size={13} />
  if (type === 'rule') {
    switch (subtype) {
      case 'condition':     return <AlertTriangle size={13} />
      case 'action':        return <Zap size={13} />
      case 'cover':         return <Layers size={13} />
      case 'concentration': return <Sparkles size={13} />
      case 'rest':          return <Moon size={13} />
      case 'death':         return <Skull size={13} />
      case 'combat':        return <Swords size={13} />
      case 'reaction':      return <Zap size={13} />
      default:              return <BookOpen size={13} />
    }
  }
  switch (subtype) {
    case 'ammunition':   return <Target size={13} />
    case 'light source': return <Flame size={13} />
    case 'consumable':   return <Droplets size={13} />
    case 'potion':       return <FlaskConical size={13} />
    case 'scroll':       return <ScrollText size={13} />
    case 'focus':        return <Sparkles size={13} />
    case 'kit':          return <Briefcase size={13} />
    case 'container':    return <Archive size={13} />
    case 'gear':         return <Hammer size={13} />
    default:             return <Package size={13} />
  }
}

const TYPE_COLOR = {
  weapon: { iconBg: 'rgba(123,30,30,0.25)', iconColor: '#c05050', iconBorder: 'rgba(123,30,30,0.4)' },
  armor:  { iconBg: 'var(--color-gold-glow)', iconColor: 'var(--color-gold)', iconBorder: 'rgba(201,168,76,0.4)' },
  item:   { iconBg: 'rgba(106,88,48,0.2)', iconColor: 'var(--color-text-secondary)', iconBorder: 'rgba(106,88,48,0.3)' },
  rule:   { iconBg: 'rgba(40,60,100,0.25)', iconColor: '#6ea8d8', iconBorder: 'rgba(40,60,100,0.4)' },
}

export default function CodexCard({ entry, onClick }: Props) {
  const stat      = getPrimaryStat(entry)
  const color     = TYPE_COLOR[entry.type as keyof typeof TYPE_COLOR] ?? TYPE_COLOR.item
  const subtypePt = translateSubtype(entry.subtype)
  const icon      = getIcon(entry.type, entry.subtype)

  return (
    <button
      onClick={onClick}
      className="group w-full rounded text-left transition-opacity hover:opacity-80"
      style={{ border: '1px solid var(--color-border-default)', background: 'var(--color-bg-secondary)' }}
    >
      <div className="flex items-start gap-3 p-3">
        <div
          className="mt-0.5 flex h-8 w-8 shrink-0 items-center justify-center rounded"
          style={{ background: color.iconBg, color: color.iconColor, border: `1px solid ${color.iconBorder}` }}
        >
          {icon}
        </div>

        <div className="min-w-0 flex-1">
          <div className="flex items-start justify-between gap-2">
            <p className="text-lg leading-tight" style={{ color: 'var(--color-text-primary)' }}>
              {entry.name}
            </p>
            {subtypePt && (
              <span className="shrink-0 rounded px-1.5 py-0.5 text-sm"
                style={{ background: 'var(--color-bg-tertiary)', color: 'var(--color-text-muted)' }}>
                {subtypePt}
              </span>
            )}
          </div>

          {stat && (
            <p className="mt-0.5 text-base" style={{ color: 'var(--color-gold)' }}>
              {stat}
            </p>
          )}

          {entry.description && (
            <p className="mt-1 line-clamp-2 text-sm leading-relaxed" style={{ color: 'var(--color-text-muted)' }}>
              {entry.description}
            </p>
          )}
        </div>
      </div>
    </button>
  )
}
