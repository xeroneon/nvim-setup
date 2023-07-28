return {
  'mhartington/formatter.nvim',
  config = function()
    local status, formatter = pcall(require, 'formatter')
    if not status then
      return
    end

    -- Utilities for creating configurations
    local util = require 'formatter.util'

    local function prettierd()
      return {
        exe = 'prettierd',
        args = {
          util.escape_path(util.get_current_buffer_file_path()),
        },
        stdin = true,
      }
    end

    local function eslint_d()
      return {
        exe = 'eslint_d',
        args = {
          '--stdin',
          '--stdin-filename',
          util.escape_path(util.get_current_buffer_file_path()),
          '--fix-to-stdout',
        },
        stdin = true,
        try_node_modules = true,
      }
    end

    local function stylua()
      return {
        exe = 'stylua',
        args = {
          '--indent-type',
          'Spaces',
          '--line-endings',
          'Unix',
          '--quote-style',
          'AutoPreferSingle',
          '--indent-width',
          2,
          -- '--column-width',
          -- vim.bo.textwidth,
          '-',
        },
        stdin = true,
      }
    end

    formatter.setup {
      -- Enable or disable logging
      logging = true,
      -- Set the log level
      log_level = vim.log.levels.WARN,
      -- All formatter configurations are opt-in
      filetype = {
        javascript = {
          prettierd,
          eslint_d,
        },
        typescript = {
          prettierd,
          eslint_d,
        },
        javascriptreact = {
          prettierd,
          eslint_d,
        },
        typescriptreact = {
          prettierd,
          eslint_d,
        },
        ['javascript.jsx'] = {
          prettierd,
          eslint_d,
        },
        ['typescript.tsx'] = {
          prettierd,
          eslint_d,
        },
        markdown = {
          prettierd,
          eslint_d,
        },
        css = {
          prettierd,
          eslint_d,
        },
        json = {
          prettierd,
          eslint_d,
        },
        jsonc = {
          prettierd,
          eslint_d,
        },
        scss = {
          prettierd,
          eslint_d,
        },
        less = {
          prettierd,
          eslint_d,
        },
        yaml = {
          prettierd,
          eslint_d,
        },
        graphql = {
          prettierd,
          eslint_d,
        },
        html = {
          prettierd,
          eslint_d,
        },
        lua = {
          stylua,
        },
        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        ['*'] = {
          -- "formatter.filetypes.any" defines default configurations for any
          -- filetype
          --
          require('formatter.filetypes.any').remove_trailing_whitespace,
        },
      },
    }
    vim.cmd [[
		augroup FormatOnSave
		autocmd!
		autocmd BufWritePost * FormatWrite
		augroup END
		]]
  end,
}
