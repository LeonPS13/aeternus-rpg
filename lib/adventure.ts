import { getSupabase } from './supabase'
import type { Adventure, DiaryEntry } from '@/types/adventure'

type AdventureRow = {
  id: string
  name: string
  master_id: string
  created_at: string
  icon: string | null
}

type MembershipRow = {
  adventures: AdventureRow | null
}

type DiaryEntryRow = {
  id: string
  adventure_id: string
  date: string
  title: string
  summary: string
  tags: string[] | null
  author_id: string
  diary_type: 'adventure' | 'personal'
  created_at: string
  updated_at: string
}

const PLAYER_KEY = 'aeternus_player_id'

export function generateAdventureId(): string {
  const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'
  const arr = new Uint8Array(6)
  crypto.getRandomValues(arr)
  return Array.from(arr, (b) => chars[b % chars.length]).join('')
}

export function getPlayerId(): string {
  let id = localStorage.getItem(PLAYER_KEY)
  if (!id) {
    id = crypto.randomUUID()
    localStorage.setItem(PLAYER_KEY, id)
  }
  return id
}

export async function getAdventures(playerId: string): Promise<Adventure[]> {
  const { data, error } = await getSupabase()
    .from('adventure_memberships')
    .select('adventures(id, name, master_id, created_at, icon)')
    .eq('player_id', playerId)

  if (error || !data) return []

  return (data as unknown as MembershipRow[])
    .map((m) => m.adventures)
    .filter((a): a is AdventureRow => a !== null)
    .map((a) => ({
      id: a.id,
      name: a.name,
      masterId: a.master_id,
      createdAt: a.created_at,
      icon: a.icon ?? 'BookOpen',
    }))
}

export async function findAdventure(id: string): Promise<Adventure | null> {
  const { data, error } = await getSupabase()
    .from('adventures')
    .select('id, name, master_id, created_at, icon')
    .eq('id', id)
    .single()

  if (error || !data) return null

  return {
    id: data.id,
    name: data.name,
    masterId: data.master_id,
    createdAt: data.created_at,
    icon: data.icon ?? 'BookOpen',
  }
}

export async function saveAdventure(adventure: Adventure, playerId: string): Promise<void> {
  const { error } = await getSupabase().from('adventures').upsert({
    id: adventure.id,
    name: adventure.name,
    master_id: adventure.masterId,
    created_at: adventure.createdAt,
    icon: adventure.icon ?? 'BookOpen',
  })

  if (error) {
    await getSupabase().from('adventures').upsert({
      id: adventure.id,
      name: adventure.name,
      master_id: adventure.masterId,
      created_at: adventure.createdAt,
    })
  }

  await getSupabase().from('adventure_memberships').upsert({
    adventure_id: adventure.id,
    player_id: playerId,
  })
}

export async function getEntries(adventureId: string): Promise<DiaryEntry[]> {
  const { data, error } = await getSupabase()
    .from('diary_entries')
    .select('*')
    .eq('adventure_id', adventureId)
    .order('date', { ascending: false })

  if (error || !data) return []

  return data.map((e: DiaryEntryRow) => ({
    id: e.id,
    adventureId: e.adventure_id,
    date: e.date,
    title: e.title,
    summary: e.summary,
    tags: e.tags ?? [],
    authorId: e.author_id,
    diaryType: e.diary_type,
    createdAt: e.created_at,
    updatedAt: e.updated_at,
  }))
}

export async function saveEntry(entry: DiaryEntry): Promise<void> {
  await getSupabase().from('diary_entries').upsert({
    id: entry.id,
    adventure_id: entry.adventureId,
    date: entry.date,
    title: entry.title,
    summary: entry.summary,
    tags: entry.tags,
    author_id: entry.authorId,
    diary_type: entry.diaryType,
    created_at: entry.createdAt,
    updated_at: entry.updatedAt,
  })
}

export async function updateAdventure(id: string, name: string, icon: string): Promise<void> {
  const { error } = await getSupabase().from('adventures').update({ name, icon }).eq('id', id)
  if (error) {
    await getSupabase().from('adventures').update({ name }).eq('id', id)
  }
}

export async function deleteEntry(id: string): Promise<void> {
  await getSupabase().from('diary_entries').delete().eq('id', id)
}

export async function deleteAdventure(adventureId: string): Promise<void> {
  await getSupabase().from('adventures').delete().eq('id', adventureId)
}

export async function leaveAdventure(adventureId: string, playerId: string): Promise<void> {
  await getSupabase()
    .from('adventure_memberships')
    .delete()
    .eq('adventure_id', adventureId)
    .eq('player_id', playerId)
}
