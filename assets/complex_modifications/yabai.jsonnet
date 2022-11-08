
// Lib
local lib = import 'library.libsonnet';
local manipulators = lib.manipulators;
//std.objectFields(o)

{
  title: 'Yabai Window Management',
  rules: [
    {
      description: 'focus window',
      manipulators: manipulators({
        'alt - h': 'yabai -m window --focus west',
        'alt - j': 'yabai -m window --focus south',
        'alt - k': 'yabai -m window --focus north',
        'alt - l': 'yabai -m window --focus east',
      }),
    },
    {
      description: 'Next Previous',
      manipulators: manipulators({
        'alt - p': 'yabai -m window --focus stack.prev',
        'alt - n': 'yabai -m window --focus stack.next',
      }),
    },
    {
      description: 'Wwap window',
      manipulators: manipulators({
        'shift + alt - h': 'yabai -m window --swap west',
        'shift + alt - j': 'yabai -m window --swap south',
        'shift + alt - k': 'yabai -m window --swap north',
        'shift + alt - l': 'yabai -m window --swap east',
      }),
    },
    {
      description: 'move window',
      manipulators: manipulators({
        'shift + cmd - h': 'yabai -m window --warp west',
        'shift + cmd - j': 'yabai -m window --warp south',
        'shift + cmd - k': 'yabai -m window --warp north',
        'shift + cmd - l': 'yabai -m window --warp east',
      }),
    },
    {
      description: 'move desktop',
      manipulators: manipulators({
        'alt - 1': 'yabai -m space --focus 1',
        'alt - 2': 'yabai -m space --focus 2',
        'alt - 3': 'yabai -m space --focus 3',
        'alt - 4': 'yabai -m space --focus 4',
        'alt - 5': 'yabai -m space --focus 5',
        'alt - 6': 'yabai -m space --focus 6',
        'alt - 7': 'yabai -m space --focus 7',
        'alt - 8': 'yabai -m space --focus 8',
        'alt - 9': 'yabai -m space --focus 9',
      }),
    },
    {
      description: 'move window and focus desktop',
      manipulators: manipulators({
        'shift + alt - 0': 'yabai -m space --balance',
        'shift + alt - 1': 'yabai -m window --space 1; yabai -m space --focus 1',
        'shift + alt - 2': 'yabai -m window --space 2; yabai -m space --focus 2',
        'shift + alt - 3': 'yabai -m window --space 3; yabai -m space --focus 3',
        'shift + alt - 4': 'yabai -m window --space 4; yabai -m space --focus 4',
        'shift + alt - 5': 'yabai -m window --space 5; yabai -m space --focus 5',
        'shift + alt - 6': 'yabai -m window --space 6; yabai -m space --focus 6',
        'shift + alt - 7': 'yabai -m window --space 7; yabai -m space --focus 7',
        'shift + alt - 8': 'yabai -m window --space 8; yabai -m space --focus 8',
        'shift + alt - 9': 'yabai -m window --space 9; yabai -m space --focus 9',
      }),
    },
    {
      description: 'rotate float fullscreen',
      manipulators: manipulators({
        'alt - r': 'yabai -m space --rotate 90',
        'alt - f': 'yabai -m window --toggle zoom-fullscreen',
        'alt - t': 'yabai -m window --toggle float;yabai -m window --grid 4:4:1:1:2:2',
        'alt - e': 'yabai -m window --toggle split',
      }),
    },

  ],
}
