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

	elif down('d') then 
		@.pos.x += 300 * dt
		if @.bird_anim.delay != .05 then @.bird_anim:set_delay(.05) end
	else
		@.bird_anim:set_delay(.1)
	end

	if   down('z') then 
		@.pos.y -= 300 * dt
		if @.tilt != -.4 then @.tilt = -.4 end
	elif down('s') then 
		@.pos.y += 300 * dt
		if @.tilt != .4 then @.tilt = .4 end
	else
		if @.tilt != 0 then @.tilt = 0 end
	end

	if down('space') then
		@:every_immediate(.3, fn() @.scene:add(Bullet(@.pos.x, @.pos.y)) end, _, 'shoot')
	else
		@.trigger:remove('shoot')
	end

end

function Bird:draw()
	@.bird_anim:draw(@.pos.x, @.pos.y, @.tilt)
end
