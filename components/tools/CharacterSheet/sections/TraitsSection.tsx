'use client'

import type { Character } from '@/types/character'

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

function TextArea({
  label, value, placeholder, onChange: onCh,
}: {
  label: string
  value: string
  placeholder: string
  onChange: (v: string) => void
}) {
  return (
    <div>
      <label className="mb-1.5 block text-sm font-medium" style={{ color: 'var(--color-text-muted)' }}>{label}</label>
      <textarea
        value={value}
        onChange={(e) => onCh(e.target.value)}
        placeholder={placeholder}
        rows={4}
        className="w-full resize-y px-3 py-2 text-sm"
        style={inputStyle}
      />
    </div>
  )
}

export default function TraitsSection({ char, onChange }: Props) {
  return (
    <div className="space-y-6">
      <div className="arcane-panel p-4">
        <p className="section-label mb-4">· Proficiências e Idiomas ·</p>
        <TextArea
          label="Outras Proficiências e Idiomas"
          value={char.otherProficiencies}
          placeholder="Idiomas falados, instrumentos, ferramentas, armaduras e armas adicionais…"
          onChange={(v) => onChange({ otherProficiencies: v })}
        />
      </div>

      <div className="arcane-panel p-4">
        <p className="section-label mb-4">· Características e Habilidades ·</p>
        <TextArea
          label="Habilidades de Classe, Raça e Antecedente"
          value={char.featuresTraits}
          placeholder="Rage (Barbarian), Sneak Attack (Rogue), Darkvision (Elf)…"
          onChange={(v) => onChange({ featuresTraits: v })}
        />
      </div>

      <div className="arcane-panel p-4">
        <p className="section-label mb-4">· Detalhes de Background ·</p>
        <div className="grid gap-4 sm:grid-cols-2">
          <TextArea
            label="Traços de Personalidade"
            value={char.personalityTraits}
            placeholder="Como seu personagem age e se comporta…"
            onChange={(v) => onChange({ personalityTraits: v })}
          />
          <TextArea
            label="Ideais"
            value={char.ideals}
            placeholder="Os princípios que guiam seu personagem…"
            onChange={(v) => onChange({ ideals: v })}
          />
          <TextArea
            label="Vínculos"
            value={char.bonds}
            placeholder="Conexões com pessoas, lugares ou eventos…"
            onChange={(v) => onChange({ bonds: v })}
          />
          <TextArea
            label="Defeitos"
            value={char.flaws}
            placeholder="Fraquezas, medos ou falhas do personagem…"
            onChange={(v) => onChange({ flaws: v })}
          />
        </div>
      </div>
    </div>
  )
}
