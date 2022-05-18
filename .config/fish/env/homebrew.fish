# fish 3.1+ doesn't add binaries to the path autmatically anymore
# https://github.com/fish-shell/fish-shell/issues/6594
fish_add_path /usr/local/bin -P

# on m1 macs, homebrew installs things in /opt/homebrew
# contains /opt/homebrew/bin
# or set path /opt/homebrew/bin $path

fish_add_path /opt/homebrew/bin  -P
