'use client'

import { useState } from 'react'
import { Plus, LogIn, Copy, Check, Crown, User, BookOpen } from 'lucide-react'
import type { Adventure } from '@/types/adventure'
import { generateAdventureId, saveAdventure, getAdventures } from '@/lib/adventure'

interface AdventureHomeProps {
  adventures: Adventure[]
  playerId: string
  onSelect: (id: string) => void
  onAdventuresChange: (adventures: Adventure[]) => void
}

export default function AdventureHome({ adventures, playerId, onSelect, onAdventuresChange }: AdventureHomeProps) {
  const [newName, setNewName] = useState('')
  const [joinCode, setJoinCode] = useState('')
  const [joinError, setJoinError] = useState('')
  const [copiedId, setCopiedId] = useState<string | null>(null)

  function handleCreate() {
    const name = newName.trim()
    if (!name) return
    const adventure: Adventure = {
      id: generateAdventureId(),
      name,
      masterId: playerId,
      createdAt: new Date().toISOString(),
    }
    saveAdventure(adventure)
    onAdventuresChange(getAdventures())
    setNewName('')
    onSelect(adventure.id)
  }

  function handleJoin() {
    setJoinError('')
    const code = joinCode.trim().toUpperCase()
    if (!code) return

    const all = getAdventures()
    const found = all.find((a) => a.id === code)
    if (!found) {
      setJoinError('Código não encontrado. Verifique e tente novamente.')
      return
    }
    const alreadyIn = adventures.some((a) => a.id === code)
    if (!alreadyIn) {
      saveAdventure(found)
      onAdventuresChange(getAdventures())
    }
    setJoinCode('')
    onSelect(found.id)
  }

  function copyId(id: string) {
    navigator.clipboard.writeText(id)
    setCopiedId(id)
    setTimeout(() => setCopiedId(null), 1500)
  }

  return (
    <div className="mx-auto w-full max-w-2xl px-6 py-8">
      {/* Header */}
      <div className="mb-8">
        <div className="mb-1 flex items-center gap-2">
          <span className="rounded-md bg-amber-500/10 p-1">
            <BookOpen size={14} className="text-amber-400" />
          </span>
          <h1 className="text-2xl font-bold text-slate-100">Diário de Aventura</h1>
        </div>
        <p className="text-sm text-slate-500">Crie uma aventura ou entre com o código do Mestre.</p>
      </div>

      {/* Actions */}
      <div className="mb-8 grid gap-4 sm:grid-cols-2">
        {/* Create */}
        <div className="rounded-xl border border-slate-800 bg-slate-900/60 p-4">
          <p className="mb-3 text-xs font-semibold uppercase tracking-widest text-slate-500">Nova Aventura</p>
          <input
            value={newName}
            onChange={(e) => setNewName(e.target.value)}
            onKeyDown={(e) => { if (e.key === 'Enter') handleCreate() }}
            placeholder="Nome da aventura…"
            className="mb-3 w-full rounded-lg border border-slate-700 bg-slate-800/60 px-3 py-2 text-sm text-slate-200 placeholder:text-slate-600 focus:border-cyan-500/60 focus:outline-none"
          />
          <button
            onClick={handleCreate}
            disabled={!newName.trim()}
            className="flex w-full items-center justify-center gap-2 rounded-lg bg-gradient-to-r from-amber-600 to-orange-700 py-2 text-sm font-semibold text-white transition-all hover:from-amber-500 hover:to-orange-600 disabled:cursor-not-allowed disabled:opacity-50"
          >
            <Plus size={14} /> Criar como Mestre
          </button>
        </div>

        {/* Join */}
        <div className="rounded-xl border border-slate-800 bg-slate-900/60 p-4">
          <p className="mb-3 text-xs font-semibold uppercase tracking-widest text-slate-500">Entrar numa Aventura</p>
          <input
            value={joinCode}
            onChange={(e) => { setJoinCode(e.target.value); setJoinError('') }}
            onKeyDown={(e) => { if (e.key === 'Enter') handleJoin() }}
            placeholder="Código (ex: AB12CD)…"
            maxLength={6}
            className="mb-3 w-full rounded-lg border border-slate-700 bg-slate-800/60 px-3 py-2 font-mono text-sm uppercase tracking-widest text-slate-200 placeholder:normal-case placeholder:tracking-normal placeholder:text-slate-600 focus:border-cyan-500/60 focus:outline-none"
          />
          {joinError && <p className="mb-2 text-[11px] text-red-400">{joinError}</p>}
          <button
            onClick={handleJoin}
            disabled={!joinCode.trim()}
            className="flex w-full items-center justify-center gap-2 rounded-lg border border-slate-700 py-2 text-sm font-semibold text-slate-300 transition-all hover:border-slate-600 hover:bg-slate-800 disabled:cursor-not-allowed disabled:opacity-50"
          >
            <LogIn size={14} /> Entrar como Jogador
          </button>
        </div>
      </div>

      {/* Adventure list */}
      {adventures.length > 0 && (
        <div>
          <p className="mb-3 text-xs font-semibold uppercase tracking-widest text-slate-500">Suas Aventuras</p>
          <ul className="space-y-2">
            {adventures.map((adv) => {
              const isMaster = adv.masterId === playerId
              return (
                <li key={adv.id}>
                  <button
                    onClick={() => onSelect(adv.id)}
                    className="group flex w-full items-center gap-3 rounded-xl border border-slate-800 bg-slate-900/40 px-4 py-3 text-left transition-all hover:border-slate-700 hover:bg-slate-800/60"
                  >
                    <div className={`flex h-8 w-8 shrink-0 items-center justify-center rounded-lg ${isMaster ? 'bg-amber-500/10 text-amber-400' : 'bg-slate-700/50 text-slate-400'}`}>
                      {isMaster ? <Crown size={14} /> : <User size={14} />}
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="truncate text-sm font-medium text-slate-200 group-hover:text-slate-100">{adv.name}</p>
                      <p className="font-mono text-[11px] text-slate-600">{adv.id}</p>
                    </div>
                    <div className="flex items-center gap-2">
                      <span className={`rounded-full px-2 py-0.5 text-[10px] font-bold uppercase tracking-wide ${isMaster ? 'bg-amber-500/10 text-amber-500' : 'bg-slate-700 text-slate-400'}`}>
                        {isMaster ? 'Mestre' : 'Jogador'}
                      </span>
                      <button
                        onClick={(e) => { e.stopPropagation(); copyId(adv.id) }}
                        className="rounded-md p-1 text-slate-600 hover:bg-slate-700 hover:text-slate-300"
                        title="Copiar código"
                      >
                        {copiedId === adv.id ? <Check size={13} className="text-emerald-400" /> : <Copy size={13} />}
                      </button>
                    </div>
                  </button>
                </li>
              )
            })}
          </ul>
        </div>
      )}

      {adventures.length === 0 && (
        <div className="flex flex-col items-center justify-center gap-3 rounded-2xl border border-dashed border-slate-800 py-12 text-center">
          <BookOpen size={28} className="text-slate-700" />
          <p className="text-sm text-slate-600">Nenhuma aventura ainda.<br />Crie uma ou entre com um código.</p>
        </div>
      )}
    </div>
  )
}
