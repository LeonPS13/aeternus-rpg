'use client'

import { useState, useEffect, useMemo } from 'react'
import { Search, Library } from 'lucide-react'
import type { CodexEntry } from '@/types/codex'
import type { SpellEntry } from '@/types/spell'
import type { ClassEntry } from '@/types/class'
import { SPELL_CLASSES } from '@/types/spell'
import { getCodexEntries, translateSubtype } from '@/lib/codex'
import { getSpellEntries, translateSpellClass, translateSchool, spellLevelLabel } from '@/lib/spells'
import { getAllClasses } from '@/lib/classes'
import CodexCard from './CodexCard'
import CodexDetail from './CodexDetail'
import SpellCard from './SpellCard'
import SpellDetail from './SpellDetail'
import ClassCard from './ClassCard'
import ClassDetail from './ClassDetail'

type TypeFilter = 'all' | 'weapon' | 'armor' | 'item' | 'rule' | 'spell' | 'class'

const TABS: { id: TypeFilter; label: string }[] = [
  { id: 'all',    label: 'Todos'     },
  { id: 'weapon', label: 'Armas'     },
  { id: 'armor',  label: 'Armaduras' },
  { id: 'item',   label: 'Itens'     },
  { id: 'rule',   label: 'Regras'    },
  { id: 'spell',  label: 'Magias'    },
  { id: 'class',  label: 'Classes'   },
]

const SUBTYPE_ORDER: Partial<Record<TypeFilter, string[]>> = {
  weapon: ['simple melee', 'simple ranged', 'martial melee', 'martial ranged'],
  armor:  ['light', 'medium', 'heavy', 'shield'],
  item:   ['ammunition', 'light source', 'consumable', 'potion', 'scroll', 'focus', 'kit', 'container', 'gear'],
  rule:   ['condition', 'action', 'cover', 'concentration', 'rest', 'death', 'combat', 'reaction'],
}

const SPELL_LEVELS = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

function buildGroups(entries: CodexEntry[], typeFilter: TypeFilter, hasSearch: boolean) {
  if (hasSearch) return [{ key: 'results', label: '', entries }]

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
    if (group.length) { groups.push({ key: sub, label: translateSubtype(sub), entries: group }); used.add(sub) }
  }
  const rest = entries.filter(e => !used.has(e.subtype ?? ''))
  if (rest.length) groups.push({ key: '_rest', label: 'Outros', entries: rest })
  return groups
}

let _codexCache:   CodexEntry[]  | null = null
let _spellCache:   SpellEntry[]  | null = null
let _classesCache: ClassEntry[]  | null = null

