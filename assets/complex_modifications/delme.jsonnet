

//#Applications Start
//hyper - s : open -a Safari
//hyper - a : open -a Alacritty

local shell(cmd) = { shell_command: cmd };
local to_shell(cmd) = { to: [{ shell_command: cmd }] };

local brew_cmd(mod, key, cmd) = {
  local brew_bin_path = 'export PATH=/opt/homebrew/bin:$PATH; ',
  type: 'basic',
  from: {
    key_code: key,
    modifiers: { mandatory: mod },
  },
  to: [{ shell_command: brew_bin_path + cmd }],
};


local Focus_Window = [
  { k: 'h', c: 'yabai -m window --focus west' },
  { k: 'j', c: 'yabai -m window --focus south' },
  { k: 'k', c: 'yabai -m window --focus north' },
  { k: 'l', c: 'yabai -m window --focus east' },
];

local Next_Previous = [
  { k: 'p', c: 'yabai -m window --focus stack.prev' },
  { k: 'n', c: 'yabai -m window --focus stack.next' },
];

local Swap_Window = [
  { k: 'h', c: 'yabai -m window --swap west' },
  { k: 'j', c: 'yabai -m window --swap south' },
  { k: 'k', c: 'yabai -m window --swap north' },
  { k: 'l', c: 'yabai -m window --swap east' },
];

local Move_Window = [
  { k: 'h', c: 'yabai -m window --warp west' },
  { k: 'j', c: 'yabai -m window --warp south' },
  { k: 'k', c: 'yabai -m window --warp north' },
  { k: 'l', c: 'yabai -m window --warp east' },
];

local move_to_desktop = [
  { k: '1', c: 'yabai -m space --focus 1' },
  { k: '2', c: 'yabai -m space --focus 2' },
  { k: '3', c: 'yabai -m space --focus 3' },
  { k: '4', c: 'yabai -m space --focus 4' },
  { k: '5', c: 'yabai -m space --focus 5' },
  { k: '6', c: 'yabai -m space --focus 6' },
  { k: '7', c: 'yabai -m space --focus 7' },
  { k: '8', c: 'yabai -m space --focus 8' },
  { k: '9', c: 'yabai -m space --focus 9' },
];


local move_window_and_focus_desktop = [
    { k: '0', c: 'yabai -m space --balance' },
    { k: '1', c: 'yabai -m window --space 1; yabai -m space --focus 1' },
    { k: '2', c: 'yabai -m window --space 2; yabai -m space --focus 2' },
    { k: '3', c: 'yabai -m window --space 3; yabai -m space --focus 3' },
    { k: '4', c: 'yabai -m window --space 4; yabai -m space --focus 4' },
    { k: '5', c: 'yabai -m window --space 5; yabai -m space --focus 5' },
    { k: '6', c: 'yabai -m window --space 6; yabai -m space --focus 6' },
    { k: '7', c: 'yabai -m window --space 7; yabai -m space --focus 7' },
    { k: '8', c: 'yabai -m window --space 8; yabai -m space --focus 8' },
    { k: '9', c: 'yabai -m window --space 9; yabai -m space --focus 9' },
];

local rotate_fullscreen_float = [
   { k: 'r', c: 'yabai -m space --rotate 90' }, // Rotate
   { k: 'f', c: 'yabai -m window --toggle zoom-fullscreen' }, // fullscreen
   { k: 't', c: 'yabai -m window --toggle float;yabai -m window --grid 4:4:1:1:2:2' }, // float
   { k: 'e', c: 'yabai -m window --toggle split' }, // split (vertical|horizontal)
];

{
  title: 'Yabai Window Management',
  rules: [
    {
      description: 'Focus Window',
      manipulators: [brew_cmd(['left_option'], x.k, x.c) for x in Focus_Window],
    },
    {
      description: 'Next Previous',
      manipulators: [brew_cmd(['left_option'], x.k, x.c) for x in Focus_Window],
    },
    {
      description: 'Swap Window',
      manipulators: [brew_cmd(['left_option', 'left_shift'], x.k, x.c) for x in Swap_Window],
    },
    {
      description: 'Move Window',
      manipulators: [brew_cmd(['left_shift', 'left_command'], x.k, x.c) for x in Move_Window],
    },
    {
      description: 'Move to desktop',
      manipulators: [brew_cmd(['left_option'], x.k, x.c) for x in move_to_desktop],
    },
    {
      description: 'Move window and focus desktop',
      manipulators: [brew_cmd(['left_option', 'left_shift'], x.k, x.c) for x in move_window_and_focus_desktop],
    },
    {
      description: 'rotate_fullscreen_float',
      manipulators: [brew_cmd(['left_option'], x.k, x.c) for x in rotate_fullscreen_float],
    },

  ],
}
