-- Get required modules
local storyboard = require("storyboard")
local bubble_effect = require("bubble_effect")

-- Build a new scene
local scene = storyboard.newScene()

-- A timer for timed scene change
local timer_fade
local function _onSplashTimeout()
	storyboard.gotoScene("scene1", "bubbles", 1000)
	return true
end

-- Scene creation event
function scene:createScene(event)
	local group = self.view
	local background = display.newImageRect("scene2.png", 569, 360)
	background:setReferencePoint(display.CenterReferencePoint)
	background.x = 240
	background.y = 160
	group:insert(background)
end

-- Scene entered event
function scene:enterScene(event)
	timer_fade = timer.performWithDelay(1000, _onSplashTimeout)
end

-- Scene exit event
function scene:exitScene(event)
	timer.cancel(timer_fade)
	timer_fade = nil
end

scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
return scene
