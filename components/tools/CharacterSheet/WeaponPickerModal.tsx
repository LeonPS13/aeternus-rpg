'use client'

import { useState, useEffect } from 'react'
import { X } from 'lucide-react'
import type { Character, CharacterAttack, InventoryItem, AttackStat } from '@/types/character'
import type { CodexEntry } from '@/types/codex'
import { getWeaponEntries, translateSubtype, translateDamageType } from '@/lib/codex'
import { mod, profBonus, fmtMod } from '@/lib/character-calc'
import { WEAPON_PROF_TO_NAMES } from '@/lib/classAutomation'

interface Props {
  char: Character
  onConfirm: (attacks: CharacterAttack[], item: InventoryItem) => void
  onClose: () => void
  weaponProficiencies?: string[]
}

const SUBTYPE_ORDER = ['simple melee', 'simple ranged', 'martial melee', 'martial ranged']

const inputStyle = {
  background: 'var(--color-bg-tertiary)',
  border: '1px solid var(--color-border-default)',
  color: 'var(--color-text-primary)',
  borderRadius: '4px',
  outline: 'none',
  caretColor: 'var(--color-gold)',
}

function getAbilityMod(weapon: CodexEntry, char: Character, finesseAttr: 'str' | 'dex'): number {
  const props = (weapon.data.properties as string[]) ?? []
  const isRanged = weapon.subtype?.includes('ranged') ?? false
  const hasFinesse = props.includes('finesse')
  if (isRanged)   return mod(char.dexScore)
  if (hasFinesse) return finesseAttr === 'dex' ? mod(char.dexScore) : mod(char.strScore)
  return mod(char.strScore)
}

function calcAttackBonus(weapon: CodexEntry, char: Character, proficient: boolean, magicBonus: number, finesseAttr: 'str' | 'dex'): string {
  const pb = profBonus(char.level)
  return fmtMod(getAbilityMod(weapon, char, finesseAttr) + (proficient ? pb : 0) + magicBonus)
}

function calcDamageStr(weapon: CodexEntry, char: Character, magicBonus: number, twoHanded: boolean, finesseAttr: 'str' | 'dex'): string {
  const d = weapon.data
  const props = (d.properties as string[]) ?? []
  const isVersatile = props.includes('versatile')
  const totalMod = getAbilityMod(weapon, char, finesseAttr) + magicBonus
  const dice = twoHanded && isVersatile && d.versatile_damage
    ? (d.versatile_damage as string)
    : (d.damage as string)
  if (totalMod > 0) return `${dice} + ${totalMod}`
  if (totalMod < 0) return `${dice} - ${Math.abs(totalMod)}`
  return dice
}

