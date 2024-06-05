module.exports = {
  theme: {
    extend: {
        animation: {
            "slide-out-top": "slide-out-top 2s cubic-bezier(0.550, 0.085, 0.680, 0.530) 5s  both"
        },
        keyframes: {
            "slide-out-top": {
                "0%": {
                    transform: "translateY(0)",
                    opacity: "1"
                },
                to: {
                    transform: "translateY(-1000px)",
                    opacity: "0"
                }
            }
        }
    }
  },
  daisyui: {
    darkTheme: false,
    themes: ["pastel"],
  },
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require('daisyui')
  ],
}