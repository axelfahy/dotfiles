# Set the prompt.
# Adaptation from Acidhub example, which was not working correctly for git.
# Format [vim-status] <username@hostname|path>status>
function fish_prompt --description 'Write out the prompt'
	set laststatus $status

    if set -l git_branch (command git symbolic-ref HEAD 2>/dev/null | string replace refs/heads/ '')
        set git_branch (set_color -o blue)"$git_branch"
        set upstream (command git for-each-ref --format='%(upstream:short)' (command git symbolic-ref -q HEAD))
        if not command git diff-index --quiet HEAD --
            if set -l count (command git rev-list --count --left-right $upstream...HEAD 2>/dev/null)
                echo $count | read -l behind ahead
                if test "$ahead" -gt 0
                    set git_status "$git_status"(set_color red)⬆
                end
                if test "$behind" -gt 0
                    set git_status "$git_status"(set_color red)⬇
                end
            end
            for i in (git status --porcelain | string sub -l 2 | string trim -- | sort -u)
                switch $i
                    case "."
                        set git_status "$git_status"(set_color green)✚
                    case "D"
                        set git_status "$git_status"(set_color red)✖
                    case "M"
                        set git_status "$git_status"(set_color green)✱
                    case "R"
                        set git_status "$git_status"(set_color purple)➜
                    case "U"
                        set git_status "$git_status"(set_color brown)═
                    case "\?\?"
                        set git_status "$git_status"(set_color red)≠
                end
            end
        else
            set git_status (set_color green):
        end
        set git_info "(git$git_status$git_branch"(set_color white)")"
    end

    set_color -b black
    printf '%s%s%s%s%s%s%s%s%s%s%s%s%s' (set_color -o white) '❰' (set_color red) $USER (set_color yellow) '@' (set_color white) $hostname (set_color white) '❙' (set_color green) (echo $PWD | sed -e "s|^$HOME|~|") (set_color white) $git_info (set_color white) '❱' (set_color white)
    if test $laststatus -eq 0
        printf "%s✔%s≻%s " (set_color -o green) (set_color white) (set_color normal)
    else
        printf "%s✘%s≻%s " (set_color -o red) (set_color white) (set_color normal)
    end

    # Color the hostname in the prompt in ssh.
    if set -q SSH_TTY
        set -g fish_color_host brred
    end
end
