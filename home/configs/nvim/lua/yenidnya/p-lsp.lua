return {
	{ "neovim/nvim-lspconfig" },
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
			require("mason-install").ensure_formatters_installed()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
			capabilities.textDocument.foldingRange = {
				lineFoldingOnly = true,
			}

			require("mason-lspconfig").setup({
				ensure_installed = {
					"rust_analyzer",
					"jsonls",
					"lua_ls",
					"pylsp",
					"ts_ls",
					"typos_lsp",
					"zls",
				},
			})

			vim.lsp.config("*", {
				capabilities,
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			local rust_commands = require("rust-commands")
			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						["server.extraEnv"] = {
							-- Use custom target dir for rust-analyzer to prevent collisions with brazil-build
							CARGO_TARGET_DIR = ".rust-analyzer/target",
						},
						checkOnSave = {
							allTargets = true,
						},
						cargo = {
							target = "aarch64-apple-darwin",
							targetDir = "target/rust-analyzer-dir",
						},
						["check.features"] = { "use_ignx_local", "allow_no_js_vm" },
					},
				},
				commands = {
					ExpandMacro = { rust_commands.expand_macro },
				},
			})

			vim.lsp.config("typos_lsp", {
				init_options = {
					-- Custom config. Used together with a config file found in the workspace or its parents,
					-- taking precedence for settings declared in both.
					-- Equivalent to the typos `--config` cli argument.
					config = "~/.config/typos.toml",
					-- How typos are rendered in the editor, can be one of an Error, Warning, Info or Hint.
					diagnosticSeverity = "Hint",
				},
			})
		end,
	},
}
