Play_scene = Scene:extend('Play_scene')

local clouds          = lg.newImage('assets/images/clouds.png')
local mountains       = lg.newImage('assets/images/mountains.png')
local forest          = lg.newImage('assets/images/forest.png')
local back_grass      = lg.newImage('assets/images/back_grass.png')
local back_grass_tree = lg.newImage('assets/images/back_grass_tree.png')
local front_grass     = lg.newImage('assets/images/front_grass.png')

local bird_frames = AnimationFrames('assets/images/bird.png', 207, 206, _, _, '1-1, 2-1, 3-1, 4-1, 5-1, 6-1, 7-1, 8-1, 9-1')


function Play_scene:new()
	Play_scene.super.new(@)

	@.bird_anim = Animation(.1, bird_frames)

	@:add('rect', Rectangle(0, 0, 100, 100, {mode = 'line', color = {.8, .3, .3}, centered = true}))
	@.camera:set_position(400, 300)

	@.delta = 0
end

function Play_scene:update(dt)
	Play_scene.super.update(@, dt)
	@.bird_anim:update(dt)
	if pressed('escape') then game:change_scene_with_transition('menu') end

	local rect = @:get('rect')
	
	if rect then
		if down('z') then rect.pos.y -= 300 * dt end
		if down('s') then rect.pos.y += 300 * dt end
		if down('q') then rect.pos.x -= 300 * dt end
		if down('d') then rect.pos.x += 300 * dt end
	end

	@.delta -= 1
	if math.abs(@.delta) > front_grass:getWidth() then 
		@.delta = 0 
	end
end

function Play_scene:draw_inside_camera_bg()
	lg.draw(clouds         , @.delta * .6,                         0, _, 2)
	lg.draw(clouds         , @.delta * .6 + clouds:getWidth() * 2, 0, _, 2)
	-- lg.draw(clouds         , @.delta * .6 + clouds:getWidth() * 2, 0, _, 2)
	
	-- lg.draw(mountains      , @.delta * .7,                           0, _, 2)
	-- lg.draw(mountains      , @.delta * .7 +mountains:getWidth()    , 0, _, 2)
	-- lg.draw(mountains      , @.delta * .7 +mountains:getWidth() * 2, 0, _, 2)
	
	-- lg.draw(forest         , @.delta * .8,                        0, _, 2)
	-- lg.draw(forest         , @.delta * .8 +forest:getWidth()    , 0, _, 2)
	-- lg.draw(forest         , @.delta * .8 +forest:getWidth() * 2, 0, _, 2)
	
	-- lg.draw(back_grass_tree, @.delta * .9,                                 0, _, 2)
	-- lg.draw(back_grass_tree, @.delta * .9 +back_grass_tree:getWidth()    , 0, _, 2)
	-- lg.draw(back_grass_tree, @.delta * .9 +back_grass_tree:getWidth() * 2, 0, _, 2)
end

function Play_scene:draw_inside_camera_fg()
	local rect = @:get('rect')

	if rect then
		@.bird_anim:draw(rect.pos.x, rect.pos.y)
	end

	lg.draw(front_grass, @.delta,                              0, _, 2)
	lg.draw(front_grass, @.delta + front_grass:getWidth()    , 0, _, 2)
	lg.draw(front_grass, @.delta + front_grass:getWidth() * 2, 0, _, 2)
end
