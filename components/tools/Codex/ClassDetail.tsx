'use client'

import { useState, useEffect } from 'react'
import type { ReactNode } from 'react'
import { X, ChevronDown, ChevronUp } from 'lucide-react'
import type { ClassEntry, ClassLevel, ClassFeature, Subclass, SubclassFeature } from '@/types/class'
import { getClassLevels, getClassFeatures, getSubclassesByClass, getSubclassFeatures } from '@/lib/classes'
import { HIT_DIE_STYLE } from './ClassCard'

// ── translation maps ──────────────────────────────────────────
const ABILITY_PT: Record<string, string> = {
  strength: 'Força', dexterity: 'Destreza', constitution: 'Constituição',
  intelligence: 'Inteligência', wisdom: 'Sabedoria', charisma: 'Carisma',
}
const ARMOR_PT:  Record<string, string> = {
  light: 'Leves', medium: 'Médias', heavy: 'Pesadas', shields: 'Escudos',
}
const WEAPON_PT: Record<string, string> = {
  simple: 'Simples', martial: 'Marciais',
  hand_crossbow: 'Besta de Mão', light_crossbow: 'Besta Leve', longsword: 'Espada Longa',
  rapier: 'Rapieira', shortsword: 'Espada Curta',
  club: 'Clava', dagger: 'Adaga', dart: 'Dardo', javelin: 'Azagaia',
  mace: 'Maça', quarterstaff: 'Cajado', scimitar: 'Cimitarra',
  sickle: 'Foice', sling: 'Funda', spear: 'Lança',
}
const TOOL_PT: Record<string, string> = {
  herbalism_kit: 'Kit de Herbalismo',
  thieves_tools: 'Ferramentas de Ladrão',
  disguise_kit: 'Kit de Disfarce',
  forgery_kit: 'Kit de Falsificação',
  poisoners_kit: 'Kit de Venenos',
}
const SKILL_PT:  Record<string, string> = {
  animal_handling: 'Adestrar Animais', athletics: 'Atletismo',
  intimidation: 'Intimidação', nature: 'Natureza', perception: 'Percepção',
  survival: 'Sobrevivência', acrobatics: 'Acrobacia', arcana: 'Arcanismo',
  deception: 'Enganação', history: 'História', insight: 'Intuição',
  investigation: 'Investigação', medicine: 'Medicina', performance: 'Atuação',
  persuasion: 'Persuasão', religion: 'Religião',
  sleight_of_hand: 'Prestidigitação', stealth: 'Furtividade',
}
const META_LABELS: Record<string, string> = {
  rages: 'Fúrias', rage_damage: 'Dano', brutal_critical: 'Crít.',
  bardic_inspiration: 'Inspiração', song_of_rest: 'Canção',
  channel_divinity: 'C. Divindade', destroy_undead: 'Destruir M-V',
  wild_shape_cr: 'F. Selvagem CR',
  action_surge: 'Ação Amp.', indomitable: 'Indomável',
  ki_points: 'Ki', sneak_attack: 'Furtivo', sorcery_points: 'Pts Feitiç.',
  martial_arts: 'Artes Marc.', unarmored_movement: 'Mov. Extra',
  invocations: 'Invocações',
}
const META_HIDDEN = new Set(['song_of_rest'])
const FEATURE_BADGE: Record<string, { label: string; color: string; bg: string }> = {
  feature:      { label: 'Habilidade',    color: 'var(--color-text-muted)', bg: 'var(--color-bg-tertiary)' },
  asi:          { label: 'Inc. Atributo', color: 'var(--color-gold)',        bg: 'rgba(201,168,76,0.12)'    },
  extra_attack: { label: 'Ataque Extra',  color: '#e07070',                  bg: 'rgba(180,60,60,0.12)'     },
  spellcasting: { label: 'Conjuração',    color: '#7ba2e0',                  bg: 'rgba(123,162,224,0.12)'   },
}

// ── tiny layout helpers ───────────────────────────────────────
function Chip({ children }: { children: ReactNode }) {
  return (
    <span className="rounded px-2 py-0.5 text-sm"
      style={{ background: 'var(--color-bg-tertiary)', color: 'var(--color-text-secondary)', border: '1px solid var(--color-border-default)' }}>
      {children}
    </span>
  )
}

