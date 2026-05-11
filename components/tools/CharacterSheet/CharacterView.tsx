'use client'

import { useState, useEffect, useRef } from 'react'
import { ArrowLeft, Edit2, Trash2, Plus, BookOpen, Star } from 'lucide-react'
import type { Character, CharacterAttack, InventoryItem, AttackStat } from '@/types/character'
import { SKILL_NAMES } from '@/types/character'
import {
  ATTR_DEFS, SAVE_DEFS, SKILL_LABELS, SKILL_ATTR_ABBR,
  mod, profBonus, fmtMod, calcAC, calcInitiative, calcPassivePerception,
  calcSkillValue, calcSaveValue, calcAttackBonus, HIT_DICE_BY_CLASS, STAT_TO_ATTR,
} from '@/lib/character-calc'
import ArmorSelector from '@/components/tools/CharacterSheet/ArmorSelector'
import WeaponPickerModal from '@/components/tools/CharacterSheet/WeaponPickerModal'
import ItemPickerModal from '@/components/tools/CharacterSheet/ItemPickerModal'
import SpellsSection from '@/components/tools/CharacterSheet/sections/SpellsSection'

interface Props {
  char: Character
  onChange: (u: Partial<Character>) => void
  onBack: () => void
  onEdit: () => void
  onDelete: () => void
}

const CURRENCIES = [
  { key: 'cp' as const, label: 'PC', color: '#b45309' },
  { key: 'sp' as const, label: 'PP', color: '#9ca3af' },
  { key: 'gp' as const, label: 'PO', color: 'var(--color-gold)' },
  { key: 'pp' as const, label: 'PL', color: '#e5e7eb' },
]

function StatPill({ label, value }: { label: string; value: string | number }) {
  return (
    <div className="flex flex-col items-center gap-0.5 rounded px-2 py-1.5"
      style={{ background: 'var(--color-bg-secondary)', border: '1px solid var(--color-border-default)' }}>
      <span className="text-2xl leading-none" style={{ color: 'var(--color-gold-light)' }}>{value}</span>
      <span className="text-center text-sm leading-tight" style={{ color: 'var(--color-text-muted)' }}>{label}</span>
    </div>
  )
}

function InspirationPill({ active, onToggle }: { active: boolean; onToggle: () => void }) {
  return (
    <button
      onClick={onToggle}
      className="flex flex-col items-center gap-0.5 rounded px-2 py-1.5 transition-colors"
      style={{
        background: active ? 'var(--color-gold-glow)' : 'var(--color-bg-secondary)',
        border: `1px solid ${active ? 'var(--color-gold)' : 'var(--color-border-default)'}`,
      }}
    >
      <span className="text-2xl leading-none" style={{ color: active ? 'var(--color-gold-light)' : 'var(--color-text-muted)' }}>✦</span>
      <span className="text-center text-sm leading-tight" style={{ color: active ? 'var(--color-gold-dark)' : 'var(--color-text-muted)' }}>Inspiração</span>
    </button>
  )
}

function AttrBox({ abbr, score }: { abbr: string; score: number }) {
  return (
    <div className="flex flex-col items-center gap-1 rounded py-3 px-2"
      style={{ background: 'var(--color-bg-tertiary)', border: '1px solid var(--color-border-default)' }}>
      <span className="text-sm font-bold tracking-wider" style={{ color: 'var(--color-text-secondary)' }}>
        {abbr.toLowerCase()}
      </span>
      <span className="text-3xl leading-none" style={{ color: 'var(--color-gold-light)' }}>
        {fmtMod(mod(score))}
      </span>
      <span className="text-base leading-none" style={{ color: 'var(--color-text-secondary)' }}>
        {score}
      </span>
    </div>
  )
}

function StepBtn({ onClick, children }: { onClick: () => void; children: React.ReactNode }) {
  return (
    <button
      onClick={onClick}
      className="flex h-6 w-6 shrink-0 items-center justify-center rounded text-sm leading-none"
      style={{ border: '1px solid var(--color-border-default)', color: 'var(--color-text-muted)' }}>
      {children}
    </button>
  )
}

function NumInput({ value, min = 0, onChange, className = '', style }: {
  value: number; min?: number; onChange: (v: number) => void
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
        const n = text === '' || isNaN(Number(text)) ? min : Math.max(min, Number(text))
        onChange(n)
        setText(String(n))
      }}
      onChange={(e) => setText(e.target.value)}
    />
  )
}

