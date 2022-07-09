# paths
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths
set CLASSPATH ~/current_project $CLASSPATH

# fish greeting supressed
set fish_greeting

# terminal type set TERM "xterm-256color"

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

# backup function
function backup --argument filename
	cp $filename $filename.backup
end

# qtile
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

# qtile
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

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# vim 
alias vim='nvim'

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

# test awesome configuration
function testwm
	kill Xephyr
	Xephyr :5 & sleep 1 ; DISPLAY=:5 awesome
end

# colorscripts after opening terminal
colorscript random

# setting starship prompt
starship init fish | source
