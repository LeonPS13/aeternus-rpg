import type { Metadata } from 'next'
import AppLayout from '@/components/layout/AppLayout'
import CharacterSheet from '@/components/tools/CharacterSheet'

export const dynamic = 'force-dynamic'

export const metadata: Metadata = {
  title: 'Ficha de Personagem — Aeternus RPG',
  description: 'Crie e gerencie fichas de personagem D&D 5e SRD.',
}

export default function CharacterSheetPage() {
  return (
    <AppLayout>
      <CharacterSheet />
    </AppLayout>
  )
}
