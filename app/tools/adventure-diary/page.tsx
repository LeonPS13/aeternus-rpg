import type { Metadata } from 'next'
import AppLayout from '@/components/layout/AppLayout'
import AdventureDiary from '@/components/tools/AdventureDiary'

export const dynamic = 'force-dynamic'

export const metadata: Metadata = {
  title: 'Diário de Aventura — Aeternus RPG',
  description: 'Registre sessões, crie anotações pessoais e compartilhe o diário da aventura com sua mesa.',
}

export default function AdventureDiaryPage() {
  return (
    <AppLayout>
      <AdventureDiary />
    </AppLayout>
  )
}
