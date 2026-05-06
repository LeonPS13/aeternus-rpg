import type { Metadata } from 'next'
import AppLayout from '@/components/layout/AppLayout'
import MasterShield from '@/components/tools/MasterShield'

export const metadata: Metadata = { title: 'Escudo do Mestre — Æternus RPG' }

export default function Page() {
  return <AppLayout><MasterShield /></AppLayout>
}
