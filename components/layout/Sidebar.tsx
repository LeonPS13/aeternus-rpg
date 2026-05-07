'use client'

import { useState } from 'react'
import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { X } from 'lucide-react'
import ThemePickerModal from '@/components/layout/ThemePickerModal'

function NavIcon({ file, active }: { file: string; active: boolean }) {
  return (
    <img
      src={`/icons_2/${file}`}
      width={28}
      height={28}
      alt=""
      style={{
        objectFit: 'contain',
        filter: active ? 'var(--nav-icon-filter-active)' : 'var(--nav-icon-filter-inactive)',
        flexShrink: 0,
      }}
    />
  )
}

interface ToolItem {
  label: string
  href: string
  iconFile: string
  active: boolean
}

const tools: ToolItem[] = [
  { label: 'Rolador de Dados',      href: '/tools/dice-roller',      iconFile: 'meteoro.png',         active: true  },
  { label: 'Diário de Aventura',    href: '/tools/adventure-diary',  iconFile: 'livro-magico.png',    active: true  },
  { label: 'Ficha de Personagem',   href: '/tools/character-sheet',  iconFile: 'chapeu-de-mago.png',  active: true  },
  { label: 'Escudo do Mestre',      href: '/tools/master-shield',    iconFile: 'escudo.png',          active: true  },
  { label: 'Codex',                 href: '/tools/codex',            iconFile: 'bola-de-cristal.png', active: true  },
  { label: 'Tabelas de Encontro',   href: '/tools/encounter-tables', iconFile: 'binocular.png',       active: false },
  { label: 'Mapa de Masmorra',      href: '/tools/dungeon-map',      iconFile: 'mapa.png',            active: false },
]

interface SidebarProps {
  isOpen: boolean
  onClose: () => void
}

export default function Sidebar({ isOpen, onClose }: SidebarProps) {
  const pathname = usePathname()
  const [themeOpen, setThemeOpen] = useState(false)

  return (
    <aside
      className={[
        'fixed inset-y-0 left-0 z-40 flex h-full w-52 flex-col',
        'transition-transform duration-200 ease-in-out',
        isOpen ? 'translate-x-0' : '-translate-x-full',
        'md:relative md:translate-x-0',
      ].join(' ')}
      style={{ background: 'var(--color-bg-secondary)', borderRight: '1px solid var(--color-border-default)' }}>

      {/* Logo — clicável para trocar tema */}
      <div className="flex flex-col items-center justify-center py-3"
        style={{ borderBottom: '1px solid var(--color-border-default)' }}>
        <div className="relative w-full text-center" style={{ lineHeight: 1.1 }}>
          {/* Close button — mobile only */}
          <button
            onClick={onClose}
            className="absolute right-2 top-0 rounded p-1 md:hidden"
            style={{ color: 'var(--color-text-muted)' }}
            aria-label="Fechar menu"
          >
            <X size={16} />
          </button>
          <button
            onClick={() => setThemeOpen(true)}
            className="inline-block transition-opacity hover:opacity-75"
            style={{ lineHeight: 1.1 }}
            title="Trocar tema"
          >
            <p className="text-4xl tracking-widest"
              style={{ color: 'var(--color-gold-light)', textShadow: '0 0 24px var(--color-logo-glow)' }}>
              Æternus
            </p>
            <p className="text-4xl tracking-widest"
              style={{ color: 'var(--color-gold-light)', textShadow: '0 0 24px var(--color-logo-glow)' }}>
              RPG
            </p>
          </button>
        </div>
      </div>

      {/* Tools Navigation */}
      <nav className="flex-1 overflow-y-auto scrollbar-thin px-3 py-4">
        <p className="section-label mb-3 px-2">· Ferramentas ·</p>
        <ul className="space-y-0.5">
          {tools.map((tool) => {
            const isActive = pathname === tool.href
            if (!tool.active) {
              return (
                <li key={tool.href}>
                  <span className="flex cursor-not-allowed items-center gap-3 border-l-2 border-transparent px-3 py-2.5 opacity-25">
                    <NavIcon file={tool.iconFile} active={false} />
                    <span className="flex-1 text-base" style={{ color: 'var(--color-text-muted)' }}>{tool.label}</span>
                    <span className="rounded-sm px-1.5 py-0.5 text-xs font-medium"
                      style={{ background: 'var(--color-bg-tertiary)', color: 'var(--color-text-muted)' }}>
                      Em breve
                    </span>
                  </span>
                </li>
              )
            }
            return (
              <li key={tool.href}>
                <Link
                  href={tool.href}
                  onClick={onClose}
                  className="group flex items-center gap-3 border-l-2 px-3 py-2.5 transition-all duration-150"
                  style={isActive ? {
                    borderLeftColor: 'var(--color-gold)',
                    background: 'var(--color-gold-glow)',
                    color: 'var(--color-gold-light)',
                  } : {
                    borderLeftColor: 'transparent',
                    color: 'var(--color-text-secondary)',
                  }}
                >
                  <NavIcon file={tool.iconFile} active={isActive} />
                  <span className="flex-1 text-base font-medium">{tool.label}</span>
                </Link>
              </li>
            )
          })}
        </ul>
      </nav>

      {/* Footer */}
      <div className="px-5 py-3" style={{ borderTop: '1px solid var(--color-border-default)' }}>
        <p className="text-xs" style={{ color: 'var(--color-text-muted)' }}>v0.1.0 — Alpha</p>
      </div>

      {themeOpen && <ThemePickerModal onClose={() => setThemeOpen(false)} />}
    </aside>
  )
}
