local status, flash = pcall(require, "flash")
if not status then
	return
end
flash.setup({
	search = {
		multi_window = true,
	},
	prompt = {
		prefix = { { "Teleport ⚡", "FlashPromptIcon" } },
	},
})

vim.keymap.set({ "n", "x", "o" }, "f", function()
	flash.jump()
end, { desc = "Flash Jump" })
vim.keymap.set({ "n", "x", "o" }, "F", function()
	flash.treesitter()
end, { desc = "Flash Treesitter" })
vim.keymap.set({ "x", "o" }, "R", function()
	flash.treesitter_search()
end, { desc = "Flash Treesitter Search" })
