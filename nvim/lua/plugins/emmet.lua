return {
    'mattn/emmet-vim',

    config = function ()
        vim.cmd([[
            let g:user_emmet_leader_key='<c-e>'
        ]])
    end
}
