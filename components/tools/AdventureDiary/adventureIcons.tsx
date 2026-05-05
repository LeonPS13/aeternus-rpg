import {
  BookOpen, Crown, Shield, Map, Compass, Flame, Star, Eye,
  Gem, Zap, Moon, Key, Trophy, Skull, Swords, Wand2, ScrollText, Castle,
} from 'lucide-react'
import type { ComponentType } from 'react'

interface LucideIconProps {
  size?: number
  className?: string
  style?: React.CSSProperties
}

export const ADVENTURE_ICONS: { id: string; component: ComponentType<LucideIconProps> }[] = [
  { id: 'BookOpen',   component: BookOpen   },
  { id: 'Crown',      component: Crown      },
  { id: 'Shield',     component: Shield     },
  { id: 'Map',        component: Map        },
  { id: 'Compass',    component: Compass    },
  { id: 'Flame',      component: Flame      },
  { id: 'Star',       component: Star       },
  { id: 'Eye',        component: Eye        },
  { id: 'Gem',        component: Gem        },
  { id: 'Zap',        component: Zap        },
  { id: 'Moon',       component: Moon       },
  { id: 'Key',        component: Key        },
  { id: 'Trophy',     component: Trophy     },
  { id: 'Skull',      component: Skull      },
  { id: 'Swords',     component: Swords     },
  { id: 'Wand2',      component: Wand2      },
  { id: 'ScrollText', component: ScrollText },
  { id: 'Castle',     component: Castle     },
]

export function getAdventureIcon(id?: string): ComponentType<LucideIconProps> {
  return ADVENTURE_ICONS.find((i) => i.id === id)?.component ?? BookOpen
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
              color: 'var(--color-gold)',
            } : {
              background: 'var(--color-bg-tertiary)',
              border: '1px solid var(--color-border-default)',
              color: 'var(--color-text-muted)',
            }}
          >
            <Icon size={14} />
          </button>
        )
      })}
    </div>
  )
}
