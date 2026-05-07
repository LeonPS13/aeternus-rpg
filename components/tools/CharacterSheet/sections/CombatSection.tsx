'use client'

import { useState, useEffect, useRef } from 'react'
import { Plus, Trash2, CheckCircle2, Circle, BookOpen } from 'lucide-react'
import type { Character, CharacterAttack, InventoryItem, AttackStat } from '@/types/character'
import {
  calcAC, calcInitiative, calcPassivePerception, calcAttackBonus, fmtMod, HIT_DICE_BY_CLASS,
  mod, STAT_TO_ATTR,
} from '@/lib/character-calc'
import ArmorSelector from '@/components/tools/CharacterSheet/ArmorSelector'
import WeaponPickerModal from '@/components/tools/CharacterSheet/WeaponPickerModal'

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

function NumInput({ value, min = 0, onChange: onCh }: { value: number; min?: number; onChange: (n: number) => void }) {
  const [text, setText] = useState(String(value))
  const focused = useRef(false)

  useEffect(() => {
    if (!focused.current) setText(String(value))
  }, [value])

  return (
    <input
      type="number"
      value={text}
      className="w-full text-center text-base [appearance:textfield] [&::-webkit-inner-spin-button]:appearance-none [&::-webkit-outer-spin-button]:appearance-none"
      style={inputStyle}
      onFocus={() => { focused.current = true }}
      onBlur={() => {
        focused.current = false
        const n = text === '' || isNaN(Number(text)) ? min : Math.max(min, Number(text))
        onCh(n)
        setText(String(n))
      }}
      onChange={(e) => setText(e.target.value)}
    />
  )
}

function StatBox({ label, value }: { label: string; value: string | number }) {
  return (
    <div className="flex flex-col items-center gap-1 rounded py-3 px-2"
      style={{ background: 'var(--color-bg-tertiary)', border: '1px solid var(--color-border-default)' }}>
      <span className="text-2xl leading-none" style={{ color: 'var(--color-gold-light)' }}>{value}</span>
      <span className="text-xs text-center" style={{ color: 'var(--color-text-muted)' }}>{label}</span>
    </div>
  )
}

function DeathDots({ count, max = 3, colorActive, onChange: onCh }:
  { count: number; max?: number; colorActive: string; onChange: (n: number) => void }) {
  return (
    <div className="flex gap-1">
      {Array.from({ length: max }, (_, i) => {
        const filled = i < count
        return (
          <button key={i} onClick={() => onCh(filled ? i : i + 1)}>
            {filled
              ? <CheckCircle2 size={18} style={{ color: colorActive }} />
              : <Circle size={18} style={{ color: 'var(--color-text-muted)' }} />}
          </button>
        )
      })}
    </div>
  )
}

function updateAttack(attacks: CharacterAttack[], id: string, updates: Partial<CharacterAttack>): CharacterAttack[] {
  return attacks.map((a) => a.id === id ? { ...a, ...updates } : a)
}

const STAT_OPTIONS: { val: AttackStat | ''; label: string }[] = [
  { val: '', label: '—' },
  { val: 'str', label: 'FOR' },
  { val: 'dex', label: 'DES' },
  { val: 'con', label: 'CON' },
  { val: 'int', label: 'INT' },
  { val: 'wis', label: 'SAB' },
  { val: 'cha', label: 'CAR' },
]

function StatDropdown({ value, onChange: onCh }: { value: AttackStat | ''; onChange: (v: AttackStat | '') => void }) {
  const [open, setOpen] = useState(false)
  const current = STAT_OPTIONS.find(o => o.val === value) ?? STAT_OPTIONS[0]
  return (
    <div className="relative">
      <button
        type="button"
        onClick={() => setOpen(!open)}
        className="flex items-center gap-0.5 rounded py-1 pl-1 pr-1 text-xs"
        style={{ ...inputStyle, color: value ? 'var(--color-gold-dark)' : 'var(--color-text-muted)' }}
      >
        <span>{current.label}</span>
        <span style={{ fontSize: '0.5rem', lineHeight: 1, marginTop: '1px' }}>▾</span>
      </button>
      {open && (
        <>
          <div className="fixed inset-0 z-10" onClick={() => setOpen(false)} />
          <div className="absolute left-0 top-full z-20 overflow-hidden rounded"
            style={{ background: 'var(--color-bg-secondary)', border: '1px solid var(--color-border-default)', minWidth: '3.5rem' }}>
            {STAT_OPTIONS.map(({ val, label }) => (
              <button
                key={val}
                type="button"
                onClick={() => { onCh(val); setOpen(false) }}
                className="block w-full px-2 py-0.5 text-left text-xs"
                style={{ color: value === val ? 'var(--color-gold-light)' : 'var(--color-text-muted)' }}
              >
                {label}
              </button>
            ))}
          </div>
        </>
      )}
    </div>
  )
}

