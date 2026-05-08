import type { Metadata } from 'next'
import { Geist, Geist_Mono, Jacquard_12, Jersey_10, Teko } from 'next/font/google'
import './globals.css'
import { ThemeProvider } from '@/context/theme'

const geistSans = Geist({
  variable: '--font-geist-sans',
  subsets: ['latin'],
})

const geistMono = Geist_Mono({
  variable: '--font-geist-mono',
  subsets: ['latin'],
})

const jacquard12 = Jacquard_12({
  variable: '--font-jacquard',
  weight: '400',
  subsets: ['latin'],
})

const jersey10 = Jersey_10({
  variable: '--font-jersey',
  weight: '400',
  subsets: ['latin'],
})

const teko = Teko({
  variable: '--font-teko',
  weight: ['400', '500', '600', '700'],
  subsets: ['latin'],
})

export const metadata: Metadata = {
  title: 'Aeternus RPG',
  description: 'Ferramentas profissionais para mesas de RPG',
}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html
      lang="pt-BR"
      className={`${geistSans.variable} ${geistMono.variable} ${jacquard12.variable} ${jersey10.variable} ${teko.variable} h-full antialiased`}
    >
      <body className="h-full"><ThemeProvider>{children}</ThemeProvider></body>
    </html>
  )
}
