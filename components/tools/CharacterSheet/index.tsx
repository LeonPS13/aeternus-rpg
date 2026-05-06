'use client'

import { useState, useEffect, useCallback, useRef } from 'react'
import type { Character } from '@/types/character'
import { getCharacters, saveCharacter, deleteCharacter, createEmptyCharacter } from '@/lib/character'
import { getPlayerId } from '@/lib/adventure'
import CharacterList from './CharacterList'
import WizardView from './WizardView'
import CharacterView from './CharacterView'
import SheetView from './SheetView'

type Mode = 'list' | 'create' | 'view' | 'edit'

export default function CharacterSheet() {
  const [playerId, setPlayerId] = useState('')
  const [characters, setCharacters] = useState<Character[]>([])
  const [mode, setMode] = useState<Mode>('list')
  const [active, setActive] = useState<Character | null>(null)
  const [draft, setDraft] = useState<Character | null>(null)
  const isDirty = useRef(false)

  useEffect(() => {
    const id = getPlayerId()
    setPlayerId(id)
    getCharacters(id).then(setCharacters)
  }, [])

  // Auto-save: fires whenever `active` changes AND the change came from user interaction
  useEffect(() => {
    if (!isDirty.current || !active) return
    const id = setTimeout(async () => {
      await saveCharacter(active)
      isDirty.current = false
      setCharacters((prev) => prev.map((c) => (c.id === active.id ? active : c)))
    }, 1500)
    return () => clearTimeout(id)
  }, [active])

  const handleChange = useCallback((updates: Partial<Character>) => {
    isDirty.current = true
    setActive((prev) => {
      if (!prev) return prev
      return { ...prev, ...updates, updatedAt: new Date().toISOString() }
    })
  }, [])

  function handleStartCreate() {
    if (!playerId) return
    setDraft(createEmptyCharacter(playerId))
    setMode('create')
  }

  async function handleSaveCreate(char: Character) {
    await saveCharacter(char)
    setCharacters(await getCharacters(playerId))
    setDraft(null)
    setMode('list')
  }

  function handleCancelCreate() {
    setDraft(null)
    setMode('list')
  }

  function handleSelectChar(char: Character) {
    isDirty.current = false
    setActive(char)
    setMode('view')
  }

  async function handleBackFromView() {
    if (isDirty.current && active) {
      isDirty.current = false
      await saveCharacter(active)
      setCharacters((prev) => prev.map((c) => (c.id === active.id ? active : c)))
    }
    setActive(null)
    setMode('list')
  }

  function handleStartEdit() {
    setMode('edit')
  }

  async function handleSaveEdit() {
    if (!active) return
    isDirty.current = false
    const toSave = { ...active, updatedAt: new Date().toISOString() }
    await saveCharacter(toSave)
    setActive(toSave)
    setCharacters((prev) => prev.map((c) => (c.id === toSave.id ? toSave : c)))
    setMode('view')
  }

  async function handleDelete(id: string) {
    isDirty.current = false
    await deleteCharacter(id)
    setCharacters(await getCharacters(playerId))
    setActive(null)
    setMode('list')
  }

  if (!playerId) return null

  if (mode === 'create' && draft) {
    return (
      <WizardView
        draft={draft}
        onDraftChange={(u: Partial<Character>) => setDraft((prev) => prev ? { ...prev, ...u } : prev)}
        onSave={handleSaveCreate}
        onCancel={handleCancelCreate}
      />
    )
  }

  if (mode === 'view' && active) {
    return (
      <CharacterView
        char={active}
        onChange={handleChange}
        onBack={handleBackFromView}
        onEdit={handleStartEdit}
        onDelete={() => handleDelete(active.id)}
      />
    )
  }

  if (mode === 'edit' && active) {
    return (
      <SheetView
        char={active}
        onChange={handleChange}
        onSave={handleSaveEdit}
        onBack={() => setMode('view')}
        onDelete={() => handleDelete(active.id)}
      />
    )
  }

  return (
    <CharacterList
      characters={characters}
      onSelect={handleSelectChar}
      onCreate={handleStartCreate}
      onDelete={handleDelete}
    />
  )
}
