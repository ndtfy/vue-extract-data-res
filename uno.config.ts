import { defineConfig, presetUno, presetAttributify } from 'unocss'

export default defineConfig({
  presets: [
    presetUno(),
    presetAttributify(),
  ],

  theme: {
    colors: {
      clear: {
        DEFAULT: '#ff6347',
        dark: '#b81c00',
      },
      warning: {
        DEFAULT: '#ffa',
        dark: '#550',
      }
    }
  },

  dark: 'class',

  shortcuts: [
    ['error', 'bg-error text-white dark:bg-error-dark'],
  ]
})
