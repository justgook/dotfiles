#
### GLOBAL VARIABLES
#

# colors for ls command
set -gx lscolors "cxbgdxdxbxdgeghegeacad"

# keys binding
bind "^x\\x7f" backward-kill-line

# editor
set -x editor v
set -x git_editor $editor
set -x sudo_editor "rvim -u none"

switch (uname)
case linux
    set -x ostype "linux"
case darwin
    set -x ostype "macos"
case freebsd netbsd dragonfly
    set -x ostype "freebsd"
case '*'
    set -x ostype "unknown"
end



if [ -f $HOME/.config/fish/env/index.fish ]
    source $HOME/.config/fish/env/index.fish
end

if [ -f $HOME/.config/fish/aliases/index.fish ]
    source $HOME/.config/fish/aliases/index.fish
end

#
### GIT PROMPT CONFIGURATION
# See the file /usr/local/share/fish/functions/fish_git_prompt.fish
#
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_showupstream 'yes'

set -l cl_empress '757575'
set -l cl_gainsboro 'E0E0E0'
set -l cl_dodger_blue '297EF2'
set -l cl_gorse 'FFEB3B'
set -l cl_red_orange 'F52D2D'
set __fish_git_prompt_color_branch $cl_gorse -b $cl_empress
set __fish_git_prompt_color_dirtystate $cl_dodger_blue -b $cl_gainsboro
set __fish_git_prompt_color_invalidstate $cl_red_orange -b $cl_gainsboro
set __fish_git_prompt_color_stagedstate $cl_dodger_blue -b $cl_gainsboro
set __fish_git_prompt_color_cleanstate $cl_dodger_blue -b $cl_gainsboro
set __fish_git_prompt_color_stashstate $cl_dodger_blue -b $cl_gainsboro
set __fish_git_prompt_color_upstream $cl_gainsboro -b $cl_empress
set __fish_git_prompt_color_untrackedfiles $cl_dodger_blue -b $cl_gainsboro
set __fish_git_prompt_color $cl_gainsboro -b $cl_empress

set __fish_git_prompt_char_cleanstate '  '
set __fish_git_prompt_char_dirtystate '  '
set __fish_git_prompt_char_invalidstate '  '
set __fish_git_prompt_char_stagedstate '  '
set __fish_git_prompt_char_stashstate '  '
set __fish_git_prompt_char_stateseparator ' '
set __fish_git_prompt_char_untrackedfiles '  '
set __fish_git_prompt_char_upstream_ahead '  '
set __fish_git_prompt_char_upstream_behind '  '
set __fish_git_prompt_char_upstream_diverged '  '
set __fish_git_prompt_char_upstream_equal '  '
set __fish_git_prompt_char_upstream_prefix ' '

#
### PROMPT
#

# Prevent directories names from being shortened
set fish_prompt_pwd_dir_length 0

# fish_prompt defined in ~/.config/fish/functions/fish_prompt.fish



