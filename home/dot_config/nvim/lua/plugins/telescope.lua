-- ~/.config/nvim/lua/plugins/telescope.lua

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
  config = function()
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = {},
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        mappings = {
          i = {
            ["<C-n>"] = require("telescope.actions").move_selection_next,
            ["<C-p>"] = require("telescope.actions").move_selection_previous,
          },
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          previewer = false,
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
          },
          find_command = { "rg", "--files", "--no-ignore", "--hidden", "--glob", "!.git/*" },
        },
        live_grep = {
          theme = "dropdown",
          previewer = true,
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
          },
          additional_args = function()
            return { "--hidden", "--glob", "!.git/*" }
          end,
        },
      },
      extensions = {
        fzf = {
          fuzzy = false, -- Desactiva la búsqueda fuzzy
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    -- Carga la extensión fzf si está disponible
    require("telescope").load_extension("fzf")
  end,
}