function Th({ children, align = 'center' }: { children: ReactNode; align?: 'left' | 'center' }) {
  return (
    <th className={`px-2 py-2 text-${align} text-xs`}
      style={{ color: 'var(--color-text-muted)', whiteSpace: 'nowrap' }}>
      {children}
    </th>
  )
}

// ── FeatureItem ───────────────────────────────────────────────
function FeatureItem({ feature }: { feature: ClassFeature | SubclassFeature }) {
  const [open, setOpen] = useState(false)
  const badge = FEATURE_BADGE[feature.type] ?? FEATURE_BADGE.feature

  return (
    <div className="rounded"
      style={{ border: '1px solid var(--color-border-default)', background: 'var(--color-bg-secondary)' }}>
      <button
        onClick={() => setOpen(o => !o)}
        className="flex w-full items-center gap-2 px-3 py-2 text-left"
      >
        <div className="min-w-0 flex-1">
          <span className="text-base" style={{ color: 'var(--color-text-primary)' }}>
            {feature.name}
          </span>
          {feature.nameEn && (
            <span className="ml-2 text-sm" style={{ color: 'var(--color-text-muted)' }}>
              {feature.nameEn}
            </span>
          )}
        </div>
        <span className="shrink-0 rounded px-1.5 py-0.5 text-xs"
          style={{ background: badge.bg, color: badge.color }}>
          {badge.label}
        </span>
        {open
          ? <ChevronUp   size={14} style={{ color: 'var(--color-text-muted)', flexShrink: 0 }} />
          : <ChevronDown size={14} style={{ color: 'var(--color-text-muted)', flexShrink: 0 }} />}
      </button>

      {open && feature.description && (
        <div className="border-t px-3 pb-3 pt-2"
          style={{ borderColor: 'var(--color-border-default)' }}>
          {feature.description.split('\n\n').map((para, i) => (
            <p key={i} className={`text-sm leading-relaxed${i > 0 ? ' mt-2' : ''}`}
              style={{ color: 'var(--color-text-secondary)' }}>
              {para}
            </p>
          ))}
        </div>
      )}
    </div>
  )
}

// ── SubclassPanel ─────────────────────────────────────────────
function SubclassPanel({ sc, features }: { sc: Subclass; features: SubclassFeature[] }) {
  const byLevel = features.reduce<Record<number, SubclassFeature[]>>((acc, f) => {
    (acc[f.level] ??= []).push(f); return acc
  }, {})

  return (
    <div className="arcane-panel p-4">
      <h3 className="text-xl leading-tight" style={{ color: 'var(--color-text-primary)' }}>
        {sc.name}
      </h3>
      {sc.nameEn && (
        <p className="mb-2 text-sm" style={{ color: 'var(--color-text-muted)' }}>
          {sc.nameEn} · ganha no nível {sc.levelGained}
        </p>
      )}
      {sc.description && (
        <p className="mb-4 text-sm leading-relaxed" style={{ color: 'var(--color-text-secondary)' }}>
          {sc.description}
        </p>
      )}
      <div className="space-y-4">
        {Object.entries(byLevel)
          .sort(([a], [b]) => +a - +b)
          .map(([level, feats]) => (
            <div key={level}>
              <p className="mb-1.5 text-sm" style={{ color: 'var(--color-gold)' }}>
                Nível {level}
              </p>
              <div className="space-y-1.5">
                {feats.map(f => <FeatureItem key={f.id} feature={f} />)}
              </div>
            </div>
          ))}
      </div>
    </div>
  )
}

// ── ClassDetail ───────────────────────────────────────────────
interface ClassData {
  levels:           ClassLevel[]
  features:         ClassFeature[]
  subclasses:       Subclass[]
  subclassFeatures: Record<string, SubclassFeature[]>
}

interface Props {
  cls:     ClassEntry
  onClose: () => void
}

