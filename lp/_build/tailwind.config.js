/** Tailwind + daisyUI solo para las landings nuevas de `lp/`.
    No mira el resto del sitio: las 121 páginas existentes no se tocan. */
module.exports = {
  content: ['../**/*.html'],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter', 'SF Pro Display', 'Segoe UI', 'system-ui', 'sans-serif'],
      },
    },
  },
  plugins: [require('daisyui')],
  daisyui: {
    themes: [
      {
        navia: {
          // Los 4 colores de marca — NAVIA_SISTEMA.md §7. No agregar otros.
          primary: '#1b4b8d',          // azul primario
          'primary-content': '#ffffff',
          secondary: '#3b97d3',        // azul cielo
          'secondary-content': '#ffffff',
          accent: '#36b398',           // teal — es el color de acción, no hay rojo
          'accent-content': '#ffffff',
          neutral: '#2c3e50',          // charcoal
          'neutral-content': '#ffffff',
          'base-100': '#ffffff',
          'base-200': '#f8f9fa',
          'base-300': '#b0b8c1',
          'base-content': '#2c3e50',
          info: '#3b97d3',
          success: '#36b398',
          warning: '#36b398',
          error: '#2c3e50',            // sin rojo en la marca: se usa charcoal
          '--rounded-btn': '0.5rem',
        },
      },
    ],
  },
};
