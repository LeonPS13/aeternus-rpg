import type { ComponentType } from 'react'

interface RpgIconProps {
  size?: number
  className?: string
  style?: React.CSSProperties
}

function makeRpgIcon(file: string): ComponentType<RpgIconProps> {
  function RpgIcon({ size = 16, style }: RpgIconProps) {
    const px = Math.round(size * 1.75)
    return (
      <img
        src={`/icons_2/${file}`}
        width={px}
        height={px}
        alt=""
        style={{ objectFit: 'contain', filter: 'invert(1)', ...style }}
      />
    )
  }
  RpgIcon.displayName = file.replace('.png', '')
  return RpgIcon
}

export const ADVENTURE_ICONS: { id: string; component: ComponentType<RpgIconProps> }[] = [
  { id: 'BookOpen',   component: makeRpgIcon('livro-magico.png')    },
  { id: 'Crown',      component: makeRpgIcon('capacete-viking.png') },
  { id: 'Shield',     component: makeRpgIcon('escudo.png')          },
  { id: 'Map',        component: makeRpgIcon('mapa.png')            },
  { id: 'Compass',    component: makeRpgIcon('binocular.png')       },
  { id: 'Flame',      component: makeRpgIcon('meteoro.png')         },
  { id: 'Star',       component: makeRpgIcon('diamante.png')        },
  { id: 'Eye',        component: makeRpgIcon('bola-de-cristal.png') },
  { id: 'Gem',        component: makeRpgIcon('perola.png')          },
  { id: 'Zap',        component: makeRpgIcon('varinha-magica.png')  },
  { id: 'Moon',       component: makeRpgIcon('curar.png')           },
  { id: 'Key',        component: makeRpgIcon('chave.png')           },
  { id: 'Trophy',     component: makeRpgIcon('dinheiro.png')        },
  { id: 'Skull',      component: makeRpgIcon('machado.png')         },
  { id: 'Swords',     component: makeRpgIcon('espada.png')          },
  { id: 'Wand2',      component: makeRpgIcon('chapeu-de-mago.png')  },
  { id: 'ScrollText', component: makeRpgIcon('mochila.png')         },
  { id: 'Castle',     component: makeRpgIcon('portao.png')          },
]

export function getAdventureIcon(id?: string): ComponentType<RpgIconProps> {
  return ADVENTURE_ICONS.find((i) => i.id === id)?.component ?? makeRpgIcon('livro-magico.png')
}

interface IconPickerProps {
  value: string
  onChange: (id: string) => void
}

export function IconPicker({ value, onChange }: IconPickerProps) {
  return (
    <div className="grid grid-cols-6 gap-1">
      {ADVENTURE_ICONS.map(({ id, component: Icon }) => {
        const selected = value === id
        return (
          <button
            key={id}
            type="button"
            onClick={() => onChange(id)}
            className="flex items-center justify-center rounded p-2 transition-all"
            style={selected ? {
              background: 'var(--color-gold-glow)',
              border: '1px solid var(--color-gold)',
            } : {
              background: 'var(--color-bg-tertiary)',
              border: '1px solid var(--color-border-default)',
            }}
          >
            <Icon size={14} />
          </button>
        )
      })}
    </div>
  )
}
