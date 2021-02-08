local function lerp(a, b, x, dt) 
	return a + (b - a) * (1.0 - math.exp(-x * dt)) 
end

local function random(x) 
	return love.math.noise(love.math.random()) - 0.5 
end

Camera = Class:extend('Camera')

function Camera:new(x, y, w, h)
	@.x = x or 0
	@.y = y or 0
	@.w = w or lg.getWidth()
	@.h = h or lg.getHeight()

	@.lerpness = 10
	@.zoomness = 10
	
	@.target_x = 0
	@.target_y = 0
	@.target_s = 1
	@.camera_x = 0
	@.camera_y = 0
	@.camera_s = 1

	@.shake_timer = 0
	@.shake_tick  = 1/60

	@.shk = {s = 0, xrs = 0, yrs = 0}
end

function Camera:update(dt)
	@.camera_x = lerp(@.camera_x, @.target_x, @.lerpness, dt)
	@.camera_y = lerp(@.camera_y, @.target_y, @.lerpness, dt)
	@.camera_s = lerp(@.camera_s, @.target_s, @.zoomness, dt)

	@.shake_timer = @.shake_timer + dt

	if @.shake_timer > @.shake_tick then 
		if @.shk.s ~= 0 then 
			@.shk.xrs, @.shk.yrs = random()*@.shk.s, random()*@.shk.s 
		else 
			@.shk.xrs, @.shk.yrs = 0, 0
		end
		@.shake_timer = @.shake_timer - @.shake_tick
	end

	if math.abs(@.shk.s) > 5 then 
		@.shk.s = lerp(@.shk.s, 0, 5, dt) 
	else 
		if @.shk.s ~= 0 then 
			@.shk.s = 0 
		end 
	end
end

function Camera:draw(func)
	lg.push()
	lg.translate(@.x + @.w/2, @.y + @.h/2)
	lg.scale(@.camera_s)
	lg.translate(-@.camera_x + @.shk.xrs, -@.camera_y + @.shk.yrs)
	func()
	lg.pop()
end

function Camera:follow(x, y)
	@.target_x = x or @.target_x
	@.target_y = y or @.target_y
end

function Camera:zoom(s) 
	@.target_s = s 
end

function Camera:shake(s) 
	@.shk.s = s or 0
end

function Camera:get_position() 
	return @.camera_x, @.camera_y, @.target_x, @.target_y 
end

function Camera:get_zoom() 
	return @.camera_s, @.target_s 
end

function Camera:set_lerpness(sv) 
	@.lerpness = sv 
end

function Camera:set_zoomness(sv) 
	@.zoomness = ssv 
end

function Camera:set_zoom(s) 
	@.camera_s, @.target_s = s, s 
end

function Camera:set_position(x, y) 
	@.camera_x, @.target_x = x or @.camera_x, x or @.target_x
	@.camera_y, @.target_y = y or @.camera_y, y or @.target_y
end

function Camera:cam_to_screen(x, y)
	x, y = x - @.camera_x, y - @.camera_y
	x, y = x * @.camera_s, y * @.camera_s
	x, y = x + @.w / 2 + @.x, y + @.h / 2 + @.y
	return x, y
end

function Camera:screen_to_cam(x, y)
	x, y = x - @.w / 2 - @.x, y - @.h / 2 - @.y
	x, y = x / @.camera_s, y / @.camera_s
	x, y = x + @.camera_x, y + @.camera_y
	return x, y
end

function Camera:get_mouse_position() return
	@:screen_to_cam(love.mouse.getPosition()) 
end
