local M = {}
M.buttons = {}

local button_id = "/button"
local action_id_touch = hash("touch")

local function hit_test(self, node, action_id, action)

	if not self.is_enabled( self, node ) then
		return false
	end

	local hit = gui.pick_node( node, action.x, action.y )
	local touch = action_id == action_id_touch
	return touch and hit

end

function M.is_enabled(self, node)

	local parent = gui.get_parent(node)
	if parent then
		return self.is_enabled(self, parent)
	end

	return gui.is_enabled(node)
end


function M.add( self,gui,node_id,flipbook_idle,flipbook_pressed,cb )

	self.buttons[node_id] = { flipbook_idle=flipbook_idle, flipbook_pressed=flipbook_pressed, cb=cb }

end

function M.remove( self,node_id )
	self.buttons[node_id] = nil
end

function M.on_input( self, action_id, action )

	local buttons = self.buttons
	for node_id,button_data in pairs(buttons) do
		local flipbook = button_data.flipbook_idle
		local node = gui.get_node(node_id .. button_id)
		local hit = hit_test( self, node, action_id, action )
		if hit then
			if not button_data.pressed_outside then
				flipbook = button_data.flipbook_pressed
				if action.pressed then
					button_data.pressed_inside = true
				elseif action.released and button_data.pressed_inside then
					flipbook = button_data.flipbook_idle
					button_data.pressed_inside = false
					button_data.cb()
				end
			elseif action.released then
				button_data.pressed_outside = false
			end
		else
			if action.released then
				button_data.pressed_outside = false
			elseif action.pressed then
				button_data.pressed_outside = true
			end
		end

		gui.play_flipbook(node, flipbook)

	end

end

return M