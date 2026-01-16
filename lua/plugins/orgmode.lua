return {
    'nvim-orgmode/orgmode',
    pin = true, -- Pinned for Neovim 0.10.x compatibility
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
        -- Setup orgmode
        require('orgmode').setup({
            org_agenda_files = '~/orgfiles/**/*',
            org_default_notes_file = '~/orgfiles/refile.org',
        })
    end,
}
