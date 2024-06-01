require('plugins.colors')

return require('packer').startup(function(use)
	vim.o.termguicolors = true

	use 'wbthomason/packer.nvim'
	use 'ojroques/nvim-bufdel'
	use {
	"nvim-zh/colorful-winsep.nvim",
		config = function ()
			require('colorful-winsep').setup()
		end
	}
	use {
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup {}
		end
	}
	use {
		'neovim/nvim-lspconfig',
		config = function()
			require("plugins.lspconfig").setup()
		end
	}
	use {
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
		config = function()
			require("plugins.navic").setup()
		end
	}
	use {
		"github/copilot.vim"
	}
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', 'catppuccin/nvim' },
		config = function()
			require('plugins.lualine')
		end
	}
	use {
		'hrsh7th/nvim-cmp',
		requires={ 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',  'hrsh7th/cmp-cmdline', 'hrsh7th/cmp-vsnip', 'hrsh7th/vim-vsnip' },
		config = function()
			require("plugins.cmp")
		end
	}
	use {
		'nvim-lua/telescope.nvim', tag = '0.1.6',
		requires = { { 'nvim-lua/plenary.nvim' } },
		config = function ()
			require('plugins.telescope')
		end
	}
	use { 
		"catppuccin/nvim",
		as = "catppuccin",
		requires = {'nvim-lua/telescope.nvim' },

		config = function()
			require("plugins.catppuccin")
		end
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	use {
		'theprimeagen/harpoon'
	}
	use {
		'nvim-tree/nvim-tree.lua',
		requires = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require("plugins.nvim-tree")
		end
	}
	use {
		'akinsho/bufferline.nvim',
		tag = "*",
		requires = 'nvim-tree/nvim-web-devicons',
		config = function()
			require("plugins.bufferline")
		end
	}
	use {
		'xiyaowong/transparent.nvim'
	}
	use {
		'mrjones2014/smart-splits.nvim',
		tag = 'v1.0.0',
		config = function()
			require('plugins.smart-splits')
		end
	}
end)
