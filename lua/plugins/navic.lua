vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
-- Set highlights for NavicIcons
	vim.api.nvim_set_hl(0, 'NavicIconsFile', { default = true, fg = '#FFD700' }) -- Gold color for files
	vim.api.nvim_set_hl(0, 'NavicIconsModule', { default = true, fg = '#FF4500' }) -- Orange red for modules
	vim.api.nvim_set_hl(0, 'NavicIconsNamespace', { default = true, fg = '#1E90FF' }) -- Dodger blue for namespaces
	vim.api.nvim_set_hl(0, 'NavicIconsPackage', { default = true, fg = '#32CD32' }) -- Lime green for packages
	vim.api.nvim_set_hl(0, 'NavicIconsClass', { default = true, fg = '#8A2BE2' }) -- Blue violet for classes
	vim.api.nvim_set_hl(0, 'NavicIconsMethod', { default = true, fg = '#FF8C00' }) -- Dark orange for methods
	vim.api.nvim_set_hl(0, 'NavicIconsProperty', { default = true, fg = '#ADFF2F' }) -- Green yellow for properties
	vim.api.nvim_set_hl(0, 'NavicIconsField', { default = true, fg = '#FF1493' }) -- Deep pink for fields
	vim.api.nvim_set_hl(0, 'NavicIconsConstructor', { default = true, fg = '#00BFFF' }) -- Deep sky blue for constructors
	vim.api.nvim_set_hl(0, 'NavicIconsEnum', { default = true, fg = '#8B0000' }) -- Dark red for enums
	vim.api.nvim_set_hl(0, 'NavicIconsInterface', { default = true, fg = '#FF00FF' }) -- Magenta for interfaces
	vim.api.nvim_set_hl(0, 'NavicIconsFunction', { default = true, fg = '#7CFC00' }) -- Lawn green for functions
	vim.api.nvim_set_hl(0, 'NavicIconsVariable', { default = true, fg = '#00FA9A' }) -- Medium spring green for variables
	vim.api.nvim_set_hl(0, 'NavicIconsConstant', { default = true, fg = '#1E90FF' }) -- Dodger blue for constants
	vim.api.nvim_set_hl(0, 'NavicIconsString', { default = true, fg = '#FF4500' }) -- Orange red for strings
	vim.api.nvim_set_hl(0, 'NavicIconsNumber', { default = true, fg = '#FFD700' }) -- Gold for numbers
	vim.api.nvim_set_hl(0, 'NavicIconsBoolean', { default = true, fg = '#00FF00' }) -- Lime for booleans
	vim.api.nvim_set_hl(0, 'NavicIconsArray', { default = true, fg = '#1E90FF' }) -- Dodger blue for arrays
	vim.api.nvim_set_hl(0, 'NavicIconsObject', { default = true, fg = '#8A2BE2' }) -- Blue violet for objects
	vim.api.nvim_set_hl(0, 'NavicIconsKey', { default = true, fg = '#FF4500' }) -- Orange red for keys
	vim.api.nvim_set_hl(0, 'NavicIconsNull', { default = true, fg = '#FFD700' }) -- Gold for null
	vim.api.nvim_set_hl(0, 'NavicIconsEnumMember', { default = true, fg = '#8B0000' }) -- Dark red for enum members
	vim.api.nvim_set_hl(0, 'NavicIconsStruct', { default = true, fg = '#00BFFF' }) -- Deep sky blue for structs
	vim.api.nvim_set_hl(0, 'NavicIconsEvent', { default = true, fg = '#FF00FF' }) -- Magenta for events
	vim.api.nvim_set_hl(0, 'NavicIconsOperator', { default = true, fg = '#FF1493' }) -- Deep pink for operators
	vim.api.nvim_set_hl(0, 'NavicIconsTypeParameter', { default = true, fg = '#7CFC00' }) -- Lawn green for type parameters

	-- Set highlights for NavicText and NavicSeparator
	--
	vim.api.nvim_set_hl(0, 'NavicText', { default = false, fg = '#ffffff' }) -- Grey color for separator
	vim.api.nvim_set_hl(0, 'NavicSeparator', { default = true, fg = '#808080' }) -- Grey color for separator
end
})

require("nvim-navic").setup({
	highlight = true
})
