@AGENTS.md

# Aeternus RPG

SaaS de ferramentas para RPG de mesa. Stack: Next.js 16.2.4 (App Router), React 19, TypeScript 5, Tailwind CSS v4, Lucide React, Supabase.

---

## Comandos

```powershell
$env:PATH = "C:\Program Files\nodejs;$env:PATH"; npm.cmd run dev
$env:PATH = "C:\Program Files\nodejs;$env:PATH"; npm.cmd run build
```

> PowerShell exige `npm.cmd` + PATH manual — `.ps1` bloqueado pela execution policy.

---

## Tailwind v4

Sem `tailwind.config.js`. Config em `app/globals.css` (`@import "tailwindcss"`). Animações customizadas: `fade-up`, `roll-spin`, `result-pop`, `slot-tick`.

**Gotcha:** valores arbitrários com vírgulas (ex: `grid-cols-[minmax(0,1fr)_...]`) podem não ser gerados. Para layouts com `flex: 1 1 0%` / `min-width: 0` / `minmax`, use classes em `globals.css` com `@media` explícito.

---

## Identidade Visual

**Nunca usar classes Tailwind de cor** — sempre `style={{ color: 'var(--color-*)' }}`.

CSS custom properties definidas em `app/globals.css`. Variáveis: `--color-bg-primary/secondary/tertiary`, `--color-gold/gold-light/gold-dark/gold-glow`, `--color-accent`, `--color-text-primary/secondary/muted`, `--color-border-default`.

**Classes CSS globais:** `.arcane-panel`, `.arcane-btn`, `.ornament-divider`, `.section-label`, `.attack-row`, `.attack-col` — definidas em `globals.css`, nunca recriar via Tailwind.

**Tipografia:** Jacquard 12 via `next/font/google`, `font-sans`. `html { font-size: 22px }` desktop / `18px` mobile. Usar `leading-none` em chips/botões (ascender alto da fonte).

---

## Sistema de Temas

3 temas aplicados como classe no `<html>`: `.theme-grimoire` (padrão), `.theme-cyber`, `.theme-nuclear`. Persistido em `localStorage['aeternus_theme']`. Usar `useTheme()` de `context/theme.tsx`.

---

## Supabase

**Projeto:** `zgebucfjvvctunnpdijn`

**Tabelas:** `adventures`, `adventure_memberships`, `diary_entries`, `characters`, `codex`

**Identidade do jogador:** UUID em `localStorage['aeternus_player_id']` — sem Supabase Auth.

RLS habilitado com políticas abertas (MVP). `lib/supabase.ts` exporta `getSupabase()` singleton.

Migrações aplicadas em prod:
- `ALTER TABLE adventures ADD COLUMN IF NOT EXISTS icon TEXT DEFAULT 'BookOpen';`
- `ALTER TABLE characters ADD COLUMN IF NOT EXISTS subrace TEXT DEFAULT '';`
- `ALTER TABLE characters ADD COLUMN IF NOT EXISTS racial_asi JSONB DEFAULT '{}';`

---

## Regras de código

- Dados: `crypto.getRandomValues()` + rejection sampling — nunca `Math.random()` para resultados reais
- Sem comentários salvo WHY não-óbvio
- `FormEvent` deprecado no React 19 — usar `React.SyntheticEvent` inline
- snake_case (DB) ↔ camelCase (TS) feito nas funções de `lib/`
- Inputs numéricos: estado local `string` + normalização no `onBlur` (padrão NumInput)
- Auto-save da ficha: `isDirty` ref + debounce 1500ms; flush no `onBack`
- EP (Electrum) existe no schema `characters` mas é ocultado da UI

---

## Automação da Ficha

### Classe (`lib/classAutomation.ts`)
- `applyClassDefaults(cls)` — aplica saving throws, speed, proficiências ao selecionar classe
- `applyRaceDefaults(entry, prevRacialAsi, scores)` — reverte ASI anterior e aplica novo; atualiza `speed` e `racialAsi`
- `buildFeaturesTraitsText(raceEntry, activeSubrace)` — gera texto de traços raciais para `featuresTraits`
- `buildProficienciesText(cls)` — gera texto de proficiências para `otherProficiencies`
- `WEAPON_PROF_TO_NAMES` — mapa de chave DB snake_case inglês → nome PT do codex (para filtro de armas por proficiência)

### Raça (`lib/races.ts`, `types/race.ts`)
- 9 raças do SRD implementadas como dados estáticos em `lib/races.ts`
- Raças com sub-raças: Dwarf, Elf, Halfling, Gnome
- Raças sem sub-raças: Human, Dragonborn, Half-Elf, Half-Orc, Tiefling
- `getRaceByNameEn(nameEn)` — lookup por nome EN (corresponde ao valor de `char.race`)
- `Character` tem `subrace: string` e `racialAsi: Partial<Record<string, number>>`
- Meio-Elfo: apenas CAR +2 automático; +1 em 2 atributos fica como nota para o jogador

### Filtros por proficiência de classe
- **Armas** (`WeaponPickerModal`): recebe `weaponProficiencies?: string[]`; filtra usando `WEAPON_PROF_TO_NAMES` para converter chaves EN → nomes PT do codex
- **Armaduras** (`ArmorSelector`): recebe `proficientTypes?: string[]`; `undefined` = sem classe (mostra tudo), `[]` = sem proficiência (mostra nada)

### Peso de carga
- Fórmula: `strScore × 15` lb (D&D 5e SRD)
- Exibido em `EquipmentSection` (edição) e `CharacterView` (leitura)
- Aviso vermelho "⚠ Sobrecarregado" se peso atual > máximo

---

## Quirks conhecidos

- **ArmorSelector:** restaura dropdown via `useEffect` quando armaduras carregam do Codex — sem isso volta a "Sem armadura" ao reabrir ficha
- **CombatSection:** tabela de ataques usa `.attack-row`/`.attack-col` (globals.css) + `StatDropdown` customizado, não `<select>` nativo
- **Codex:** cache module-level em `Codex/index.tsx` — não re-faz fetch ao navegar de volta
- **IdentitySection:** `applyRaceDefaults` precisa dos scores atuais e do `racialAsi` anterior para calcular o delta corretamente — não chamar com `char` stale

---

## Nova ferramenta

1. `app/tools/[nome]/page.tsx` com metadata + `<AppLayout>`
2. `components/tools/[NomePascalCase]/index.tsx`
3. Entrada em `components/layout/Sidebar.tsx` (array `tools`)

---

## Ferramentas planejadas

- Tabelas de Encontro (`/tools/encounter-tables`)
- Mapa de Masmorra (`/tools/dungeon-map`)
