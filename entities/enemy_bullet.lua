Enemy_Bullet = Entity:extend('Enemy_Bullet')

Enemy_Bullet.beams = lg.newImage('assets/images/beams.png')
Enemy_Bullet.blue_beam_quad = lg.newQuad(30, 120, 120, 80, Enemy_Bullet.beams:getWidth(), Enemy_Bullet.beams:getHeight())

function Enemy_Bullet:new(x, y)
	Enemy_Bullet.super.new(@, {x = x, y = y} )

	@:after(5, fn() self:kill() end)
end

function Enemy_Bullet:update(dt)
	Enemy_Bullet.super.update(@, dt)

	@.pos.x -= 500 * dt
end

function Enemy_Bullet:draw()
	lg.draw(@.beams, @.blue_beam_quad, @.pos.x, @.pos.y, _, 1, 1)
end

function Enemy_Bullet:aabb()
	return {
		@.pos.x + 40,
		@.pos.y + 30,
		45,
		20,
	}
end
