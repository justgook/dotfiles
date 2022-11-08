local ModKeyNames = {
  cmd: 'left_command',
  command: 'left_command',
  '◆': 'left_command',
  G: 'left_command',
  '⌘': 'left_command',
  '': 'left_command',

  control: 'left_control',
  '⎈': 'left_control',
  C: 'left_control',
  '⋀': 'left_control',

  option: 'left_option',
  alt: 'left_option',
  '⎇': 'left_option',
  '⌥': 'left_option',
  A: 'left_option',
  O: 'left_option',

  shift: 'left_shift',
  '⇧': 'left_shift',
  S: 'left_shift',

  fn: 'fn',
  '⇪': 'caps_lock',
  '⎋': 'escape',
  '⌫': 'delete_or_backspace',
};

local keyString(keys) = {
  local cleanup(x) = std.map((function(s) std.stripChars(s, ' ')), x),
  local modAndKey = cleanup(std.split(keys, '-')),
  local modKey = std.map(function(x) ModKeyNames[x], cleanup(std.split(modAndKey[0], '+'))),

  key_code: modAndKey[1],
  modifiers: { mandatory: modKey },
};

local hyper = '';

local run(keys, cmd, prefix='export PATH=/opt/homebrew/bin:$PATH; ') = {
  type: 'basic',
  from: keyString(keys),
  to: [{ shell_command: prefix + cmd }],
};


local manipulators(input) = [
  run(key, input[key])
  for key in std.objectFields(input)
];

{
  manipulators: manipulators,
}
