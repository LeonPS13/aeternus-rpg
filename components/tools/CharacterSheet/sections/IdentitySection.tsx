'use client'

import { useState, useEffect, useRef } from 'react'
import { CheckCircle2, Circle } from 'lucide-react'
import type { Character, SkillName } from '@/types/character'
import type { ClassEntry, Subclass } from '@/types/class'
import type { RaceEntry, RaceSubentry } from '@/types/race'
import { CLASSES, RACES, ALIGNMENTS, defaultSkills } from '@/types/character'
import { SKILL_LABELS } from '@/lib/character-calc'
import { profBonus } from '@/lib/character-calc'
import { getClassById, getSubclassesByClass } from '@/lib/classes'
import { dbSkillToTs, applyClassDefaults, applyRaceDefaults, buildFeaturesTraitsText } from '@/lib/classAutomation'
import { getRaceByNameEn } from '@/lib/races'

interface Props {
  char: Character
  onChange: (u: Partial<Character>) => void
}

const inputStyle = {
  background: 'var(--color-bg-tertiary)',
  border: '1px solid var(--color-border-default)',
  color: 'var(--color-text-primary)',
  borderRadius: '4px',
  outline: 'none',
  caretColor: 'var(--color-gold)',
}

const selectStyle = { ...inputStyle, caretColor: undefined }

function Field({ label, children }: { label: string; children: React.ReactNode }) {
  return (
    <div>
      <label className="mb-1 block text-sm font-medium" style={{ color: 'var(--color-text-muted)' }}>{label}</label>
      {children}
    </div>
  )
}

