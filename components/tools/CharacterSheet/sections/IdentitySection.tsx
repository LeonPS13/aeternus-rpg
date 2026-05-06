'use client'

import type { Character } from '@/types/character'
import { CLASSES, RACES, ALIGNMENTS } from '@/types/character'
import { profBonus } from '@/lib/character-calc'

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

const selectStyle = { ...inputStyle, caretColor: undefined }

function Field({ label, children }: { label: string; children: React.ReactNode }) {
  return (
    <div>
      <label className="mb-1 block text-sm font-medium" style={{ color: 'var(--color-text-muted)' }}>{label}</label>
      {children}
    </div>
  )
}

export default function IdentitySection({ char, onChange }: Props) {
  const pb = profBonus(char.level)

  return (
    <div className="space-y-6">
      {/* Name row */}
      <div className="arcane-panel p-4">
        <p className="section-label mb-4">· Identificação ·</p>
        <div className="grid gap-3 sm:grid-cols-2">
          <Field label="Nome do Personagem">
            <input
              value={char.characterName}
              onChange={(e) => onChange({ characterName: e.target.value })}
              placeholder="Ex: Aldric Voss"
              className="w-full px-3 py-2 text-base"
              style={inputStyle}
            />
          </Field>
          <Field label="Nome do Jogador">
            <input
              value={char.playerName}
              onChange={(e) => onChange({ playerName: e.target.value })}
              placeholder="Seu nome"
              className="w-full px-3 py-2 text-base"
              style={inputStyle}
            />
          </Field>
        </div>
      </div>

      {/* Class / Race / Level */}
      <div className="arcane-panel p-4">
        <p className="section-label mb-4">· Classe e Raça ·</p>
        <div className="grid gap-3 sm:grid-cols-3">
          <Field label="Classe">
            <select
              value={char.characterClass}
              onChange={(e) => onChange({ characterClass: e.target.value })}
              className="w-full px-3 py-2 text-base"
              style={selectStyle}
            >
              <option value="">Selecionar…</option>
              {CLASSES.map((c) => <option key={c} value={c}>{c}</option>)}
            </select>
          </Field>
          <Field label="Raça">
            <select
              value={char.race}
              onChange={(e) => onChange({ race: e.target.value })}
              className="w-full px-3 py-2 text-base"
              style={selectStyle}
            >
              <option value="">Selecionar…</option>
              {RACES.map((r) => <option key={r} value={r}>{r}</option>)}
            </select>
          </Field>
          <Field label="Nível">
            <input
              type="number" min={1} max={20}
              value={char.level}
              onChange={(e) => onChange({ level: Math.min(20, Math.max(1, Number(e.target.value) || 1)) })}
              className="w-full px-3 py-2 text-base [appearance:textfield] [&::-webkit-inner-spin-button]:appearance-none [&::-webkit-outer-spin-button]:appearance-none"
              style={inputStyle}
            />
          </Field>
        </div>

        {/* PB display */}
        <div className="mt-3 flex items-center gap-2 rounded px-3 py-2"
          style={{ background: 'var(--color-gold-glow)', border: '1px solid var(--color-border-default)' }}>
          <span className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Bônus de Proficiência:</span>
          <span className="text-base font-medium" style={{ color: 'var(--color-gold-light)' }}>+{pb}</span>
        </div>
      </div>

      {/* Background / Alignment / XP */}
      <div className="arcane-panel p-4">
        <p className="section-label mb-4">· Antecedente ·</p>
        <div className="grid gap-3 sm:grid-cols-3">
          <Field label="Antecedente">
            <input
              value={char.background}
              onChange={(e) => onChange({ background: e.target.value })}
              placeholder="Ex: Sage, Criminal…"
              className="w-full px-3 py-2 text-base"
              style={inputStyle}
            />
          </Field>
          <Field label="Alinhamento">
            <select
              value={char.alignment}
              onChange={(e) => onChange({ alignment: e.target.value })}
              className="w-full px-3 py-2 text-base"
              style={selectStyle}
            >
              <option value="">Selecionar…</option>
              {ALIGNMENTS.map((a) => <option key={a} value={a}>{a}</option>)}
            </select>
          </Field>
          <Field label="XP">
            <input
              type="number" min={0}
              value={char.xp}
              onChange={(e) => onChange({ xp: Math.max(0, Number(e.target.value) || 0) })}
              className="w-full px-3 py-2 text-base [appearance:textfield] [&::-webkit-inner-spin-button]:appearance-none [&::-webkit-outer-spin-button]:appearance-none"
              style={inputStyle}
            />
          </Field>
        </div>
      </div>
    </div>
  )
}
