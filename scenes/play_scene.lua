Play_scene = Scene:extend('Play_scene')

local clouds          = lg.newImage("assets/images/clouds.png")
local mountains       = lg.newImage("assets/images/mountains.png")
local forest          = lg.newImage("assets/images/forest.png")
local back_grass      = lg.newImage("assets/images/back_grass.png")
local back_grass_tree = lg.newImage("assets/images/back_grass_tree.png")
local front_grass     = lg.newImage("assets/images/front_grass.png")

function Play_scene:new()
	Play_scene.super.new(@)

	@:add('rect', Rectangle(0, 0, 100, 100, {mode = 'fill', color = {.8, .3, .3}}))
	@.camera:set_position(400, 300)
end

function Play_scene:update(dt)
	Play_scene.super.update(@, dt)
	if pressed('escape') then game:change_scene_with_transition('menu') end


	local rect = @:get('rect')

	if down('z') then rect.pos.y -= 3 end
	if down('s') then rect.pos.y += 3 end
	if down('q') then rect.pos.x -= 3 end
	if down('d') then rect.pos.x += 3 end
end


function Play_scene:draw_inside_camera_bg()
	lg.draw(clouds         , @.camera.x    ,-10, _, 2)
	lg.draw(mountains      , @.camera.x*0.5,  0, _, 2)
	lg.draw(forest         , @.camera.x*0.4,  0, _, 2)
	lg.draw(back_grass_tree, @.camera.x*0.2,  0, _, 2)
end

function Play_scene:draw_inside_camera_fg()

	lg.draw(front_grass    , 0,  0, _, 2)
end



