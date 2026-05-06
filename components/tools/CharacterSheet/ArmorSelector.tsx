'use client'

import { useState, useEffect } from 'react'
import type { Character, InventoryItem } from '@/types/character'
import type { ArmorType } from '@/types/character'
import type { CodexEntry } from '@/types/codex'
import { getArmorEntries, translateSubtype } from '@/lib/codex'
import { calcAC } from '@/lib/character-calc'

interface Props {
  char: Character
  onChange: (u: Partial<Character>) => void
  onItemAdd: (item: InventoryItem) => void
  onItemRemove: (name: string) => void
}

const inputStyle = {
  background: 'var(--color-bg-tertiary)',
  border: '1px solid var(--color-border-default)',
  color: 'var(--color-text-primary)',
  borderRadius: '4px',
  outline: 'none',
}

const ARMOR_SUBTYPE_ORDER = ['light', 'medium', 'heavy']

export default function ArmorSelector({ char, onChange, onItemAdd, onItemRemove }: Props) {
  const [armors, setArmors]                   = useState<CodexEntry[]>([])
  const [selectedArmorId, setSelectedArmorId] = useState('')
  const [selectedShieldId, setSelectedShieldId] = useState('')

  useEffect(() => {
    getArmorEntries().then(setArmors)
  }, [])

  const armorList  = armors.filter(a => a.subtype !== 'shield')
  const shieldList = armors.filter(a => a.subtype === 'shield')

  function handleArmorChange(id: string) {
    const prevEntry = armors.find(a => a.id === selectedArmorId)
    if (prevEntry) onItemRemove(prevEntry.name)
    setSelectedArmorId(id)
    if (!id) {
      onChange({ acArmorType: 'none', acArmorEquipped: 0 })
      return
    }
    const entry = armors.find(a => a.id === id)
    if (!entry) return
    const d = entry.data
    onChange({
      acArmorType:     entry.subtype as ArmorType,
      acArmorEquipped: d.ac_base as number,
    })
    onItemAdd({
      id:          crypto.randomUUID(),
      name:        entry.name,
      quantity:    1,
      weight:      (d.weight as number) ?? 0,
      description: entry.description ?? '',
    })
  }

  function handleShieldChange(id: string) {
    const prevEntry = armors.find(a => a.id === selectedShieldId)
    if (prevEntry) onItemRemove(prevEntry.name)
    setSelectedShieldId(id)
    if (!id) {
      onChange({ acShieldBonus: 0 })
      return
    }
    const entry = armors.find(a => a.id === id)
    if (!entry) return
    const d = entry.data
    onChange({ acShieldBonus: (d.ac_bonus as number) ?? 2 })
    onItemAdd({
      id:          crypto.randomUUID(),
      name:        entry.name,
      quantity:    1,
      weight:      (d.weight as number) ?? 6,
      description: entry.description ?? '',
    })
  }

  const grouped = ARMOR_SUBTYPE_ORDER
    .map(sub => ({ label: translateSubtype(sub), entries: armorList.filter(a => a.subtype === sub) }))
    .filter(g => g.entries.length > 0)

  const selectedArmor  = armors.find(a => a.id === selectedArmorId) ?? null
  const selectedShield = armors.find(a => a.id === selectedShieldId) ?? null

  const infoItems: string[] = []
  if (selectedArmor) {
    const minStr = selectedArmor.data.min_strength as number
    if (minStr > 0) infoItems.push(`For mín ${minStr}`)
    if (selectedArmor.data.stealth_disadvantage) infoItems.push('Furtividade: desvantagem')
  }

  return (
    <div className="space-y-3">
      <div className="grid gap-3 sm:grid-cols-2">
        {/* Armor dropdown */}
        <div>
          <label className="mb-1 block text-xs" style={{ color: 'var(--color-text-muted)' }}>
            Armadura
          </label>
          <select
            value={selectedArmorId}
            onChange={e => handleArmorChange(e.target.value)}
            className="w-full px-2 py-1.5 text-sm"
            style={inputStyle}
          >
            <option value="">Sem armadura</option>
            {grouped.map(g => (
              <optgroup key={g.label} label={g.label}>
                {g.entries.map(a => (
                  <option key={a.id} value={a.id}>
                    {a.name} (CA {a.data.ac_base as number})
                  </option>
                ))}
              </optgroup>
            ))}
          </select>
        </div>

        {/* Shield dropdown */}
        <div>
          <label className="mb-1 block text-xs" style={{ color: 'var(--color-text-muted)' }}>
            Escudo
          </label>
          <select
            value={selectedShieldId}
            onChange={e => handleShieldChange(e.target.value)}
            className="w-full px-2 py-1.5 text-sm"
            style={inputStyle}
          >
            <option value="">Sem escudo</option>
            {shieldList.map(s => (
              <option key={s.id} value={s.id}>
                {s.name} (+{(s.data.ac_bonus as number) ?? 2} CA)
              </option>
            ))}
          </select>
        </div>
      </div>

      {/* CA preview + info */}
      {(selectedArmor || selectedShield) && (
        <div className="flex flex-wrap items-center gap-x-4 gap-y-1 text-sm"
          style={{ color: 'var(--color-text-muted)' }}>
          <span>
            CA calculada:{' '}
            <strong style={{ color: 'var(--color-gold-light)' }}>{calcAC(char)}</strong>
          </span>
          {infoItems.map((info, i) => (
            <span key={i}>· {info}</span>
          ))}
        </div>
      )}
    </div>
  )
}
