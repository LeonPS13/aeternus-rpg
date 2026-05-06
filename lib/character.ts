import { supabase } from './supabase'
import type { Character } from '@/types/character'
import { defaultSkills } from '@/types/character'

function toRow(c: Character) {
  return {
    id: c.id, player_id: c.playerId, created_at: c.createdAt, updated_at: c.updatedAt,
    character_name: c.characterName, player_name: c.playerName, class: c.characterClass,
    level: c.level, race: c.race, background: c.background, alignment: c.alignment, xp: c.xp,
    str_score: c.strScore, dex_score: c.dexScore, con_score: c.conScore,
    int_score: c.intScore, wis_score: c.wisScore, cha_score: c.chaScore,
    inspiration: c.inspiration,
    ac_armor_equipped: c.acArmorEquipped, ac_shield_bonus: c.acShieldBonus,
    ac_extra_bonus: c.acExtraBonus, ac_armor_type: c.acArmorType,
    speed: c.speed, initiative_bonus: c.initiativeBonus,
    save_str_proficient: c.saveStrProficient, save_dex_proficient: c.saveDexProficient,
    save_con_proficient: c.saveConProficient, save_int_proficient: c.saveIntProficient,
    save_wis_proficient: c.saveWisProficient, save_cha_proficient: c.saveChaProficient,
    skills: c.skills,
    max_hp: c.maxHp, current_hp: c.currentHp, temp_hp: c.tempHp,
    hit_dice_spent: c.hitDiceSpent,
    death_saves_success: c.deathSavesSuccess, death_saves_failure: c.deathSavesFailure,
    attacks: c.attacks,
    cp: c.cp, sp: c.sp, ep: c.ep, gp: c.gp, pp: c.pp, inventory: c.inventory,
    other_proficiencies: c.otherProficiencies, features_traits: c.featuresTraits,
    personality_traits: c.personalityTraits, ideals: c.ideals, bonds: c.bonds, flaws: c.flaws,
  }
}

function fromRow(r: any): Character {
  return {
    id: r.id ?? crypto.randomUUID(),
    playerId: r.player_id ?? '',
    createdAt: r.created_at ?? new Date().toISOString(),
    updatedAt: r.updated_at ?? new Date().toISOString(),
    characterName: r.character_name ?? '', playerName: r.player_name ?? '',
    characterClass: r.class ?? '', level: r.level ?? 1,
    race: r.race ?? '', background: r.background ?? '',
    alignment: r.alignment ?? '', xp: r.xp ?? 0,
    strScore: r.str_score ?? 10, dexScore: r.dex_score ?? 10, conScore: r.con_score ?? 10,
    intScore: r.int_score ?? 10, wisScore: r.wis_score ?? 10, chaScore: r.cha_score ?? 10,
    inspiration: r.inspiration ?? false,
    acArmorEquipped: r.ac_armor_equipped ?? 0, acShieldBonus: r.ac_shield_bonus ?? 0,
    acExtraBonus: r.ac_extra_bonus ?? 0, acArmorType: r.ac_armor_type ?? 'none',
    speed: r.speed ?? 30, initiativeBonus: r.initiative_bonus ?? 0,
    saveStrProficient: r.save_str_proficient ?? false,
    saveDexProficient: r.save_dex_proficient ?? false,
    saveConProficient: r.save_con_proficient ?? false,
    saveIntProficient: r.save_int_proficient ?? false,
    saveWisProficient: r.save_wis_proficient ?? false,
    saveChaProficient: r.save_cha_proficient ?? false,
    skills: { ...defaultSkills(), ...(r.skills ?? {}) },
    maxHp: r.max_hp ?? 0, currentHp: r.current_hp ?? 0, tempHp: r.temp_hp ?? 0,
    hitDiceSpent: r.hit_dice_spent ?? 0,
    deathSavesSuccess: r.death_saves_success ?? 0, deathSavesFailure: r.death_saves_failure ?? 0,
    attacks: r.attacks ?? [],
    cp: r.cp ?? 0, sp: r.sp ?? 0, ep: r.ep ?? 0, gp: r.gp ?? 0, pp: r.pp ?? 0,
    inventory: r.inventory ?? [],
    otherProficiencies: r.other_proficiencies ?? '', featuresTraits: r.features_traits ?? '',
    personalityTraits: r.personality_traits ?? '', ideals: r.ideals ?? '',
    bonds: r.bonds ?? '', flaws: r.flaws ?? '',
  }
}

export function createEmptyCharacter(playerId: string): Character {
  return fromRow({ player_id: playerId })
}

export async function getCharacters(playerId: string): Promise<Character[]> {
  const { data, error } = await supabase
    .from('characters')
    .select('*')
    .eq('player_id', playerId)
    .order('updated_at', { ascending: false })
  if (error || !data) return []
  return data.map(fromRow)
}

export async function saveCharacter(character: Character): Promise<void> {
  await supabase.from('characters').upsert(toRow(character))
}

export async function deleteCharacter(id: string): Promise<void> {
  await supabase.from('characters').delete().eq('id', id)
}
