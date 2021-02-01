Play_scene = Scene:extend('Play_scene')

local clouds          = lg.newImage('assets/images/clouds.png')
local mountains       = lg.newImage('assets/images/mountains.png')
local forest          = lg.newImage('assets/images/forest.png')
local back_grass      = lg.newImage('assets/images/back_grass.png')
local back_grass_tree = lg.newImage('assets/images/back_grass_tree.png')
local front_grass     = lg.newImage('assets/images/front_grass.png')



function Play_scene:new()
	Play_scene.super.new(@)

	@:add('bird', Bird(100, 100))
	@.camera:set_position(400, 300)


	@.delta = 0
end

function Play_scene:update(dt)
	Play_scene.super.update(@, dt)
	if pressed('escape') then game:change_scene_with_transition('menu') end

	local bird = @:get('bird')
	
	if bird then
		if down('z') then bird.pos.y -= 300 * dt end
		if down('s') then bird.pos.y += 300 * dt end
		if down('q') then bird.pos.x -= 300 * dt end
		if down('d') then bird.pos.x += 300 * dt end
	end

	@.delta -= 1
end

function Play_scene:draw_inside_camera_bg()
	lg.draw(clouds, @.delta * .6 % clouds:getWidth() * 2                        , 0, _, 2)
	lg.draw(clouds, @.delta * .6 % clouds:getWidth() * 2 + clouds:getWidth() * 2, 0, _, 2)
	lg.draw(clouds, @.delta * .6 % clouds:getWidth() * 2 - clouds:getWidth() * 2, 0, _, 2)
	
	lg.draw(mountains, @.delta * .7 % mountains:getWidth() * 2                           , 0, _, 2)
	lg.draw(mountains, @.delta * .7 % mountains:getWidth() * 2 + mountains:getWidth() * 2, 0, _, 2)
	lg.draw(mountains, @.delta * .7 % mountains:getWidth() * 2 - mountains:getWidth() * 2, 0, _, 2)

	lg.draw(forest, @.delta * .8 % forest:getWidth() * 2                        , 0, _, 2)
	lg.draw(forest, @.delta * .8 % forest:getWidth() * 2 + forest:getWidth() * 2, 0, _, 2)
	lg.draw(forest, @.delta * .8 % forest:getWidth() * 2 - forest:getWidth() * 2, 0, _, 2)

	lg.draw(back_grass_tree, @.delta * .9 % back_grass_tree:getWidth() * 2                                 , 0, _, 2)
	lg.draw(back_grass_tree, @.delta * .9 % back_grass_tree:getWidth() * 2 + back_grass_tree:getWidth() * 2, 0, _, 2)
	lg.draw(back_grass_tree, @.delta * .9 % back_grass_tree:getWidth() * 2 - back_grass_tree:getWidth() * 2, 0, _, 2)
	
end

function Play_scene:draw_inside_camera_fg()
	lg.draw(front_grass, @.delta % front_grass:getWidth() * 2                             , 30, _, 2)
	lg.draw(front_grass, @.delta % front_grass:getWidth() * 2 + front_grass:getWidth() * 2, 30, _, 2)
	lg.draw(front_grass, @.delta % front_grass:getWidth() * 2 - front_grass:getWidth() * 2, 30, _, 2)

end
