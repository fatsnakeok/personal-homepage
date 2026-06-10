import { createContentLoader } from 'vitepress'

export interface Article {
  title: string
  date: string
  excerpt: string
  cover?: string
  tags: string[]
  url: string
}

declare module 'vitepress' {
  interface ThemeConfig {
    profile?: {
      name: string
      bio: string
      avatar: string
    }
    motto?: string
  }
}

export default createContentLoader('posts/*.md', {
  excerpt: true,
  transform(rawData): Article[] {
    return rawData
      .map(({ url, frontmatter, excerpt }) => ({
        title: frontmatter.title || '',
        date: frontmatter.date || '',
        excerpt: frontmatter.excerpt || excerpt || '',
        cover: frontmatter.cover || '',
        tags: frontmatter.tags || [],
        url
      }))
      .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime())
  }
})
