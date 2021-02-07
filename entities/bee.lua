Bee = Entity:extend('Bee')

local bees = lg.newImage('assets/images/bees.png')
Bee.fly_frames = AnimationFrames(bees, bees:getWidth() / 8, bees:getHeight() / 5, _, _, '1-1, 2-1, 3-1, 4-1')

function Bee:new(x, y )
	Bee.super.new(@, {x = x, y = y} )

	@.bee_anim   = Animation(.1, Bee.fly_frames)
	@.sin        = Sinewave(0, 150, 2)
	@.inital_pos = @.pos.y
end

function Bee:update(dt)
	Bee.super.update(@, dt)
	@.bee_anim:update(dt)
	@.sin:update(dt)

	@.pos.y = @.inital_pos + @.sin:get()
end

function Bee:draw()
	@.bee_anim:draw(@.pos.x, @.pos.y, _ , -2, 2)
end

function Bee:aabb()
	return {
		@.pos.x,
		@.pos.y,
		bees:getWidth() / 8 * 2,
		bees:getHeight() / 5 * 2,
	}
end
