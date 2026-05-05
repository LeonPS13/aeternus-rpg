'use client'

import Image from 'next/image'
import Link from 'next/link'
import { usePathname } from 'next/navigation'
import {
  Dice6,
  User,
  Map,
  Table2,
  ChevronRight,
  BookOpen,
} from 'lucide-react'

interface ToolItem {
  label: string
  href: string
  icon: React.ReactNode
  active: boolean
}

const tools: ToolItem[] = [
  {
    label: 'Rolador de Dados',
    href: '/tools/dice-roller',
    icon: <Dice6 size={16} />,
    active: true,
  },
  {
    label: 'Diário de Aventura',
    href: '/tools/adventure-diary',
    icon: <BookOpen size={16} />,
    active: true,
  },
  {
    label: 'Gerador de Personagem',
    href: '/tools/character-generator',
    icon: <User size={16} />,
    active: false,
  },
  {
    label: 'Tabelas de Encontro',
    href: '/tools/encounter-tables',
    icon: <Table2 size={16} />,
    active: false,
  },
  {
    label: 'Mapa de Masmorra',
    href: '/tools/dungeon-map',
    icon: <Map size={16} />,
    active: false,
  },
]

export default function Sidebar() {
  const pathname = usePathname()

  return (
    <aside className="relative flex h-full w-60 flex-col border-r border-amber-700/20 bg-gradient-to-b from-slate-900 to-slate-950 shadow-[inset_-1px_0_0_rgba(120,53,15,0.15)]">
      {/* Logo */}
      <div className="relative overflow-hidden border-b border-amber-700/20">
        <Image
          src="/logo.png"
          alt="Aeternus RPG"
          width={240}
          height={92}
          className="w-full object-cover"
          priority
        />
        <div className="absolute inset-x-0 bottom-0 h-6 bg-gradient-to-t from-slate-900 to-transparent" />
      </div>

      {/* Tools Navigation */}
      <nav className="flex-1 overflow-y-auto px-3 py-4">
        <p className="mb-2 px-2 text-[10px] font-semibold uppercase tracking-widest text-amber-600/50">
          Ferramentas
        </p>
        <ul className="space-y-0.5">
          {tools.map((tool) => {
            const isCurrentPath = pathname === tool.href
            if (!tool.active) {
              return (
                <li key={tool.href}>
                  <span className="flex cursor-not-allowed items-center gap-3 rounded-lg px-3 py-2.5 opacity-30">
                    <span className="text-slate-500">{tool.icon}</span>
                    <span className="flex-1 text-sm text-slate-500">{tool.label}</span>
                    <span className="rounded-full bg-slate-800 px-1.5 py-0.5 text-[9px] font-medium text-slate-500">
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
                  className={`group flex items-center gap-3 rounded-lg px-3 py-2.5 transition-all duration-150 ${
                    isCurrentPath
                      ? 'border border-amber-500/30 bg-amber-500/10 text-amber-300 shadow-sm shadow-amber-500/10'
                      : 'text-slate-400 hover:bg-slate-800/60 hover:text-slate-200'
                  }`}
                >
                  <span
                    className={
                      isCurrentPath
                        ? 'text-amber-400'
                        : 'text-slate-500 group-hover:text-slate-300'
                    }
                  >
                    {tool.icon}
                  </span>
                  <span className="flex-1 text-sm font-medium">{tool.label}</span>
                  {isCurrentPath && (
                    <ChevronRight size={12} className="text-amber-500" />
                  )}
                </Link>
              </li>
            )
          })}
        </ul>
      </nav>

      {/* Footer */}
      <div className="border-t border-amber-700/20 px-5 py-3">
        <p className="text-[10px] text-slate-600">v0.1.0 — Alpha</p>
      </div>
    </aside>
  )
}
