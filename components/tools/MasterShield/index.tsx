'use client'

import { useState, useEffect } from 'react'
import type { CodexEntry } from '@/types/codex'
import type { ShieldData, ShieldCard } from '@/types/master-shield'
import { loadShield, saveShield } from '@/lib/master-shield'
import { getRuleEntries } from '@/lib/codex'
import ShieldGrid from './ShieldGrid'
import CreateCardModal from './RulePickerModal'

export default function MasterShield() {
  const [shield, setShield]         = useState<ShieldData>(() => loadShield())
  const [rules, setRules]           = useState<CodexEntry[]>([])
  const [pickerSlot, setPickerSlot] = useState<number | null>(null)

  useEffect(() => {
    getRuleEntries().then(setRules)
  }, [])

  function updateCards(updater: (cards: ShieldCard[]) => ShieldCard[]) {
    setShield(prev => {
      const next: ShieldData = { cards: updater(prev.cards) }
      saveShield(next)
      return next
    })
  }

  function setCard(i: number, card: Exclude<ShieldCard, null>) {
    updateCards(cards => cards.map((c, idx) => idx === i ? card : c))
  }

  function updateNote(i: number, title: string, content: string) {
    updateCards(cards => cards.map((c, idx) => idx === i ? { type: 'note', title, content } : c))
  }

  function removeCard(i: number) {
    updateCards(cards => cards.map((c, idx) => idx === i ? null : c))
  }

  return (
    <div className="mx-auto w-full max-w-5xl px-4 py-6 sm:px-6 sm:py-8">
      <div className="mb-6 text-center">
        <h1 className="text-5xl" style={{ color: 'var(--color-text-primary)', textShadow: '0 0 24px rgba(201,168,76,0.3)' }}>
          Escudo do Mestre
        </h1>
        <p className="mt-1 text-base" style={{ color: 'var(--color-text-muted)' }}>
          Notas rápidas e regras à mão para a sessão
        </p>
      </div>

      <div className="ornament-divider mb-8">
        <div className="ornament-line" />
        <div className="ornament-diamond" />
        <div className="ornament-line" />
      </div>

      <ShieldGrid
        cards={shield.cards}
        codexRules={rules}
        onCreateCard={(i) => setPickerSlot(i)}
        onUpdateNote={updateNote}
        onRemove={removeCard}
      />

      {pickerSlot !== null && (
        <CreateCardModal
          rules={rules}
          onConfirm={(card) => {
            setCard(pickerSlot, card)
            setPickerSlot(null)
          }}
          onClose={() => setPickerSlot(null)}
        />
      )}
    </div>
  )
}
