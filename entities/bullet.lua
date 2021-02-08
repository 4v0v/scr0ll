Bullet = Entity:extend('Bullet')

Bullet.beams = lg.newImage('assets/images/beams.png')
Bullet.red_beam_quad = lg.newQuad(30, 200, 120, 80, Bullet.beams:getWidth(), Bullet.beams:getHeight())

function Bullet:new(x, y)
	Bullet.super.new(@, {x = x, y = y} )

	@.damage = 10
	@:after(5, fn() self:kill() end)
end

function Bullet:update(dt)
	Bullet.super.update(@, dt)

	@.pos.x += 800 * dt
end

function Bullet:draw()
	lg.draw(@.beams, @.red_beam_quad, @.pos.x, @.pos.y, _, 1, 1)
end

function Bullet:aabb()
	return {
		@.pos.x + 40,
		@.pos.y + 23,
		45,
		20,
	}
end
