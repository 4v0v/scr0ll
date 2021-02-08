Bee = Entity:extend('Bee')

Bee.spritesheet = lg.newImage('assets/images/bees.png')
Bee.fly_frames  = AnimationFrames(Bee.spritesheet, Bee.spritesheet:getWidth() / 8, Bee.spritesheet:getHeight() / 5, _, _, '1-1, 2-1, 3-1, 4-1')
Bee.explode     = AnimationFrames(Bee.spritesheet, Bee.spritesheet:getWidth() / 8, Bee.spritesheet:getHeight() / 5, _, _, '1-5, 2-5, 3-5')
Bee.fill_shader = lg.newShader("assets/shaders/fill.glsl")

function Bee:new(x, y )
	Bee.super.new(@, {x = x, y = y} )

	@.bee_anim   = Animation(.1, @.fly_frames)
	@.sin        = Sinewave(0, 150, 2)
	@.inital_pos = @.pos.y
	@.hp         = 30
	@.hit_alpha  = Tween(0)

	@:every({.1, 5}, fn() @.scene:add(Enemy_Bullet(@.pos.x, @.pos.y)) end, 'shoot')
end

function Bee:update(dt)
	Bee.super.update(@, dt)
	@.bee_anim:update(dt)
	@.sin:update(dt)
	@.hit_alpha:update(dt)

	@.pos.y = @.inital_pos + @.sin:get()
end

function Bee:draw()
	@.bee_anim:draw(@.pos.x, @.pos.y, _ , -2, 2)

	if @.hit_alpha:get() > 0 then

		lg.setColor(COLORS.GREEN[1], COLORS.GREEN[2], COLORS.GREEN[3], @.hit_alpha:get())
		lg.setShader(@.fill_shader)
		@.bee_anim:draw(@.pos.x, @.pos.y, _ , -2, 2)
		lg.setShader()
	end

end

function Bee:aabb()
	return {
		@.pos.x - (@.spritesheet:getWidth() / 8 * 2)/ 2,
		@.pos.y - (@.spritesheet:getHeight() / 5 * 2) / 2,
		@.spritesheet:getWidth() / 8 * 2,
		@.spritesheet:getHeight() / 5 * 2,
	}
end

function Bee:hit(damage)
	@.hp -= damage

	if @.hp <= 0 then 
		@:kill()
	else
		@.hit_alpha:set(1)
		@.hit_alpha:tween(0, .2)
	end
end