export default function Codex() {
  const [entries,       setEntries]       = useState<CodexEntry[]>([])
  const [spells,        setSpells]        = useState<SpellEntry[]>([])
  const [classes,       setClasses]       = useState<ClassEntry[]>([])
  const [loading,       setLoading]       = useState(true)
  const [spellLoading,  setSpellLoading]  = useState(false)
  const [classLoading,  setClassLoading]  = useState(false)
  const [error,         setError]         = useState<string | null>(null)
  const [spellError,    setSpellError]    = useState<string | null>(null)
  const [classError,    setClassError]    = useState<string | null>(null)
  const [search,        setSearch]        = useState('')
  const [typeFilter,    setTypeFilter]    = useState<TypeFilter>('all')
  const [selected,      setSelected]      = useState<CodexEntry | null>(null)
  const [selectedSpell, setSelectedSpell] = useState<SpellEntry | null>(null)
  const [selectedClass, setSelectedClass] = useState<ClassEntry | null>(null)
  const [spellLevel,    setSpellLevel]    = useState<number | null>(null)
  const [spellClass,    setSpellClass]    = useState<string | null>(null)

  useEffect(() => {
    if (_codexCache) { setEntries(_codexCache); setLoading(false); return }
    getCodexEntries()
      .then(data => { _codexCache = data; setEntries(data); setLoading(false) })
      .catch(() => { setError('Erro ao carregar o Codex. Tente recarregar a página.'); setLoading(false) })
  }, [])

  useEffect(() => {
    if (typeFilter !== 'spell') return
    if (_spellCache) { setSpells(_spellCache); return }
    setSpellLoading(true)
    getSpellEntries()
      .then(data => { _spellCache = data; setSpells(data); setSpellLoading(false) })
      .catch(() => { setSpellError('Erro ao carregar magias. Tente recarregar a página.'); setSpellLoading(false) })
  }, [typeFilter])

  useEffect(() => {
    if (typeFilter !== 'class') return
    if (_classesCache) { setClasses(_classesCache); return }
    setClassLoading(true)
    getAllClasses()
      .then(data => { _classesCache = data; setClasses(data); setClassLoading(false) })
      .catch(() => { setClassError('Erro ao carregar classes. Tente recarregar a página.'); setClassLoading(false) })
  }, [typeFilter])

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

  const filteredSpells = useMemo(() => {
    let result = spells
    if (spellLevel !== null) result = result.filter(s => s.level === spellLevel)
    if (spellClass)          result = result.filter(s => (s.classes as string[]).includes(spellClass))
    const q = search.toLowerCase().trim()
    if (q) result = result.filter(s =>
      s.name.toLowerCase().includes(q) ||
      s.description.toLowerCase().includes(q) ||
      translateSchool(s.school).toLowerCase().includes(q)
    )
    return result
  }, [spells, spellLevel, spellClass, search])

  const filteredClasses = useMemo(() => {
    const q = search.toLowerCase().trim()
    if (!q) return classes
    return classes.filter(c =>
      c.name.toLowerCase().includes(q) ||
      (c.nameEn ?? '').toLowerCase().includes(q) ||
      (c.description ?? '').toLowerCase().includes(q)
    )
  }, [classes, search])

  const spellGroups = useMemo(() => {
    if (search.trim() || spellLevel !== null) {
      return [{ level: -1, label: '', entries: filteredSpells }]
    }
    const map = new Map<number, SpellEntry[]>()
    for (const s of filteredSpells) {
      if (!map.has(s.level)) map.set(s.level, [])
      map.get(s.level)!.push(s)
    }
    return Array.from(map.entries())
      .sort(([a], [b]) => a - b)
      .map(([level, entries]) => ({ level, label: spellLevelLabel(level), entries }))
  }, [filteredSpells, search, spellLevel])

  const counts = useMemo(() => {
    const c: Record<TypeFilter, number> = {
      all: entries.length, weapon: 0, armor: 0, item: 0, rule: 0,
      spell: spells.length, class: classes.length,
    }
    for (const e of entries) {
      if      (e.type === 'weapon') c.weapon++
      else if (e.type === 'armor')  c.armor++
      else if (e.type === 'item')   c.item++
      else if (e.type === 'rule')   c.rule++
    }
    return c
  }, [entries, spells.length, classes.length])

  const isSpell = typeFilter === 'spell'
  const isClass = typeFilter === 'class'

  function handleTabChange(id: TypeFilter) {
    setTypeFilter(id)
    setSearch('')
    if (id !== 'spell') { setSpellLevel(null); setSpellClass(null) }
  }

  const chipActive = {
    background: 'var(--color-gold-glow)',
    color: 'var(--color-gold-light)',
    border: '1px solid rgba(201,168,76,0.5)',
  }
  const chipIdle = {
    background: 'transparent',
    color: 'var(--color-text-muted)',
    border: '1px solid transparent',
  }

  return (
    <div className="mx-auto w-full max-w-4xl px-6 py-8">
      {/* Header */}
      <div className="mb-6">
        <h1 className="mb-1 text-3xl" style={{ color: 'var(--color-text-primary)' }}>Codex</h1>
        <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
          Biblioteca D&D 5e SRD — armas, armaduras, equipamento, magias e classes.
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
                onClick={() => handleTabChange(tab.id)}
                className="rounded px-3 py-1.5 text-base transition-all"
                style={active ? chipActive : chipIdle}
              >
                {tab.label}
                <span className="ml-1.5 text-xs opacity-50">{counts[tab.id]}</span>
              </button>
            )
          })}
        </div>

        {/* Spell sub-filters */}
        {isSpell && (
          <div className="mb-3 space-y-2">
            <div className="flex flex-wrap gap-1">
              <button onClick={() => setSpellLevel(null)}
                className="rounded px-2.5 py-1 text-sm transition-all"
                style={spellLevel === null ? chipActive : chipIdle}>
                Todos os círculos
              </button>
              {SPELL_LEVELS.map(lvl => (
                <button key={lvl}
                  onClick={() => setSpellLevel(spellLevel === lvl ? null : lvl)}
                  className="rounded px-2.5 py-1 text-sm transition-all"
                  style={spellLevel === lvl ? chipActive : chipIdle}>
                  {lvl === 0 ? 'Truque' : `${lvl}º`}
                </button>
              ))}
            </div>
            <div className="flex flex-wrap gap-1">
              <button onClick={() => setSpellClass(null)}
                className="rounded px-2.5 py-1 text-sm transition-all"
                style={spellClass === null ? chipActive : chipIdle}>
                Todas as classes
              </button>
              {SPELL_CLASSES.map(cls => (
                <button key={cls}
                  onClick={() => setSpellClass(spellClass === cls ? null : cls)}
                  className="rounded px-2.5 py-1 text-sm transition-all"
                  style={spellClass === cls ? chipActive : chipIdle}>
                  {translateSpellClass(cls)}
                </button>
              ))}
            </div>
          </div>
        )}

        {/* Search */}
        <div className="relative">
          <Search size={14} className="absolute left-3 top-1/2 -translate-y-1/2"
            style={{ color: 'var(--color-text-muted)' }} />
          <input
            type="text"
            placeholder={
              isSpell ? 'Buscar por nome, escola ou efeito…' :
              isClass ? 'Buscar por nome ou descrição…' :
              'Buscar por nome ou descrição…'
            }
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
              {isSpell ? filteredSpells.length : isClass ? filteredClasses.length : filtered.length}
            </span>
          )}
        </div>
      </div>

      {/* ── Content: Classes ── */}
      {isClass ? (
        classLoading ? (
          <div className="flex items-center justify-center py-20">
            <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Carregando classes…</p>
          </div>
        ) : classError ? (
          <div className="flex items-center justify-center py-20">
            <p className="text-sm" style={{ color: 'var(--color-accent)' }}>{classError}</p>
          </div>
        ) : filteredClasses.length === 0 ? (
          <div className="flex flex-col items-center justify-center gap-3 rounded border border-dashed py-16 text-center"
            style={{ borderColor: 'var(--color-border-default)' }}>
            <Library size={28} style={{ color: 'var(--color-text-muted)' }} />
            <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Nenhuma classe encontrada.</p>
          </div>
        ) : (
          <div className="grid grid-cols-1 gap-2 sm:grid-cols-2 lg:grid-cols-3">
            {filteredClasses.map(cls => (
              <ClassCard key={cls.id} cls={cls} onClick={() => setSelectedClass(cls)} />
            ))}
          </div>
        )

      /* ── Content: Spells ── */
      ) : isSpell ? (
        spellLoading ? (
          <div className="flex items-center justify-center py-20">
            <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Carregando magias…</p>
          </div>
        ) : spellError ? (
          <div className="flex items-center justify-center py-20">
            <p className="text-sm" style={{ color: 'var(--color-accent)' }}>{spellError}</p>
          </div>
        ) : filteredSpells.length === 0 ? (
          <div className="flex flex-col items-center justify-center gap-3 rounded border border-dashed py-16 text-center"
            style={{ borderColor: 'var(--color-border-default)' }}>
            <Library size={28} style={{ color: 'var(--color-text-muted)' }} />
            <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Nenhuma magia encontrada.</p>
          </div>
        ) : (
          <div className="space-y-8">
            {spellGroups.map(group => (
              <div key={group.level}>
                {group.label && <p className="section-label mb-3">· {group.label} ·</p>}
                <div className="grid grid-cols-1 gap-2 lg:grid-cols-2">
                  {group.entries.map(spell => (
                    <SpellCard key={spell.id} spell={spell} onClick={() => setSelectedSpell(spell)} />
                  ))}
                </div>
              </div>
            ))}
          </div>
        )

      /* ── Content: Codex (all, weapons, armor, items, rules) ── */
      ) : loading ? (
        <div className="flex items-center justify-center py-20">
          <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Carregando Codex…</p>
        </div>
      ) : error ? (
        <div className="flex items-center justify-center py-20">
          <p className="text-sm" style={{ color: 'var(--color-accent)' }}>{error}</p>
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

      {/* Overlays */}
      {selected      && <CodexDetail  entry={selected}      onClose={() => setSelected(null)}      />}
      {selectedSpell && <SpellDetail  spell={selectedSpell} onClose={() => setSelectedSpell(null)} />}
      {selectedClass && <ClassDetail  cls={selectedClass}   onClose={() => setSelectedClass(null)} />}
    </div>
  )
}
