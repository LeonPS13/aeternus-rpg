'use client'

import { useState, useEffect, useRef } from 'react'
import { CheckCircle2, Circle } from 'lucide-react'
import type { Character, SkillName } from '@/types/character'
import { SKILL_NAMES } from '@/types/character'
import {
  ATTR_DEFS, SAVE_DEFS, SKILL_LABELS, SKILL_ATTR_ABBR,
  mod, profBonus, fmtMod, calcSkillValue, calcSaveValue,
} from '@/lib/character-calc'

interface Props {
  char: Character
  onChange: (u: Partial<Character>) => void
}

const inputStyle = {
  background: 'var(--color-bg-tertiary)',
  border: '1px solid var(--color-border-default)',
  color: 'var(--color-text-primary)',
  borderRadius: '4px',
  outline: 'none',
  caretColor: 'var(--color-gold)',
}

function NumInput({ value, min = 0, max, onChange: onCh, className = '', style }: {
  value: number; min?: number; max?: number; onChange: (n: number) => void
  className?: string; style?: React.CSSProperties
}) {
  const [text, setText] = useState(String(value))
  const focused = useRef(false)

  useEffect(() => {
    if (!focused.current) setText(String(value))
  }, [value])

  return (
    <input
      type="number"
      value={text}
      className={`[appearance:textfield] [&::-webkit-inner-spin-button]:appearance-none [&::-webkit-outer-spin-button]:appearance-none ${className}`}
      style={style}
      onFocus={() => { focused.current = true }}
      onBlur={() => {
        focused.current = false
        let n = text === '' || isNaN(Number(text)) ? min : Math.max(min, Number(text))
        if (max !== undefined) n = Math.min(max, n)
        onCh(n)
        setText(String(n))
      }}
      onChange={(e) => setText(e.target.value)}
    />
  )
}

function ProfCircle({ active, onClick }: { active: boolean; onClick: () => void }) {
  return (
    <button onClick={onClick} className="shrink-0 transition-opacity hover:opacity-80">
      {active
        ? <CheckCircle2 size={14} style={{ color: 'var(--color-gold)' }} />
        : <Circle size={14} style={{ color: 'var(--color-text-muted)' }} />}
    </button>
  )
}

function ExpertCircle({ active, onClick }: { active: boolean; onClick: () => void }) {
  return (
    <button onClick={onClick} className="shrink-0 transition-opacity hover:opacity-80">
      {active
        ? <CheckCircle2 size={14} style={{ color: 'var(--color-gold-light)' }} />
        : <Circle size={14} style={{ color: 'var(--color-text-muted)', opacity: 0.4 }} />}
    </button>
  )
}

export default function StatsSection({ char, onChange }: Props) {
  const pb = profBonus(char.level)

  function updateSkill(name: SkillName, field: 'proficient' | 'expert', value: boolean) {
    const current = char.skills[name]
    const updated = { ...current, [field]: value }
    if (field === 'expert' && value) updated.proficient = true
    if (field === 'proficient' && !value) updated.expert = false
    onChange({ skills: { ...char.skills, [name]: updated } })
  }

  return (
    <div className="space-y-6">
      {/* Attribute boxes */}
      <div className="arcane-panel p-4">
        <p className="section-label mb-4">· Atributos Base ·</p>
        <div className="grid grid-cols-3 gap-3 md:grid-cols-6">
          {ATTR_DEFS.map(({ key, abbr }) => {
            const score = char[key] as number
            const modVal = mod(score)
            return (
              <div key={key}
                className="flex flex-col items-center gap-1 rounded py-3 px-2"
                style={{ background: 'var(--color-bg-tertiary)', border: '1px solid var(--color-border-default)' }}>
                <span className="text-xs font-bold tracking-wider" style={{ color: 'var(--color-text-muted)' }}>{abbr}</span>
                <span className="text-3xl leading-none" style={{ color: 'var(--color-gold-light)' }}>{fmtMod(modVal)}</span>
                <NumInput
                  value={score}
                  min={1} max={30}
                  onChange={(n) => onChange({ [key]: n })}
                  className="w-12 text-center text-base"
                  style={inputStyle}
                />
              </div>
            )
          })}
        </div>
      </div>

      {/* Saving Throws */}
      <div className="arcane-panel p-4">
        <p className="section-label mb-4">· Testes de Resistência <span className="font-sans text-xs" style={{ color: 'var(--color-text-muted)' }}>(PB +{pb})</span> ·</p>
        <div className="grid grid-cols-1 gap-1 sm:grid-cols-2">
          {SAVE_DEFS.map(({ profKey, scoreKey, label }) => {
            const isProficient = char[profKey] as boolean
            const value = calcSaveValue(char, scoreKey, profKey)
            return (
              <div key={profKey} className="flex items-center gap-2 rounded px-2 py-1.5"
                style={{ background: isProficient ? 'var(--color-gold-glow)' : undefined }}>
                <ProfCircle
                  active={isProficient}
                  onClick={() => onChange({ [profKey]: !isProficient })}
                />
                <span className="flex-1 text-sm" style={{ color: 'var(--color-text-secondary)' }}>{label}</span>
                <span className="w-8 text-right text-sm font-medium"
                  style={{ color: 'var(--color-gold-light)' }}>{fmtMod(value)}</span>
              </div>
            )
          })}
        </div>
      </div>

      {/* Skills */}
      <div className="arcane-panel p-4">
        <div className="mb-2 flex items-baseline gap-3">
          <p className="section-label">· Perícias ·</p>
          <span className="text-xs" style={{ color: 'var(--color-text-muted)' }}>
            <CheckCircle2 size={10} className="inline mr-0.5" style={{ color: 'var(--color-gold)' }} /> Proficiência
            &nbsp;·&nbsp;
            <CheckCircle2 size={10} className="inline mr-0.5" style={{ color: 'var(--color-gold-light)' }} /> Especialização
          </span>
        </div>
        <div className="mt-3 grid grid-cols-1 gap-0.5 sm:grid-cols-2">
          {SKILL_NAMES.map((skill) => {
            const s = char.skills[skill]
            const value = calcSkillValue(char, skill)
            return (
              <div key={skill}
                className="flex items-center gap-1.5 rounded px-2 py-1"
                style={{ background: s.proficient ? 'var(--color-gold-glow)' : undefined }}>
                <ProfCircle
                  active={s.proficient}
                  onClick={() => updateSkill(skill, 'proficient', !s.proficient)}
                />
                <ExpertCircle
                  active={s.expert}
                  onClick={() => updateSkill(skill, 'expert', !s.expert)}
                />
                <span className="flex-1 text-sm" style={{ color: 'var(--color-text-secondary)' }}>
                  {SKILL_LABELS[skill]}
                  <span className="ml-1 text-xs" style={{ color: 'var(--color-text-muted)' }}>
                    ({SKILL_ATTR_ABBR[skill]})
                  </span>
                </span>
                <span className="w-8 text-right text-sm font-medium"
                  style={{ color: 'var(--color-gold-light)' }}>{fmtMod(value)}</span>
              </div>
            )
          })}
        </div>
      </div>
    </div>
  )
}
