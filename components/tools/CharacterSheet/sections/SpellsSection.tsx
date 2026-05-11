'use client'

import { useState, useEffect } from 'react'
import { Plus, X } from 'lucide-react'
import type { Character } from '@/types/character'
import type { CharacterSpell, ClassEntry, ClassLevel } from '@/types/class'
import type { SpellEntry } from '@/types/spell'
import { getCharacterSpells, saveCharacterSpells } from '@/lib/characterSpells'
import { getClassById, getClassLevel } from '@/lib/classes'
import { getSpellEntries, spellLevelLabel, spellLevelShort, translateSchool, SCHOOL_COLORS } from '@/lib/spells'
import SpellDetail from '@/components/tools/Codex/SpellDetail'

const SLOT_KEYS: (keyof ClassLevel)[] = [
  'slot1','slot2','slot3','slot4','slot5','slot6','slot7','slot8','slot9',
]

function SlotPips({ total, used, onToggle }: {
  total: number
  used: number
  onToggle: (idx: number) => void
}) {
  return (
    <div className="flex flex-wrap gap-1.5">
      {Array.from({ length: total }).map((_, i) => (
        <button
          key={i}
          onClick={() => onToggle(i)}
          className="h-4 w-4 rounded-full border transition-all"
          style={{
            background: i < used ? 'var(--color-bg-tertiary)' : 'var(--color-gold-glow)',
            borderColor: i < used ? 'var(--color-border-default)' : 'var(--color-gold)',
          }}
        />
      ))}
    </div>
  )
}

interface Props {
  char: Character
  onChange: (updates: Partial<Character>) => void
}

