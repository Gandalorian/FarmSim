extends Node2D

@onready var tile_map = $TileMap
@onready var player = $Player

func _input(event):
	if Input.is_action_just_pressed("CLICK_LEFT"):
		var mouse_pos: Vector2 = get_global_mouse_position()
		
		var tile_mouse_pos: Vector2i = tile_map.local_to_map(mouse_pos)
		
		var tile_data: TileData = tile_map.get_cell_tile_data(1,tile_mouse_pos)
		
		if tile_data:
			if tile_data.get_custom_data("can_be_tilled"):
				tile_map.set_cell(2, tile_mouse_pos,0, Vector2i(0,1),)
	if Input.is_action_just_pressed("ACTION_SLOT_1"):
		player.current_item = player.inventory[0]
	else: if Input.is_action_just_pressed("ACTION_SLOT_2"):
		player.current_item = player.inventory[1]
	else: if Input.is_action_just_pressed("ACTION_SLOT_3"):
		player.current_item = player.inventory[2]
	else: if Input.is_action_just_pressed("ACTION_SLOT_4"):
		player.current_item = player.inventory[3]
