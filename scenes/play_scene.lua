Play_scene = Scene:extend('Play_scene')

local clouds          = lg.newImage('assets/images/clouds.png')
local mountains       = lg.newImage('assets/images/mountains.png')
local forest          = lg.newImage('assets/images/forest.png')
local back_grass      = lg.newImage('assets/images/back_grass.png')
local front_grass     = lg.newImage('assets/images/front_grass.png')
local back_grass_tree = lg.newImage('assets/images/back_grass_tree.png')

function Play_scene:new()
	Play_scene.super.new(@)

	@:add('bird', Bird(100, 100))
	@:add(Bee(500, 200))
	@:after(.2, fn() @:add(Bee(580, 200)) end)
	@:after(.4, fn() @:add(Bee(660, 200)) end)
	
	@.camera:set_position(400, 300)

	@.delta = 0
	@:always(fn() @.delta -= 3 end, 'add_delta')
end

function Play_scene:update(dt)
	Play_scene.super.update(@, dt)
	if pressed('escape') then change_scene_with_transition('menu') end

	local bees = @:get_by_type('Bee')

	local bullets = @:get_by_type('Bullet')
	
	ifor bee in bees do 
		ifor bullet in bullets do
			if rect_rect_collision(bee:aabb(), bullet:aabb()) then 

				bullet:kill()
				bee:kill()
			end
		end
	end

	local bees_count = @:count('Bee')

	if bees_count == 0 then
		@:once(fn()
			@:after(1  , fn() @:add(Bee(500, 200)) end)
			@:after(1.2, fn() @:add(Bee(580, 200)) end)
			@:after(1.4, fn() @:add(Bee(660, 200)) end)
			@:after(1.6, fn() @.trigger:remove('spawn_bees') end)
		end, 'spawn_bees')
	end

	@:once(fn() @:every(.5, fn() print(@:count('All')) end)  end, 'print_ent_numbers')

end

function Play_scene:draw_inside_camera_bg()
	lg.draw(clouds    , @.delta * .1 % clouds:getWidth()     * 2                            , 0, _, 2)
	lg.draw(clouds    , @.delta * .1 % clouds:getWidth()     * 2 - clouds:getWidth()     * 2, 0, _, 2)
	lg.draw(clouds    , @.delta * .1 % clouds:getWidth()     * 2 + clouds:getWidth()     * 2, 0, _, 2)
	lg.draw(mountains , @.delta * .3 % mountains:getWidth()  * 2                            , 0, _, 2)
	lg.draw(mountains , @.delta * .3 % mountains:getWidth()  * 2 - mountains:getWidth()  * 2, 0, _, 2)
	lg.draw(mountains , @.delta * .3 % mountains:getWidth()  * 2 + mountains:getWidth()  * 2, 0, _, 2)
	lg.draw(forest    , @.delta * .5 % forest:getWidth()     * 2                            , 0, _, 2)
	lg.draw(forest    , @.delta * .5 % forest:getWidth()     * 2 - forest:getWidth()     * 2, 0, _, 2)
	lg.draw(forest    , @.delta * .5 % forest:getWidth()     * 2 + forest:getWidth()     * 2, 0, _, 2)
	lg.draw(back_grass, @.delta * .7 % back_grass:getWidth() * 2                            , 0, _, 2)
	lg.draw(back_grass, @.delta * .7 % back_grass:getWidth() * 2 - back_grass:getWidth() * 2, 0, _, 2)
	lg.draw(back_grass, @.delta * .7 % back_grass:getWidth() * 2 + back_grass:getWidth() * 2, 0, _, 2)
end

function Play_scene:draw_inside_camera_fg()
	lg.draw(front_grass, @.delta % front_grass:getWidth() * 2                             , 30, _, 2)
	lg.draw(front_grass, @.delta % front_grass:getWidth() * 2 + front_grass:getWidth() * 2, 30, _, 2)
	lg.draw(front_grass, @.delta % front_grass:getWidth() * 2 - front_grass:getWidth() * 2, 30, _, 2)
end
