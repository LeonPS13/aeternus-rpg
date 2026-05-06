'use client'

import { useState, useEffect, useRef } from 'react'
import { Plus, Trash2, CheckCircle2, Circle } from 'lucide-react'
import type { Character, CharacterAttack, ArmorType } from '@/types/character'
import { ARMOR_TYPES } from '@/types/character'
import {
  calcAC, calcInitiative, calcPassivePerception, fmtMod, HIT_DICE_BY_CLASS,
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

export default function CombatSection({ char, onChange }: Props) {
  const hitDice = HIT_DICE_BY_CLASS[char.characterClass] ?? 'd8'
  const acLabel = char.acArmorType !== 'none'
    ? { light: 'leve', medium: 'média', heavy: 'pesada' }[char.acArmorType] ?? ''
    : ''

  function addAttack() {
    onChange({
      attacks: [
        ...char.attacks,
        { id: crypto.randomUUID(), name: '', attackBonus: '', damage: '', damageType: '' },
      ],
    })
  }

  function removeAttack(id: string) {
    onChange({ attacks: char.attacks.filter((a) => a.id !== id) })
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

        {/* AC config */}
        <div className="mt-4 grid gap-3 sm:grid-cols-4">
          <div>
            <label className="mb-1 block text-xs" style={{ color: 'var(--color-text-muted)' }}>Tipo de Armadura</label>
            <select
              value={char.acArmorType}
              onChange={(e) => onChange({ acArmorType: e.target.value as ArmorType })}
              className="w-full px-2 py-1.5 text-sm"
              style={inputStyle}
            >
              <option value="none">Sem armadura</option>
              <option value="light">Leve</option>
              <option value="medium">Média</option>
              <option value="heavy">Pesada</option>
            </select>
          </div>
          {char.acArmorType !== 'none' && (
            <div>
              <label className="mb-1 block text-xs" style={{ color: 'var(--color-text-muted)' }}>
                CA da armadura {acLabel}
              </label>
              <NumInput value={char.acArmorEquipped} onChange={(n) => onChange({ acArmorEquipped: n })} />
            </div>
          )}
          <div>
            <label className="mb-1 block text-xs" style={{ color: 'var(--color-text-muted)' }}>Bônus de Escudo</label>
            <NumInput value={char.acShieldBonus} onChange={(n) => onChange({ acShieldBonus: n })} />
          </div>
          <div>
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
      <div className="arcane-panel p-4">
        <div className="mb-4 flex items-center justify-between">
          <p className="section-label">· Ataques e Magias ·</p>
          <button
            onClick={addAttack}
            className="flex items-center gap-1 rounded px-2 py-1 text-xs transition-colors"
            style={{ border: '1px solid var(--color-border-default)', color: 'var(--color-text-muted)' }}>
            <Plus size={12} /> Adicionar
          </button>
        </div>

        {char.attacks.length === 0 ? (
          <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Nenhum ataque cadastrado.</p>
        ) : (
          <div className="space-y-2">
            {/* Header */}
            <div className="hidden grid-cols-[1fr_5rem_5rem_5rem_2rem] gap-2 sm:grid">
              {['Nome', 'Bônus', 'Dano', 'Tipo', ''].map((h, i) => (
                <span key={i} className="text-xs" style={{ color: 'var(--color-text-muted)' }}>{h}</span>
              ))}
            </div>

            {char.attacks.map((atk) => (
              <div key={atk.id}
                className="grid grid-cols-1 gap-2 rounded p-2 sm:grid-cols-[1fr_5rem_5rem_5rem_2rem]"
                style={{ background: 'var(--color-bg-tertiary)' }}>
                <input
                  value={atk.name}
                  onChange={(e) => onChange({ attacks: updateAttack(char.attacks, atk.id, { name: e.target.value }) })}
                  placeholder="Nome da arma/magia"
                  className="px-2 py-1 text-sm"
                  style={inputStyle}
                />
                <input
                  value={atk.attackBonus}
                  onChange={(e) => onChange({ attacks: updateAttack(char.attacks, atk.id, { attackBonus: e.target.value }) })}
                  placeholder="+5"
                  className="px-2 py-1 text-sm"
                  style={inputStyle}
                />
                <input
                  value={atk.damage}
                  onChange={(e) => onChange({ attacks: updateAttack(char.attacks, atk.id, { damage: e.target.value }) })}
                  placeholder="1d8+3"
                  className="px-2 py-1 text-sm"
                  style={inputStyle}
                />
                <input
                  value={atk.damageType}
                  onChange={(e) => onChange({ attacks: updateAttack(char.attacks, atk.id, { damageType: e.target.value }) })}
                  placeholder="Cortante"
                  className="px-2 py-1 text-sm"
                  style={inputStyle}
                />
                <button onClick={() => removeAttack(atk.id)}
                  className="flex items-center justify-center rounded transition-colors"
                  style={{ color: 'var(--color-text-muted)' }}>
                  <Trash2 size={13} />
                </button>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  )
}
