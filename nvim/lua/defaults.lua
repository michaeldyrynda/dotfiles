--
-- Default configuration
--

vim.api.nvim_create_autocmd("VimResized", {
    pattern = { "*" },
    callback = function ()
        vim.cmd("wincmd =")
    end
})
