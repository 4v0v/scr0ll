Bird = Entity:extend('Bird')

Bird.fly_frames = AnimationFrames('assets/images/bird.png', 207, 206, _, _, '1-1, 2-1, 3-1, 4-1, 5-1, 6-1, 7-1, 8-1, 9-1')


function Bird:new(x, y )
	Bird.super.new(@, {x = x, y = y} )

	@.bird_anim = Animation(.1, Bird.fly_frames)

	@.tilt = 0
end

function Bird:update(dt)
	Bird.super.update(@, dt)

	@.bird_anim:update(dt)

	if   down('q') then 
		@.pos.x -= 300 * dt
		if @.bird_anim.delay != .2 then @.bird_anim:set_delay(.2) end
		if @.tilt != -.4 then @.tilt = -.4 end


	elif down('d') then 
		@.pos.x += 300 * dt
		if @.bird_anim.delay != .05 then @.bird_anim:set_delay(.05) end
	end

	if   down('z') then 
		@.pos.y -= 300 * dt
		if @.tilt != -.4 then @.tilt = -.4 end
		if @.bird_anim.delay != .05 then @.bird_anim:set_delay(.05) end


	elif down('s') then 
		@.pos.y += 300 * dt
		if @.tilt != .4 then @.tilt = .4 end
		if @.bird_anim.delay != .2 then @.bird_anim:set_delay(.2) end

	end


	if   !down('q') && !down('d') && !down('z') && !down('s') then
		if @.tilt != 0             then @.tilt = 0               end
		if @.bird_anim.delay != .1 then @.bird_anim:set_delay(.1) end
	end

end

function Bird:draw()
	@.bird_anim:draw(@.pos.x, @.pos.y, @.tilt)
end
