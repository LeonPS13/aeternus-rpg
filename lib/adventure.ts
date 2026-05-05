import type { Adventure, DiaryEntry } from '@/types/adventure'

const KEYS = {
  playerId: 'aeternus_player_id',
  adventures: 'aeternus_adventures',
  entries: 'aeternus_entries',
} as const

export function generateAdventureId(): string {
  const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'
  const arr = new Uint8Array(6)
  crypto.getRandomValues(arr)
  return Array.from(arr, (b) => chars[b % chars.length]).join('')
}

export function getPlayerId(): string {
  let id = localStorage.getItem(KEYS.playerId)
  if (!id) {
    id = crypto.randomUUID()
    localStorage.setItem(KEYS.playerId, id)
  }
  return id
}

export function getAdventures(): Adventure[] {
  try {
    return JSON.parse(localStorage.getItem(KEYS.adventures) ?? '[]')
  } catch {
    return []
  }
}

export function saveAdventure(adventure: Adventure): void {
  const all = getAdventures()
  const idx = all.findIndex((a) => a.id === adventure.id)
  if (idx >= 0) {
    all[idx] = adventure
  } else {
    all.push(adventure)
  }
  localStorage.setItem(KEYS.adventures, JSON.stringify(all))
}

export function getAllEntries(): DiaryEntry[] {
  try {
    return JSON.parse(localStorage.getItem(KEYS.entries) ?? '[]')
  } catch {
    return []
  }
}

export function getEntries(adventureId: string): DiaryEntry[] {
  return getAllEntries().filter((e) => e.adventureId === adventureId)
}

export function saveEntry(entry: DiaryEntry): void {
  const all = getAllEntries()
  const idx = all.findIndex((e) => e.id === entry.id)
  if (idx >= 0) {
    all[idx] = entry
  } else {
    all.push(entry)
  }
  localStorage.setItem(KEYS.entries, JSON.stringify(all))
}

export function deleteEntry(id: string): void {
  const all = getAllEntries().filter((e) => e.id !== id)
  localStorage.setItem(KEYS.entries, JSON.stringify(all))
}
