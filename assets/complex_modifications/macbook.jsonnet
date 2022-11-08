{
  "title": "Macbook Keyboard Enhancement",
  "rules": [
    {
      "description": "CapsLock to Hyper",
      "manipulators": [
        {
          "type": "basic",
          "from": {
            "key_code": "caps_lock",
            "modifiers": {
              "optional": [
                "any"
              ]
            }
          },
          "to": [
            {
              "key_code": "right_shift",
              "modifiers": [
                "right_command",
                "right_control",
                "right_option"
              ]
            }
          ]
        }
      ]
    },
    {
      "manipulators": [
        {
          "description": "Tap Left Shift to '('",
          "type": "basic",
          "from": {
            "key_code": "left_shift",
            "modifiers": {
              "optional": [
                "any"
              ]
            }
          },
          "to": [
            {
              "key_code": "left_shift"
            }
          ],
          "to_if_alone": [
            {
              "key_code": "9",
              "modifiers": [
                "left_shift"
              ]
            }
          ]
        }
      ]
    }
  ]
}
