'use client'

import { useState, useEffect, useRef } from 'react'
import { X } from 'lucide-react'
import type { InventoryItem } from '@/types/character'
import type { CodexEntry } from '@/types/codex'
import { getItemEntries, translateSubtype } from '@/lib/codex'

interface Props {
  onConfirm: (item: InventoryItem) => void
  onClose: () => void
}

const SUBTYPE_ORDER = [
  'ammunition', 'consumable', 'potion', 'scroll', 'focus',
  'kit', 'container', 'gear', 'light source',
]

const inputStyle = {
  background: 'var(--color-bg-tertiary)',
  border: '1px solid var(--color-border-default)',
  color: 'var(--color-text-primary)',
  borderRadius: '4px',
  outline: 'none',
  caretColor: 'var(--color-gold)',
}

export default function ItemPickerModal({ onConfirm, onClose }: Props) {
  const [items, setItems]           = useState<CodexEntry[]>([])
  const [selectedId, setSelectedId] = useState('')
  const [qtyText, setQtyText]       = useState('1')
  const qtyFocused                  = useRef(false)

  useEffect(() => {
    document.body.style.overflow = 'hidden'
    return () => { document.body.style.overflow = '' }
  }, [])

  useEffect(() => {
    getItemEntries().then(setItems)
  }, [])

  const selected = items.find(i => i.id === selectedId) ?? null

  function handleQtyBlur() {
    const n = isNaN(Number(qtyText)) || Number(qtyText) < 1 ? 1 : Math.floor(Number(qtyText))
    setQtyText(String(n))
  }

  function handleConfirm() {
    if (!selected) return
    onConfirm({
      id:          crypto.randomUUID(),
      name:        selected.name,
      quantity:    isNaN(Number(qtyText)) ? 1 : Math.max(1, Math.floor(Number(qtyText))),
      weight:      (selected.data.weight as number) ?? 0,
      description: selected.description ?? '',
    })
  }

  const grouped = SUBTYPE_ORDER
    .map(sub => ({ label: translateSubtype(sub), entries: items.filter(i => i.subtype === sub) }))
    .filter(g => g.entries.length > 0)

  const weight = selected ? (selected.data.weight as number) ?? 0 : null

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-4"
      style={{ background: 'rgba(0,0,0,0.75)' }}
      onClick={onClose}
    >
      <div
        className="arcane-panel relative w-full max-w-sm p-6"
        onClick={e => e.stopPropagation()}
      >
        <button
          onClick={onClose}
          className="absolute right-4 top-4 rounded p-1"
          style={{ color: 'var(--color-text-muted)' }}
          aria-label="Fechar"
        >
          <X size={16} />
        </button>

        <h2 className="mb-4 text-2xl" style={{ color: 'var(--color-text-primary)' }}>
          Adicionar Item
        </h2>

        {/* Item select */}
        <div className="mb-4">
          <label className="mb-1 block text-sm" style={{ color: 'var(--color-text-muted)' }}>Item</label>
          <select
            value={selectedId}
            onChange={e => setSelectedId(e.target.value)}
            className="w-full px-3 py-2 text-base"
            style={inputStyle}
          >
            <option value="">— Selecionar item —</option>
            {grouped.map(g => (
              <optgroup key={g.label} label={g.label}>
                {g.entries.map(item => (
                  <option key={item.id} value={item.id}>{item.name}</option>
                ))}
              </optgroup>
            ))}
          </select>
        </div>

        {/* Quantity */}
        <div className="mb-4 w-28">
          <label className="mb-1 block text-sm" style={{ color: 'var(--color-text-muted)' }}>Quantidade</label>
          <input
            type="number"
            value={qtyText}
            onChange={e => setQtyText(e.target.value)}
            onFocus={() => { qtyFocused.current = true }}
            onBlur={() => { qtyFocused.current = false; handleQtyBlur() }}
            className="w-full px-3 py-2 text-base [appearance:textfield] [&::-webkit-inner-spin-button]:appearance-none [&::-webkit-outer-spin-button]:appearance-none"
            style={inputStyle}
          />
        </div>

        {/* Preview */}
        {selected && (
          <div className="mb-4 rounded px-4 py-3 text-sm"
            style={{ background: 'var(--color-bg-tertiary)', border: '1px solid var(--color-border-default)' }}>
            {selected.description && (
              <p className="mb-2 leading-snug" style={{ color: 'var(--color-text-secondary)' }}>
                {selected.description}
              </p>
            )}
            {weight !== null && weight > 0 && (
              <p style={{ color: 'var(--color-text-muted)' }}>
                Peso: <span style={{ color: 'var(--color-gold-light)' }}>{weight} lb</span>
                {Number(qtyText) > 1 && (
                  <span> · Total: <span style={{ color: 'var(--color-gold-light)' }}>{weight * Math.max(1, Math.floor(Number(qtyText) || 1))} lb</span></span>
                )}
              </p>
            )}
          </div>
        )}

        {/* Buttons */}
        <div className="flex gap-2">
          <button
            onClick={handleConfirm}
            disabled={!selected}
            className="arcane-btn flex-1 py-2 text-base disabled:opacity-40"
          >
            Confirmar
          </button>
          <button
            onClick={onClose}
            className="rounded px-4 py-2 text-base"
            style={{ border: '1px solid var(--color-border-default)', color: 'var(--color-text-muted)' }}
          >
            Cancelar
          </button>
        </div>
      </div>
    </div>
  )
}