export default function IdentitySection({ char, onChange }: Props) {
  const pb = profBonus(char.level)
  const [levelText, setLevelText] = useState(String(char.level))
  const levelFocused = useRef(false)
  useEffect(() => { if (!levelFocused.current) setLevelText(String(char.level)) }, [char.level])

  const [classEntry, setClassEntry] = useState<ClassEntry | null>(null)
  const [subclasses, setSubclasses] = useState<Subclass[]>([])
  const [classLoading, setClassLoading] = useState(false)
  const [raceEntry, setRaceEntry] = useState<RaceEntry | null>(null)

  // Carregar dados da classe no mount (se já houver classe salva)
  useEffect(() => {
    const classId = char.characterClass.toLowerCase().trim()
    if (!classId) return
    setClassLoading(true)
    Promise.all([getClassById(classId), getSubclassesByClass(classId)])
      .then(([cls, subs]) => { setClassEntry(cls); setSubclasses(subs) })
      .finally(() => setClassLoading(false))
  }, []) // eslint-disable-line react-hooks/exhaustive-deps

  // Carregar dados da raça no mount
  useEffect(() => {
    if (char.race) setRaceEntry(getRaceByNameEn(char.race) ?? null)
  }, []) // eslint-disable-line react-hooks/exhaustive-deps

  function activeSubrace(entry: RaceEntry | null, subraceId: string): RaceSubentry | null {
    return entry?.subraces?.find(s => s.id === subraceId) ?? null
  }

  function handleClassChange(newClass: string) {
    onChange({ characterClass: newClass })
    const classId = newClass.toLowerCase().trim()
    if (!classId) {
      setClassEntry(null)
      setSubclasses([])
      return
    }
    setClassLoading(true)
    Promise.all([getClassById(classId), getSubclassesByClass(classId)])
      .then(([cls, subs]) => {
        setClassEntry(cls)
        setSubclasses(subs)
        if (cls) {
          onChange({ skills: defaultSkills(), ...applyClassDefaults(cls) })
        }
      })
      .finally(() => setClassLoading(false))
  }

  function handleRaceChange(newRace: string) {
    const entry = getRaceByNameEn(newRace)
    setRaceEntry(entry ?? null)
    if (!newRace || !entry) {
      onChange({
        race: newRace,
        subrace: '',
        ...applyRaceDefaults(null, char.racialAsi, char),
        featuresTraits: buildFeaturesTraitsText(null, null),
      })
      return
    }
    if (!entry.subraces) {
      onChange({
        race: newRace,
        subrace: '',
        ...applyRaceDefaults({ speed: entry.speed, asi: entry.asi ?? {} }, char.racialAsi, char),
        featuresTraits: buildFeaturesTraitsText(entry, null),
      })
    } else {
      onChange({
        race: newRace,
        subrace: '',
        ...applyRaceDefaults(null, char.racialAsi, char),
        featuresTraits: buildFeaturesTraitsText(entry, null),
      })
    }
  }

  function handleSubraceChange(subraceId: string) {
    if (!raceEntry?.subraces) return
    const sub = raceEntry.subraces.find(s => s.id === subraceId) ?? null
    if (!sub) {
      onChange({
        subrace: '',
        ...applyRaceDefaults(null, char.racialAsi, char),
        featuresTraits: buildFeaturesTraitsText(raceEntry, null),
      })
      return
    }
    onChange({
      subrace: subraceId,
      ...applyRaceDefaults({ speed: raceEntry.speed, asi: sub.asi }, char.racialAsi, char),
      featuresTraits: buildFeaturesTraitsText(raceEntry, sub),
    })
  }

  // Skill picker
  const availableSkills: SkillName[] = classEntry
    ? (classEntry.skillChoices.map(dbSkillToTs).filter(Boolean) as SkillName[])
    : []
  const selectedSkillCount = availableSkills.filter(s => char.skills[s]?.proficient).length
  const maxSkills = classEntry?.skillChoicesCount ?? 0

  function toggleSkill(skill: SkillName) {
    const current = char.skills[skill]?.proficient ?? false
    if (!current && selectedSkillCount >= maxSkills) return
    onChange({ skills: { ...char.skills, [skill]: { proficient: !current, expert: char.skills[skill]?.expert ?? false } } })
  }

  // Subclass picker
  const eligibleSubclasses = subclasses.filter(s => char.level >= s.levelGained)
  const selectedSubclass = subclasses.find(s => s.id === char.subclassId) ?? null
  const showSubclassPicker = eligibleSubclasses.length > 0

  return (
    <div className="space-y-6">
      {/* Name row */}
      <div className="arcane-panel p-4">
        <p className="section-label mb-4">· Identificação ·</p>
        <div className="grid gap-3 sm:grid-cols-2">
          <Field label="Nome do Personagem">
            <input
              value={char.characterName}
              onChange={(e) => onChange({ characterName: e.target.value })}
              placeholder="Ex: Aldric Voss"
              className="w-full px-3 py-2 text-base"
              style={inputStyle}
            />
          </Field>
          <Field label="Nome do Jogador">
            <input
              value={char.playerName}
              onChange={(e) => onChange({ playerName: e.target.value })}
              placeholder="Seu nome"
              className="w-full px-3 py-2 text-base"
              style={inputStyle}
            />
          </Field>
        </div>
      </div>

      {/* Class / Race / Level */}
      <div className="arcane-panel p-4">
        <p className="section-label mb-4">· Classe e Raça ·</p>
        <div className="grid gap-3 sm:grid-cols-3">
          <Field label="Classe">
            <select
              value={char.characterClass}
              onChange={(e) => handleClassChange(e.target.value)}
              className="w-full px-3 py-2 text-base"
              style={selectStyle}
            >
              <option value="">Selecionar…</option>
              {CLASSES.map((c) => <option key={c} value={c}>{c}</option>)}
            </select>
          </Field>
          <Field label="Raça">
            <select
              value={char.race}
              onChange={(e) => handleRaceChange(e.target.value)}
              className="w-full px-3 py-2 text-base"
              style={selectStyle}
            >
              <option value="">Selecionar…</option>
              {RACES.map((r) => <option key={r} value={r}>{r}</option>)}
            </select>
          </Field>
          <Field label="Nível">
            <input
              type="number" min={1} max={20}
              value={levelText}
              onChange={(e) => setLevelText(e.target.value)}
              onFocus={() => { levelFocused.current = true }}
              onBlur={() => {
                levelFocused.current = false
                const n = Math.min(20, Math.max(1, Number(levelText) || 1))
                onChange({ level: n })
                setLevelText(String(n))
              }}
              className="w-full px-3 py-2 text-base [appearance:textfield] [&::-webkit-inner-spin-button]:appearance-none [&::-webkit-outer-spin-button]:appearance-none"
              style={inputStyle}
            />
          </Field>
        </div>

        {/* PB display */}
        <div className="mt-3 flex items-center gap-2 rounded px-3 py-2"
          style={{ background: 'var(--color-gold-glow)', border: '1px solid var(--color-border-default)' }}>
          <span className="text-sm" style={{ color: 'var(--color-text-muted)' }}>Bônus de Proficiência:</span>
          <span className="text-base font-medium" style={{ color: 'var(--color-gold-light)' }}>+{pb}</span>
          {classLoading && (
            <span className="ml-auto text-sm" style={{ color: 'var(--color-text-muted)' }}>Carregando…</span>
          )}
        </div>
      </div>

      {/* Race Traits Panel */}
      {raceEntry && (() => {
        const activeSubrace = raceEntry.subraces
          ? raceEntry.subraces.find(s => s.id === char.subrace) ?? null
          : null
        const appliedAsi = activeSubrace?.asi ?? raceEntry.asi ?? {}
        const allTraits = [
          ...raceEntry.traits.traits,
          ...(activeSubrace?.extraTraits ?? []),
        ]
        const ASI_LABELS: Record<string, string> = {
          str: 'FOR', dex: 'DES', con: 'CON', int: 'INT', wis: 'SAB', cha: 'CAR',
        }
        return (
          <div className="arcane-panel p-4">
            <p className="section-label mb-3">· Traços Raciais · <span className="normal-case font-normal text-sm ml-1" style={{ color: 'var(--color-text-muted)' }}>{raceEntry.name}{activeSubrace ? ` — ${activeSubrace.name}` : ''}</span></p>

            {raceEntry.subraces && (
              <div className="mb-3">
                <label className="mb-1 block text-sm font-medium" style={{ color: 'var(--color-text-muted)' }}>Sub-raça</label>
                <select
                  value={char.subrace}
                  onChange={(e) => handleSubraceChange(e.target.value)}
                  className="w-full px-3 py-2 text-base"
                  style={selectStyle}
                >
                  <option value="">Selecionar…</option>
                  {raceEntry.subraces.map(s => (
                    <option key={s.id} value={s.id}>{s.name}</option>
                  ))}
                </select>
              </div>
            )}

            {Object.keys(appliedAsi).length > 0 && (
              <div className="mb-3 flex flex-wrap gap-1.5">
                {(Object.entries(appliedAsi) as [string, number][]).map(([k, v]) => (
                  <span key={k} className="rounded px-2 py-0.5 text-xs font-medium"
                    style={{ background: 'var(--color-gold-glow)', border: '1px solid var(--color-gold)', color: 'var(--color-gold-light)' }}>
                    {ASI_LABELS[k] ?? k.toUpperCase()} +{v}
                  </span>
                ))}
                <span className="rounded px-2 py-0.5 text-xs"
                  style={{ background: 'var(--color-bg-tertiary)', border: '1px solid var(--color-border-default)', color: 'var(--color-text-muted)' }}>
                  {raceEntry.speed} pés
                </span>
              </div>
            )}

            <ul className="space-y-1">
              {allTraits.map((t, i) => (
                <li key={i} className="text-sm leading-snug" style={{ color: 'var(--color-text-secondary)' }}>
                  · {t}
                </li>
              ))}
            </ul>

            <p className="mt-2 text-xs" style={{ color: 'var(--color-text-muted)' }}>
              Idiomas: {raceEntry.traits.languages.join(', ')}
            </p>
          </div>
        )
      })()}

      {/* Skill Picker */}
      {classEntry && availableSkills.length > 0 && (
        <div className="arcane-panel p-4">
          <div className="mb-3 flex items-center justify-between">
            <p className="section-label">· Perícias de Classe ·</p>
            <span className="text-sm tabular-nums"
              style={{ color: selectedSkillCount >= maxSkills ? 'var(--color-gold)' : 'var(--color-text-muted)' }}>
              {selectedSkillCount}/{maxSkills}
            </span>
          </div>
          <p className="mb-3 text-sm" style={{ color: 'var(--color-text-muted)' }}>
            Escolha {maxSkills} {maxSkills === 1 ? 'perícia' : 'perícias'} disponíveis para {classEntry.name}
          </p>
          <div className="grid gap-2 sm:grid-cols-2">
            {availableSkills.map(skill => {
              const proficient = char.skills[skill]?.proficient ?? false
              const disabled = !proficient && selectedSkillCount >= maxSkills
              return (
                <button
                  key={skill}
                  onClick={() => toggleSkill(skill)}
                  disabled={disabled}
                  className="flex items-center gap-2 rounded p-2.5 text-left text-sm transition-opacity"
                  style={{
                    background: proficient ? 'var(--color-gold-glow)' : 'var(--color-bg-tertiary)',
                    border: `1px solid ${proficient ? 'var(--color-gold)' : 'var(--color-border-default)'}`,
                    color: disabled ? 'var(--color-text-muted)' : 'var(--color-text-primary)',
                    opacity: disabled ? 0.4 : 1,
                  }}
                >
                  {proficient
                    ? <CheckCircle2 size={13} style={{ color: 'var(--color-gold)', flexShrink: 0 }} />
                    : <Circle size={13} style={{ color: 'var(--color-text-muted)', flexShrink: 0 }} />}
                  {SKILL_LABELS[skill]}
                </button>
              )
            })}
          </div>
        </div>
      )}

      {/* Subclass Picker */}
      {showSubclassPicker && (
        <div className="arcane-panel p-4">
          <p className="section-label mb-3">· Subclasse ·</p>
          {selectedSubclass ? (
            <div>
              <div className="mb-2 flex items-start justify-between gap-3">
                <div>
                  <p className="text-base" style={{ color: 'var(--color-text-primary)' }}>{selectedSubclass.name}</p>
                  {selectedSubclass.nameEn && (
                    <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>{selectedSubclass.nameEn}</p>
                  )}
                </div>
                <button
                  onClick={() => onChange({ subclassId: null })}
                  className="shrink-0 text-sm transition-opacity hover:opacity-70"
                  style={{ color: 'var(--color-text-muted)' }}
                >
                  Alterar
                </button>
              </div>
              {selectedSubclass.description && (
                <p className="text-sm leading-relaxed" style={{ color: 'var(--color-text-secondary)' }}>
                  {selectedSubclass.description}
                </p>
              )}
            </div>
          ) : (
            <div>
              <p className="mb-2 text-sm" style={{ color: 'var(--color-text-muted)' }}>
                Você atingiu o nível para escolher uma subclasse
              </p>
              <select
                value=""
                onChange={(e) => { if (e.target.value) onChange({ subclassId: e.target.value }) }}
                className="w-full px-3 py-2 text-base"
                style={selectStyle}
              >
                <option value="">Escolher subclasse…</option>
                {eligibleSubclasses.map(s => (
                  <option key={s.id} value={s.id}>{s.name}</option>
                ))}
              </select>
            </div>
          )}
        </div>
      )}

      {/* Background / Alignment / XP */}
      <div className="arcane-panel p-4">
        <p className="section-label mb-4">· Antecedente ·</p>
        <div className="grid gap-3 sm:grid-cols-3">
          <Field label="Antecedente">
            <input
              value={char.background}
              onChange={(e) => onChange({ background: e.target.value })}
              placeholder="Ex: Sage, Criminal…"
              className="w-full px-3 py-2 text-base"
              style={inputStyle}
            />
          </Field>
          <Field label="Alinhamento">
            <select
              value={char.alignment}
              onChange={(e) => onChange({ alignment: e.target.value })}
              className="w-full px-3 py-2 text-base"
              style={selectStyle}
            >
              <option value="">Selecionar…</option>
              {ALIGNMENTS.map((a) => <option key={a} value={a}>{a}</option>)}
            </select>
          </Field>
          <Field label="XP">
            <input
              type="number" min={0}
              value={char.xp}
              onChange={(e) => onChange({ xp: Math.max(0, Number(e.target.value) || 0) })}
              className="w-full px-3 py-2 text-base [appearance:textfield] [&::-webkit-inner-spin-button]:appearance-none [&::-webkit-outer-spin-button]:appearance-none"
              style={inputStyle}
            />
          </Field>
        </div>
      </div>
    </div>
  )
}
