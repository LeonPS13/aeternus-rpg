import { getSupabase } from './supabase'
import type { ClassEntry, ClassLevel, ClassFeature, SubclassFeature } from '@/types/class'

type ClassRow = {
  id: string; name: string; name_en: string | null; description: string | null
  hit_die: number; primary_ability: string[]; saving_throws: string[]
  armor_proficiencies: string[]; weapon_proficiencies: string[]; tool_proficiencies: string[]
  skill_choices_count: number; skill_choices: string[]; speed: number
  spellcasting_ability: string | null; spellcasting_type: string | null; source: string
}

type ClassLevelRow = {
  id: string; class_id: string; level: number; proficiency_bonus: number
  cantrips_known: number | null; spells_known: number | null
  slot_1: number; slot_2: number; slot_3: number; slot_4: number; slot_5: number
  slot_6: number; slot_7: number; slot_8: number; slot_9: number
  meta: Record<string, unknown> | null
}

type ClassFeatureRow = {
  id: string; class_id: string; level: number; name: string
  name_en: string | null; description: string | null; type: string; source: string
}

type SubclassFeatureRow = {
  id: string; subclass_id: string; level: number; name: string
  name_en: string | null; description: string | null; type: string; source: string
}

function classFromRow(r: ClassRow): ClassEntry {
  return {
    id: r.id, name: r.name, nameEn: r.name_en, description: r.description,
    hitDie: r.hit_die, primaryAbility: r.primary_ability ?? [],
    savingThrows: r.saving_throws ?? [], armorProficiencies: r.armor_proficiencies ?? [],
    weaponProficiencies: r.weapon_proficiencies ?? [], toolProficiencies: r.tool_proficiencies ?? [],
    skillChoicesCount: r.skill_choices_count, skillChoices: r.skill_choices ?? [],
    speed: r.speed, spellcastingAbility: r.spellcasting_ability,
    spellcastingType: r.spellcasting_type as ClassEntry['spellcastingType'],
    source: r.source,
  }
}

function levelFromRow(r: ClassLevelRow): ClassLevel {
  return {
    id: r.id, classId: r.class_id, level: r.level, proficiencyBonus: r.proficiency_bonus,
    cantripsKnown: r.cantrips_known, spellsKnown: r.spells_known,
    slot1: r.slot_1, slot2: r.slot_2, slot3: r.slot_3, slot4: r.slot_4, slot5: r.slot_5,
    slot6: r.slot_6, slot7: r.slot_7, slot8: r.slot_8, slot9: r.slot_9,
    meta: r.meta,
  }
}

function featureFromRow(r: ClassFeatureRow): ClassFeature {
  return {
    id: r.id, classId: r.class_id, level: r.level, name: r.name,
    nameEn: r.name_en, description: r.description,
    type: r.type as ClassFeature['type'], source: r.source,
  }
}

function subclassFeatureFromRow(r: SubclassFeatureRow): SubclassFeature {
  return {
    id: r.id, subclassId: r.subclass_id, level: r.level, name: r.name,
    nameEn: r.name_en, description: r.description,
    type: r.type as SubclassFeature['type'], source: r.source,
  }
}

export async function getClassById(id: string): Promise<ClassEntry | null> {
  const { data } = await getSupabase().from('classes').select('*').eq('id', id).single()
  return data ? classFromRow(data as ClassRow) : null
}

export async function getClassLevel(classId: string, level: number): Promise<ClassLevel | null> {
  const { data } = await getSupabase()
    .from('class_levels').select('*').eq('class_id', classId).eq('level', level).single()
  return data ? levelFromRow(data as ClassLevelRow) : null
}

export async function getClassFeatures(classId: string): Promise<ClassFeature[]> {
  const { data } = await getSupabase()
    .from('class_features').select('*').eq('class_id', classId).order('level')
  return (data ?? []).map(r => featureFromRow(r as ClassFeatureRow))
}

export async function getSubclassFeatures(subclassId: string): Promise<SubclassFeature[]> {
  const { data } = await getSupabase()
    .from('subclass_features').select('*').eq('subclass_id', subclassId).order('level')
  return (data ?? []).map(r => subclassFeatureFromRow(r as SubclassFeatureRow))
}
