'use client'

import { createContext, useContext, useState, useEffect, type ReactNode } from 'react'
import type { Theme } from '@/types/theme'
import { THEMES, applyTheme, loadSavedTheme, saveTheme } from '@/lib/themes'

interface ThemeContextValue {
  theme: Theme
  setTheme: (theme: Theme) => void
}

const ThemeContext = createContext<ThemeContextValue | null>(null)

export function ThemeProvider({ children }: { children: ReactNode }) {
  const [theme, setThemeState] = useState<Theme>(THEMES[0])

  useEffect(() => {
    const saved = loadSavedTheme()
    applyTheme(saved)
    setThemeState(saved)
  }, [])

  function setTheme(t: Theme) {
    setThemeState(t)
    applyTheme(t)
    saveTheme(t.id)
  }

  return (
    <ThemeContext.Provider value={{ theme, setTheme }}>
      {children}
    </ThemeContext.Provider>
  )
}

export function useTheme() {
  const ctx = useContext(ThemeContext)
  if (!ctx) throw new Error('useTheme must be used within ThemeProvider')
  return ctx
}
