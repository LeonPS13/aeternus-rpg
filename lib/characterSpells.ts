import { getSupabase } from './supabase'
import type { CharacterSpell } from '@/types/class'

export async function getCharacterSpells(characterId: string): Promise<CharacterSpell[]> {
  const { data } = await getSupabase()
    .from('character_spells')
    .select('spells')
    .eq('character_id', characterId)
    .single()
  if (!data) return []
  return (data as { spells: CharacterSpell[] }).spells ?? []
}

export async function saveCharacterSpells(
  characterId: string,
  spells: CharacterSpell[],
): Promise<void> {
  await getSupabase()
    .from('character_spells')
    .upsert({ character_id: characterId, spells, updated_at: new Date().toISOString() })
}
