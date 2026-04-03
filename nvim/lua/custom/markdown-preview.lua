vim.g.mkdp_preview_options = {
    uml = {
        imageFormat = 'svg',
    },
}
vim.g.mkdp_theme = 'dark'

larp.fn.map('n', '<leader>mds', '<cmd>MarkdownPreview<cr>', { desc = 'Start Markdown Preview' })
larp.fn.map('n', '<leader>mdS', '<cmd>MarkdownPreviewStop<cr>', { desc = 'Stop Markdown Preview' })
larp.fn.map('n', '<leader>mdr', '<cmd>MarkdownPreviewStop<cr><cmd>MarkdownPreview<cr>', { desc = 'Restart Markdown Preview' })