export default function WeaponPickerModal({ char, onConfirm, onClose, weaponProficiencies }: Props) {
  const [weapons, setWeapons]           = useState<CodexEntry[]>([])
  const [selectedId, setSelectedId]     = useState('')
  const [magicBonus, setMagicBonus]     = useState(0)
  const [magicText, setMagicText]       = useState('0')
  const [proficient, setProficient]     = useState(true)
  const [finesseAttr, setFinesseAttr]   = useState<'str' | 'dex'>('str')

  useEffect(() => {
    document.body.style.overflow = 'hidden'
    return () => { document.body.style.overflow = '' }
  }, [])

  useEffect(() => {
    getWeaponEntries().then(setWeapons)
  }, [])

  const selected    = weapons.find(w => w.id === selectedId) ?? null
  const selProps    = selected ? ((selected.data.properties as string[]) ?? []) : []
  const isVersatile = selProps.includes('versatile')
  const hasFinesse  = selProps.includes('finesse')

  function handleSelectWeapon(id: string) {
    setSelectedId(id)
    setFinesseAttr('str')
  }

  function handleMagicBlur() {
    const n = isNaN(Number(magicText)) ? 0 : Number(magicText)
    setMagicBonus(n)
    setMagicText(String(n))
  }

  function handleConfirm() {
    if (!selected) return
    const dmgType    = translateDamageType(selected.data.damage_type as string)
    const atkBonus   = calcAttackBonus(selected, char, proficient, magicBonus, finesseAttr)
    const isRanged   = selected.subtype?.includes('ranged') ?? false
    const stat: AttackStat = isRanged ? 'dex' : hasFinesse ? finesseAttr : 'str'
    const mb         = magicBonus !== 0 ? magicBonus : undefined

    const attacks: CharacterAttack[] = isVersatile
      ? [
          {
            id: crypto.randomUUID(),
            name: `${selected.name} (1 mão)`,
            attackBonus: atkBonus,
            stat,
            damageDice: selected.data.damage as string,
            magicBonus: mb,
            damage: calcDamageStr(selected, char, magicBonus, false, finesseAttr),
            damageType: dmgType,
          },
          {
            id: crypto.randomUUID(),
            name: `${selected.name} (2 mãos)`,
            attackBonus: atkBonus,
            stat,
            damageDice: selected.data.versatile_damage as string,
            magicBonus: mb,
            damage: calcDamageStr(selected, char, magicBonus, true, finesseAttr),
            damageType: dmgType,
          },
        ]
      : [
          {
            id: crypto.randomUUID(),
            name: selected.name,
            attackBonus: atkBonus,
            stat,
            damageDice: selected.data.damage as string,
            magicBonus: mb,
            damage: calcDamageStr(selected, char, magicBonus, false, finesseAttr),
            damageType: dmgType,
          },
        ]

    onConfirm(attacks, {
      id:          crypto.randomUUID(),
      name:        selected.name,
      quantity:    1,
      weight:      (selected.data.weight as number) ?? 0,
      description: selected.description ?? '',
    })
  }

  const allowedSubtypes = new Set<string>()
  const allowedNames    = new Set<string>()  // nomes PT em lowercase
  if (weaponProficiencies && weaponProficiencies.length > 0) {
    for (const p of weaponProficiencies) {
      if (p === 'simple')       { allowedSubtypes.add('simple melee');  allowedSubtypes.add('simple ranged') }
      else if (p === 'martial') { allowedSubtypes.add('martial melee'); allowedSubtypes.add('martial ranged') }
      else {
        const mapped = WEAPON_PROF_TO_NAMES[p]
        if (mapped) mapped.forEach(n => allowedNames.add(n.toLowerCase()))
        else allowedNames.add(p.replace(/_/g, ' ').toLowerCase())
      }
    }
  }

  function isAllowed(w: CodexEntry): boolean {
    if (!weaponProficiencies || weaponProficiencies.length === 0) return true
    if (w.subtype && allowedSubtypes.has(w.subtype)) return true
    if (allowedNames.has(w.name.toLowerCase())) return true
    return false
  }

  const grouped = SUBTYPE_ORDER
    .map(sub => ({ label: translateSubtype(sub), weapons: weapons.filter(w => w.subtype === sub && isAllowed(w)) }))
    .filter(g => g.weapons.length > 0)

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-4"
      style={{ background: 'rgba(0,0,0,0.75)' }}
      onClick={onClose}
    >
      <div
        className="arcane-panel relative w-full max-w-md p-6"
        onClick={e => e.stopPropagation()}
      >
        <button
          onClick={onClose}
          className="absolute right-4 top-4 rounded p-1"
          style={{ color: 'var(--color-text-muted)' }}
          aria-label="Fechar"
        >
          <X size={16} />
        </button>

        <h2 className="mb-4 text-2xl" style={{ color: 'var(--color-text-primary)' }}>
          Adicionar Arma
        </h2>

        {/* Weapon select */}
        <div className="mb-3">
          <label className="mb-1 block text-sm" style={{ color: 'var(--color-text-muted)' }}>Arma</label>
          <select
            value={selectedId}
            onChange={e => handleSelectWeapon(e.target.value)}
            className="w-full px-3 py-2 text-base"
            style={inputStyle}
          >
            <option value="">— Selecionar arma —</option>
            {grouped.map(g => (
              <optgroup key={g.label} label={g.label}>
                {g.weapons.map(w => (
                  <option key={w.id} value={w.id}>{w.name}</option>
                ))}
              </optgroup>
            ))}
          </select>
        </div>

        {/* Options row */}
        <div className="mb-4 flex flex-wrap items-end gap-4">
          <div className="w-28">
            <label className="mb-1 block text-sm" style={{ color: 'var(--color-text-muted)' }}>Bônus mágico</label>
            <input
              type="number"
              value={magicText}
              onChange={e => setMagicText(e.target.value)}
              onBlur={handleMagicBlur}
              className="w-full px-3 py-2 text-base [appearance:textfield] [&::-webkit-inner-spin-button]:appearance-none [&::-webkit-outer-spin-button]:appearance-none"
              style={inputStyle}
            />
          </div>

          <div className="flex flex-col gap-2 pb-0.5">
            <label className="flex cursor-pointer select-none items-center gap-2 text-sm"
              style={{ color: 'var(--color-text-secondary)' }}>
              <input
                type="checkbox"
                checked={proficient}
                onChange={e => setProficient(e.target.checked)}
              />
              Proficiente
            </label>
            {hasFinesse && (
              <div className="flex items-center gap-3 text-sm" style={{ color: 'var(--color-text-secondary)' }}>
                <span>Finesse:</span>
                <label className="flex cursor-pointer select-none items-center gap-1">
                  <input type="radio" name="finesse" value="str"
                    checked={finesseAttr === 'str'}
                    onChange={() => setFinesseAttr('str')} />
                  FOR
                </label>
                <label className="flex cursor-pointer select-none items-center gap-1">
                  <input type="radio" name="finesse" value="dex"
                    checked={finesseAttr === 'dex'}
                    onChange={() => setFinesseAttr('dex')} />
                  DES
                </label>
              </div>
            )}
          </div>
        </div>

        {/* Preview */}
        {selected && (
          <div className="mb-4 rounded px-4 py-3"
            style={{ background: 'var(--color-bg-tertiary)', border: '1px solid var(--color-border-default)' }}>
            {isVersatile ? (
              <div className="space-y-1.5">
                {([false, true] as const).map(twoH => (
                  <div key={String(twoH)} className="flex items-baseline gap-4">
                    <span className="w-14 shrink-0 text-xs" style={{ color: 'var(--color-text-muted)' }}>
                      {twoH ? '2 mãos' : '1 mão'}
                    </span>
                    <span style={{ color: 'var(--color-gold-light)' }}>
                      {calcAttackBonus(selected, char, proficient, magicBonus, finesseAttr)}
                    </span>
                    <span style={{ color: 'var(--color-text-primary)' }}>
                      {calcDamageStr(selected, char, magicBonus, twoH, finesseAttr)}
                    </span>
                  </div>
                ))}
              </div>
            ) : (
              <div className="flex flex-wrap items-baseline gap-6">
                <div>
                  <span className="text-xs" style={{ color: 'var(--color-text-muted)' }}>Ataque</span>
                  <p className="text-2xl leading-tight" style={{ color: 'var(--color-gold-light)' }}>
                    {calcAttackBonus(selected, char, proficient, magicBonus, finesseAttr)}
                  </p>
                </div>
                <div>
                  <span className="text-xs" style={{ color: 'var(--color-text-muted)' }}>Dano</span>
                  <p className="text-xl leading-tight" style={{ color: 'var(--color-text-primary)' }}>
                    {calcDamageStr(selected, char, magicBonus, false, finesseAttr)}
                  </p>
                </div>
                {(selected.data.weight as number) > 0 && (
                  <div className="ml-auto">
                    <span className="text-xs" style={{ color: 'var(--color-text-muted)' }}>Peso</span>
                    <p className="text-sm" style={{ color: 'var(--color-text-muted)' }}>
                      {selected.data.weight as number} lb
                    </p>
                  </div>
                )}
              </div>
            )}
          </div>
        )}

        {/* Buttons */}
        <div className="flex gap-2">
          <button
            onClick={handleConfirm}
            disabled={!selected}
            className="arcane-btn flex-1 py-2 text-base disabled:opacity-40"
          >
            Confirmar
          </button>
          <button
            onClick={onClose}
            className="rounded px-4 py-2 text-base"
            style={{ border: '1px solid var(--color-border-default)', color: 'var(--color-text-muted)' }}
          >
            Cancelar
          </button>
        </div>
      </div>
    </div>
  )
}
