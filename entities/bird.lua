Bird = Entity:extend('Bird')

Bird.fly_frames = AnimationFrames('assets/images/bird.png', 207, 206, _, _, '1-1, 2-1, 3-1, 4-1, 5-1, 6-1, 7-1, 8-1, 9-1')


function Bird:new(x, y )
	Bird.super.new(@, {x = x, y = y} )

	@.bird_anim = Animation(.1, Bird.fly_frames)
end

function Bird:update(dt)
	Bird.super.update(@, dt)

	@.bird_anim:update(dt)

	if @:is_state('default') then 
		if @.bird_anim.delay != .1 then @.bird_anim:set_delay(.1) end
	end

	if @:is_state('moving_down') then 
		@.pos.y += 300 * dt
	end

	if @:is_state('moving_up') then
		@.pos.y -= 300 * dt
	end

	if @:is_state('moving_left') then
		@.pos.x -= 300 * dt
		if @.bird_anim.delay != .2 then @.bird_anim:set_delay(.2) end
	end

	if @:is_state('moving_right') then
		@.pos.x += 300 * dt
		if @.bird_anim.delay != .05 then @.bird_anim:set_delay(.05) end
	end

	if @:is_state('moving_up_left') then
		@.pos.y -= 300 * dt
		@.pos.x -= 300 * dt
		if @.bird_anim.delay != .2 then @.bird_anim:set_delay(.2) end
	end

	if @:is_state('moving_up_right') then
		@.pos.y -= 300 * dt
		@.pos.x += 300 * dt
		if @.bird_anim.delay != .05 then @.bird_anim:set_delay(.05) end
	end

	if @:is_state('moving_down_left') then
		@.pos.y += 300 * dt
		@.pos.x -= 300 * dt
		if @.bird_anim.delay != .2 then @.bird_anim:set_delay(.2) end
	end

	if @:is_state('moving_down_right') then
		@.pos.y += 300 * dt
		@.pos.x += 300 * dt
		if @.bird_anim.delay != .05 then @.bird_anim:set_delay(.05) end
	end

end

function Bird:draw()
	if   @:is_state('default', 'moving_left', 'moving_right') then 
		@.bird_anim:draw(self.pos.x, self.pos.y)

	elif @:is_state('moving_down', 'moving_down_right', 'moving_down_left') then 
		@.bird_anim:draw(self.pos.x, self.pos.y, .4)

	elif @:is_state('moving_up', 'moving_up_right', 'moving_up_left')  then 
		@.bird_anim:draw(self.pos.x, self.pos.y, -.4)
	end
end
