'use client'

import { useState, useMemo } from 'react'
import { ArrowLeft, Copy, Check, Plus, BookOpen, User, Crown, ShieldAlert, Pencil } from 'lucide-react'
import type { Adventure, DiaryEntry, ActiveTab } from '@/types/adventure'
import SearchBar from './SearchBar'
import EntryCard from './EntryCard'
import NewEntryModal from './NewEntryModal'
import EditAdventureModal from './EditAdventureModal'
import { getAdventureIcon } from './adventureIcons'

interface AdventureViewProps {
  adventure: Adventure
  entries: DiaryEntry[]
  playerId: string
  onBack: () => void
  onSaveEntry: (entry: DiaryEntry) => void
  onDeleteEntry: (id: string) => void
  onEditAdventure: (updated: Adventure) => void
}

export default function AdventureView({ adventure, entries, playerId, onBack, onSaveEntry, onDeleteEntry, onEditAdventure }: AdventureViewProps) {
  const [activeTab, setActiveTab]       = useState<ActiveTab>('adventure')
  const [searchQuery, setSearchQuery]   = useState('')
  const [editingEntry, setEditingEntry] = useState<DiaryEntry | null>(null)
  const [modalOpen, setModalOpen]       = useState(false)
  const [editOpen, setEditOpen]         = useState(false)
  const [copiedId, setCopiedId]         = useState(false)

  const AdventureIcon = getAdventureIcon(adventure.icon)

  const isMaster = adventure.masterId === playerId

  const filtered = useMemo(() => {
    const q = searchQuery.toLowerCase()
    return entries
      .filter((e) => activeTab === 'adventure' ? e.diaryType === 'adventure' : e.diaryType === 'personal' && e.authorId === playerId)
      .filter((e) => !q || e.title.toLowerCase().includes(q) || e.summary.toLowerCase().includes(q) || e.tags.some((t) => t.includes(q)))
      .sort((a, b) => b.date.localeCompare(a.date))
  }, [entries, activeTab, playerId, searchQuery])

  function copyCode() {
    navigator.clipboard.writeText(adventure.id)
    setCopiedId(true)
    setTimeout(() => setCopiedId(false), 1500)
  }

  const canWrite = activeTab === 'personal' || isMaster

  return (
    <div className="mx-auto w-full max-w-2xl px-6 py-8">
      {/* Header */}
      <div className="mb-6">
        <button onClick={onBack}
          className="mb-4 flex items-center gap-1.5 text-xs transition-colors"
          style={{ color: 'var(--color-text-muted)' }}>
          <ArrowLeft size={13} /> Voltar às aventuras
        </button>
        <div className="flex items-start justify-between gap-3">
          <div>
            <div className="flex items-center gap-2">
              <div className="flex h-8 w-8 shrink-0 items-center justify-center rounded"
                style={{ background: 'var(--color-gold-glow)', color: 'var(--color-gold)' }}>
                <AdventureIcon size={16} />
              </div>
              <h1 className="text-2xl" style={{ color: 'var(--color-text-primary)' }}>{adventure.name}</h1>
              {isMaster && (
                <button onClick={() => setEditOpen(true)} className="rounded p-1 transition-colors" style={{ color: 'var(--color-text-muted)' }} title="Editar aventura">
                  <Pencil size={13} />
                </button>
              )}
            </div>
            <div className="mt-1 flex items-center gap-2">
              <span className="font-mono text-xs" style={{ color: 'var(--color-text-muted)' }}>Código: {adventure.id}</span>
              <button onClick={copyCode} style={{ color: 'var(--color-text-muted)' }} title="Copiar código">
                {copiedId
                  ? <Check size={12} style={{ color: 'var(--color-gold)' }} />
                  : <Copy size={12} />}
              </button>
              <span className="rounded px-2 py-0.5 text-xs font-bold tracking-wide"
                style={{ border: '1px solid var(--color-border-default)', color: 'var(--color-gold-dark)', background: 'var(--color-gold-glow)' }}>
                {isMaster ? <><Crown size={9} className="inline mr-0.5" />Mestre</> : <><User size={9} className="inline mr-0.5" />Jogador</>}
              </span>
            </div>
          </div>
          {canWrite && (
            <button
              onClick={() => { setEditingEntry(null); setModalOpen(true) }}
              className="arcane-btn flex shrink-0 items-center gap-1.5 px-4 py-2 text-sm font-semibold">
              <Plus size={14} /> Nova Sessão
            </button>
          )}
        </div>
      </div>

      {/* Tabs */}
      <div className="mb-5 flex gap-1 rounded p-1"
        style={{ border: '1px solid var(--color-border-default)', background: 'var(--color-bg-secondary)' }}>
        {(['adventure', 'personal'] as ActiveTab[]).map((tab) => {
          const isActive = activeTab === tab
          return (
            <button
              key={tab}
              onClick={() => setActiveTab(tab)}
              className="flex flex-1 items-center justify-center gap-2 rounded py-2 text-sm font-medium transition-all"
              style={isActive ? {
                background: 'var(--color-bg-tertiary)',
                color: 'var(--color-gold-light)',
                border: '1px solid var(--color-border-default)',
              } : {
                color: 'var(--color-text-muted)',
              }}
            >
              {tab === 'adventure' ? <><BookOpen size={14} /> Diário da Aventura</> : <><User size={14} /> Meu Diário</>}
            </button>
          )
        })}
      </div>

      {/* Read-only banner */}
      {activeTab === 'adventure' && !isMaster && (
        <div className="mb-4 flex items-center gap-2.5 rounded px-4 py-3"
          style={{ border: '1px solid rgba(201,168,76,0.2)', background: 'rgba(201,168,76,0.04)' }}>
          <ShieldAlert size={14} className="shrink-0" style={{ color: 'var(--color-gold)' }} />
          <p className="text-xs" style={{ color: 'var(--color-text-secondary)' }}>
            Apenas o Mestre pode escrever no Diário da Aventura.
          </p>
        </div>
      )}

      {/* Search */}
      {filtered.length > 0 || searchQuery ? (
        <div className="mb-4"><SearchBar value={searchQuery} onChange={setSearchQuery} /></div>
      ) : null}

      {/* Entries */}
      {filtered.length > 0 ? (
        <ul className="space-y-3">
          {filtered.map((entry) => (
            <li key={entry.id}>
              <EntryCard
                entry={entry}
                canEdit={entry.authorId === playerId}
                searchQuery={searchQuery}
                onDelete={onDeleteEntry}
                onEdit={(e) => { setEditingEntry(e); setModalOpen(true) }}
              />
            </li>
          ))}
        </ul>
      ) : (
        <div className="flex flex-col items-center justify-center gap-3 rounded border border-dashed py-12 text-center"
          style={{ borderColor: 'var(--color-border-default)' }}>
          <BookOpen size={24} style={{ color: 'var(--color-text-muted)' }} />
          <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
            {searchQuery
              ? 'Nenhuma entrada corresponde à busca.'
              : activeTab === 'adventure'
                ? 'O Mestre ainda não registrou nenhuma sessão.'
                : 'Você ainda não criou anotações nessa aventura.'}
          </p>
          {canWrite && !searchQuery && (
            <button onClick={() => { setEditingEntry(null); setModalOpen(true) }}
              className="mt-1 text-xs transition-colors"
              style={{ color: 'var(--color-gold-dark)' }}>
              Criar primeira entrada →
            </button>
          )}
        </div>
      )}

      {editOpen && (
        <EditAdventureModal
          adventure={adventure}
          onSave={(updated) => { onEditAdventure(updated); setEditOpen(false) }}
          onClose={() => setEditOpen(false)}
        />
      )}

      {modalOpen && (
        <NewEntryModal
          adventureId={adventure.id}
          authorId={playerId}
          diaryType={activeTab}
          initialEntry={editingEntry ?? undefined}
          onSave={(entry) => { onSaveEntry(entry); setModalOpen(false); setEditingEntry(null) }}
          onClose={() => { setModalOpen(false); setEditingEntry(null) }}
        />
      )}
    </div>
  )
}
