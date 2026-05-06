import type { Metadata } from 'next'
import AppLayout from '@/components/layout/AppLayout'
import Codex from '@/components/tools/Codex'

export const dynamic = 'force-dynamic'

export const metadata: Metadata = {
  title: 'Codex — Aeternus RPG',
  description: 'Biblioteca D&D 5e SRD: armas, armaduras e equipamento de aventureiro.',
}

export default function CodexPage() {
  return (
    <AppLayout>
      <Codex />
    </AppLayout>
  )
}
