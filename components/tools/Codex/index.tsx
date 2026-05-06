'use client'

import { useState, useEffect, useMemo } from 'react'
import { Search, Library } from 'lucide-react'
import type { CodexEntry } from '@/types/codex'
import { getCodexEntries, translateSubtype } from '@/lib/codex'
import CodexCard from './CodexCard'
import CodexDetail from './CodexDetail'

type TypeFilter = 'all' | 'weapon' | 'armor' | 'item' | 'rule'

const TABS: { id: TypeFilter; label: string }[] = [
  { id: 'all',    label: 'Todos'     },
  { id: 'weapon', label: 'Armas'     },
  { id: 'armor',  label: 'Armaduras' },
  { id: 'item',   label: 'Itens'     },
  { id: 'rule',   label: 'Regras'    },
]

const SUBTYPE_ORDER: Partial<Record<TypeFilter, string[]>> = {
  weapon: ['simple melee', 'simple ranged', 'martial melee', 'martial ranged'],
  armor:  ['light', 'medium', 'heavy', 'shield'],
  item:   ['ammunition', 'light source', 'consumable', 'potion', 'scroll', 'focus', 'kit', 'container', 'gear'],
  rule:   ['condition', 'action', 'cover', 'concentration', 'rest', 'death', 'combat', 'reaction'],
}

function buildGroups(entries: CodexEntry[], typeFilter: TypeFilter, hasSearch: boolean) {
  if (hasSearch) {
    return [{ key: 'results', label: '', entries }]
  }

  if (typeFilter === 'all') {
    return [
      { key: 'weapon', label: 'Armas',     entries: entries.filter(e => e.type === 'weapon') },
      { key: 'armor',  label: 'Armaduras', entries: entries.filter(e => e.type === 'armor')  },
      { key: 'item',   label: 'Itens',     entries: entries.filter(e => e.type === 'item')   },
      { key: 'rule',   label: 'Regras',    entries: entries.filter(e => e.type === 'rule')   },
    ].filter(g => g.entries.length > 0)
  }

  const order = SUBTYPE_ORDER[typeFilter] ?? []
  const groups: { key: string; label: string; entries: CodexEntry[] }[] = []
  const used = new Set<string>()

  for (const sub of order) {
    const group = entries.filter(e => e.subtype === sub)
    if (group.length) {
      groups.push({ key: sub, label: translateSubtype(sub), entries: group })
      used.add(sub)
    }
  }

  const rest = entries.filter(e => !used.has(e.subtype ?? ''))
  if (rest.length) groups.push({ key: '_rest', label: 'Outros', entries: rest })

  return groups
}

export default function Codex() {
  const [entries, setEntries]     = useState<CodexEntry[]>([])
  const [loading, setLoading]     = useState(true)
  const [search, setSearch]       = useState('')
  const [typeFilter, setTypeFilter] = useState<TypeFilter>('all')
  const [selected, setSelected]   = useState<CodexEntry | null>(null)

  useEffect(() => {
    getCodexEntries().then(data => { setEntries(data); setLoading(false) })
  }, [])

  const filtered = useMemo(() => {
    const q = search.toLowerCase().trim()
    let result = typeFilter !== 'all' ? entries.filter(e => e.type === typeFilter) : entries
    if (q) result = result.filter(e =>
      e.name.toLowerCase().includes(q) ||
      e.description?.toLowerCase().includes(q) ||
      e.subtype?.toLowerCase().includes(q)
    )
    return result
  }, [entries, typeFilter, search])

  const groups = useMemo(
    () => buildGroups(filtered, typeFilter, search.trim().length > 0),
    [filtered, typeFilter, search],
  )

  const counts = useMemo(() => {
    const c = { all: entries.length, weapon: 0, armor: 0, item: 0, rule: 0 }
    for (const e of entries) {
      if (e.type === 'weapon')      c.weapon++
      else if (e.type === 'armor')  c.armor++
      else if (e.type === 'item')   c.item++
      else if (e.type === 'rule')   c.rule++
    }
    return c
  }, [entries])

  return (
    <div className="mx-auto w-full max-w-4xl px-6 py-8">
      {/* Header */}
      <div className="mb-6">
        <h1 className="mb-1 text-3xl" style={{ color: 'var(--color-text-primary)' }}>Codex</h1>
        <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
          Biblioteca D&D 5e SRD — armas, armaduras e equipamento de aventureiro.
        </p>
      </div>

      {/* Filter panel */}
      <div className="arcane-panel mb-6 p-4">
        {/* Type tabs */}
        <div className="mb-3 flex flex-wrap gap-1">
          {TABS.map(tab => {
            const active = typeFilter === tab.id
            return (
              <button
                key={tab.id}
                onClick={() => setTypeFilter(tab.id)}
                className="rounded px-3 py-1.5 text-base transition-all"
                style={active ? {
                  background: 'var(--color-gold-glow)',
                  color: 'var(--color-gold-light)',
                  border: '1px solid rgba(201,168,76,0.5)',
                } : {
                  background: 'transparent',
                  color: 'var(--color-text-muted)',
                  border: '1px solid transparent',
                }}
              >
                {tab.label}
                <span className="ml-1.5 text-xs opacity-50">{counts[tab.id]}</span>
              </button>
            )
          })}
        </div>

        {/* Search */}
        <div className="relative">
          <Search size={14} className="absolute left-3 top-1/2 -translate-y-1/2"
            style={{ color: 'var(--color-text-muted)' }} />
          <input
            type="text"
            placeholder="Buscar por nome ou descrição…"
            value={search}
            onChange={e => setSearch(e.target.value)}
            className="w-full rounded py-2 pl-9 pr-12 text-base outline-none"
            style={{
              background: 'var(--color-bg-tertiary)',
              border: '1px solid var(--color-border-default)',
              color: 'var(--color-text-primary)',
            }}
          />
          {search && (
            <span className="pointer-events-none absolute right-3 top-1/2 -translate-y-1/2 text-sm"
              style={{ color: 'var(--color-text-muted)' }}>
              {filtered.length}
            </span>
          )}
        </div>
      </div>

      {/* Content */}
      {loading ? (
        <div className="flex items-center justify-center py-20">
          <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Carregando Codex…</p>
        </div>
      ) : filtered.length === 0 ? (
        <div className="flex flex-col items-center justify-center gap-3 rounded border border-dashed py-16 text-center"
          style={{ borderColor: 'var(--color-border-default)' }}>
          <Library size={28} style={{ color: 'var(--color-text-muted)' }} />
          <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Nenhum resultado encontrado.</p>
        </div>
      ) : (
        <div className="space-y-8">
          {groups.map(group => (
            <div key={group.key}>
              {group.label && <p className="section-label mb-3">· {group.label} ·</p>}
              <div className="grid grid-cols-1 gap-2 lg:grid-cols-2">
                {group.entries.map(entry => (
                  <CodexCard key={entry.id} entry={entry} onClick={() => setSelected(entry)} />
                ))}
              </div>
            </div>
          ))}
        </div>
      )}

      {selected && <CodexDetail entry={selected} onClose={() => setSelected(null)} />}
    </div>
  )
}
