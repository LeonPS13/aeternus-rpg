'use client'

import { useEffect } from 'react'
import { Check, X } from 'lucide-react'
import { useTheme } from '@/context/theme'
import { THEMES } from '@/lib/themes'
import type { Theme } from '@/types/theme'

interface Props {
  onClose: () => void
}

export default function ThemePickerModal({ onClose }: Props) {
  const { theme: current, setTheme } = useTheme()

  useEffect(() => {
    document.body.style.overflow = 'hidden'
    return () => { document.body.style.overflow = '' }
  }, [])

  return (
    <div
      className="fixed inset-0 z-50 flex items-start justify-start p-4 pt-16 md:items-center md:justify-center"
      style={{ background: 'rgba(0,0,0,0.75)' }}
      onClick={onClose}
    >
      <div
        className="arcane-panel w-full max-w-xs p-5"
        onClick={e => e.stopPropagation()}
      >
        <div className="mb-4 flex items-center justify-between">
          <p className="section-label">· Tema Visual ·</p>
          <button
            onClick={onClose}
            className="rounded p-1"
            style={{ color: 'var(--color-text-muted)' }}
            aria-label="Fechar"
          >
            <X size={14} />
          </button>
        </div>

        <div className="space-y-2">
          {THEMES.map(t => (
            <ThemeCard
              key={t.id}
              theme={t}
              active={t.id === current.id}
              onSelect={() => { setTheme(t); onClose() }}
            />
          ))}
        </div>
      </div>
    </div>
  )
}

function ThemeCard({ theme, active, onSelect }: {
  theme: Theme
  active: boolean
  onSelect: () => void
}) {
  return (
    <button
      onClick={onSelect}
      className="w-full rounded p-3 text-left transition-all"
      style={{
        border: `1px solid ${active ? 'var(--color-gold)' : 'var(--color-border-default)'}`,
        background: active ? 'var(--color-gold-glow)' : 'var(--color-bg-tertiary)',
      }}
    >
      <div className="flex items-center justify-between gap-2">
        <p className="text-base font-medium leading-tight" style={{ color: 'var(--color-text-primary)' }}>
          {theme.name}
        </p>
        {active && <Check size={13} style={{ color: 'var(--color-gold)', flexShrink: 0 }} />}
      </div>
    </button>
  )
}
