import type { Metadata } from 'next'
import AppLayout from '@/components/layout/AppLayout'
import DiceRoller from '@/components/tools/DiceRoller'

export const metadata: Metadata = {
  title: 'Rolador de Dados — Aeternus RPG',
  description: 'Role dados profissionalmente: d4, d6, d8, d10, d12, d20 e d100 com modificadores e histórico.',
}

export default function DiceRollerPage() {
  return (
    <AppLayout>
      <DiceRoller />
    </AppLayout>
  )
}
