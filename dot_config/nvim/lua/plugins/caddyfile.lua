return {
  { "isobit/vim-caddyfile" },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        caddyfile = { "caddyfile" },
      },
      formatters = {
        caddyfile = {
          command = "caddy",
          args = { "fmt", "-" },
          stdin = true,
        },
      },
    },
  },
}
