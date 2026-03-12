return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        kdl = { "kdl" },
      },
      formatters = {
        kdl = {
          command = "kdlfmt",
          args = { "format", "--kdl-version=v1", "-" },
          stdin = true,
        },
      },
    },
  },
}
