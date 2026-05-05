'use client'

import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { Dice6, User, Map, Table2, BookOpen, X } from 'lucide-react'

interface ToolItem {
  label: string
  href: string
  icon: React.ReactNode
  active: boolean
}

const tools: ToolItem[] = [
  { label: 'Rolador de Dados',      href: '/tools/dice-roller',         icon: <Dice6 size={16} />,    active: true  },
  { label: 'Diário de Aventura',    href: '/tools/adventure-diary',     icon: <BookOpen size={16} />, active: true  },
  { label: 'Gerador de Personagem', href: '/tools/character-generator', icon: <User size={16} />,     active: false },
  { label: 'Tabelas de Encontro',   href: '/tools/encounter-tables',    icon: <Table2 size={16} />,   active: false },
  { label: 'Mapa de Masmorra',      href: '/tools/dungeon-map',         icon: <Map size={16} />,      active: false },
]

interface SidebarProps {
  isOpen: boolean
  onClose: () => void
}

export default function Sidebar({ isOpen, onClose }: SidebarProps) {
  const pathname = usePathname()

  return (
    <aside
      className={[
        'fixed inset-y-0 left-0 z-40 flex h-full w-60 flex-col',
        'transition-transform duration-200 ease-in-out',
        isOpen ? 'translate-x-0' : '-translate-x-full',
        'md:relative md:translate-x-0',
      ].join(' ')}
      style={{ background: 'var(--color-bg-secondary)', borderRight: '1px solid var(--color-border-default)' }}>

      {/* Logo text */}
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
          <p className="text-4xl tracking-widest"
            style={{ color: 'var(--color-gold-light)', textShadow: '0 0 24px rgba(201,168,76,0.6)' }}>
            Æternus
          </p>
          <p className="text-4xl tracking-widest"
            style={{ color: 'var(--color-gold-light)', textShadow: '0 0 24px rgba(201,168,76,0.6)' }}>
            RPG
          </p>
        </div>
      </div>

      {/* Tools Navigation */}
      <nav className="flex-1 overflow-y-auto px-3 py-4">
        <p className="section-label mb-3 px-2">· Ferramentas ·</p>
        <ul className="space-y-0.5">
          {tools.map((tool) => {
            const isActive = pathname === tool.href
            if (!tool.active) {
              return (
                <li key={tool.href}>
                  <span className="flex cursor-not-allowed items-center gap-3 border-l-2 border-transparent px-3 py-2.5 opacity-25">
                    <span style={{ color: 'var(--color-text-muted)' }}>{tool.icon}</span>
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
                  <span style={isActive ? { color: 'var(--color-gold)' } : { color: 'var(--color-text-muted)' }}>
                    {tool.icon}
                  </span>
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
    </aside>
  )
}