export default function SpellsSection({ char, onChange }: Props) {
  const [charSpells, setCharSpells] = useState<CharacterSpell[]>([])
  const [allSpells, setAllSpells]   = useState<SpellEntry[]>([])
  const [classLevel, setClassLevel] = useState<ClassLevel | null>(null)
  const [classEntry, setClassEntry] = useState<ClassEntry | null>(null)
  const [loading, setLoading]       = useState(true)
  const [showPicker, setShowPicker]     = useState(false)
  const [pickerSearch, setPickerSearch] = useState('')
  const [selectedSpell, setSelectedSpell] = useState<SpellEntry | null>(null)

  const classId = char.characterClass.toLowerCase().trim()

  useEffect(() => {
    if (!classId) { setLoading(false); return }
    Promise.all([
      getCharacterSpells(char.id),
      getSpellEntries(),
      getClassLevel(classId, char.level),
      getClassById(classId),
    ]).then(([cs, spells, cl, ce]) => {
      setCharSpells(cs)
      setAllSpells(spells)
      setClassLevel(cl)
      setClassEntry(ce)
    }).finally(() => setLoading(false))
  }, [char.id, classId, char.level])

  const spellMap = new Map(allSpells.map(s => [s.id, s]))

  function toggleSlot(circle: number, idx: number) {
    const key = String(circle)
    const current = char.spellSlotsUsed[key] ?? 0
    const total = classLevel ? (classLevel[SLOT_KEYS[circle - 1]] as number) : 0
    const newUsed = idx < current ? idx : Math.min(idx + 1, total)
    onChange({ spellSlotsUsed: { ...char.spellSlotsUsed, [key]: newUsed } })
  }

  async function removeSpell(spellId: string) {
    const updated = charSpells.filter(s => s.spellId !== spellId)
    setCharSpells(updated)
    await saveCharacterSpells(char.id, updated)
  }

  async function togglePrepared(spellId: string) {
    const updated = charSpells.map(cs =>
      cs.spellId !== spellId ? cs
        : { ...cs, status: (cs.status === 'prepared' ? 'known' : 'prepared') as CharacterSpell['status'] }
    )
    setCharSpells(updated)
    await saveCharacterSpells(char.id, updated)
  }

  async function addSpell(spell: SpellEntry) {
    if (charSpells.some(s => s.spellId === spell.id)) return
    const updated: CharacterSpell[] = [...charSpells, { spellId: spell.id, status: 'known' }]
    setCharSpells(updated)
    await saveCharacterSpells(char.id, updated)
    setShowPicker(false)
    setPickerSearch('')
  }

  const isSpellcaster     = !!classLevel && SLOT_KEYS.some(k => (classLevel[k] as number) > 0)
  const isPreparedCaster  = classEntry?.spellcastingType === 'prepared'
  const preparedCount     = charSpells.filter(cs => cs.status === 'prepared').length

  const grouped = new Map<number, { entry: SpellEntry; cs: CharacterSpell }[]>()
  for (const cs of charSpells) {
    const entry = spellMap.get(cs.spellId)
    if (!entry) continue
    if (!grouped.has(entry.level)) grouped.set(entry.level, [])
    grouped.get(entry.level)!.push({ entry, cs })
  }
  const sortedGroups = Array.from(grouped.entries()).sort(([a], [b]) => a - b)

  const maxSpellLevel = classLevel
    ? SLOT_KEYS.reduce((max, key, i) => ((classLevel[key] as number) > 0 ? i + 1 : max), 0)
    : 0

  const knownSpellIds = new Set(charSpells.map(cs => cs.spellId))
  const pickerSpells = allSpells.filter(s => {
    if (knownSpellIds.has(s.id)) return false
    if (classId && !(s.classes as string[]).includes(classId)) return false
    if (s.level > 0 && s.level > maxSpellLevel) return false
    const q = pickerSearch.toLowerCase()
    if (q && !s.name.toLowerCase().includes(q) && !translateSchool(s.school).toLowerCase().includes(q)) return false
    return true
  })

  if (!classId) {
    return (
      <div className="flex flex-col items-center justify-center py-16 text-center">
        <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
          Defina a classe do personagem para ver as magias.
        </p>
      </div>
    )
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center py-16">
        <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Carregando magias…</p>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      {/* Spell slot tracker */}
      {isSpellcaster && classLevel && (
        <div>
          <p className="section-label mb-3">· Espaços de Magia ·</p>
          <div className="arcane-panel p-4 space-y-3">
            {SLOT_KEYS.map((key, i) => {
              const circle = i + 1
              const total = classLevel[key] as number
              if (total === 0) return null
              const used = char.spellSlotsUsed[String(circle)] ?? 0
              return (
                <div key={circle} className="flex items-center gap-3">
                  <span className="w-20 shrink-0 text-sm" style={{ color: 'var(--color-text-muted)' }}>
                    {circle}º círculo
                  </span>
                  <SlotPips
                    total={total}
                    used={used}
                    onToggle={(idx) => toggleSlot(circle, idx)}
                  />
                  <span className="text-sm tabular-nums" style={{ color: 'var(--color-text-muted)' }}>
                    {total - used}/{total}
                  </span>
                </div>
              )
            })}
          </div>
        </div>
      )}

      {/* Spell list */}
      <div>
        <div className="mb-3 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <p className="section-label">· Magias Conhecidas ·</p>
            {isPreparedCaster && preparedCount > 0 && (
              <span className="rounded px-2 py-0.5 text-xs"
                style={{ background: 'var(--color-gold-glow)', border: '1px solid var(--color-gold)', color: 'var(--color-gold-light)' }}>
                {preparedCount} preparada{preparedCount !== 1 ? 's' : ''}
              </span>
            )}
          </div>
          <button
            onClick={() => setShowPicker(true)}
            className="arcane-btn flex items-center gap-1.5 px-3 py-1.5 text-sm"
          >
            <Plus size={14} /> Adicionar
          </button>
        </div>

        {sortedGroups.length === 0 ? (
          <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
            Nenhuma magia adicionada ainda.
          </p>
        ) : (
          <div className="space-y-4">
            {sortedGroups.map(([level, items]) => (
              <div key={level}>
                <p className="section-label mb-2">
                  {spellLevelLabel(level)}
                </p>
                <div className="space-y-1.5">
                  {items.map(({ entry, cs }) => {
                    const color = SCHOOL_COLORS[entry.school] ?? SCHOOL_COLORS.evocation
                    return (
                      <div
                        key={entry.id}
                        className="flex cursor-pointer items-center justify-between rounded p-2.5 transition-opacity hover:opacity-80"
                        style={{ background: 'var(--color-bg-secondary)', border: '1px solid var(--color-border-default)' }}
                        onClick={() => setSelectedSpell(entry)}
                      >
                        <div className="flex min-w-0 items-center gap-2">
                          <span className="shrink-0 rounded px-1.5 py-0.5 text-xs leading-none"
                            style={{ background: color.bg, color: color.color, border: `1px solid ${color.border}` }}>
                            {translateSchool(entry.school)}
                          </span>
                          <span className="truncate text-base" style={{ color: 'var(--color-text-primary)' }}>
                            {entry.name}
                          </span>
                          {isPreparedCaster && entry.level > 0 ? (
                            <label
                              className="flex shrink-0 cursor-pointer select-none items-center gap-1"
                              onClick={e => e.stopPropagation()}
                            >
                              <input
                                type="checkbox"
                                checked={cs.status === 'prepared'}
                                onChange={() => togglePrepared(entry.id)}
                              />
                              <span className="text-xs" style={{
                                color: cs.status === 'prepared' ? 'var(--color-gold)' : 'var(--color-text-muted)'
                              }}>
                                {cs.status === 'prepared' ? 'Preparada' : 'Preparar'}
                              </span>
                            </label>
                          ) : (
                            <span className="shrink-0 text-xs" style={{ color: 'var(--color-text-muted)' }}>
                              {cs.status === 'prepared' ? 'Preparada' : 'Conhecida'}
                            </span>
                          )}
                        </div>
                        <button
                          onClick={e => { e.stopPropagation(); removeSpell(entry.id) }}
                          className="ml-2 shrink-0 rounded p-1"
                          style={{ color: 'var(--color-text-muted)' }}
                        >
                          <X size={14} />
                        </button>
                      </div>
                    )
                  })}
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Spell detail modal */}
      {selectedSpell && (
        <SpellDetail spell={selectedSpell} onClose={() => setSelectedSpell(null)} />
      )}

      {/* Spell picker modal */}
      {showPicker && (
        <div
          className="fixed inset-0 z-50 flex items-center justify-center p-4"
          style={{ background: 'rgba(0,0,0,0.75)' }}
          onClick={() => { setShowPicker(false); setPickerSearch('') }}
          onKeyDown={e => { if (e.key === 'Escape') { setShowPicker(false); setPickerSearch('') } }}
        >
          <div
            className="arcane-panel relative w-full max-w-lg overflow-hidden"
            style={{ maxHeight: '80vh' }}
            onClick={e => e.stopPropagation()}
          >
            <div className="border-b p-4" style={{ borderColor: 'var(--color-border-default)' }}>
              <h3 className="mb-2 text-lg" style={{ color: 'var(--color-text-primary)' }}>
                Adicionar Magia
              </h3>
              <input
                type="text"
                placeholder="Buscar magia…"
                value={pickerSearch}
                onChange={e => setPickerSearch(e.target.value)}
                autoFocus
                className="w-full rounded py-2 px-3 text-base outline-none"
                style={{
                  background: 'var(--color-bg-tertiary)',
                  border: '1px solid var(--color-border-default)',
                  color: 'var(--color-text-primary)',
                }}
              />
            </div>
            <div className="overflow-y-auto" style={{ maxHeight: 'calc(80vh - 120px)' }}>
              {pickerSpells.length === 0 ? (
                <p className="p-4 text-sm" style={{ color: 'var(--color-text-muted)' }}>
                  Nenhuma magia disponível.
                </p>
              ) : (
                pickerSpells.map(spell => {
                  const color = SCHOOL_COLORS[spell.school] ?? SCHOOL_COLORS.evocation
                  return (
                    <button
                      key={spell.id}
                      onClick={() => addSpell(spell)}
                      className="flex w-full items-center gap-3 p-3 text-left transition-opacity hover:opacity-80"
                      style={{ borderBottom: '1px solid var(--color-border-default)' }}
                    >
                      <span className="shrink-0 rounded px-1.5 py-0.5 text-xs leading-none"
                        style={{ background: color.bg, color: color.color, border: `1px solid ${color.border}` }}>
                        {spellLevelShort(spell.level)}
                      </span>
                      <span className="flex-1 text-base" style={{ color: 'var(--color-text-primary)' }}>
                        {spell.name}
                      </span>
                      <span className="text-xs" style={{ color: 'var(--color-text-muted)' }}>
                        {translateSchool(spell.school)}
                      </span>
                    </button>
                  )
                })
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