export default function ClassDetail({ cls, onClose }: Props) {
  const [data,       setData]      = useState<ClassData | null>(null)
  const [loading,    setLoading]   = useState(true)
  const [selectedSc, setSelectedSc] = useState<string | null>(null)

  useEffect(() => {
    setLoading(true)
    setData(null)
    Promise.all([
      getClassLevels(cls.id),
      getClassFeatures(cls.id),
      getSubclassesByClass(cls.id),
    ]).then(async ([levels, features, subclasses]) => {
      const scEntries = await Promise.all(
        subclasses.map(async sc =>
          [sc.id, await getSubclassFeatures(sc.id)] as [string, SubclassFeature[]]
        )
      )
      setData({ levels, features, subclasses, subclassFeatures: Object.fromEntries(scEntries) })
      if (subclasses.length > 0) setSelectedSc(subclasses[0].id)
      setLoading(false)
    }).catch(() => setLoading(false))
  }, [cls.id])

  // ── derived data ──────────────────────────────────────────
  const featuresByLevel = data?.features.reduce<Record<number, ClassFeature[]>>((acc, f) => {
    (acc[f.level] ??= []).push(f); return acc
  }, {}) ?? {}

  const metaKeys = Array.from(
    new Set((data?.levels ?? []).flatMap(l => Object.keys(l.meta ?? {})))
  ).filter(k => !META_HIDDEN.has(k))
  const hasSpells      = !!cls.spellcastingAbility
  const hasCantripCol  = !!(data?.levels.some(l => (l.cantripsKnown ?? 0) > 0))
  const hasSpellsKnown = !!(data?.levels.some(l => (l.spellsKnown ?? 0) > 0))
  const slotCols       = hasSpells
    ? ([1,2,3,4,5,6,7,8,9] as const).filter(n =>
        data?.levels.some(l => (l[`slot${n}` as keyof ClassLevel] as number) > 0)
      )
    : ([] as number[])

  const die = HIT_DIE_STYLE[cls.hitDie] ?? HIT_DIE_STYLE[8]

  return (
    <div
      className="fixed inset-0 z-50 flex justify-end"
      style={{ background: 'rgba(0,0,0,0.6)' }}
      onClick={e => { if (e.target === e.currentTarget) onClose() }}
    >
      <div
        className="relative flex h-full w-full flex-col overflow-y-auto md:max-w-2xl"
        style={{ background: 'var(--color-bg-primary)', borderLeft: '1px solid var(--color-border-default)' }}
      >

        {/* ── sticky header ── */}
        <div
          className="sticky top-0 z-10 flex items-center justify-between gap-3 px-5 py-4"
          style={{ background: 'var(--color-bg-primary)', borderBottom: '1px solid var(--color-border-default)' }}
        >
          <div className="min-w-0">
            <h2 className="text-2xl leading-none" style={{ color: 'var(--color-text-primary)' }}>
              {cls.name}
            </h2>
            {cls.nameEn && (
              <p className="mt-0.5 text-sm" style={{ color: 'var(--color-text-muted)' }}>
                {cls.nameEn}
              </p>
            )}
          </div>
          <div className="flex shrink-0 items-center gap-2">
            <span className="rounded px-2 py-1 text-base font-bold"
              style={{ background: die.bg, color: die.color, border: `1px solid ${die.border}` }}>
              d{cls.hitDie}
            </span>
            <button
              onClick={onClose}
              className="rounded p-1.5 transition-opacity hover:opacity-60"
              style={{ background: 'var(--color-bg-tertiary)', color: 'var(--color-text-muted)' }}
            >
              <X size={16} />
            </button>
          </div>
        </div>

        {/* ── body ── */}
        {loading ? (
          <div className="flex flex-1 items-center justify-center py-20">
            <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
              Carregando dados da classe…
            </p>
          </div>
        ) : (
          <div className="space-y-6 p-5">

            {/* description */}
            {cls.description && (
              <p className="text-base leading-relaxed" style={{ color: 'var(--color-text-secondary)' }}>
                {cls.description}
              </p>
            )}

            {/* ── Perfil ── */}
            <div className="arcane-panel p-4">
              <p className="section-label mb-3">· Perfil ·</p>
              <div className="grid grid-cols-2 gap-x-6 gap-y-2 text-sm sm:grid-cols-3">
                <div>
                  <p style={{ color: 'var(--color-text-muted)' }}>Dado de Vida</p>
                  <p style={{ color: 'var(--color-text-primary)' }}>1d{cls.hitDie} por nível</p>
                </div>
                <div>
                  <p style={{ color: 'var(--color-text-muted)' }}>Velocidade base</p>
                  <p style={{ color: 'var(--color-text-primary)' }}>{cls.speed} m</p>
                </div>
                {cls.spellcastingAbility && (
                  <div>
                    <p style={{ color: 'var(--color-text-muted)' }}>Atributo de Conjuração</p>
                    <p style={{ color: 'var(--color-text-primary)' }}>
                      {ABILITY_PT[cls.spellcastingAbility] ?? cls.spellcastingAbility}
                    </p>
                  </div>
                )}
                {cls.primaryAbility.length > 0 && (
                  <div>
                    <p style={{ color: 'var(--color-text-muted)' }}>Atributo primário</p>
                    <p style={{ color: 'var(--color-text-primary)' }}>
                      {cls.primaryAbility.map(a => ABILITY_PT[a] ?? a).join(', ')}
                    </p>
                  </div>
                )}
                {cls.savingThrows.length > 0 && (
                  <div className="col-span-2 sm:col-span-3">
                    <p style={{ color: 'var(--color-text-muted)' }}>Resistências</p>
                    <p style={{ color: 'var(--color-text-primary)' }}>
                      {cls.savingThrows.map(s => ABILITY_PT[s] ?? s).join(', ')}
                    </p>
                  </div>
                )}
              </div>
            </div>

            {/* ── Proficiências ── */}
            <div>
              <p className="section-label mb-3">· Proficiências ·</p>
              <div className="space-y-2">
                {cls.armorProficiencies.length > 0 && (
                  <div className="flex flex-wrap items-center gap-1">
                    <span className="shrink-0 text-sm" style={{ color: 'var(--color-text-muted)' }}>
                      Armaduras:
                    </span>
                    {cls.armorProficiencies.map(a => <Chip key={a}>{ARMOR_PT[a] ?? a}</Chip>)}
                  </div>
                )}
                {cls.weaponProficiencies.length > 0 && (
                  <div className="flex flex-wrap items-center gap-1">
                    <span className="shrink-0 text-sm" style={{ color: 'var(--color-text-muted)' }}>
                      Armas:
                    </span>
                    {cls.weaponProficiencies.map(w => <Chip key={w}>{WEAPON_PT[w] ?? w}</Chip>)}
                  </div>
                )}
                {cls.toolProficiencies.length > 0 && (
                  <div className="flex flex-wrap items-center gap-1">
                    <span className="shrink-0 text-sm" style={{ color: 'var(--color-text-muted)' }}>
                      Ferramentas:
                    </span>
                    {cls.toolProficiencies.map(t => <Chip key={t}>{TOOL_PT[t] ?? t}</Chip>)}
                  </div>
                )}
                {cls.skillChoices.length > 0 && (
                  <div>
                    <p className="mb-1 text-sm" style={{ color: 'var(--color-text-muted)' }}>
                      Perícias — escolha {cls.skillChoicesCount}:
                    </p>
                    <div className="flex flex-wrap gap-1">
                      {cls.skillChoices.map(s => <Chip key={s}>{SKILL_PT[s] ?? s}</Chip>)}
                    </div>
                  </div>
                )}
              </div>
            </div>

            {/* ── Progressão ── */}
            {data && data.levels.length > 0 && (
              <div>
                <p className="section-label mb-3">· Progressão ·</p>
                <div className="overflow-x-auto rounded"
                  style={{ border: '1px solid var(--color-border-default)' }}>
                  <table className="w-full text-sm">
                    <thead>
                      <tr style={{ background: 'var(--color-bg-tertiary)', borderBottom: '1px solid var(--color-border-default)' }}>
                        <Th>Nív</Th>
                        <Th>BPr</Th>
                        {hasCantripCol  && <Th>Truques</Th>}
                        {hasSpellsKnown && <Th>Magias</Th>}
                        {metaKeys.map(k => <Th key={k}>{META_LABELS[k] ?? k}</Th>)}
                        {slotCols.map(n => <Th key={n}>{n}º</Th>)}
                        <Th align="left">Habilidades</Th>
                      </tr>
                    </thead>
                    <tbody>
                      {data.levels.map((lvl, i) => {
                        const levelFeats = featuresByLevel[lvl.level] ?? []
                        return (
                          <tr key={lvl.level}
                            style={{
                              borderBottom: i < 19 ? '1px solid var(--color-border-default)' : undefined,
                              background: i % 2 === 0 ? 'var(--color-bg-secondary)' : 'var(--color-bg-primary)',
                            }}>
                            <td className="px-2 py-1.5 text-center font-mono text-xs"
                              style={{ color: 'var(--color-text-muted)' }}>
                              {lvl.level}
                            </td>
                            <td className="px-2 py-1.5 text-center text-xs"
                              style={{ color: 'var(--color-gold)' }}>
                              +{lvl.proficiencyBonus}
                            </td>
                            {hasCantripCol && (
                              <td className="px-2 py-1.5 text-center text-xs"
                                style={{ color: 'var(--color-text-secondary)' }}>
                                {lvl.cantripsKnown ?? '—'}
                              </td>
                            )}
                            {hasSpellsKnown && (
                              <td className="px-2 py-1.5 text-center text-xs"
                                style={{ color: 'var(--color-text-secondary)' }}>
                                {lvl.spellsKnown ?? '—'}
                              </td>
                            )}
                            {metaKeys.map(k => {
                              const v = (lvl.meta as Record<string, unknown> | null)?.[k]
                              return (
                                <td key={k} className="px-2 py-1.5 text-center text-xs"
                                  style={{ color: 'var(--color-text-secondary)' }}>
                                  {v === null ? '∞' : v === undefined ? '—' : String(v)}
                                </td>
                              )
                            })}
                            {slotCols.map(n => {
                              const v = (lvl[`slot${n}` as keyof ClassLevel] as number) ?? 0
                              return (
                                <td key={n} className="px-2 py-1.5 text-center text-xs"
                                  style={{ color: v > 0 ? 'var(--color-text-secondary)' : 'var(--color-text-muted)' }}>
                                  {v > 0 ? v : '—'}
                                </td>
                              )
                            })}
                            <td className="px-2 py-1.5 text-xs"
                              style={{ color: 'var(--color-text-muted)', maxWidth: 180 }}>
                              {levelFeats.map(f => f.name).join(', ') || '—'}
                            </td>
                          </tr>
                        )
                      })}
                    </tbody>
                  </table>
                </div>
              </div>
            )}

            {/* ── Habilidades de Classe ── */}
            {data && Object.keys(featuresByLevel).length > 0 && (
              <div>
                <p className="section-label mb-3">· Habilidades de Classe ·</p>
                <div className="space-y-4">
                  {Object.entries(featuresByLevel)
                    .sort(([a], [b]) => +a - +b)
                    .map(([level, feats]) => (
                      <div key={level}>
                        <p className="mb-1.5 text-sm" style={{ color: 'var(--color-gold)' }}>
                          Nível {level}
                        </p>
                        <div className="space-y-1.5">
                          {feats.map(f => <FeatureItem key={f.id} feature={f} />)}
                        </div>
                      </div>
                    ))}
                </div>
              </div>
            )}

            {/* ── Subclasses ── */}
            {data && data.subclasses.length > 0 && (
              <div>
                <p className="section-label mb-3">· Subclasses ·</p>

                {/* selector */}
                <div className="mb-4 flex flex-wrap gap-1">
                  {data.subclasses.map(sc => (
                    <button
                      key={sc.id}
                      onClick={() => setSelectedSc(sc.id)}
                      className="rounded px-3 py-1.5 text-sm transition-all"
                      style={selectedSc === sc.id
                        ? { background: 'var(--color-gold-glow)', color: 'var(--color-gold-light)', border: '1px solid rgba(201,168,76,0.5)' }
                        : { background: 'transparent', color: 'var(--color-text-muted)', border: '1px solid var(--color-border-default)' }
                      }
                    >
                      {sc.name}
                    </button>
                  ))}
                </div>

                {selectedSc && (() => {
                  const sc = data.subclasses.find(s => s.id === selectedSc)
                  if (!sc) return null
                  return (
                    <SubclassPanel
                      sc={sc}
                      features={data.subclassFeatures[selectedSc] ?? []}
                    />
                  )
                })()}
              </div>
            )}

          </div>
        )}
      </div>
    </div>
  )
}
