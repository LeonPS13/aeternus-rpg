'use client'

import { useState, useEffect } from 'react'
import type { Adventure, DiaryEntry } from '@/types/adventure'
import {
  getPlayerId,
  getAdventures,
  getEntries,
  saveEntry,
  deleteEntry,
} from '@/lib/adventure'
import AdventureHome from './AdventureHome'
import AdventureView from './AdventureView'

export default function AdventureDiary() {
  const [playerId, setPlayerId] = useState('')
  const [adventures, setAdventures] = useState<Adventure[]>([])
  const [entries, setEntries] = useState<DiaryEntry[]>([])
  const [selectedId, setSelectedId] = useState<string | null>(null)

  useEffect(() => {
    const id = getPlayerId()
    setPlayerId(id)
    setAdventures(getAdventures())
  }, [])

  useEffect(() => {
    if (selectedId) {
      setEntries(getEntries(selectedId))
    }
  }, [selectedId])

  function handleSelect(id: string) {
    setSelectedId(id)
    setEntries(getEntries(id))
  }

  function handleSaveEntry(entry: DiaryEntry) {
    saveEntry(entry)
    if (selectedId) setEntries(getEntries(selectedId))
  }

  function handleDeleteEntry(id: string) {
    deleteEntry(id)
    if (selectedId) setEntries(getEntries(selectedId))
  }

  const selectedAdventure = adventures.find((a) => a.id === selectedId) ?? null

  if (!playerId) return null

  if (selectedAdventure) {
    return (
      <AdventureView
        adventure={selectedAdventure}
        entries={entries}
        playerId={playerId}
        onBack={() => setSelectedId(null)}
        onSaveEntry={handleSaveEntry}
        onDeleteEntry={handleDeleteEntry}
      />
    )
  }

  return (
    <AdventureHome
      adventures={adventures}
      playerId={playerId}
      onSelect={handleSelect}
      onAdventuresChange={setAdventures}
    />
  )
}
