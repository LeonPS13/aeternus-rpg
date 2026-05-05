'use client'

import { useState, useMemo } from 'react'
import { ArrowLeft, Copy, Check, Plus, BookOpen, User, Crown, ShieldAlert } from 'lucide-react'
import type { Adventure, DiaryEntry, ActiveTab } from '@/types/adventure'
import SearchBar from './SearchBar'
import EntryCard from './EntryCard'
import NewEntryModal from './NewEntryModal'

interface AdventureViewProps {
  adventure: Adventure
  entries: DiaryEntry[]
  playerId: string
  onBack: () => void
  onSaveEntry: (entry: DiaryEntry) => void
  onDeleteEntry: (id: string) => void
}

export default function AdventureView({
  adventure,
  entries,
  playerId,
  onBack,
  onSaveEntry,
  onDeleteEntry,
}: AdventureViewProps) {
  const [activeTab, setActiveTab] = useState<ActiveTab>('adventure')
  const [searchQuery, setSearchQuery] = useState('')
  const [editingEntry, setEditingEntry] = useState<DiaryEntry | null>(null)
  const [modalOpen, setModalOpen] = useState(false)
  const [copiedId, setCopiedId] = useState(false)

  const isMaster = adventure.masterId === playerId

  const filtered = useMemo(() => {
    const q = searchQuery.toLowerCase()
    return entries
      .filter((e) => {
        if (activeTab === 'adventure') return e.diaryType === 'adventure'
        return e.diaryType === 'personal' && e.authorId === playerId
      })
      .filter((e) => {
        if (!q) return true
        return (
          e.title.toLowerCase().includes(q) ||
          e.summary.toLowerCase().includes(q) ||
          e.tags.some((t) => t.includes(q))
        )
      })
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
        <button
          onClick={onBack}
          className="mb-4 flex items-center gap-1.5 text-xs text-slate-500 hover:text-slate-300"
        >
          <ArrowLeft size={13} /> Voltar às aventuras
        </button>
        <div className="flex items-start justify-between gap-3">
          <div>
            <h1 className="text-xl font-bold text-slate-100">{adventure.name}</h1>
            <div className="mt-1 flex items-center gap-2">
              <span className="font-mono text-xs text-slate-500">Código: {adventure.id}</span>
              <button onClick={copyCode} className="text-slate-600 hover:text-slate-300" title="Copiar código">
                {copiedId ? <Check size={12} className="text-emerald-400" /> : <Copy size={12} />}
              </button>
              <span className={`rounded-full px-2 py-0.5 text-[10px] font-bold uppercase tracking-wide ${isMaster ? 'bg-amber-500/10 text-amber-500' : 'bg-slate-700 text-slate-400'}`}>
                {isMaster ? <><Crown size={9} className="inline mr-0.5" />Mestre</> : <><User size={9} className="inline mr-0.5" />Jogador</>}
              </span>
            </div>
          </div>
          {canWrite && (
            <button
              onClick={() => { setEditingEntry(null); setModalOpen(true) }}
              className="flex shrink-0 items-center gap-1.5 rounded-lg bg-gradient-to-r from-amber-600 to-orange-700 px-4 py-2 text-sm font-semibold text-white shadow-md shadow-amber-600/25 transition-all hover:from-amber-500 hover:to-orange-600"
            >
              <Plus size={14} /> Nova Sessão
            </button>
          )}
        </div>
      </div>

      {/* Tabs */}
      <div className="mb-5 flex gap-1 rounded-xl border border-slate-800 bg-slate-900/60 p-1">
        <button
          onClick={() => setActiveTab('adventure')}
          className={`flex flex-1 items-center justify-center gap-2 rounded-lg py-2 text-sm font-medium transition-all ${
            activeTab === 'adventure'
              ? 'bg-slate-800 text-slate-100 shadow-sm'
              : 'text-slate-500 hover:text-slate-300'
          }`}
        >
          <BookOpen size={14} /> Diário da Aventura
        </button>
        <button
          onClick={() => setActiveTab('personal')}
          className={`flex flex-1 items-center justify-center gap-2 rounded-lg py-2 text-sm font-medium transition-all ${
            activeTab === 'personal'
              ? 'bg-slate-800 text-slate-100 shadow-sm'
              : 'text-slate-500 hover:text-slate-300'
          }`}
        >
          <User size={14} /> Meu Diário
        </button>
      </div>

      {/* Read-only banner for non-masters on adventure tab */}
      {activeTab === 'adventure' && !isMaster && (
        <div className="mb-4 flex items-center gap-2.5 rounded-xl border border-amber-500/20 bg-amber-500/5 px-4 py-3">
          <ShieldAlert size={14} className="shrink-0 text-amber-500" />
          <p className="text-xs text-amber-400/80">
            Apenas o Mestre pode escrever no Diário da Aventura.
          </p>
        </div>
      )}

      {/* Search */}
      {filtered.length > 0 || searchQuery ? (
        <div className="mb-4">
          <SearchBar value={searchQuery} onChange={setSearchQuery} />
        </div>
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
        <div className="flex flex-col items-center justify-center gap-3 rounded-2xl border border-dashed border-slate-800 py-12 text-center">
          <BookOpen size={24} className="text-slate-700" />
          <p className="text-sm text-slate-600">
            {searchQuery
              ? 'Nenhuma entrada corresponde à busca.'
              : activeTab === 'adventure'
                ? 'O Mestre ainda não registrou nenhuma sessão.'
                : 'Você ainda não criou anotações nessa aventura.'}
          </p>
          {canWrite && !searchQuery && (
            <button
              onClick={() => { setEditingEntry(null); setModalOpen(true) }}
              className="mt-1 text-xs text-cyan-500 hover:text-cyan-300"
            >
              Criar primeira entrada →
            </button>
          )}
        </div>
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
