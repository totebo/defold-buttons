# Defold Buttons
A minimal button implementation, supporting idle and pressed and not much else.

# Installation
You can use Defold Buttons in your own project by adding this project as a [Defold library dependency](http://www.defold.com/manuals/libraries/). Open your game.project file and in the dependencies field under project add:

    https://github.com/totebo/defold-buttons/archive/master.zip

Or point to the ZIP file of a [specific release](https://github.com/totebo/defold-buttons/releases).


## Example

      -- Init
      local buttons = require "buttons"
      msg.post(".", "acquire_input_focus")

      -- Register a button
      buttons:add( self,"button_id", "button_idle_playbook", "button_pressed_playbook", on_button__trigger )

      -- Unregister a button
      buttons:remove( "button_id" )

      -- On input
      buttons:on_input( action_id, action )
