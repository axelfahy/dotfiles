function fish_user_key_bindings --description 'Ctrl-F and Ctrl-O to accept autosuggestion and Ctrl-A / Ctrl-E for start / end of line.'
    for mode in insert default visual
        bind -M $mode \cf forward-char
        bind -M $mode \co forward-char
        bind -M $mode \ca beginning-of-line
        bind -M $mode \ce end-of-line
    end
end
