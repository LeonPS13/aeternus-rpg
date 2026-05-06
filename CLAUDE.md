@AGENTS.md

# Aeternus RPG

SaaS de ferramentas para RPG de mesa. Stack: Next.js 16.2.4 (App Router), React 19, TypeScript 5, Tailwind CSS v4, Lucide React, Supabase.

---

## Comandos

```powershell
# Dev server (PowerShell)
$env:PATH = "C:\Program Files\nodejs;$env:PATH"; npm.cmd run dev

# Ou simplesmente abrir o start-dev.bat na raiz do projeto

# Build
$env:PATH = "C:\Program Files\nodejs;$env:PATH"; npm.cmd run build
```

> npm/npx no PowerShell exige chamar `npm.cmd` e setar o PATH manualmente — executar `.ps1` está bloqueado pela execution policy.

---

## Tailwind v4

Sem `tailwind.config.js`. Configuração em `app/globals.css`:

```css
@import "tailwindcss";
@custom-variant dark (&:is(.dark *));
@theme inline { ... }
```

Animações customizadas definidas em `globals.css` via `@keyframes`: `fade-up`, `roll-spin`, `result-pop`, `slot-tick`.

---

## Estrutura de arquivos

```
app/
  globals.css                  Tailwind v4 + keyframes + noise texture + CSS vars
  layout.tsx                   Root layout
  tools/
    dice-roller/page.tsx
    adventure-diary/page.tsx
    character-sheet/page.tsx

components/
  layout/
    AppLayout.tsx              Sidebar + main com ambient glow
    Sidebar.tsx                Nav lateral com logo "Æternus / RPG" e ferramentas

  tools/
    DiceRoller/                Rolador de dados completo
    AdventureDiary/            Diário de aventura (Supabase)
      adventureIcons.tsx       Lista de 18 ícones RPG + componente IconPicker
      EditAdventureModal.tsx   Modal para editar nome e ícone da aventura
    CharacterSheet/            Ficha de personagem D&D 5e SRD (Supabase)
      index.tsx                Orquestrador — 4 modos: list / create / view / edit
      CharacterList.tsx        Lista de fichas com confirmação de exclusão
      WizardView.tsx           Criação passo a passo (5 etapas sequenciais)
      CharacterView.tsx        Visão de leitura com edição rápida inline
      SheetView.tsx            Edição completa com abas livres
      sections/
        IdentitySection.tsx
        StatsSection.tsx
        CombatSection.tsx
        EquipmentSection.tsx
        TraitsSection.tsx

lib/
  supabase.ts                  Client Supabase singleton (createClient)
  dice.ts                      Lógica de rolagem (crypto.getRandomValues + rejection sampling)
  adventure.ts                 CRUD Supabase para Adventure/DiaryEntry
  character.ts                 CRUD Supabase para Character (getCharacters, saveCharacter, deleteCharacter, createEmptyCharacter)
  character-calc.ts            Cálculos D&D 5e SRD: mod(), profBonus(), calcAC(), calcInitiative(), calcSkillValue(), etc.

types/
  dice.ts                      DieType, DiceConfig, RollRecord
  adventure.ts                 Adventure, DiaryEntry, ActiveTab
  character.ts                 Character, CharacterAttack, InventoryItem, Skills, CLASSES, RACES, ALIGNMENTS

.env.local                     NEXT_PUBLIC_SUPABASE_URL + NEXT_PUBLIC_SUPABASE_ANON_KEY (não commitado)
```

---

## Supabase

**Projeto:** `zgebucfjvvctunnpdijn` (conta separada, não conectada ao MCP do Claude)

**Tabelas:**

| Tabela | Descrição |
|---|---|
| `adventures` | id (text PK, 6 chars), name, master_id, created_at, icon (text, default 'BookOpen') |
| `adventure_memberships` | adventure_id + player_id (PK composta) — controla quem tem acesso |
| `diary_entries` | id (uuid), adventure_id, date, title, summary, tags[], author_id, diary_type, created_at, updated_at |

**Migração pendente** (rodar no SQL Editor do Supabase se coluna `icon` ainda não existir):
```sql
ALTER TABLE adventures ADD COLUMN IF NOT EXISTS icon TEXT DEFAULT 'BookOpen';
```

O código já tem fallback resiliente: tenta upsert com `icon`, e se falhar (coluna inexistente) refaz sem o campo.

RLS habilitado com políticas abertas (MVP sem autenticação).

**Identidade do jogador:** UUID gerado na primeira visita, persistido em `localStorage['aeternus_player_id']`. Distingue mestre de jogador sem Supabase Auth.

**Funções em `lib/adventure.ts`:**

| Função | Descrição |
|---|---|
| `getPlayerId()` | sync — localStorage |
| `generateAdventureId()` | sync — 6 chars, charset sem ambiguidade |
| `getAdventures(playerId)` | async — via adventure_memberships JOIN |
| `findAdventure(id)` | async — busca por código para entrar |
| `saveAdventure(adv, playerId)` | async — upsert adventure + membership |
| `deleteAdventure(adventureId)` | async — mestre exclui tudo (cascade) |
| `leaveAdventure(adventureId, playerId)` | async — jogador remove só sua membership |
| `getEntries(adventureId)` | async |
| `updateAdventure(id, name, icon)` | async — edição de nome/ícone pelo mestre |
| `saveEntry(entry)` | async — upsert por id |
| `deleteEntry(id)` | async |

