export interface Adventure {
  id: string
  name: string
  masterId: string
  createdAt: string
  icon?: string
}

export interface DiaryEntry {
  id: string
  adventureId: string
  date: string
  title: string
  summary: string
  tags: string[]
  authorId: string
  diaryType: 'adventure' | 'personal'
  createdAt: string
  updatedAt: string
}

export type ActiveTab = 'adventure' | 'personal'
