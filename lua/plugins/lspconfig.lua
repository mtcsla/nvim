local function setup()
	local lspconfig = require('lspconfig')

	local function on_attach(client, bufnr)
		require("nvim-navic").attach(client, bufnr)
	end

	lspconfig.rust_analyzer.setup {
	  -- Server-specific settings. See `:help lspconfig-setup`
	  on_attach = on_attach,
	  settings = {
	    ['rust-analyzer'] = {},
	  },
	}


	require'lspconfig'.lua_ls.setup {
	  on_attach = on_attach,
	  on_init = function(client)
	    local path = client.workspace_folders[1].name
	    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
	      return
	    end

	    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
	      runtime = {
		-- Tell the language server which version of Lua you're using
		-- (most likely LuaJIT in the case of Neovim)
		version = 'LuaJIT'
	      },
	      -- Make the server aware of Neovim runtime files
	      workspace = {
		checkThirdParty = false,
		library = {
		  vim.env.VIMRUNTIME
		  -- Depending on the usage, you might want to add additional paths here.
		  -- "${3rd}/luv/library"
		  -- "${3rd}/busted/library",
		}
		-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
		-- library = vim.api.nvim_get_runtime_file("", true)
	      }
	    })
	  end,
	  settings = {
	    Lua = {}
	  }
	}
	lspconfig.pyright.setup {
	--  capabilities = capabilities,
	  on_attach = on_attach,
	  on_new_config = function(config, root_dir)
	    local env = vim.trim(vim.fn.system('cd "' .. root_dir .. '"; poetry env info -p 2>/dev/null'))
	    if string.len(env) > 0 then
	      config.settings.python.pythonPath = env .. '/bin/python'
	    end
	  end
	}
end

return { setup = setup }
