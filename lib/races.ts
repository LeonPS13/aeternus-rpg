import type { RaceEntry } from '@/types/race'

export const RACE_DATA: RaceEntry[] = [
  {
    id: 'dwarf',
    name: 'Anão',
    nameEn: 'Dwarf',
    speed: 25,
    traits: {
      traits: [
        'Visão no Escuro (18 m)',
        'Resiliência Anã: vantagem em resistências contra veneno; resistência a dano de veneno',
        'Treinamento de Combate Anão: proficiência com machadinha, machado de batalha, martelo e martelo de guerra',
        'Habilidade com Ferramentas: proficiência com ferramentas de ferreiro, cervejeiro ou pedreiro',
        'Sentido de Pedra: dobro do bônus de proficiência em testes de História sobre origem de estruturas de pedra',
      ],
      languages: ['Comum', 'Anão'],
    },
    subraces: [
      {
        id: 'dwarf_hill',
        name: 'Anão da Colina',
        nameEn: 'Hill Dwarf',
        asi: { con: 2, wis: 1 },
        extraTraits: ['Tenacidade Anã: máximo de pontos de vida aumenta em 1 por nível'],
      },
      {
        id: 'dwarf_mountain',
        name: 'Anão da Montanha',
        nameEn: 'Mountain Dwarf',
        asi: { str: 2, con: 2 },
        extraTraits: ['Treinamento com Armadura Anã: proficiência com armaduras leves e médias'],
      },
    ],
  },

  {
    id: 'elf',
    name: 'Elfo',
    nameEn: 'Elf',
    speed: 30,
    traits: {
      traits: [
        'Visão no Escuro (18 m)',
        'Sentidos Aguçados: proficiência em Percepção',
        'Ancestralidade Feérica: vantagem em saves contra encantamento; imune a efeitos de sono mágico',
        'Transe: em vez de dormir, medita em semiconsciência por 4 horas (equivale a 8 horas de descanso)',
      ],
      languages: ['Comum', 'Élfico'],
    },
    subraces: [
      {
        id: 'elf_high',
        name: 'Alto Elfo',
        nameEn: 'High Elf',
        asi: { dex: 2, int: 1 },
        extraTraits: [
          'Treinamento com Armas Élfico: proficiência com espada longa, espada curta, arco longo e arco curto',
          'Truque: aprenda um truque de mago à sua escolha (usa INT)',
          'Idioma Extra: um idioma adicional à sua escolha',
        ],
      },
      {
        id: 'elf_wood',
        name: 'Elfo da Floresta',
        nameEn: 'Wood Elf',
        asi: { dex: 2, wis: 1 },
        extraTraits: [
          'Treinamento com Armas Élfico: proficiência com espada longa, espada curta, arco longo e arco curto',
          'Passo Rápido: deslocamento base aumenta para 10,5 m (35 pés)',
          'Máscara da Floresta: pode se esconder quando levemente obscurecido por folhagem, chuva forte, neve, névoa ou outro fenômeno natural',
        ],
      },
      {
        id: 'elf_drow',
        name: 'Drow',
        nameEn: 'Dark Elf',
        asi: { dex: 2, cha: 1 },
        extraTraits: [
          'Visão no Escuro Superior: alcance de 36 m (120 pés)',
          'Sensibilidade à Luz Solar: desvantagem em ataques e testes de Percepção baseados em visão sob luz solar direta',
          'Magia Drow: truque Luzes Dançantes; nível 3: Fogo das Fadas 1x/descanso longo; nível 5: Escuridão 1x/descanso longo (usa CAR)',
          'Treinamento com Armas Drow: proficiência com rapieira, espada curta e besta de mão',
        ],
      },
    ],
  },

  {
    id: 'halfling',
    name: 'Halfling',
    nameEn: 'Halfling',
    speed: 25,
    traits: {
      traits: [
        'Sortudo: ao tirar 1 natural em ataque, teste de atributo ou resistência, role o dado novamente e use o novo resultado',
        'Bravo: vantagem em saves contra o estado amedrontado',
        'Agilidade de Halfling: pode se mover pelo espaço de qualquer criatura de tamanho Médio ou maior',
      ],
      languages: ['Comum', 'Halfling'],
    },
    subraces: [
      {
        id: 'halfling_lightfoot',
        name: 'Pé-Leve',
        nameEn: 'Lightfoot',
        asi: { dex: 2, cha: 1 },
        extraTraits: ['Furtividade Natural: pode tentar se esconder quando obscurecido apenas por uma criatura de tamanho Médio ou maior'],
      },
      {
        id: 'halfling_stout',
        name: 'Robusto',
        nameEn: 'Stout',
        asi: { dex: 2, con: 1 },
        extraTraits: ['Robustez Stout: vantagem em saves contra veneno; resistência a dano de veneno'],
      },
    ],
  },

  {
    id: 'human',
    name: 'Humano',
    nameEn: 'Human',
    speed: 30,
    traits: {
      traits: ['+1 em todos os atributos'],
      languages: ['Comum', 'Um idioma adicional à sua escolha'],
    },
    asi: { str: 1, dex: 1, con: 1, int: 1, wis: 1, cha: 1 },
  },

  {
    id: 'dragonborn',
    name: 'Draconato',
    nameEn: 'Dragonborn',
    speed: 30,
    traits: {
      traits: [
        'Ancestralidade Dracônica: escolha um tipo de dragão; determina o tipo de dano e a forma do seu sopro',
        'Arma de Sopro: ação; cone de 4,5 m ou linha de 1,5 × 9 m; CD = 8 + mod CON + bônus de proficiência; 2d6 (aumenta com o nível)',
        'Resistência a Dano: resistência ao tipo de dano da sua ancestralidade dracônica',
      ],
      languages: ['Comum', 'Dracônico'],
    },
    asi: { str: 2, cha: 1 },
  },

  {
    id: 'gnome',
    name: 'Gnomo',
    nameEn: 'Gnome',
    speed: 25,
    traits: {
      traits: [
        'Visão no Escuro (18 m)',
        'Astúcia de Gnomo: vantagem em saves de INT, SAB e CAR contra magia',
      ],
      languages: ['Comum', 'Gnômico'],
    },
    subraces: [
      {
        id: 'gnome_forest',
        name: 'Gnomo da Floresta',
        nameEn: 'Forest Gnome',
        asi: { int: 2, dex: 1 },
        extraTraits: [
          'Ilusionismo Natural: truque Ilusão Menor gratuitamente (usa INT)',
          'Falar com Pequenas Bestas: pode se comunicar com animais de tamanho Miúdo ou menor',
        ],
      },
      {
        id: 'gnome_rock',
        name: 'Gnomo da Rocha',
        nameEn: 'Rock Gnome',
        asi: { int: 2, con: 1 },
        extraTraits: [
          'Conhecimento de Artificer: dobro do bônus de proficiência em testes de História sobre itens mágicos, alquímicos ou tecnológicos',
          'Chapinador: pode construir dispositivos mecânicos simples com 1 hora de trabalho',
        ],
      },
    ],
  },

  {
    id: 'half_elf',
    name: 'Meio-Elfo',
    nameEn: 'Half-Elf',
    speed: 30,
    traits: {
      traits: [
        'CAR +2 aplicado automaticamente; +1 a dois atributos à sua escolha — aplique manualmente nos atributos',
        'Visão no Escuro (18 m)',
        'Ancestralidade Feérica: vantagem em saves contra encantamento; imune a efeitos de sono mágico',
        'Versatilidade de Perícias: proficiência em 2 perícias à sua escolha — marque manualmente na aba Identificação',
      ],
      languages: ['Comum', 'Élfico', 'Um idioma adicional à sua escolha'],
    },
    asi: { cha: 2 },
  },

  {
    id: 'half_orc',
    name: 'Meio-Orc',
    nameEn: 'Half-Orc',
    speed: 30,
    traits: {
      traits: [
        'Visão no Escuro (18 m)',
        'Ameaçador: proficiência em Intimidação',
        'Resistência Implacável: quando reduzido a 0 PV (exceto por morte instantânea), cai para 1 PV em vez disso — 1x por descanso longo',
        'Ataques Selvagens: em acerto crítico com arma corpo a corpo, role um dos dados de dano do ataque uma vez adicional',
      ],
      languages: ['Comum', 'Orc'],
    },
    asi: { str: 2, con: 1 },
  },

  {
    id: 'tiefling',
    name: 'Tiefling',
    nameEn: 'Tiefling',
    speed: 30,
    traits: {
      traits: [
        'Visão no Escuro (18 m)',
        'Resistência Infernal: resistência a dano de fogo',
        'Legado Infernal: truque Taumaturgia; nível 3: Represália Infernal 1x/descanso longo (como 2º círculo); nível 5: Escuridão 1x/descanso longo (usa CAR)',
      ],
      languages: ['Comum', 'Infernal'],
    },
    asi: { cha: 2, int: 1 },
  },
]

export function getRaceByNameEn(nameEn: string): RaceEntry | undefined {
  return RACE_DATA.find(r => r.nameEn === nameEn)
}
