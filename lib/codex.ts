import { getSupabase } from './supabase'
import type { CodexEntry } from '@/types/codex'

function fromRow(r: any): CodexEntry {
  return {
    id: r.id,
    name: r.name,
    type: r.type,
    subtype: r.subtype ?? null,
    description: r.description ?? null,
    data: r.data ?? {},
    source: r.source ?? 'srd',
    playerId: r.player_id ?? null,
    createdAt: r.created_at,
    updatedAt: r.updated_at,
  }
}

export async function getCodexEntries(): Promise<CodexEntry[]> {
  const { data, error } = await getSupabase()
    .from('codex')
    .select('*')
    .order('type')
    .order('name')
  if (error || !data) return []
  return data.map(fromRow)
}

export async function getWeaponEntries(): Promise<CodexEntry[]> {
  const { data, error } = await getSupabase()
    .from('codex')
    .select('*')
    .eq('type', 'weapon')
    .order('subtype')
    .order('name')
  if (error || !data) return []
  return data.map(fromRow)
}

export async function getArmorEntries(): Promise<CodexEntry[]> {
  const { data, error } = await getSupabase()
    .from('codex')
    .select('*')
    .eq('type', 'armor')
    .order('subtype')
    .order('name')
  if (error || !data) return []
  return data.map(fromRow)
}

export async function getItemEntries(): Promise<CodexEntry[]> {
  const { data, error } = await getSupabase()
    .from('codex')
    .select('*')
    .eq('type', 'item')
    .order('subtype')
    .order('name')
  if (error || !data) return []
  return data.map(fromRow)
}

export async function getRuleEntries(): Promise<CodexEntry[]> {
  const { data, error } = await getSupabase()
    .from('codex')
    .select('*')
    .eq('type', 'rule')
    .order('subtype')
    .order('name')
  if (error || !data) return []
  return data.map(fromRow)
}

export function translateSubtype(subtype: string | null): string {
  if (!subtype) return ''
  const map: Record<string, string> = {
    'simple melee':   'Simples C.C.',
    'simple ranged':  'Simples Dist.',
    'martial melee':  'Marcial C.C.',
    'martial ranged': 'Marcial Dist.',
    'light':          'Leve',
    'medium':         'Média',
    'heavy':          'Pesada',
    'shield':         'Escudo',
    'ammunition':     'Munição',
    'light source':   'Luz',
    'consumable':     'Consumível',
    'potion':         'Poção',
    'scroll':         'Pergaminho',
    'focus':          'Foco',
    'kit':            'Kit',
    'container':      'Contêiner',
    'gear':           'Equipamento',
    // rule subtypes
    'condition':      'Condição',
    'action':         'Ação',
    'cover':          'Cobertura',
    'concentration':  'Concentração',
    'rest':           'Descanso',
    'death':          'Morte',
    'combat':         'Combate',
    'reaction':       'Reação',
  }
  return map[subtype] ?? subtype
}

export function translateDamageType(dmgType: string): string {
  const map: Record<string, string> = {
    piercing:    'perfurante',
    slashing:    'cortante',
    bludgeoning: 'concussão',
    fire:        'fogo',
    radiant:     'radiante',
    acid:        'ácido',
    special:     'especial',
  }
  return map[dmgType] ?? dmgType
}

export function translateProperty(prop: string): string {
  const map: Record<string, string> = {
    finesse:       'fineza',
    light:         'leve',
    heavy:         'pesada',
    'two-handed':  'duas mãos',
    versatile:     'versátil',
    thrown:        'arremessável',
    reach:         'alcance',
    ammunition:    'munição',
    loading:       'recarga',
    special:       'especial',
  }
  return map[prop] ?? prop
}
