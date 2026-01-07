local augroup = vim.api.nvim_create_augroup("Compile&Upload", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.ino",
	group = augroup,
	callback = function()
		local sketch = vim.fn.expand("%:p:h")

		vim.fn.jobstart('arduino-cli compile --fqbn arduino:avr:uno "' .. sketch .. '"', {
			-- stdout_buffered = true,
			-- stderr_buffered = true,
			on_exit = function(_, exit_code)
				if exit_code == 0 then
					vim.notify("Succeed in Compile", vim.log.levels.INFO, {
						timeout = 3000,
					})
					vim.fn.jobstart('arduino-cli upload -p /dev/ttyUSB0 --fqbn arduino:avr:uno "' .. sketch .. '"', {
						on_exit = function(_, exit_code)
							if exit_code == 0 then
								vim.notify("Uploaded", vim.log.levels.INFO, {
									timeout = 3000,
								})
							else
								vim.notify("Failed in upload", vim.log.levels.ERROR, {
									timeout = 5000,
								})
							end
						end,
					})
				else
					vim.notify("Failed in Compile", vim.log.levels.ERROR, {
						timeout = 5000,
					})
				end
			end,
		})
	end,
})

vim.lsp.enable("arduino_language_server")
vim.treesitter.start()
