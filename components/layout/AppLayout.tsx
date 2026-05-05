import Sidebar from './Sidebar'

export default function AppLayout({ children }: { children: React.ReactNode }) {
  return (
    <div className="flex h-full bg-slate-950">
      <Sidebar />
      <main className="relative flex flex-1 flex-col overflow-auto">
        {/* Ambient glow matching logo colors */}
        <div className="pointer-events-none absolute inset-0 bg-[radial-gradient(ellipse_60%_40%_at_70%_-10%,rgba(20,184,166,0.06),transparent)]" />
        <div className="pointer-events-none absolute inset-0 bg-[radial-gradient(ellipse_40%_30%_at_20%_100%,rgba(245,158,11,0.04),transparent)]" />
        <div className="relative z-10 flex flex-1 flex-col">{children}</div>
      </main>
    </div>
  )
}
