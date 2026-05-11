'use client'

import type { SpellEntry } from '@/types/spell'
import { translateSchool, translateSpellClass, spellLevelShort, SCHOOL_COLORS } from '@/lib/spells'

function RpgIcon({ file, size = 22 }: { file: string; size?: number }) {
  return (
    <img
      src={`/icons_2/${file}`}
      width={size}
      height={size}
      alt=""
      style={{ objectFit: 'contain', filter: 'invert(1)' }}
    />
  )
}

function spellIcon(school: string) {
  switch (school) {
    case 'evocation':     return <RpgIcon file="meteoro.png" />
    case 'conjuration':   return <RpgIcon file="bola-de-cristal.png" />
    case 'necromancy':    return <RpgIcon file="curar.png" />
    case 'illusion':      return <RpgIcon file="espantalho.png" />
    case 'enchantment':   return <RpgIcon file="varinha-magica.png" />
    case 'divination':    return <RpgIcon file="perola.png" />
    case 'abjuration':    return <RpgIcon file="escudo.png" />
    case 'transmutation': return <RpgIcon file="diamante.png" />
    default:              return <RpgIcon file="livro-magico.png" />
  }
}

interface Props {
  spell: SpellEntry
  onClick: () => void
}

export default function SpellCard({ spell, onClick }: Props) {
  const color     = SCHOOL_COLORS[spell.school] ?? SCHOOL_COLORS.evocation
  const schoolPt  = translateSchool(spell.school)
  const levelStr  = spellLevelShort(spell.level)

  return (
    <button
      onClick={onClick}
      className="group w-full rounded text-left transition-opacity hover:opacity-80"
      style={{ border: '1px solid var(--color-border-default)', background: 'var(--color-bg-secondary)' }}
    >
      <div className="flex items-start gap-3 p-3">
        {/* School icon */}
        <div
          className="mt-0.5 flex h-8 w-8 shrink-0 items-center justify-center rounded"
          style={{ background: color.bg, color: color.color, border: `1px solid ${color.border}` }}
        >
          {spellIcon(spell.school)}
        </div>

        <div className="min-w-0 flex-1">
          <div className="flex items-start justify-between gap-2">
            <p className="text-lg leading-tight" style={{ color: 'var(--color-text-primary)' }}>
              {spell.name}
            </p>
            {/* Level + school badge */}
            <span className="shrink-0 rounded px-1.5 py-0.5 text-sm"
              style={{ background: 'var(--color-bg-tertiary)', color: 'var(--color-text-muted)', border: '1px solid var(--color-border-default)' }}>
              {levelStr}
            </span>
          </div>

          <p className="text-sm leading-none" style={{ color: color.color }}>
            {schoolPt}
            {spell.concentration && <span style={{ color: 'var(--color-text-muted)' }}> · C</span>}
            {spell.ritual && <span style={{ color: 'var(--color-text-muted)' }}> · Ritual</span>}
          </p>

          <p className="text-sm leading-snug" style={{ color: 'var(--color-text-muted)' }}>
            {spell.castingTime} · {spell.range}
            {spell.classes.length > 0 && (
              <> · {spell.classes.slice(0, 3).map(translateSpellClass).join(', ')}{spell.classes.length > 3 ? '…' : ''}</>
            )}
          </p>
        </div>
      </div>
    </button>
  )
}
