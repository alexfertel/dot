local wk = require("whichkey_setup")
local util = require("util")

local M = {}

function M.setup(client, bufnr)
  -- Mappings.
  local opts = { noremap = true, silent = true, bufnr = bufnr }

  local keymap = {
    c = {
      name = "+code",
      r = { "<cmd>lua require('lspsaga.rename').rename()<CR>", "Rename" },
      a = { "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", "Code Action" },
      d = { "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", "Line Diagnostics" },
      l = {
        name = "+lsp",
        i = { "<cmd>LspInfo<cr>", "Lsp Info" },
        a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Folder" },
        r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Folder" },
        l = {
          "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
          "List Folders"
        }
      }
    },
    x = {
      s = { "<cmd>Telescope lsp_document_diagnostics<cr>", "Search Document Diagnostics" },
      w = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics" }
    }
  }

  if client.name == "typescript" then
    keymap.c.o = { "<cmd>:TSLspOrganize<CR>", "Organize Imports" }
    keymap.c.R = { "<cmd>:TSLspRenameFile<CR>", "Rename File" }
  end

  local keymap_visual = {
    c = {
      name = "+code",
      a = { ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", "Code Action" }
    }
  }

  local keymap_goto = {
    name = "+goto",
    r = { "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", "References" },
    d = { "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", "Peek Definition" },
    D = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
    s = { "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", "Signature Help" },
    I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
    -- I = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Goto Declaration" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" }
  }

  util.nnoremap("K", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
  util.nnoremap("<CR>", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
  util.nnoremap("[d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", opts)
  util.nnoremap("]d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    keymap.c.f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format Document" }
  elseif client.resolved_capabilities.document_range_formatting then
    keymap_visual.c.f = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Format Range" }
  end

  wk.register_keymap("leader", keymap, { noremap = true, silent = true, bufnr = bufnr })
  wk.register_keymap("visual", keymap_visual, { noremap = true, silent = true, bufnr = bufnr })
  wk.register_keymap("g", keymap_goto, { noremap = true, silent = true, bufnr = bufnr })
end

return M