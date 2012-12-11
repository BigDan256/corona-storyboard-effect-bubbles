--- bubble wipe transition

local storyboard = require("storyboard")

-- Load our bubble textures
local bubble_sheet = graphics.newImageSheet("bubble.png", {width = 64, height = 64, numFrames = 5, })

-- Add a new effect to storyboard (copy of the slideUp transition, with modifications)
storyboard.effectList.bubbles = {
	concurrent = true,
	to = {
		yEnd = 0,
		yStart = 384,

		-- Modified transition
		transition = function(t, tMax, start, delta)
			local percent = t / tMax

			if percent <= 0.5 then
				-- Add a bubble every tick
				local _sprite = display.newSprite(bubble_sheet, {
					{name = "float", start = 1, count = 5, time = 500, loopCount = 0, loopDirection = "bounce", }
				})
				_sprite.x = math.random(-63, 543)
				_sprite.y = 384
				_sprite:play()

				-- Float the bubble up and destroy it
				transition.to(_sprite, {time = math.random(tMax / 2, tMax), y = -64, onComplete = function(obj)
					obj:removeSelf()
				end, })
			end

			if percent <= 0.25 then
				return start
			elseif percent >= 0.75 then
				return start + delta
			else
				-- Return normal transitions in a shorter period
				return easing.inOutExpo(percent * 2 - 0.5, 1, start, delta)
			end
		end,
	},
	from = {
		yEnd = -384,
		yStart = 0,
		transition = function(t, tMax, start, delta)
			local percent = t / tMax

			if percent <= 0.25 then
				return start
			elseif percent >= 0.75 then
				return start + delta
			else
				-- Return normal transitions in a shorter period
				return easing.inOutExpo(percent * 2 - 0.5, 1, start, delta)
			end
		end,
	},
}
