Bird = Entity:extend('Bird')

Bird.fly_frames = AnimationFrames('assets/images/bird.png', 207, 206, _, _, '1-1, 2-1, 3-1, 4-1, 5-1, 6-1, 7-1, 8-1, 9-1')


function Bird:new(x, y )
	Bird.super.new(@, {x = x, y = y} )

	@.bird_anim = Animation(.1, Bird.fly_frames)

end

function Bird:update(dt)
	Bird.super.update(@, dt)

	@.bird_anim:update(dt)

end

function Bird:draw()
	@.bird_anim:draw(self.pos.x, self.pos.y)
end
