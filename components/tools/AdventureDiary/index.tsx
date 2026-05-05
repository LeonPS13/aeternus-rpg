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
    getAdventures(id).then(setAdventures)
  }, [])

  useEffect(() => {
    if (selectedId) {
      getEntries(selectedId).then(setEntries)
    }
  }, [selectedId])

  async function handleSelect(id: string) {
    setSelectedId(id)
    const data = await getEntries(id)
    setEntries(data)
  }

  async function handleSaveEntry(entry: DiaryEntry) {
    await saveEntry(entry)
    if (selectedId) setEntries(await getEntries(selectedId))
  }

  async function handleDeleteEntry(id: string) {
    await deleteEntry(id)
    if (selectedId) setEntries(await getEntries(selectedId))
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
