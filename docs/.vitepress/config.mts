import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  base: '/form-craft/',
  title: "Form Craft",
  lang: 'en',
  description: "Build better forms with a simple and flexible validation library for Swift and SwiftUI",
  head: [
    ['link', { rel: 'icon', type: 'image/png', href: '/form-craft/form-craft-logo-icon.ico' }],
    ['meta', { name: 'theme-color', content: '#5f67ee' }],
    ['meta', { property: 'og:type', content: 'website' }],
    ['meta', { property: 'og:site_name', content: 'FormCraft' }],
    ['meta', { property: 'og:image', content: 'https://artycodingart.github.io/form-craft/formcraft-og.png' }],
    ['meta', { property: 'og:url', content: 'https://artycodingart.github.io/form-craft/' }]
  ],

  themeConfig: {
    logo: { src: '/form-craft-logo-min.png', width: 24, height: 24 },

    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Home', link: '/' },
      { text: 'API', link: '/api/' },
      { text: 'Validation Rules', link: '/validation-rules/' },
      { text: 'Examples', link: '/examples/' }
    ],

    sidebar: [
      { text: 'Overview', link: '/overview' },
      { text: 'Getting Started', link: '/getting-started' },
      {
        text: 'API',
        items: [
          { text: 'FormCraft', link: '/' },
          { text: 'FormCraftFields', link: '/' },
          { text: 'FormCraftField', link: '/' },
          { text: 'FormCraftView', link: '/' },
          { text: 'FormCraftControllerView', link: '/' },
          { text: 'FormCraftProviderView', link: '/' },
        ]
      },
      {
        text: 'Validation Rules',
        link: '/validation-rules/',
        items: [
          { text: 'String', link: '/validation-rules/string' },
          { text: 'Boolean', link: '/validation-rules/boolean'},
          { text: 'Integer', link: '/validation-rules/integer' },
          { text: 'Decimal', link: '/validation-rules/decimal' },
          // { text: 'Array', link: '/validation-rules/array' },
          // { text: 'Custom Type', link: '/validation-rules/custom-type'}
        ]
      },
      {
        text: 'Examples',
        items: [
          { text: 'Basic Form', link: '/examples/login-form' },
          { text: 'Initial Values', link: '/examples/initial-values' },
          { text: 'Server Errors', link: '/examples/server-errors'},
          { text: 'Server Validation', link: '/examples/server-validation' },
          // { text: 'Cross-Field Validation', link: '/' },
        ]
      }
    ],

    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © 2025-present Drobyshev Artem'
    },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/ArtyCodingart/form-craft' }
    ],

    search: {
      provider: 'local'
    }
  }
})
