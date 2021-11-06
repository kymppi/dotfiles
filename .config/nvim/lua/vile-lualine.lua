local lualine = require 'lualine'

-- Color table for highlights
local colors = {
	vertsplit       = '#181A1F',
	special_grey    = '#555555',
	menu_grey       = '#1f281c',
    cursor_grey     = '#2C323C',
    green1          = '#8c9440',
	green2          = '#8c9440',
	white           = '#bfc7d5',
	green           = '#C3E88D',
	green3          = '#8c9440',
	green4          = '#8c9440',
	red             = '#ff5370',
	cyan            = '#89DDFF',
	black           = '#1f281c',
}


-- Config
local config = {
  options = {
    icons_enabled = true,
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {},
    theme = {
        normal = {
            a = {fg = colors.black, bg = colors.green1, gui = 'bold'},
            b = {fg = colors.green1, bg = colors.menu_grey},
            c = {fg = colors.green1, bg = colors.black},
            d = {fg = colors.green1, bg = colors.menu_grey},
        },
        insert = {
            a = {fg = colors.black, bg = colors.green2, gui = 'bold'},
            b = {fg = colors.green2, bg = colors.menu_grey},
            c = {fg = colors.green2, bg = colors.black},
            d = {fg = colors.green2, bg = colors.menu_grey},
        },
        visual = {
            a = {fg = colors.black, bg = colors.green4, gui = 'bold'},
            b = {fg = colors.green4, bg = colors.menu_grey},
            c = {fg = colors.green4, bg = colors.black},
            d = {fg = colors.green4, bg = colors.menu_grey},
        },
        replace = {
            a = {fg = colors.black, bg = colors.green3, gui = 'bold'},
            b = {fg = colors.green3, bg = colors.menu_grey},
            c = {fg = colors.green3, bg = colors.black},
            d = {fg = colors.green3, bg = colors.menu_grey},
        },
        inactive = {
            a = {fg = colors.black, bg = colors.menu_grey, gui = 'bold'},
            b = {fg = colors.black, bg = colors.menu_grey},
            c = {fg = colors.black, bg = colors.menu_gray},
            d = {fg = colors.black, bg = colors.menu_grey},
        }
    }
  },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}  
   },
  tabline = {},
  extensions = {}
}

local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

ins_left {
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then return msg end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
}

-- Now don't forget to initialize lualine
lualine.setup(config)
