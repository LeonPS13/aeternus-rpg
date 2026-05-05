'use client'

import { useState } from 'react'
import { Plus, LogIn, Copy, Check, Crown, User, BookOpen, Trash2, LogOut } from 'lucide-react'
import type { Adventure } from '@/types/adventure'
import { generateAdventureId, saveAdventure, getAdventures, findAdventure, deleteAdventure, leaveAdventure } from '@/lib/adventure'

interface AdventureHomeProps {
  adventures: Adventure[]
  playerId: string
  onSelect: (id: string) => void
  onAdventuresChange: (adventures: Adventure[]) => void
}

export default function AdventureHome({ adventures, playerId, onSelect, onAdventuresChange }: AdventureHomeProps) {
  const [newName, setNewName]     = useState('')
  const [joinCode, setJoinCode]   = useState('')
  const [joinError, setJoinError] = useState('')
  const [copiedId, setCopiedId]   = useState<string | null>(null)
  const [confirmId, setConfirmId] = useState<string | null>(null)
  const [isCreating, setIsCreating] = useState(false)
  const [isJoining, setIsJoining]   = useState(false)
  const [deletingId, setDeletingId] = useState<string | null>(null)

  async function handleCreate() {
    const name = newName.trim()
    if (!name || isCreating) return
    setIsCreating(true)
    const adventure: Adventure = { id: generateAdventureId(), name, masterId: playerId, createdAt: new Date().toISOString() }
    await saveAdventure(adventure, playerId)
    onAdventuresChange(await getAdventures(playerId))
    setNewName(''); setIsCreating(false); onSelect(adventure.id)
  }

  async function handleJoin() {
    setJoinError('')
    const code = joinCode.trim().toUpperCase()
    if (!code || isJoining) return
    setIsJoining(true)
    const found = await findAdventure(code)
    if (!found) { setJoinError('Código não encontrado. Verifique e tente novamente.'); setIsJoining(false); return }
    await saveAdventure(found, playerId)
    onAdventuresChange(await getAdventures(playerId))
    setJoinCode(''); setIsJoining(false); onSelect(found.id)
  }

  async function handleRemove(adv: Adventure) {
    setDeletingId(adv.id)
    if (adv.masterId === playerId) await deleteAdventure(adv.id)
    else await leaveAdventure(adv.id, playerId)
    onAdventuresChange(await getAdventures(playerId))
    setConfirmId(null); setDeletingId(null)
  }

  function copyId(id: string) {
    navigator.clipboard.writeText(id)
    setCopiedId(id)
    setTimeout(() => setCopiedId(null), 1500)
  }

  const inputStyle = {
    background: 'var(--color-bg-tertiary)',
    border: '1px solid var(--color-border-default)',
    color: 'var(--color-text-primary)',
    borderRadius: '4px',
  }

  return (
    <div className="mx-auto w-full max-w-2xl px-6 py-8">
      {/* Header */}
      <div className="mb-8">
        <div className="mb-1 flex items-center gap-2">
          <span className="rounded p-1" style={{ background: 'var(--color-gold-glow)' }}>
            <BookOpen size={14} style={{ color: 'var(--color-gold)' }} />
          </span>
          <h1 className="text-3xl" style={{ color: 'var(--color-text-primary)' }}>Diário de Aventura</h1>
        </div>
        <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Crie uma aventura ou entre com o código do Mestre.</p>
      </div>

      {/* Actions */}
      <div className="mb-8 grid gap-4 sm:grid-cols-2">
        {/* Create */}
        <div className="arcane-panel p-4">
          <p className="section-label mb-3">· Nova Aventura ·</p>
          <input
            value={newName}
            onChange={(e) => setNewName(e.target.value)}
            onKeyDown={(e) => { if (e.key === 'Enter') handleCreate() }}
            placeholder="Nome da aventura…"
            className="mb-3 w-full px-3 py-2 text-sm outline-none"
            style={{ ...inputStyle, caretColor: 'var(--color-gold)' }}
          />
          <button onClick={handleCreate} disabled={!newName.trim() || isCreating}
            className="arcane-btn flex w-full items-center justify-center gap-2 py-2 text-sm font-semibold">
            {isCreating ? <span className="animate-pulse">Criando…</span> : <><Plus size={14} /> Criar como Mestre</>}
          </button>
        </div>

        {/* Join */}
        <div className="arcane-panel p-4">
          <p className="section-label mb-3">· Entrar numa Aventura ·</p>
          <input
            value={joinCode}
            onChange={(e) => { setJoinCode(e.target.value); setJoinError('') }}
            onKeyDown={(e) => { if (e.key === 'Enter') handleJoin() }}
            placeholder="Código (ex: AB12CD)…"
            maxLength={6}
            className="mb-3 w-full px-3 py-2 font-mono text-sm uppercase tracking-widest outline-none"
            style={{ ...inputStyle, caretColor: 'var(--color-gold)' }}
          />
          {joinError && <p className="mb-2 text-[11px] text-red-400">{joinError}</p>}
          <button onClick={handleJoin} disabled={!joinCode.trim() || isJoining}
            className="flex w-full items-center justify-center gap-2 rounded py-2 text-sm font-semibold transition-all disabled:cursor-not-allowed disabled:opacity-50"
            style={{ border: '1px solid var(--color-border-default)', color: 'var(--color-text-secondary)' }}>
            {isJoining ? <span className="animate-pulse">Verificando…</span> : <><LogIn size={14} /> Entrar como Jogador</>}
          </button>
        </div>
      </div>

      {/* Adventure list */}
      {adventures.length > 0 && (
        <div>
          <p className="section-label mb-3">· Suas Aventuras ·</p>
          <ul className="space-y-2">
            {adventures.map((adv) => {
              const isMaster = adv.masterId === playerId
              const isConfirming = confirmId === adv.id
              const isDeleting = deletingId === adv.id
              return (
                <li key={adv.id}>
                  <div className="group flex w-full items-center gap-3 rounded px-4 py-3 transition-all"
                    style={{ border: '1px solid var(--color-border-default)', background: 'var(--color-bg-secondary)' }}>
                    <div className="flex h-8 w-8 shrink-0 items-center justify-center rounded"
                      style={{ background: 'var(--color-gold-glow)', color: 'var(--color-gold)' }}>
                      {isMaster ? <Crown size={14} /> : <User size={14} />}
                    </div>

                    <button onClick={() => onSelect(adv.id)} className="flex-1 min-w-0 text-left">
                      <p className="truncate text-sm font-medium" style={{ color: 'var(--color-text-primary)' }}>{adv.name}</p>
                      <p className="font-mono text-[11px]" style={{ color: 'var(--color-text-muted)' }}>{adv.id}</p>
                    </button>

                    <div className="flex items-center gap-1.5">
                      <span className="rounded px-2 py-0.5 text-[10px] font-bold uppercase tracking-wide"
                        style={{ border: '1px solid var(--color-border-default)', color: 'var(--color-gold-dark)', background: 'var(--color-gold-glow)' }}>
                        {isMaster ? 'Mestre' : 'Jogador'}
                      </span>
                      <button onClick={(e) => { e.stopPropagation(); copyId(adv.id) }}
                        className="rounded p-1 transition-colors"
                        style={{ color: 'var(--color-text-muted)' }}
                        title="Copiar código">
                        {copiedId === adv.id
                          ? <Check size={13} style={{ color: 'var(--color-gold)' }} />
                          : <Copy size={13} />}
                      </button>
                      {isConfirming ? (
                        <div className="flex items-center gap-1">
                          <span className="text-[11px]" style={{ color: 'var(--color-text-muted)' }}>
                            {isMaster ? 'Excluir?' : 'Sair?'}
                          </span>
                          <button onClick={() => handleRemove(adv)} disabled={isDeleting}
                            className="rounded p-1 disabled:opacity-50"
                            style={{ color: '#f87171' }}>
                            <Check size={13} />
                          </button>
                          <button onClick={() => setConfirmId(null)}
                            className="rounded p-1 text-xs font-bold"
                            style={{ color: 'var(--color-text-muted)' }}>✕</button>
                        </div>
                      ) : (
                        <button
                          onClick={(e) => { e.stopPropagation(); setConfirmId(adv.id) }}
                          className="rounded p-1 opacity-0 transition-all group-hover:opacity-100"
                          style={{ color: 'var(--color-text-muted)' }}
                          title={isMaster ? 'Excluir aventura' : 'Sair da aventura'}>
                          {isMaster ? <Trash2 size={13} /> : <LogOut size={13} />}
                        </button>
                      )}
                    </div>
                  </div>
                </li>
              )
            })}
          </ul>
        </div>
      )}

      {adventures.length === 0 && (
        <div className="flex flex-col items-center justify-center gap-3 rounded border border-dashed py-12 text-center"
          style={{ borderColor: 'var(--color-border-default)' }}>
          <BookOpen size={28} style={{ color: 'var(--color-text-muted)' }} />
          <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
            Nenhuma aventura ainda.<br />Crie uma ou entre com um código.
          </p>
        </div>
      )}
    </div>
  )
}
