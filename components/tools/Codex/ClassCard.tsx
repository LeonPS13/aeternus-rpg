'use client'

import { Zap, Music, Sun, Leaf, Swords, Layers, Shield, Target, Eye, Flame, Moon, BookOpen } from 'lucide-react'
import type { LucideIcon } from 'lucide-react'
import type { ClassEntry } from '@/types/class'

const CLASS_ICONS: Record<string, LucideIcon> = {
  barbarian: Zap,
  bard:      Music,
  cleric:    Sun,
  druid:     Leaf,
  fighter:   Swords,
  monk:      Layers,
  paladin:   Shield,
  ranger:    Target,
  rogue:     Eye,
  sorcerer:  Flame,
  warlock:   Moon,
  wizard:    BookOpen,
}

export const HIT_DIE_STYLE: Record<number, { bg: string; color: string; border: string }> = {
  6:  { bg: 'rgba(123,162,224,0.12)', color: '#7ba2e0',                   border: 'rgba(123,162,224,0.35)' },
  8:  { bg: 'rgba(201,168,76,0.10)',  color: 'var(--color-gold)',          border: 'rgba(201,168,76,0.3)'  },
  10: { bg: 'rgba(201,168,76,0.18)',  color: 'var(--color-gold-light)',    border: 'rgba(201,168,76,0.45)' },
  12: { bg: 'rgba(180,60,60,0.15)',   color: '#e07070',                   border: 'rgba(180,60,60,0.4)'   },
}

const ABILITY_SHORT: Record<string, string> = {
  strength: 'For', dexterity: 'Des', constitution: 'Con',
  intelligence: 'Int', wisdom: 'Sab', charisma: 'Car',
}

interface Props {
  cls: ClassEntry
  onClick: () => void
}

export default function ClassCard({ cls, onClick }: Props) {
  const Icon = CLASS_ICONS[cls.id] ?? BookOpen
  const die  = HIT_DIE_STYLE[cls.hitDie] ?? HIT_DIE_STYLE[8]

  return (
    <button
      onClick={onClick}
      className="group w-full rounded text-left transition-opacity hover:opacity-80"
      style={{ border: '1px solid var(--color-border-default)', background: 'var(--color-bg-secondary)' }}
    >
      <div className="flex items-start gap-3 p-3">
        {/* Icon */}
        <div
          className="mt-0.5 flex h-8 w-8 shrink-0 items-center justify-center rounded"
          style={{ background: die.bg, color: die.color, border: `1px solid ${die.border}` }}
        >
          <Icon size={16} />
        </div>

        <div className="min-w-0 flex-1">
          <div className="flex items-start justify-between gap-2">
            <p className="text-lg leading-tight" style={{ color: 'var(--color-text-primary)' }}>
              {cls.name}
            </p>
            <span
              className="shrink-0 rounded px-1.5 py-0.5 text-sm font-bold"
              style={{ background: die.bg, color: die.color, border: `1px solid ${die.border}` }}
            >
              d{cls.hitDie}
            </span>
          </div>

          <p className="text-sm leading-none" style={{ color: 'var(--color-text-muted)' }}>
            {cls.nameEn}
          </p>

          {cls.primaryAbility.length > 0 && (
            <p className="mt-1 text-sm leading-none" style={{ color: 'var(--color-gold)' }}>
              {cls.primaryAbility.map(a => ABILITY_SHORT[a] ?? a).join(' · ')}
              {cls.spellcastingAbility && (
                <span style={{ color: 'var(--color-text-muted)' }}> · conjura</span>
              )}
            </p>
          )}
        </div>
      </div>
    </button>
  )
}
