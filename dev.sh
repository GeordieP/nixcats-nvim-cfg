#!/bin/bash

# project window spawner script
# designed for niri


# >>> spwan a lazygit window
alacritty -e lazygit &
LAZYGIT_WINDOW_PID=$!

# >>> spwan a yazi window
alacritty -e yazi &
YAZI_WINDOW_PID=$!

# >>> spwan a window with a nix dev shell, for running terminal commands
alacritty -e fish -c 'nix develop' &
DEVSHELL_WINDOW_PID=$!

# spawn a dev shell in the current terminal, for running neovim in
fish -c 'nix develop'
