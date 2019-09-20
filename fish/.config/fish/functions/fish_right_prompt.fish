function fish_right_prompt --description 'Write the right of the prompt'
    set -l pink (set_color ff99ff)
    set -l dark_pink (set_color cc99ff)

    echo -n -s $pink ' [' $dark_pink (date +%H:%M:%S) $pink '] '
end

