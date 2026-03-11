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
          ergs = { "format", "--kdl-version=v1", "-" },
          stdin = true,
        },
      },
    },
  },
}
