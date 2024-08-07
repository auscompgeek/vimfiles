-- This file exists because I don't know the appropriate way to have both
-- an `init.lua` and an `init.vim`, and I don't feel like rewriting my vimrc.
-- And before the peanut gallery comes down on me, I'm not going to shove
-- Vimscript inline in Lua, or vice versa. Maybe it's better this way anyway.

local lspconfig = require('lspconfig')
lspconfig.clangd.setup{}
lspconfig.rust_analyzer.setup{}
