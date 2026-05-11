'use client'

import { useState, useEffect, useRef } from 'react'
import { Plus, Trash2, BookOpen } from 'lucide-react'
import type { Character, InventoryItem } from '@/types/character'
import ItemPickerModal from '@/components/tools/CharacterSheet/ItemPickerModal'

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

const CURRENCIES: { key: keyof Pick<Character, 'cp' | 'sp' | 'gp' | 'pp'>; label: string; color: string }[] = [
  { key: 'cp', label: 'PC (Cobre)',   color: '#b45309' },
  { key: 'sp', label: 'PP (Prata)',   color: '#9ca3af' },
  { key: 'gp', label: 'PO (Ouro)',    color: 'var(--color-gold)' },
  { key: 'pp', label: 'PL (Platina)', color: '#e5e7eb' },
]

function NumInput({ value, min = 0, onChange: onCh, className = '', style }: {
  value: number; min?: number; onChange: (n: number) => void
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
        onCh(n)
        setText(String(n))
      }}
      onChange={(e) => setText(e.target.value)}
    />
  )
}

function updateItem(items: InventoryItem[], id: string, updates: Partial<InventoryItem>): InventoryItem[] {
  return items.map((item) => item.id === id ? { ...item, ...updates } : item)
}

export default function EquipmentSection({ char, onChange }: Props) {
  const [showItemPicker, setShowItemPicker] = useState(false)

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

  return (
    <div className="space-y-6">
      {/* Currency */}
      <div className="arcane-panel p-4">
        <p className="section-label mb-4">· Moedas ·</p>
        <div className="grid grid-cols-2 gap-3 sm:grid-cols-5">
          {CURRENCIES.map(({ key, label, color }) => (
            <div key={key}>
              <label className="mb-1 block text-xs font-medium" style={{ color }}>
                {label}
              </label>
              <NumInput
                value={char[key]}
                min={0}
                onChange={(n) => onChange({ [key]: n })}
                className="w-full px-2 py-1.5 text-center text-base"
                style={inputStyle}
              />
            </div>
          ))}
        </div>
      </div>

      {/* Inventory */}
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
        <div className="mb-4 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <p className="section-label">· Inventário ·</p>
            {(() => {
              const totalWeight = char.inventory.reduce((s, i) => s + i.weight * i.quantity, 0)
              const maxCarry   = char.strScore * 15
              const over       = totalWeight > maxCarry
              return (
                <span className="text-xs" style={{ color: over ? '#ef4444' : 'var(--color-text-muted)' }}>
                  {totalWeight} lb / Máx: {maxCarry} lb
                  {over && <span className="ml-1 font-semibold">⚠ Sobrecarregado</span>}
                </span>
              )
            })()}
          </div>
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
              <Plus size={12} /> Personalizado
            </button>
          </div>
        </div>

        {char.inventory.length === 0 ? (
          <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Inventário vazio.</p>
        ) : (
          <div className="space-y-2">
            <div className="grid grid-cols-[1fr_4rem_4rem_2rem] gap-2 px-2">
              {['Item', 'Qtd', 'Peso (lb)', ''].map((h, i) => (
                <span key={i} className="text-xs" style={{ color: 'var(--color-text-muted)' }}>{h}</span>
              ))}
            </div>
            {char.inventory.map((item) => (
              <div key={item.id}
                className="rounded p-2 space-y-1.5"
                style={{ background: 'var(--color-bg-tertiary)' }}>
                <div className="grid grid-cols-[1fr_4rem_4rem_2rem] gap-2">
                  <input
                    value={item.name}
                    onChange={(e) => onChange({ inventory: updateItem(char.inventory, item.id, { name: e.target.value }) })}
                    placeholder="Nome do item"
                    className="px-2 py-1 text-sm"
                    style={inputStyle}
                  />
                  <NumInput
                    value={item.quantity}
                    min={1}
                    onChange={(n) => onChange({ inventory: updateItem(char.inventory, item.id, { quantity: n }) })}
                    className="px-2 py-1 text-center text-sm"
                    style={inputStyle}
                  />
                  <NumInput
                    value={item.weight}
                    min={0}
                    onChange={(n) => onChange({ inventory: updateItem(char.inventory, item.id, { weight: n }) })}
                    className="px-2 py-1 text-center text-sm"
                    style={inputStyle}
                  />
                  <button onClick={() => removeItem(item.id)}
                    className="flex items-center justify-center rounded transition-colors"
                    style={{ color: 'var(--color-text-muted)' }}>
                    <Trash2 size={13} />
                  </button>
                </div>
                <input
                  value={item.description ?? ''}
                  onChange={(e) => onChange({ inventory: updateItem(char.inventory, item.id, { description: e.target.value }) })}
                  placeholder="Descrição (opcional)"
                  className="w-full px-2 py-1 text-xs"
                  style={{ ...inputStyle, border: 'none', background: 'transparent', borderTop: '1px solid var(--color-border-default)' }}
                />
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  )
}