function baseWeaponName(name: string): string {
  return name.replace(/ \(1 mão\)$/, '').replace(/ \(2 mãos\)$/, '')
}

export default function CombatSection({ char, onChange }: Props) {
  const hitDice = HIT_DICE_BY_CLASS[char.characterClass] ?? 'd8'
  const [showWeaponPicker, setShowWeaponPicker] = useState(false)

  function addAttack() {
    onChange({
      attacks: [
        ...char.attacks,
        { id: crypto.randomUUID(), name: '', attackBonus: '', damage: '', damageType: '' },
      ],
    })
  }

  function removeAttack(id: string) {
    const atk = char.attacks.find(a => a.id === id)
    const remaining = char.attacks.filter(a => a.id !== id)
    const updates: Partial<Character> = { attacks: remaining }
    if (atk) {
      const base = baseWeaponName(atk.name)
      const stillLinked = remaining.some(a => baseWeaponName(a.name) === base)
      if (!stillLinked) {
        updates.inventory = char.inventory.filter(i => i.name !== base && i.name !== atk.name)
      }
    }
    onChange(updates)
  }

  return (
    <div className="space-y-6">
      {/* Combat stat boxes */}
      <div className="arcane-panel p-4">
        <p className="section-label mb-4">· Stats de Combate ·</p>
        <div className="grid grid-cols-2 gap-3 sm:grid-cols-4">
          <StatBox label="Classe de Armadura" value={calcAC(char)} />
          <StatBox label="Iniciativa" value={fmtMod(calcInitiative(char))} />
          <StatBox label="Deslocamento (ft)" value={char.speed} />
          <StatBox label="Percepção Passiva" value={calcPassivePerception(char)} />
        </div>

        {/* AC config — Armor Selector */}
        <div className="mt-4">
          <ArmorSelector
            char={char}
            onChange={onChange}
            onItemAdd={(item: InventoryItem) => {
              if (!char.inventory.some(i => i.name === item.name)) {
                onChange({ inventory: [...char.inventory, item] })
              }
            }}
            onItemRemove={(name) => {
              onChange({ inventory: char.inventory.filter(i => i.name !== name) })
            }}
          />
          <div className="mt-3 w-36">
            <label className="mb-1 block text-xs" style={{ color: 'var(--color-text-muted)' }}>Bônus Extra CA</label>
            <NumInput value={char.acExtraBonus} onChange={(n) => onChange({ acExtraBonus: n })} />
          </div>
        </div>

        {/* Speed / Initiative bonus */}
        <div className="mt-3 grid gap-3 sm:grid-cols-3">
          <div>
            <label className="mb-1 block text-xs" style={{ color: 'var(--color-text-muted)' }}>Deslocamento (ft)</label>
            <NumInput value={char.speed} onChange={(n) => onChange({ speed: n })} />
          </div>
          <div>
            <label className="mb-1 block text-xs" style={{ color: 'var(--color-text-muted)' }}>Bônus Extra Iniciativa</label>
            <NumInput value={char.initiativeBonus} onChange={(n) => onChange({ initiativeBonus: n })} min={-20} />
          </div>
          <div className="flex flex-col justify-end">
            <label className="mb-1 block text-xs" style={{ color: 'var(--color-text-muted)' }}>Inspiração</label>
            <button
              onClick={() => onChange({ inspiration: !char.inspiration })}
              className="flex items-center gap-2 rounded px-3 py-1.5 transition-all"
              style={char.inspiration ? {
                background: 'var(--color-gold-glow)',
                border: '1px solid var(--color-border-default)',
                color: 'var(--color-gold-light)',
              } : {
                border: '1px solid var(--color-border-default)',
                color: 'var(--color-text-muted)',
              }}>
              {char.inspiration
                ? <CheckCircle2 size={14} style={{ color: 'var(--color-gold)' }} />
                : <Circle size={14} />}
              <span className="text-sm">{char.inspiration ? 'Ativo' : 'Inativo'}</span>
            </button>
          </div>
        </div>
      </div>

      {/* HP */}
      <div className="arcane-panel p-4">
        <p className="section-label mb-4">· Pontos de Vida ·</p>
        <div className="grid grid-cols-3 gap-3">
          {([
            ['maxHp',     'PV Máximos'],
            ['currentHp', 'PV Atuais'],
            ['tempHp',    'PV Temporários'],
          ] as const).map(([key, label]) => (
            <div key={key}>
              <label className="mb-1 block text-xs" style={{ color: 'var(--color-text-muted)' }}>{label}</label>
              <NumInput value={char[key]} onChange={(n) => onChange({ [key]: n })} />
            </div>
          ))}
        </div>

        {/* Hit Dice */}
        <div className="mt-4 flex flex-wrap items-end gap-4">
          <div>
            <span className="mb-1 block text-xs" style={{ color: 'var(--color-text-muted)' }}>Tipo de Dado de Vida</span>
            <span className="text-2xl" style={{ color: 'var(--color-gold-light)' }}>
              {hitDice}
            </span>
            <span className="ml-2 text-xs" style={{ color: 'var(--color-text-muted)' }}>
              × {char.level} total
            </span>
          </div>
          <div className="w-24">
            <label className="mb-1 block text-xs" style={{ color: 'var(--color-text-muted)' }}>Dados Gastos</label>
            <NumInput value={char.hitDiceSpent} onChange={(n) => onChange({ hitDiceSpent: Math.min(char.level, n) })} />
          </div>
        </div>

        {/* Death saves */}
        <div className="mt-4">
          <p className="mb-2 text-xs font-medium" style={{ color: 'var(--color-text-muted)' }}>Testes contra a Morte</p>
          <div className="flex flex-wrap gap-6">
            <div>
              <p className="mb-1 text-xs" style={{ color: 'var(--color-text-muted)' }}>Sucessos</p>
              <DeathDots
                count={char.deathSavesSuccess}
                colorActive="var(--color-gold)"
                onChange={(n) => onChange({ deathSavesSuccess: n })}
              />
            </div>
            <div>
              <p className="mb-1 text-xs" style={{ color: 'var(--color-text-muted)' }}>Falhas</p>
              <DeathDots
                count={char.deathSavesFailure}
                colorActive="#f87171"
                onChange={(n) => onChange({ deathSavesFailure: n })}
              />
            </div>
          </div>
        </div>
      </div>

      {/* Attacks */}
      {showWeaponPicker && (
        <WeaponPickerModal
          char={char}
          onConfirm={(attacks, item) => {
            onChange({
              attacks:   [...char.attacks, ...attacks],
              inventory: char.inventory.some(i => i.name === item.name)
                ? char.inventory
                : [...char.inventory, item],
            })
            setShowWeaponPicker(false)
          }}
          onClose={() => setShowWeaponPicker(false)}
        />
      )}

      <div className="arcane-panel p-4">
        <div className="mb-4 flex items-center justify-between">
          <p className="section-label">· Ataques e Magias ·</p>
          <div className="flex gap-2">
            <button
              onClick={() => setShowWeaponPicker(true)}
              className="flex items-center gap-1 rounded px-2 py-1 text-xs transition-colors"
              style={{ border: '1px solid var(--color-border-default)', color: 'var(--color-gold-dark)' }}>
              <BookOpen size={11} /> Codex
            </button>
            <button
              onClick={addAttack}
              className="flex items-center gap-1 rounded px-2 py-1 text-xs transition-colors"
              style={{ border: '1px solid var(--color-border-default)', color: 'var(--color-text-muted)' }}>
              <Plus size={12} /> Personalizado
            </button>
          </div>
        </div>

        {char.attacks.length === 0 ? (
          <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Nenhum ataque cadastrado.</p>
        ) : (
          <div className="space-y-2">
            {/* Header */}
            <div className="hidden sm:flex sm:items-center sm:gap-2">
              <span className="text-xs" style={{ flex: '1 1 0%', minWidth: 0, color: 'var(--color-text-muted)' }}>Nome</span>
              <span className="text-xs" style={{ flexShrink: 0, color: 'var(--color-text-muted)' }}>Attr</span>
              <span className="text-xs" style={{ flex: '1 1 0%', minWidth: 0, color: 'var(--color-text-muted)' }}>Bônus</span>
              <span className="text-xs" style={{ flex: '1 1 0%', minWidth: 0, color: 'var(--color-text-muted)' }}>Dano</span>
              <span className="text-xs" style={{ flex: '1 1 0%', minWidth: 0, color: 'var(--color-text-muted)' }}>Tipo</span>
              <span style={{ width: '2rem', flexShrink: 0 }} />
            </div>

            {char.attacks.map((atk) => {
              const auto = atk.stat ? calcAttackBonus(char, atk.stat) : null
              const autoDmg = (atk.stat && atk.damageDice)
                ? (() => {
                    const m = mod(char[STAT_TO_ATTR[atk.stat]] as number) + (atk.magicBonus ?? 0)
                    return m > 0 ? `${atk.damageDice} + ${m}` : m < 0 ? `${atk.damageDice} - ${Math.abs(m)}` : atk.damageDice
                  })()
                : null
              return (
                <div key={atk.id} className="attack-row" style={{ background: 'var(--color-bg-tertiary)' }}>
                  <div className="attack-col">
                    <input
                      value={atk.name}
                      onChange={(e) => onChange({ attacks: updateAttack(char.attacks, atk.id, { name: e.target.value }) })}
                      placeholder="Nome da arma/magia"
                      className="px-2 py-1 text-sm"
                      style={inputStyle}
                    />
                  </div>
                  <StatDropdown
                    value={atk.stat ?? ''}
                    onChange={(val) => onChange({ attacks: updateAttack(char.attacks, atk.id, { stat: (val as AttackStat) || undefined }) })}
                  />
                  <div className="attack-col">
                    <input
                      value={auto ?? atk.attackBonus}
                      readOnly={!!auto}
                      onChange={(e) => !auto && onChange({ attacks: updateAttack(char.attacks, atk.id, { attackBonus: e.target.value }) })}
                      placeholder="+5"
                      className="px-2 py-1 text-sm"
                      style={{ ...inputStyle, color: auto ? 'var(--color-gold)' : inputStyle.color, cursor: auto ? 'default' : 'text' }}
                    />
                  </div>
                  <div className="attack-col">
                    <input
                      value={autoDmg ?? atk.damage}
                      readOnly={!!autoDmg}
                      onChange={(e) => !autoDmg && onChange({ attacks: updateAttack(char.attacks, atk.id, { damage: e.target.value }) })}
                      placeholder="1d8+3"
                      className="px-2 py-1 text-sm"
                      style={{ ...inputStyle, color: autoDmg ? 'var(--color-gold)' : inputStyle.color, cursor: autoDmg ? 'default' : 'text' }}
                    />
                  </div>
                  <div className="attack-col">
                    <input
                      value={atk.damageType}
                      onChange={(e) => onChange({ attacks: updateAttack(char.attacks, atk.id, { damageType: e.target.value }) })}
                      placeholder="Cortante"
                      className="px-2 py-1 text-sm"
                      style={inputStyle}
                    />
                  </div>
                  <button onClick={() => removeAttack(atk.id)}
                    className="flex items-center justify-center rounded transition-colors"
                    style={{ width: '2rem', flexShrink: 0, color: 'var(--color-text-muted)' }}>
                    <Trash2 size={13} />
                  </button>
                </div>
              )
            })}
          </div>
        )}
      </div>
    </div>
  )
}
