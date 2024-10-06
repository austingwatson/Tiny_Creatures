extends Node2D

const rect_size = 4
const dish_color = Color(184.0 / 255.0, 204.0 / 255.0, 216.0 / 255.0)
const slug_color = Color(156.0 / 255.0, 139.0 / 255.0, 219.0 / 255.0)
const slime_color = Color(134.0 / 255.0, 198.0 / 255.0, 154.0 / 255.0)
const amoeba_color = Color(240.0 / 255.0, 97.0 / 255.0, 84.0 / 255.0)

var tiles = [[]]


func _draw():
	global_position = Vector2.ZERO
	global_position.x -= tiles.size() * 16 / 2
	global_position.y -= tiles[0].size() * 16 / 2
	
	for i in range(tiles.size()):
		for j in range(tiles[i].size()):
			if tiles[i][j] != 0:
				print(tiles[i][j])
			match tiles[i][j]:
				0:
					draw_rect(Rect2(i * rect_size, j * rect_size, rect_size, rect_size), dish_color)
				1:
					draw_rect(Rect2(i * rect_size, j * rect_size, rect_size, rect_size), slug_color)
				2:
					draw_rect(Rect2(i * rect_size, j * rect_size, rect_size, rect_size), slime_color)
				3:
					draw_rect(Rect2(i * rect_size, j * rect_size, rect_size, rect_size), amoeba_color)


func redraw():
	update()
