@AGENTS.md

# Aeternus RPG

SaaS de ferramentas para RPG de mesa. Stack: Next.js 16.2.4 (App Router), React 19, TypeScript 5, Tailwind CSS v4, Lucide React.

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
    AdventureDiary/            Diário de aventura (localStorage MVP)

lib/
  dice.ts                      Lógica de rolagem (crypto.getRandomValues + rejection sampling)
  adventure.ts                 CRUD localStorage para Adventure/DiaryEntry

types/
  dice.ts                      DieType, DiceConfig, RollRecord
  adventure.ts                 Adventure, DiaryEntry, ActiveTab

public/
  logo.png                     Logo Aeternus RPG (pedra escura, letras douradas, glow teal)
```

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

## localStorage (Adventure Diary)

| Chave | Conteúdo |
|---|---|
| `aeternus_player_id` | UUID gerado na primeira visita — distingue mestre de jogador |
| `aeternus_adventures` | `Adventure[]` JSON |
| `aeternus_entries` | `DiaryEntry[]` JSON |

Helpers em `lib/adventure.ts`. Arquitetura pronta para migração ao Supabase.

---

## Regras de código

- Dados rolados com `crypto.getRandomValues()` + rejection sampling (sem `Math.random()`)
- Sem comentários a menos que o WHY seja não-óbvio
- `FormEvent` do React está deprecado no React 19 — usar `React.SyntheticEvent` ou `React.FormEvent` inline sem importar
- Sem `useEffect` para sync de estado com localStorage — escrita síncrona direta

---

## Ferramentas planejadas (ainda não implementadas)

- Gerador de Personagem (`/tools/character-generator`)
- Tabelas de Encontro (`/tools/encounter-tables`)
- Mapa de Masmorra (`/tools/dungeon-map`)
