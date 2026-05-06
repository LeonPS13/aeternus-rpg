import { getPlayerId } from './adventure'
import type { ShieldData } from '@/types/master-shield'

function storageKey(): string {
  return `aeternus_shield_${getPlayerId()}`
}

function empty(): ShieldData {
  return { cards: Array(12).fill(null) }
}

export function loadShield(): ShieldData {
  try {
    const raw = localStorage.getItem(storageKey())
    if (raw) return JSON.parse(raw)
  } catch {}
  return empty()
}

export function saveShield(data: ShieldData): void {
  localStorage.setItem(storageKey(), JSON.stringify(data))
}
