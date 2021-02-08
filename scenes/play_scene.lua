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

	@.total_hp = 100
	@.hp       = @.total_hp
	@.tween_hp = Tween(@.hp, 'in-out-cubic')
end

function Play_scene:update(dt)
	Play_scene.super.update(@, dt)
	@.tween_hp:update(dt)

	if pressed('escape') then change_scene_with_transition('menu') end

	local bees     = @:get_by_type('Bee')
	local bird     = @:get('bird')
	local bullets  = @:get_by_type('Bullet')
	local ebullets = @:get_by_type('Enemy_Bullet')
	
	ifor bullet in bullets do
		ifor bee in bees do 
			if rect_rect_collision(bee:aabb(), bullet:aabb()) then
				bee:hit(bullet.damage)
				bullet:kill()
			end
		end
	end

	ifor bullet in ebullets do 
		if rect_rect_collision(bullet:aabb(), bird:aabb()) then
			@:shake(20)
			bird:hit()
			bullet:kill()
			@.hp -= bullet.damage
			
			if @.hp <= 0 then 
				@.hp = @.total_hp 
			end

			@.tween_hp:tween(@.hp, .2)
		end
	end

	if @:count('Bee') == 0 then
		@:once(fn()
			@:after(1  , fn() @:add(Bee(500, 200)) end)
			@:after(1.2, fn() @:add(Bee(580, 200)) end)
			@:after(1.4, fn() @:add(Bee(660, 200)) end)
			@:after(1.6, fn() @.trigger:remove('spawn_bees') end)
		end, 'spawn_bees')
	end
end

function Play_scene:draw_inside_camera_bg()
	lg.draw(clouds    , @.delta * .1 % clouds:getWidth()     * 2                            , 0, _, 2)
	lg.draw(clouds    , @.delta * .1 % clouds:getWidth()     * 2 - clouds:getWidth()     * 2, 0, _, 2)
	lg.draw(clouds    , @.delta * .1 % clouds:getWidth()     * 2 + clouds:getWidth()     * 2, 0, _, 2)
	lg.draw(mountains , @.delta * .3 % mountains:getWidth()  * 2                            , 0 + 40, _, 2)
	lg.draw(mountains , @.delta * .3 % mountains:getWidth()  * 2 - mountains:getWidth()  * 2, 0 + 40, _, 2)
	lg.draw(mountains , @.delta * .3 % mountains:getWidth()  * 2 + mountains:getWidth()  * 2, 0 + 40, _, 2)
	lg.draw(forest    , @.delta * .5 % forest:getWidth()     * 2                            , 0 + 80, _, 2)
	lg.draw(forest    , @.delta * .5 % forest:getWidth()     * 2 - forest:getWidth()     * 2, 0 + 80, _, 2)
	lg.draw(forest    , @.delta * .5 % forest:getWidth()     * 2 + forest:getWidth()     * 2, 0 + 80, _, 2)
	lg.draw(back_grass, @.delta * .7 % back_grass:getWidth() * 2                            , 0 + 120, _, 2)
	lg.draw(back_grass, @.delta * .7 % back_grass:getWidth() * 2 - back_grass:getWidth() * 2, 0 + 120, _, 2)
	lg.draw(back_grass, @.delta * .7 % back_grass:getWidth() * 2 + back_grass:getWidth() * 2, 0 + 120, _, 2)
end

function Play_scene:draw_inside_camera_fg()
	-- for @:get_all_entities() do
	-- 	if it.aabb then 
	-- 		local aabb = it:aabb()
	-- 		lg.rectangle('line', aabb[1], aabb[2], aabb[3], aabb[4])
	-- 	end
	-- end

	lg.draw(front_grass, @.delta % front_grass:getWidth() * 2                             , 160, _, 2)
	lg.draw(front_grass, @.delta % front_grass:getWidth() * 2 + front_grass:getWidth() * 2, 160, _, 2)
	lg.draw(front_grass, @.delta % front_grass:getWidth() * 2 - front_grass:getWidth() * 2, 160, _, 2)
end

function Play_scene:draw_outside_camera_fg()
	lg.setColor(COLORS.RED)
	lg.rectangle('fill', 10 ,10, 400 * @.tween_hp:get() / @.total_hp, 30)

	lg.setColor(COLORS.WHITE)
	lg.rectangle('line', 10 ,10, 400, 30)
end
