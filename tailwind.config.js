/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{html,ts}",
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require('daisyui'),
  ],
  daisyui: {
    themes: true,
    styled: true,
    themes: [ "emerald" ],
    base: true,
    utils: true,
    logs: true,
    rtl: false,
  },
}

