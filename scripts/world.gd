extends Node2D

@onready var tile_map = $TileMap
@onready var player = $Player
@onready var interact_square = $"Interact Square"

var mouse_pos: Vector2
var local_mouse_pos: Vector2i

func _process(_delta):
	mouse_pos = get_global_mouse_position()
	mouse_pos.x = clamp(mouse_pos.x, player.global_position.x - 100, player.global_position.x + 100)
	mouse_pos.y = clamp(mouse_pos.y, player.global_position.y - 100, player.global_position.y + 100)
	local_mouse_pos = tile_map.local_to_map(mouse_pos)
	mouse_pos = tile_map.map_to_local(local_mouse_pos)
	interact_square.position = mouse_pos

func _input(_event):
	if Input.is_action_pressed("CLICK_LEFT"):		
		var tile_data_0: TileData = tile_map.get_cell_tile_data(0,local_mouse_pos)
		var tile_data_1: TileData = tile_map.get_cell_tile_data(1,local_mouse_pos)
		var tile_data_2: TileData = tile_map.get_cell_tile_data(2,local_mouse_pos)
		var tile_data_3: TileData = tile_map.get_cell_tile_data(3,local_mouse_pos)
		
		if tile_data_1:
			match player.current_tool:
				"Hoe": 
					if tile_data_1.get_custom_data("can_be_tilled") and not tile_data_2:
						tile_map.set_cell(2, local_mouse_pos,0, Vector2i(0,1))
				"Seeds":
					if tile_data_2 and tile_data_2.get_custom_data("can_be_planted") and not tile_data_3:
						tile_map.set_cell(3, local_mouse_pos,0, Vector2i(1,1))

	if Input.is_action_pressed("CLICK_RIGHT"):
		var tile_data: TileData = tile_map.get_cell_tile_data(2,local_mouse_pos)
		
		if tile_data:
			if player.current_action == 1:
				if tile_data.get_custom_data("can_be_untilled"):
					tile_map.erase_cell(2, local_mouse_pos)
					
	
	if Input.is_action_just_pressed("ACTION_SLOT_1"):
		player.swap_action(1)
	else: if Input.is_action_just_pressed("ACTION_SLOT_2"):
		player.swap_action(2)
	else: if Input.is_action_just_pressed("ACTION_SLOT_3"):
		player.swap_action(3)
	else: if Input.is_action_just_pressed("ACTION_SLOT_4"):
		player.swap_action(4)
	else: if Input.is_action_just_pressed("ACTION_SLOT_5"):
		player.swap_action(5)
	else: if Input.is_action_just_pressed("ACTION_SLOT_6"):
		player.swap_action(6)
	else: if Input.is_action_just_pressed("ACTION_SLOT_7"):
		player.swap_action(7)
	else: if Input.is_action_just_pressed("ACTION_SLOT_8"):
		player.swap_action(8)
	else: if Input.is_action_just_pressed("ACTION_SLOT_9"):
		player.swap_action(9)
	
	if Input.is_action_just_released("ACTION_SLOT_PREV"):
		player.current_action -= 1
		if player.current_action <= 0:
			player.current_action += 9
		player.action_bar.toggle_slot(player.current_action)
	else: if Input.is_action_just_released("ACTION_SLOT_NEXT"):
		player.current_action += 1
		if player.current_action >= 10:
			player.current_action -= 9
		player.action_bar.toggle_slot(player.current_action)
