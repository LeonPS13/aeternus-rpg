import Sidebar from './Sidebar'

export default function AppLayout({ children }: { children: React.ReactNode }) {
  return (
    <div className="flex h-full" style={{ background: 'var(--color-bg-primary)' }}>
      <Sidebar />
      <main className="relative flex flex-1 flex-col overflow-auto">
        <div className="pointer-events-none absolute inset-0"
          style={{ background: 'radial-gradient(ellipse at 50% 0%, rgba(201,168,76,0.04) 0%, transparent 60%)' }} />
        <div className="relative z-10 flex flex-1 flex-col">{children}</div>
      </main>
    </div>
  )
}