function TraitBlock({ label, text }: { label: string; text: string }) {
  return (
    <div>
      <p className="mb-1 text-xs font-medium" style={{ color: 'var(--color-text-muted)' }}>{label}</p>
      <p className="whitespace-pre-wrap text-sm leading-relaxed" style={{ color: 'var(--color-text-secondary)' }}>{text}</p>
    </div>
  )
}

function updateItem(items: InventoryItem[], id: string, updates: Partial<InventoryItem>): InventoryItem[] {
  return items.map((item) => item.id === id ? { ...item, ...updates } : item)
}

function updateAttack(attacks: CharacterAttack[], id: string, updates: Partial<CharacterAttack>): CharacterAttack[] {
  return attacks.map((a) => a.id === id ? { ...a, ...updates } : a)
}

export default function CharacterView({ char, onChange, onBack, onEdit, onDelete }: Props) {
  const [confirmDelete, setConfirmDelete]       = useState(false)
  const [showWeaponPicker, setShowWeaponPicker] = useState(false)
  const [showItemPicker, setShowItemPicker]     = useState(false)
  const [activeTab, setActiveTab]               = useState<'essencial' | 'bio' | 'magias'>('essencial')
  const pb = profBonus(char.level)
  const hitDice = HIT_DICE_BY_CLASS[char.characterClass] ?? 'd8'

  function pushItem(item: InventoryItem) {
    if (!char.inventory.some(i => i.name === item.name)) {
      onChange({ inventory: [...char.inventory, item] })
    }
  }

  function addItem() {
    onChange({
      inventory: [
        ...char.inventory,
        { id: crypto.randomUUID(), name: '', quantity: 1, weight: 0, description: '' },
      ],
    })
  }

  function removeItem(id: string) {
    onChange({ inventory: char.inventory.filter((i) => i.id !== id) })
  }

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
      const base = atk.name.replace(/ \(1 mão\)$/, '').replace(/ \(2 mãos\)$/, '')
      const stillLinked = remaining.some(a =>
        a.name.replace(/ \(1 mão\)$/, '').replace(/ \(2 mãos\)$/, '') === base
      )
      if (!stillLinked) {
        updates.inventory = char.inventory.filter(i => i.name !== base && i.name !== atk.name)
      }
    }
    onChange(updates)
  }

  const inputBase = {
    background: 'transparent',
    border: 'none',
    outline: 'none',
    caretColor: 'var(--color-gold)',
  }

  return (
    <div className="mx-auto w-full max-w-4xl px-4 py-6 sm:px-6 sm:py-8">
      {/* Top bar */}
      <div className="mb-5 flex items-center justify-between gap-3">
        <button
          onClick={onBack}
          className="flex items-center gap-1.5 text-xs"
          style={{ color: 'var(--color-text-muted)' }}>
          <ArrowLeft size={13} /> Fichas
        </button>
        <div className="flex items-center gap-2">
          <button
            onClick={onEdit}
            className="flex items-center gap-1.5 rounded px-3 py-1.5 text-sm transition-all"
            style={{ border: '1px solid var(--color-border-default)', color: 'var(--color-text-secondary)' }}>
            <Edit2 size={13} /> Editar
          </button>
          {confirmDelete ? (
            <>
              <span className="text-xs" style={{ color: 'var(--color-text-muted)' }}>Excluir?</span>
              <button onClick={onDelete} className="rounded px-2 py-1 text-xs"
                style={{ background: 'rgba(248,113,113,0.1)', color: '#f87171', border: '1px solid rgba(248,113,113,0.3)' }}>
                Confirmar
              </button>
              <button onClick={() => setConfirmDelete(false)} className="text-xs"
                style={{ color: 'var(--color-text-muted)' }}>✕</button>
            </>
          ) : (
            <button onClick={() => setConfirmDelete(true)} className="rounded p-1.5"
              style={{ color: 'var(--color-text-muted)' }}>
              <Trash2 size={14} />
            </button>
          )}
        </div>
      </div>

      {/* Character hero */}
      <div className="mb-6 text-center">
        <h1 className="text-5xl" style={{ color: 'var(--color-text-primary)', textShadow: '0 0 24px rgba(201,168,76,0.3)' }}>
          {char.characterName || 'Sem nome'}
        </h1>
        <p className="mt-1 text-lg" style={{ color: 'var(--color-text-muted)' }}>
          {[char.race, char.characterClass, char.level > 0 && `Nível ${char.level}`, char.background, char.alignment]
            .filter(Boolean).join(' · ')}
        </p>
        {char.playerName && (
          <p className="mt-0.5 text-sm" style={{ color: 'var(--color-text-muted)' }}>
            Jogador: {char.playerName}
          </p>
        )}
        {char.xp > 0 && (
          <p className="mt-0.5 text-xs" style={{ color: 'var(--color-text-muted)' }}>
            {char.xp.toLocaleString('pt-BR')} XP
          </p>
        )}
      </div>

      {/* Tab selector */}
      <div className="mb-6 flex gap-1 border-b" style={{ borderColor: 'var(--color-border-default)' }}>
        {(['essencial', 'bio', 'magias'] as const).map(tab => (
          <button
            key={tab}
            onClick={() => setActiveTab(tab)}
            className="px-4 py-2 text-sm transition-colors"
            style={{
              color: activeTab === tab ? 'var(--color-gold-light)' : 'var(--color-text-muted)',
              borderBottom: activeTab === tab ? '2px solid var(--color-gold)' : '2px solid transparent',
              marginBottom: '-1px',
            }}>
            {tab === 'essencial' ? 'Essencial' : tab === 'bio' ? 'Bio' : 'Magias'}
          </button>
        ))}
      </div>

      {activeTab === 'essencial' && <>
      {/* Key stats */}
      <div className="mb-6 grid grid-cols-4 gap-2 sm:grid-cols-7">
        <StatPill label="CA" value={calcAC(char)} />
        <StatPill label="Iniciativa" value={fmtMod(calcInitiative(char))} />
        <StatPill label="Deslocamento" value={`${char.speed} ft`} />
        <StatPill label="PV Máx." value={char.maxHp} />
        <StatPill label="Perc. Passiva" value={calcPassivePerception(char)} />
        <StatPill label="Bônus Prof." value={`+${pb}`} />
        <InspirationPill active={!!char.inspiration} onToggle={() => onChange({ inspiration: !char.inspiration })} />
      </div>

      {/* Two-column body */}
      <div className="grid gap-4 md:grid-cols-[280px_1fr]">
        {/* Left: attributes, saves, skills */}
        <div className="space-y-4">
          <div className="arcane-panel p-4">
            <p className="section-label mb-3">· Atributos ·</p>
            <div className="grid grid-cols-3 gap-2">
              {ATTR_DEFS.map(({ key, abbr }) => (
                <AttrBox key={key} abbr={abbr} score={char[key] as number} />
              ))}
            </div>
          </div>

          <div className="arcane-panel p-4">
            <p className="section-label mb-2">· Resistências ·</p>
            <div className="space-y-0.5">
              {SAVE_DEFS.map(({ profKey, scoreKey, label }) => {
                const isProficient = char[profKey] as boolean
                const value = calcSaveValue(char, scoreKey, profKey)
                return (
                  <div key={profKey} className="flex items-center gap-2 rounded px-2 py-1"
                    style={isProficient ? { background: 'var(--color-gold-glow)' } : {}}>
                    <div className="h-2 w-2 shrink-0 rounded-full"
                      style={{ background: isProficient ? 'var(--color-gold)' : 'var(--color-bg-tertiary)', border: '1px solid var(--color-border-default)' }} />
                    <span className="flex-1 text-sm" style={{ color: 'var(--color-text-secondary)' }}>{label}</span>
                    <span className="text-base font-medium" style={{ color: 'var(--color-gold-light)' }}>{fmtMod(value)}</span>
                  </div>
                )
              })}
            </div>
          </div>

          <div className="arcane-panel p-4">
            <p className="section-label mb-2">· Perícias ·</p>
            <div className="space-y-0.5">
              {SKILL_NAMES.map((skill) => {
                const s = char.skills[skill]
                const value = calcSkillValue(char, skill)
                return (
                  <div key={skill} className="flex items-center gap-2 rounded px-2 py-1"
                    style={s.proficient ? { background: 'var(--color-gold-glow)' } : {}}>
                    <div className="h-2 w-2 shrink-0 rounded-full"
                      style={{
                        background: s.expert ? 'var(--color-gold-light)' : s.proficient ? 'var(--color-gold)' : 'var(--color-bg-tertiary)',
                        border: '1px solid var(--color-border-default)',
                      }} />
                    <span className="flex flex-1 items-center gap-1 text-sm" style={{ color: 'var(--color-text-secondary)' }}>
                      {SKILL_LABELS[skill]}
                      <span className="text-xs" style={{ color: 'var(--color-text-secondary)' }}>
                        ({SKILL_ATTR_ABBR[skill].toLowerCase()})
                      </span>
                      {s.expert && <Star size={10} fill="currentColor" style={{ color: 'var(--color-gold-light)', flexShrink: 0 }} />}
                    </span>
                    <span className="text-base font-medium" style={{ color: 'var(--color-gold-light)' }}>{fmtMod(value)}</span>
                  </div>
                )
              })}
            </div>
          </div>
        </div>

        {/* Right: vitality, attacks, inventory, traits */}
        <div className="min-w-0 space-y-4">
          {/* Pontos de Vida */}
          <div className="arcane-panel p-4">
            <p className="section-label mb-3">· Pontos de Vida ·</p>
            <div className="grid grid-cols-2 gap-3 sm:grid-cols-3">
              {/* PV Atuais — editável com + / - */}
              <div className="flex flex-col items-center gap-2 rounded py-3 px-2"
                style={{ background: 'var(--color-bg-tertiary)', border: '1px solid var(--color-gold)', boxShadow: '0 0 8px rgba(201,168,76,0.12)' }}>
                <div className="flex w-full items-center gap-1">
                  <StepBtn onClick={() => onChange({ currentHp: char.currentHp - 1 })}>−</StepBtn>
                  <NumInput
                    value={char.currentHp}
                    onChange={(n) => onChange({ currentHp: n })}
                    className="min-w-0 flex-1 text-center text-2xl leading-none"
                    style={{ ...inputBase, color: 'var(--color-gold-light)' }}
                  />
                  <StepBtn onClick={() => onChange({ currentHp: char.currentHp + 1 })}>+</StepBtn>
                </div>
                <span className="text-xs" style={{ color: 'var(--color-text-muted)' }}>PV Atuais</span>
              </div>

              {/* PV Máximos */}
              <div className="flex flex-col items-center justify-center gap-1 rounded py-3 px-2"
                style={{ background: 'var(--color-bg-tertiary)', border: '1px solid var(--color-border-default)' }}>
                <span className="text-2xl leading-none" style={{ color: 'var(--color-text-secondary)' }}>{char.maxHp}</span>
                <span className="text-xs" style={{ color: 'var(--color-text-muted)' }}>PV Máximos</span>
              </div>

              {/* PV Temporários */}
              <div className="col-span-2 flex flex-col items-center gap-2 rounded py-3 px-2 sm:col-span-1"
                style={{ background: 'var(--color-bg-tertiary)', border: '1px solid var(--color-border-default)' }}>
                <div className="flex w-full items-center gap-1">
                  <StepBtn onClick={() => onChange({ tempHp: Math.max(0, char.tempHp - 1) })}>−</StepBtn>
                  <NumInput
                    value={char.tempHp}
                    onChange={(n) => onChange({ tempHp: n })}
                    className="min-w-0 flex-1 text-center text-2xl leading-none"
                    style={{ ...inputBase, color: 'var(--color-text-secondary)' }}
                  />
                  <StepBtn onClick={() => onChange({ tempHp: char.tempHp + 1 })}>+</StepBtn>
                </div>
                <span className="text-center text-xs" style={{ color: 'var(--color-text-muted)' }}>PV Temp.</span>
              </div>
            </div>

            {/* Dados de Vida */}
            <div className="mt-3 grid grid-cols-2 gap-3">
              <div className="flex flex-col items-center justify-center gap-1 rounded py-2 px-3"
                style={{ background: 'var(--color-bg-tertiary)', border: '1px solid var(--color-border-default)' }}>
                <span className="text-xl leading-none" style={{ color: 'var(--color-gold-light)' }}>
                  {hitDice} × {char.level}
                </span>
                <span className="text-xs" style={{ color: 'var(--color-text-muted)' }}>Dados de Vida</span>
              </div>
              <div className="flex flex-col items-center gap-2 rounded py-2 px-2"
                style={{ background: 'var(--color-bg-tertiary)', border: '1px solid var(--color-border-default)' }}>
                <div className="flex items-center gap-2">
                  <StepBtn onClick={() => onChange({ hitDiceSpent: Math.max(0, char.hitDiceSpent - 1) })}>−</StepBtn>
                  <span className="w-6 text-center text-xl leading-none" style={{ color: 'var(--color-text-secondary)' }}>
                    {char.hitDiceSpent}
                  </span>
                  <StepBtn onClick={() => onChange({ hitDiceSpent: Math.min(char.level, char.hitDiceSpent + 1) })}>+</StepBtn>
                </div>
                <span className="text-xs" style={{ color: 'var(--color-text-muted)' }}>Dados Gastos</span>
              </div>
            </div>

            {(char.deathSavesSuccess > 0 || char.deathSavesFailure > 0) && (
              <div className="mt-2 flex justify-center gap-6 text-xs" style={{ color: 'var(--color-text-muted)' }}>
                <span>Sucessos: <span style={{ color: 'var(--color-gold)' }}>{char.deathSavesSuccess}</span></span>
                <span>Falhas: <span style={{ color: '#f87171' }}>{char.deathSavesFailure}</span></span>
              </div>
            )}
          </div>

          {/* Armadura e Escudo */}
          <div className="arcane-panel p-4">
            <p className="section-label mb-4">· Armadura e Escudo ·</p>
            <ArmorSelector
              char={char}
              onChange={onChange}
              onItemAdd={pushItem}
              onItemRemove={(name) => {
                onChange({ inventory: char.inventory.filter(i => i.name !== name) })
              }}
            />
            <div className="mt-3 w-36">
              <label className="mb-1 block text-xs" style={{ color: 'var(--color-text-muted)' }}>Bônus Extra CA</label>
              <input
                type="number"
                value={char.acExtraBonus}
                onChange={e => onChange({ acExtraBonus: Number(e.target.value) || 0 })}
                className="w-full px-3 py-1.5 text-base [appearance:textfield] [&::-webkit-inner-spin-button]:appearance-none [&::-webkit-outer-spin-button]:appearance-none"
                style={{
                  background: 'var(--color-bg-tertiary)',
                  border: '1px solid var(--color-border-default)',
                  color: 'var(--color-text-primary)',
                  borderRadius: '4px',
                  outline: 'none',
                }}
              />
            </div>
          </div>

          {/* Ataques */}
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
            <div className="mb-3 flex items-center justify-between">
              <p className="section-label">· Ataques e Magias ·</p>
              <div className="flex gap-2">
                <button
                  onClick={() => setShowWeaponPicker(true)}
                  className="flex items-center gap-1 rounded px-2 py-1 text-xs"
                  style={{ border: '1px solid var(--color-border-default)', color: 'var(--color-gold-dark)' }}>
                  <BookOpen size={11} /> Codex
                </button>
                <button
                  onClick={addAttack}
                  className="flex items-center gap-1 rounded px-2 py-1 text-xs"
                  style={{ border: '1px solid var(--color-border-default)', color: 'var(--color-text-muted)' }}>
                  <Plus size={11} /> Personalizado
                </button>
              </div>
            </div>
            {char.attacks.length === 0 ? (
              <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Nenhum ataque adicionado.</p>
            ) : (
              <div className="space-y-1">
                <div className="flex items-center px-2 pb-1">
                  <span className="min-w-0 flex-1 text-xs" style={{ color: 'var(--color-text-muted)' }}>Nome</span>
                  <span className="w-10 shrink-0 text-xs" style={{ color: 'var(--color-text-muted)' }}>Attr</span>
                  <span className="w-14 shrink-0 text-xs" style={{ color: 'var(--color-text-muted)' }}>Bônus</span>
                  <span className="w-14 shrink-0 text-xs" style={{ color: 'var(--color-text-muted)' }}>Dano</span>
                  <span className="w-14 shrink-0 text-xs" style={{ color: 'var(--color-text-muted)' }}>Tipo</span>
                  <span className="w-6 shrink-0" />
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
                    <div key={atk.id}
                      className="flex items-center rounded px-2 py-1.5"
                      style={{ background: 'var(--color-bg-tertiary)' }}>
                      <input
                        value={atk.name}
                        onChange={(e) => onChange({ attacks: updateAttack(char.attacks, atk.id, { name: e.target.value }) })}
                        placeholder="Nome"
                        className="min-w-0 flex-1 text-sm"
                        style={{ ...inputBase, color: 'var(--color-text-primary)' }}
                      />
                      <select
                        value={atk.stat ?? ''}
                        onChange={(e) => onChange({ attacks: updateAttack(char.attacks, atk.id, { stat: (e.target.value as AttackStat) || undefined }) })}
                        className="w-10 shrink-0 text-xs"
                        style={{ ...inputBase, color: atk.stat ? 'var(--color-gold-dark)' : 'var(--color-text-muted)' }}
                      >
                        <option value="">—</option>
                        <option value="str">FOR</option>
                        <option value="dex">DES</option>
                        <option value="con">CON</option>
                        <option value="int">INT</option>
                        <option value="wis">SAB</option>
                        <option value="cha">CAR</option>
                      </select>
                      <input
                        value={auto ?? atk.attackBonus}
                        readOnly={!!auto}
                        onChange={(e) => !auto && onChange({ attacks: updateAttack(char.attacks, atk.id, { attackBonus: e.target.value }) })}
                        placeholder="+0"
                        className="w-14 shrink-0 text-sm"
                        style={{ ...inputBase, color: auto ? 'var(--color-gold)' : 'var(--color-gold-light)', cursor: auto ? 'default' : 'text' }}
                      />
                      <input
                        value={autoDmg ?? atk.damage}
                        readOnly={!!autoDmg}
                        onChange={(e) => !autoDmg && onChange({ attacks: updateAttack(char.attacks, atk.id, { damage: e.target.value }) })}
                        placeholder="1d6"
                        className="w-14 shrink-0 text-sm"
                        style={{ ...inputBase, color: autoDmg ? 'var(--color-gold)' : 'var(--color-text-secondary)', cursor: autoDmg ? 'default' : 'text' }}
                      />
                      <input
                        value={atk.damageType}
                        onChange={(e) => onChange({ attacks: updateAttack(char.attacks, atk.id, { damageType: e.target.value }) })}
                        placeholder="Tipo"
                        className="w-14 shrink-0 text-sm"
                        style={{ ...inputBase, color: 'var(--color-text-muted)' }}
                      />
                      <button onClick={() => removeAttack(atk.id)}
                        className="flex w-6 shrink-0 items-center justify-center rounded"
                        style={{ color: 'var(--color-text-muted)' }}>
                        <Trash2 size={12} />
                      </button>
                    </div>
                  )
                })}
              </div>
            )}
          </div>

          {/* Equipamento — sempre visível, moedas editáveis, itens gerenciáveis */}
          {showItemPicker && (
            <ItemPickerModal
              onConfirm={(item) => {
                onChange({ inventory: [...char.inventory, item] })
                setShowItemPicker(false)
              }}
              onClose={() => setShowItemPicker(false)}
            />
          )}
          <div className="arcane-panel p-4">
            <p className="section-label mb-3">· Equipamento ·</p>

            {/* Moedas editáveis */}
            <div className="mb-4 grid grid-cols-4 gap-1.5">
              {CURRENCIES.map(({ key, label, color }) => (
                <div key={key} className="flex flex-col items-center gap-0.5 rounded py-1.5 px-1"
                  style={{ background: 'var(--color-bg-tertiary)', border: '1px solid var(--color-border-default)' }}>
                  <NumInput
                    value={char[key]}
                    min={0}
                    onChange={(n) => onChange({ [key]: n })}
                    className="w-full text-center text-xl leading-none"
                    style={{ ...inputBase, color }}
                  />
                  <span className="text-sm font-normal" style={{ color: 'var(--color-text-muted)' }}>{label}</span>
                </div>
              ))}
            </div>

            {/* Inventário */}
            <div className="mb-2 flex items-center justify-between">
              <span className="text-base" style={{ color: 'var(--color-text-secondary)' }}>
                {char.inventory.length > 0
                  ? (() => {
                      const count = char.inventory.length
                      const totalWeight = char.inventory.reduce((s, i) => s + i.weight * i.quantity, 0)
                      const weightStr = totalWeight % 1 === 0 ? String(totalWeight) : totalWeight.toFixed(1)
                      return `${count} item${count !== 1 ? 's' : ''} · ${weightStr} lb`
                    })()
                  : 'Inventário vazio'}
              </span>
              <div className="flex gap-2">
                <button
                  onClick={() => setShowItemPicker(true)}
                  className="flex items-center gap-1 rounded px-2 py-1 text-xs transition-colors"
                  style={{ border: '1px solid var(--color-border-default)', color: 'var(--color-gold-dark)' }}>
                  <BookOpen size={11} /> Codex
                </button>
                <button
                  onClick={addItem}
                  className="flex items-center gap-1 rounded px-2 py-1 text-xs transition-colors"
                  style={{ border: '1px solid var(--color-border-default)', color: 'var(--color-text-muted)' }}>
                  <Plus size={11} /> Personalizado
                </button>
              </div>
            </div>

            {char.inventory.length > 0 && (
              <div className="space-y-1.5">
                {char.inventory.map((item) => (
                  <div key={item.id} className="rounded px-2 py-1.5"
                    style={{ background: 'var(--color-bg-tertiary)', border: '1px solid var(--color-border-default)' }}>
                    <div className="flex items-center gap-2">
                      {/* Nome editável */}
                      <input
                        value={item.name}
                        onChange={(e) => onChange({ inventory: updateItem(char.inventory, item.id, { name: e.target.value }) })}
                        placeholder="Nome do item"
                        className="min-w-0 flex-1 text-base"
                        style={{ ...inputBase, color: 'var(--color-text-primary)' }}
                      />
                      {/* Quantidade com + / - */}
                      <div className="flex shrink-0 items-center gap-1">
                        <StepBtn onClick={() => onChange({ inventory: updateItem(char.inventory, item.id, { quantity: Math.max(1, item.quantity - 1) }) })}>−</StepBtn>
                        <span className="w-6 text-center text-base" style={{ color: 'var(--color-text-secondary)' }}>{item.quantity}</span>
                        <StepBtn onClick={() => onChange({ inventory: updateItem(char.inventory, item.id, { quantity: item.quantity + 1 }) })}>+</StepBtn>
                      </div>
                      {/* Peso editável */}
                      <NumInput
                        value={item.weight}
                        min={0}
                        onChange={(n) => onChange({ inventory: updateItem(char.inventory, item.id, { weight: n }) })}
                        className="w-10 shrink-0 text-center text-sm"
                        style={{ ...inputBase, color: 'var(--color-text-muted)' }}
                      />
                      <span className="shrink-0 text-xs" style={{ color: 'var(--color-text-muted)' }}>lb</span>
                      {/* Remover */}
                      <button onClick={() => removeItem(item.id)} className="shrink-0 rounded p-0.5"
                        style={{ color: 'var(--color-text-muted)' }}>
                        <Trash2 size={12} />
                      </button>
                    </div>
                    <input
                      value={item.description ?? ''}
                      onChange={(e) => onChange({ inventory: updateItem(char.inventory, item.id, { description: e.target.value }) })}
                      placeholder="Descrição (opcional)"
                      className="mt-1 w-full text-xs"
                      style={{ ...inputBase, color: 'var(--color-text-muted)', borderTop: '1px solid var(--color-border-default)', paddingTop: '4px' }}
                    />
                  </div>
                ))}
              </div>
            )}
          </div>

        </div>
      </div>
      </>}

      {activeTab === 'bio' && (
        <div className="arcane-panel p-4">
          <p className="section-label mb-3">· Traços e Características ·</p>
          <div className="space-y-3">
            {char.personalityTraits  && <TraitBlock label="Traços de Personalidade"    text={char.personalityTraits} />}
            {char.ideals             && <TraitBlock label="Ideais"                      text={char.ideals} />}
            {char.bonds              && <TraitBlock label="Vínculos"                    text={char.bonds} />}
            {char.flaws              && <TraitBlock label="Defeitos"                    text={char.flaws} />}
            {char.featuresTraits     && <TraitBlock label="Habilidades de Classe/Raça" text={char.featuresTraits} />}
            {char.otherProficiencies && <TraitBlock label="Proficiências e Idiomas"    text={char.otherProficiencies} />}
          </div>
          {!char.personalityTraits && !char.ideals && !char.bonds && !char.flaws
            && !char.featuresTraits && !char.otherProficiencies && (
            <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Nenhum traço preenchido.</p>
          )}
        </div>
      )}

      {activeTab === 'magias' && (
        <SpellsSection char={char} onChange={onChange} />
      )}
    </div>
  )
}
