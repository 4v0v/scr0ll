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
	@.camera:set_position(400, 300)

	@.delta = 0
end

function Play_scene:update(dt)
	Play_scene.super.update(@, dt)

	@.delta -= 1
end

function Play_scene:draw_inside_camera_bg()
	lg.draw(clouds, @.delta * .6 % clouds:getWidth() * 2  , 0, _, 2)
	lg.draw(clouds, @.delta * .6 % clouds:getWidth() * 2    + clouds:getWidth() * 2, 0, _, 2)
	lg.draw(clouds, @.delta * .6 % clouds:getWidth() * 2 - clouds:getWidth() * 2, 0, _, 2)
	
	lg.draw(mountains, @.delta * .7 % mountains:getWidth() * 2                           , 0, _, 2)
	lg.draw(mountains, @.delta * .7 % mountains:getWidth() * 2 + mountains:getWidth() * 2, 0, _, 2)
	lg.draw(mountains, @.delta * .7 % mountains:getWidth() * 2 - mountains:getWidth() * 2, 0, _, 2)

	lg.draw(forest, @.delta * .8 % forest:getWidth() * 2                        , 0, _, 2)
	lg.draw(forest, @.delta * .8 % forest:getWidth() * 2 + forest:getWidth() * 2, 0, _, 2)
	lg.draw(forest, @.delta * .8 % forest:getWidth() * 2 - forest:getWidth() * 2, 0, _, 2)

	lg.draw(back_grass, @.delta * .9 % back_grass:getWidth() * 2                            , 0, _, 2)
	lg.draw(back_grass, @.delta * .9 % back_grass:getWidth() * 2 + back_grass:getWidth() * 2, 0, _, 2)
	lg.draw(back_grass, @.delta * .9 % back_grass:getWidth() * 2 - back_grass:getWidth() * 2, 0, _, 2)
end

function Play_scene:draw_inside_camera_fg()
	lg.draw(front_grass, @.delta % front_grass:getWidth() * 2                             , 30, _, 2)
	lg.draw(front_grass, @.delta % front_grass:getWidth() * 2 + front_grass:getWidth() * 2, 30, _, 2)
	lg.draw(front_grass, @.delta % front_grass:getWidth() * 2 - front_grass:getWidth() * 2, 30, _, 2)
end


function Play_scene:keypressed(key)
	if key == 'escape' then change_scene_with_transition('menu') end

	local bird = @:get('bird')

	if bird then
		if key == 'z' then
			if   bird:is_state('moving_left')  then bird:set_state('moving_up_left')
			elif bird:is_state('moving_right') then bird:set_state('moving_up_right')
			else bird:set_state('moving_up') end
		end

		if key == 's' then 
			if   bird:is_state('moving_left')  then bird:set_state('moving_down_left')
			elif bird:is_state('moving_right') then bird:set_state('moving_down_right')
			else bird:set_state('moving_down') end
		end

		if key == 'q' then
			if   bird:is_state('moving_up')   then bird:set_state('moving_up_left')
			elif bird:is_state('moving_down') then bird:set_state('moving_down_left')
			else bird:set_state('moving_left') end
		end

		if key == 'd' then 
			if   bird:is_state('moving_up')   then bird:set_state('moving_up_right')
			elif bird:is_state('moving_down') then bird:set_state('moving_down_right')
			else bird:set_state('moving_right') end
		end
	end
end

function Play_scene:keyreleased(key)
	local bird = @:get('bird')

	if bird then

		if key == 'z' then 
			if bird:is_state('moving_up')       then bird:set_state('default')      end
			if bird:is_state('moving_up_left')  then bird:set_state('moving_left')  end
			if bird:is_state('moving_up_right') then bird:set_state('moving_right') end
		end

		if key == 's' then 
			if bird:is_state('moving_down')       then bird:set_state('default')      end
			if bird:is_state('moving_down_left')  then bird:set_state('moving_left')  end
			if bird:is_state('moving_down_right') then bird:set_state('moving_right') end
		end

		if key == 'q' then 
			if bird:is_state('moving_left')       then bird:set_state('default')     end
			if bird:is_state('moving_up_left')    then bird:set_state('moving_up')   end
			if bird:is_state('moving_down_right') then bird:set_state('moving_down') end
		end


		if key == 'd' then 
			if bird:is_state('moving_right')      then bird:set_state('default')     end
			if bird:is_state('moving_up_right')   then bird:set_state('moving_up')   end
			if bird:is_state('moving_down_right') then bird:set_state('moving_down') end
		end

	end
end