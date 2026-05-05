'use client'

import { useState } from 'react'
import { Menu } from 'lucide-react'
import Sidebar from './Sidebar'

export default function AppLayout({ children }: { children: React.ReactNode }) {
  const [sidebarOpen, setSidebarOpen] = useState(false)

  return (
    <div className="flex h-full" style={{ background: 'var(--color-bg-primary)' }}>

      {/* Mobile overlay */}
      {sidebarOpen && (
        <div
          className="fixed inset-0 z-30 bg-black/50 md:hidden"
          onClick={() => setSidebarOpen(false)}
        />
      )}

      <Sidebar isOpen={sidebarOpen} onClose={() => setSidebarOpen(false)} />

      <main className="relative flex flex-1 flex-col overflow-auto">
        {/* Mobile header bar */}
        <header className="flex items-center px-4 py-3 md:hidden"
          style={{ borderBottom: '1px solid var(--color-border-default)' }}>
          <button
            onClick={() => setSidebarOpen(true)}
            className="rounded p-1"
            style={{ color: 'var(--color-text-muted)' }}
            aria-label="Abrir menu"
          >
            <Menu size={20} />
          </button>
          <span className="ml-3 text-xl tracking-widest" style={{ color: 'var(--color-gold-light)' }}>
            Æternus RPG
          </span>
        </header>

        <div className="pointer-events-none absolute inset-0"
          style={{ background: 'radial-gradient(ellipse at 50% 0%, rgba(201,168,76,0.04) 0%, transparent 60%)' }} />
        <div className="relative z-10 flex flex-1 flex-col">{children}</div>
      </main>
    </div>
  )
}
