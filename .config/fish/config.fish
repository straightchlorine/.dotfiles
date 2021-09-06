# paths
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths
set CLASSPATH ~/current_project $CLASSPATH

# fish greeting supressed
set fish_greeting

# terminal type
set TERM "xterm-256color"

# setting the $EDITOR variable to neovim
set EDITOR "neovim"

# setting the $VISUAL editor to Emacs
set VISUAL "emacsclient -c -a emacs"

# setting the manpager to bat
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# setting default key bindings to vi mode
function fish_user_key_bindings
  fish_vi_key_bindings
end

# autocomplete colours
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

# setting the colour scheme generated by wpgtk
cat ~/.config/wpg/sequences 

# spark
set -g spark_version 1.0.0

complete -xc spark -n __fish_use_subcommand -a --help -d "Show usage help"
complete -xc spark -n __fish_use_subcommand -a --version -d "$spark_version"
complete -xc spark -n __fish_use_subcommand -a --min -d "Minimum range value"
complete -xc spark -n __fish_use_subcommand -a --max -d "Maximum range value"

function spark -d "sparkline generator"
    if isatty
        switch "$argv"
            case {,-}-v{ersion,}
                echo "spark version $spark_version"
            case {,-}-h{elp,}
                echo "usage: spark [--min=<n> --max=<n>] <numbers...>  Draw sparklines"
                echo "examples:"
                echo "       spark 1 2 3 4"
                echo "       seq 100 | sort -R | spark"
                echo "       awk \\\$0=length spark.fish | spark"
            case \*
                echo $argv | spark $argv
        end
        return
    end

    command awk -v FS="[[:space:],]*" -v argv="$argv" '
        BEGIN {
            min = match(argv, /--min=[0-9]+/) ? substr(argv, RSTART + 6, RLENGTH - 6) + 0 : ""
            max = match(argv, /--max=[0-9]+/) ? substr(argv, RSTART + 6, RLENGTH - 6) + 0 : ""
        }
        {
            for (i = j = 1; i <= NF; i++) {
                if ($i ~ /^--/) continue
                if ($i !~ /^-?[0-9]/) data[count + j++] = ""
                else {
                    v = data[count + j++] = int($i)
                    if (max == "" && min == "") max = min = v
                    if (max < v) max = v
                    if (min > v ) min = v
                }
            }
            count += j - 1
        }
        END {
            n = split(min == max && max ? "▅ ▅" : "▁ ▂ ▃ ▄ ▅ ▆ ▇ █", blocks, " ")
            scale = (scale = int(256 * (max - min) / (n - 1))) ? scale : 1
            for (i = 1; i <= count; i++)
                out = out (data[i] == "" ? " " : blocks[idx = int(256 * (data[i] - min) / scale) + 1])
            print out
        }
    '
end

# displays the commits 
# lolcat with low frequency creates various gradient colouring for the 
function commits
	git log --author="$argv" --format=format:"%h - %ad  - %s%n"  --date=format:"%d %B %Y, %H:%M:%S" 
end

# backup function
function backup --argument filename
	cp $filename $filename.backup
end

# background setter
function background --argument filepath

        # removes all configurations
        wpg -d (wpg -l)

        # remove previous hard link to the background
        rm -rf ~/assets/wallpapers/current_background/background	

        # creating another hard link, replacing another one
        ln $filepath ~/assets/wallpapers/current_background/background
        
        # adding the image to the wpgtk 
        wpg -a $filepath

        # extracting the name of the file from given path
        string match -raiq '(?<wallpaper>)\w*.png|.jpg|.jpeg' $filepath  
       
        # setting the theme without setting the wallpaper 
        wpg -ns $wallpaper

        # restoring the wallpaper
        nitrogen --restore

        # clearing the notofications
        /bin/clear        

        # eyecandy
        wpg --preview
end

# shuffle the colourscheme
function shuffle

    # shuffle the colourscheme of the current wallpaper
    wpg -z (wpg -l)

    # set the new scheme
    wpg -ns (wpg -l) 
    
    # clearing the notifications
    /bin/clear

    # both eyecandy and visual representation of new theme
    wpg --preview
end

# simple wrapper for clear command
function clear
    command clear
    command colorscript random
end

# managing pwd
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# vim 
alias vim='nvim'

# broot
alias br='broot -dhp'
alias bs='broot --sizes'

# exa
alias ls='exa -al --color=always --group-directories-first'
alias la='exa -a --color=always --group-directories-first'
alias ll='exa -l --color=always --group-directories-first'  
alias lt='exa -aT --color=always --group-directories-first'

# mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"

# colouring grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# to prevent overwriting files
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# memory control 
alias df='df -h'
alias free='free -m'

# fast access to the journal
alias jctl="journalctl -p 3 -xb"

# colorscripts after opening terminal
colorscript random

# setting starship prompt
starship init fish | source
