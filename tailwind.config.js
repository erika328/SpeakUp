module.exports = {
  theme: {
    extend: {
        animation: {
            "fade-out-top": "fade-out-top 10.0s cubic-bezier(0.250, 0.460, 0.450, 0.940)   both"
        },
        keyframes: {
            "fade-out-top": {
                "0%": {
                    transform: "translateY(0)",
                    opacity: "1"
                },
                to: {
                    transform: "translateY(-50px)",
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