Bullet = Entity:extend('Bullet')

local beams = lg.newImage('assets/images/beams.png')
local red_beam_quad = lg.newQuad(30, 200, 120, 80, beams:getWidth(), beams:getHeight())

function Bullet:new(x, y)
	Bullet.super.new(@, {x = x, y = y} )

	@:after(5, fn() self:kill() end)
end

function Bullet:update(dt)
	Bullet.super.update(@, dt)

	@.pos.x += 800 * dt
end

function Bullet:draw()
	lg.draw(beams, red_beam_quad, @.pos.x, @.pos.y, _, 1, 1)
end

function Bullet:aabb()
	return {
		@.pos.x,
		@.pos.y,
		120,
		80,
	}
end