---

## Identidade Visual — Grimório Arcano

Todas as cores via CSS custom properties em `app/globals.css`. **Nunca usar classes Tailwind de cor** — usar `style={{ color: 'var(--color-*)' }}`.

| Variável | Valor | Uso |
|---|---|---|
| `--color-bg-primary` | `#181208` | Fundo da página |
| `--color-bg-secondary` | `#261C0E` | Painéis, sidebar |
| `--color-bg-tertiary` | `#322412` | Inputs, chips |
| `--color-gold` | `#C9A84C` | Bordas ativas, ícones |
| `--color-gold-light` | `#E8C96A` | Texto em destaque |
| `--color-gold-dark` | `#8B6914` | Labels de seção |
| `--color-gold-glow` | `rgba(201,168,76,0.15)` | Backgrounds sutis |
| `--color-accent` | `#7B1E1E` | Botão primário (vermelho escuro) |
| `--color-text-primary` | `#F0E6CC` | Texto principal |
| `--color-text-secondary` | `#A89060` | Texto secundário |
| `--color-text-muted` | `#6A5830` | Texto apagado, placeholders |
| `--color-border-default` | `rgba(201,168,76,0.3)` | Bordas padrão |

**Classes CSS globais:**
- `.arcane-panel` — card com ornamentos de canto dourados
- `.arcane-btn` — botão com clip-path octogonal e gradiente vermelho
- `.ornament-divider` — divisor com linhas e diamante dourado
- `.section-label` — label de seção em 18px, letra dourada

**Tipografia:** Jacquard 12 (medieval) via `next/font/google`. `html { font-size: 18px }` escala todos os utilitários rem do Tailwind. `font-sans` → Jacquard 12. Usar `leading-none` em chips/botões para compensar métricas de ascender da fonte.

**Logo sidebar:** "Æternus" / "RPG" em texto, `text-4xl tracking-widest`, sem imagem.

---

## Ferramentas implementadas

| Ferramenta | Rota | Componente principal |
|---|---|---|
| Rolador de Dados | `/tools/dice-roller` | `components/tools/DiceRoller/index.tsx` |
| Diário de Aventura | `/tools/adventure-diary` | `components/tools/AdventureDiary/index.tsx` |
| Ficha de Personagem | `/tools/character-sheet` | `components/tools/CharacterSheet/index.tsx` |

### Padrão para nova ferramenta

1. Criar `app/tools/[nome]/page.tsx` com metadata + `<AppLayout>`
2. Criar `components/tools/[NomePascalCase]/index.tsx`
3. Adicionar entrada em `components/layout/Sidebar.tsx` (array `tools`)

---

## Regras de código

- Dados rolados com `crypto.getRandomValues()` + rejection sampling (sem `Math.random()`)
- Sem comentários a menos que o WHY seja não-óbvio
- `FormEvent` do React está deprecado no React 19 — usar `React.SyntheticEvent` inline sem importar
- Todas as funções de lib/adventure.ts são async (exceto `getPlayerId` e `generateAdventureId`)
- Mapeamento snake_case (DB) ↔ camelCase (TypeScript) feito nas funções de lib
- Inputs numéricos usam padrão `NumInput`: estado local string + normalização no `onBlur` (permite apagar e redigitar sem travar em 0)
- Auto-save da ficha: `isDirty` ref + `useEffect` debounce 1500ms; flush imediato no `onBack`

---

## Ficha de Personagem — Supabase

**Tabela:** `characters`

Campos relevantes: `id`, `player_id`, `character_name`, `class`, `level`, `race`, `background`, `alignment`, `xp`, atributos (`str_score`…`cha_score`), combate (`ac_*`, `speed`, `initiative_bonus`), HP (`max_hp`, `current_hp`, `temp_hp`, `hit_dice_spent`), saves (`save_*_proficient`), `skills` (JSONB), `attacks` (JSONB), moedas (`cp`, `sp`, `ep`, `gp`, `pp`), `inventory` (JSONB — `{id, name, quantity, weight, description?}`), traços (`personality_traits`, `ideals`, `bonds`, `flaws`, `features_traits`, `other_proficiencies`).

> EP (Electrum) existe no schema mas é ocultado da UI — sem migração necessária.

**Funções em `lib/character.ts`:**

| Função | Descrição |
|---|---|
| `createEmptyCharacter(playerId)` | sync — retorna Character com defaults |
| `getCharacters(playerId)` | async — lista por player_id, ordem updated_at desc |
| `saveCharacter(character)` | async — upsert por id |
| `deleteCharacter(id)` | async — delete por id |

**Modos do orquestrador (`index.tsx`):**

| Modo | Componente | Descrição |
|---|---|---|
| `list` | `CharacterList` | Biblioteca de fichas |
| `create` | `WizardView` | 5 etapas sequenciais; save só na última |
| `view` | `CharacterView` | Leitura com edição inline (HP, moedas, inventário, ataques) |
| `edit` | `SheetView` | Abas livres, botão Salvar sempre visível |

---

## Ferramentas planejadas (ainda não implementadas)

- Tabelas de Encontro (`/tools/encounter-tables`)
- Mapa de Masmorra (`/tools/dungeon-map`)
