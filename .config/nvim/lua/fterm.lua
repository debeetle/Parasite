-- fterm.nvim - floating terminal

local FTERM_WIN="fterm_win"
local FTERM_BUF="fterm_buf"
local FTERM_WIDTH="fterm_width"
local FTERM_HEIGHT="fterm_height"

local FTERM_DEFAULS={
  width=100,
  height=20
}

local function get_option(name)
  return vim.g[string.format("fterm_%s", name)] or FTERM_DEFAULS[name]
end

local function window_opened()
  local win = vim.g[FTERM_WIN]
  return win and vim.api.nvim_win_is_valid(win)
end

local function close_window()
  local win = vim.g[FTERM_WIN]
  vim.api.nvim_win_close(win, false)
  vim.g[FTERM_WIN] = -1
end

local function buf_exists()
  local buf = vim.g[FTERM_BUF]
  return buf and vim.api.nvim_buf_is_valid(buf)
end

local function create_buf()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.g[FTERM_BUF] = buf
end

local function open_window()
  if not buf_exists() then
    create_buf()
  end

  local editor_width = vim.opt.columns:get()
  local editor_height = vim.opt.lines:get()

  local row
  local col
  local width
  local height
  local cmdheight = vim.opt.cmdheight:get()

	row = 0
	width = get_option("width")
	col = editor_width - width
	height = editor_height - 2 - cmdheight

  local buf = vim.g[FTERM_BUF]
  local win = vim.api.nvim_open_win(buf, true, {
    relative='win', anchor='NW', row=row, col=col, width=width, height=height, style="minimal", border="rounded"
  })

  local buf_name = vim.api.nvim_buf_get_name(buf)

  if not string.match(buf_name, "^term:") then
    vim.api.nvim_command("terminal")
  end

  vim.g[FTERM_WIN] = win
end

local function toggle()
  if window_opened() then
    close_window()
    return
  end

  open_window()
  vim.cmd('startinsert')
end

local function exec(cmd)
  if not window_opened() then
    open_window()
  end

  local buf = vim.g[FTERM_BUF]
  local channel = vim.api.nvim_buf_get_var(buf, "channel")
  vim.call("chansend", channel, string.format("%s\n", cmd))

end

local function config(opts)

  if opts["width"] then
    vim.g[FTERM_WIDTH] = opts["width"]
  end

  if opts["height"] then
    vim.g[FTERM_HEIGHT] = opts["height"]
  end
end

return {
  config = config,
  exec = exec,
  toggle = toggle,
}
