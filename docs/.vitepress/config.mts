import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  base: '/form-craft/',
  title: "Form Craft",
  description: "Build better forms with a simple and flexible validation library for Swift and SwiftUI",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Validation Rules', link: '/validation-rules' }
    ],

    sidebar: [
      {
        text: 'Examples',
        items: [
          { text: 'Getting Started', link: '/guide/getting-started' },
          { text: 'Validation Rules', link: '/validation-rules' }
        ]
      }
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/ArtyCodingart/form-craft' }
    ]
  }
})
