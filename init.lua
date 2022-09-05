--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
function MusicPlay()
  ExecuteNotifyError("playerctl play-pause")
end
function MusicNext()
  ExecuteNotifyError("playerctl next")
end
function MusicPrevious()
  ExecuteNotifyError("playerctl previous")
end
local config = {

  colorscheme = "catppuccin_mocha",

  plugins = {
    init = {
      {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
          require("catppuccin").setup {}
        end,
      },
    },
  },
  default_theme = {
    colors = function(C)
      C.telescope_green = C.green
      C.telescope_red = C.red
      C.telescope_fg = C.fg
      C.telescope_bg = C.black_1
      C.telescope_bg_alt = C.bg_1
      return C
    end,
    highlights = function(hl)
      local C = require "default_theme.colors"
      hl.TelescopeBorder = { fg = C.telescope_bg_alt, bg = C.telescope_bg }
      hl.TelescopeNormal = { bg = C.telescope_bg }
      hl.TelescopePreviewBorder = { fg = C.telescope_bg, bg = C.telescope_bg }
      hl.TelescopePreviewNormal = { bg = C.telescope_bg }
      hl.TelescopePreviewTitle = { fg = C.telescope_bg, bg = C.telescope_green }
      hl.TelescopePromptBorder = { fg = C.telescope_bg_alt, bg = C.telescope_bg_alt }
      hl.TelescopePromptNormal = { fg = C.telescope_fg, bg = C.telescope_bg_alt }
      hl.TelescopePromptPrefix = { fg = C.telescope_red, bg = C.telescope_bg_alt }
      hl.TelescopePromptTitle = { fg = C.telescope_bg, bg = C.telescope_red }
      hl.TelescopeResultsBorder = { fg = C.telescope_bg, bg = C.telescope_bg }
      hl.TelescopeResultsNormal = { bg = C.telescope_bg }
      hl.TelescopeResultsTitle = { fg = C.telescope_bg, bg = C.telescope_bg }
      return hl
    end,
  },


  -- Set dashboard header
  header = {
    "+--^----------,--------,-----,--------^-",
    "| |||||||||   `--------'     |          O",
    "`+---------------------------^----------|",
    "  `\\_,---------,---------,--------------'",
    "    / XXXXXX /'|       /'",
    "   / XXXXXX /  `\\    /'",
    "  / XXXXXX /`-------'",
    " / XXXXXX /",
    "/ XXXXXX /",
    "________(",
    "`------'              The killer editor.",
  },


  -- Mapping data with "desc" stored directly by vim.keymap.set().
  --
  -- Please use this mappings table to set keyboard mapping since this is the
  -- lower level configuration and more robust one. (which-key will
  -- automatically pick-up stored data by this setting.)
  mappings = {
    -- first key is the mode
    n = {
      -- second key is the lefthand side of the map
      -- mappings seen under group name "Buffer"
      ["<leader>mp"] = { MusicPlay, desc = "Toogle Music"},
      ["<leader>mn"] = { MusicNext, desc = "Play next music" },
      ["<leader>mP"] = { MusicPrevious, desc = "Play previous music"},
    },
  },

  -- LuaSnip Options
  luasnip = {
    -- Add paths for including more VS Code style snippets in luasnip
    vscode_snippet_paths = {},
    -- Extend filetypes
    filetype_extend = {
      javascript = { "javascriptreact" },
      typescript = { "typescriptreact" },
    },
  },


  -- Modify which-key registration (Use this with mappings table in the above.)
  ["which-key"] = {
    -- Add bindings which show up as group name
    register_mappings = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- third key is the key to bring up next level and its displayed
          -- group name in which-key top level menu
          ["m"] = { name = "Music" },
        },
      },
    },
  },
}


function ExecuteNotifyError(cmd)
  local f = io.popen(cmd .. " 2>&1 || echo ::ERROR::","r")
  local text = f:read "*a"
  if text:find "::ERROR::" then 
    vim.notify(text:gsub("\n[^\n]*$", ""):gsub("\n[^\n]*$", ""),"error")
  end
  return text
end


return config
