Bee = Entity:extend('Bee')

Bee.spritesheet = lg.newImage('assets/images/bees.png')
Bee.fly_frames  = AnimationFrames(Bee.spritesheet, Bee.spritesheet:getWidth() / 8, Bee.spritesheet:getHeight() / 5, _, _, '1-1, 2-1, 3-1, 4-1')
Bee.explode     = AnimationFrames(Bee.spritesheet, Bee.spritesheet:getWidth() / 8, Bee.spritesheet:getHeight() / 5, _, _, '1-5, 2-5, 3-5')

function Bee:new(x, y )
	Bee.super.new(@, {x = x, y = y} )

	@.bee_anim   = Animation(.1, @.fly_frames)
	@.sin        = Sinewave(0, 150, 2)
	@.inital_pos = @.pos.y


	@:every({.1, 5}, fn() @.scene:add(Enemy_Bullet(@.pos.x, @.pos.y)) end)
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
		@.pos.x - (@.spritesheet:getWidth() / 8 * 2)/ 2,
		@.pos.y - (@.spritesheet:getHeight() / 5 * 2) / 2,
		@.spritesheet:getWidth() / 8 * 2,
		@.spritesheet:getHeight() / 5 * 2,
	}
end
