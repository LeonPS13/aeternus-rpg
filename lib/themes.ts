import type { Theme } from '@/types/theme'

export const GRIMOIRE_ARCANE: Theme = {
  id: 'grimoire-arcane',
  name: 'Grimório Arcano',
  cssClass: 'theme-grimoire',
}

export const CYBER_FUTURE: Theme = {
  id: 'cyber-future',
  name: 'Futuro Cibernético',
  cssClass: 'theme-cyber',
}

export const NUCLEAR_ACCIDENT: Theme = {
  id: 'nuclear-accident',
  name: 'Acidente Nuclear',
  cssClass: 'theme-nuclear',
}

export const THEMES: Theme[] = [GRIMOIRE_ARCANE, CYBER_FUTURE, NUCLEAR_ACCIDENT]

export function applyTheme(theme: Theme): void {
  document.documentElement.classList.remove(...THEMES.map(t => t.cssClass))
  document.documentElement.classList.add(theme.cssClass)
}

export function loadSavedTheme(): Theme {
  try {
    const id = localStorage.getItem('aeternus_theme')
    if (id) return THEMES.find(t => t.id === id) ?? THEMES[0]
  } catch {}
  return THEMES[0]
}

export function saveTheme(id: string): void {
  localStorage.setItem('aeternus_theme', id)
}
