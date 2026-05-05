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
  globals.css                  Tailwind v4 + keyframes + noise texture
  layout.tsx                   Root layout
  tools/
    dice-roller/page.tsx
    adventure-diary/page.tsx

components/
  layout/
    AppLayout.tsx              Sidebar + main com ambient glow
    Sidebar.tsx                Nav lateral com logo e ferramentas

  tools/
    DiceRoller/                Rolador de dados completo
    AdventureDiary/            Diário de aventura (Supabase)

lib/
  supabase.ts                  Client Supabase singleton (createClient)
  dice.ts                      Lógica de rolagem (crypto.getRandomValues + rejection sampling)
  adventure.ts                 CRUD Supabase para Adventure/DiaryEntry

types/
  dice.ts                      DieType, DiceConfig, RollRecord
  adventure.ts                 Adventure, DiaryEntry, ActiveTab

public/
  logo.png                     Logo Aeternus RPG (pedra escura, letras douradas, glow teal)

.env.local                     NEXT_PUBLIC_SUPABASE_URL + NEXT_PUBLIC_SUPABASE_ANON_KEY (não commitado)
```

---

## Supabase

**Projeto:** `zgebucfjvvctunnpdijn` (conta separada, não conectada ao MCP do Claude)

**Tabelas:**

| Tabela | Descrição |
|---|---|
| `adventures` | id (text PK, 6 chars), name, master_id, created_at |
| `adventure_memberships` | adventure_id + player_id (PK composta) — controla quem tem acesso |
| `diary_entries` | id (uuid), adventure_id, date, title, summary, tags[], author_id, diary_type, created_at, updated_at |

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
| `saveEntry(entry)` | async — upsert por id |
| `deleteEntry(id)` | async |

---

## Identidade Visual

- **Fundo**: `bg-slate-950` / `bg-slate-900`
- **CTAs primários**: `bg-gradient-to-r from-amber-600 to-orange-700`
- **Links ativos**: `border-amber-500/30 bg-amber-500/10 text-amber-300`
- **Acentos secundários** (busca, tags, rune glow): cyan/teal — `text-cyan-400`, `bg-cyan-500/10`
- **Ambient glow**: teal sutil no topo direito, amber no canto inferior esquerdo (`AppLayout.tsx`)
- **Sidebar**: gradiente `from-slate-900 to-slate-950`, borda `border-amber-700/20`
- **Evitar**: violet, purple, blue como acento primário — inconsistente com o logo

---

## Ferramentas implementadas

| Ferramenta | Rota | Componente principal |
|---|---|---|
| Rolador de Dados | `/tools/dice-roller` | `components/tools/DiceRoller/index.tsx` |
| Diário de Aventura | `/tools/adventure-diary` | `components/tools/AdventureDiary/index.tsx` |

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

---

## Ferramentas planejadas (ainda não implementadas)

- Gerador de Personagem (`/tools/character-generator`)
- Tabelas de Encontro (`/tools/encounter-tables`)
- Mapa de Masmorra (`/tools/dungeon-map`)
