extends Node2D

@onready var tile_map = $TileMap
@onready var player = $Player
@onready var interact_square = $"UI/Interact Square"

var day_number: int = 1
var day_night_time: float = 0
var day_night_time_limit: float = Constants.DAY_TIME_LIMIT

var mouse_pos: Vector2
var local_mouse_pos: Vector2i

func _process(delta):
	handle_mouse_pos()
	handle_day_night_cycle(delta)
	

func _input(_event):
	if Input.is_action_pressed("CLICK_LEFT"):
		var tile_data_0: TileData = tile_map.get_cell_tile_data(Constants.WATER_LAYER,local_mouse_pos)
		var tile_data_1: TileData = tile_map.get_cell_tile_data(Constants.GROUND_LAYER,local_mouse_pos)
		var tile_data_2: TileData = tile_map.get_cell_tile_data(Constants.ABOVE_GROUND_LAYER,local_mouse_pos)
		var tile_data_3: TileData = tile_map.get_cell_tile_data(Constants.PLANT_LAYER,local_mouse_pos)
		
		match player.current_tool.type:
				Item.Item_Type.HOE:
					if tile_data_3 and tile_data_3.get_custom_data("days_planted") >= tile_data_3.get_custom_data("planted_object").days_until_harvest:
						tile_map.erase_cell(3, local_mouse_pos)
						tile_data_3.set_custom_data("days_planted",0)
					if tile_data_1 and tile_data_1.get_custom_data("can_be_tilled") and not tile_data_2:
						tile_map.set_cell(Constants.ABOVE_GROUND_LAYER, local_mouse_pos,0, Vector2i(0,1))
				Item.Item_Type.SEED:
					if tile_data_2 and tile_data_2.get_custom_data("can_be_planted") and not tile_data_3:
						tile_map.set_cell(Constants.PLANT_LAYER, local_mouse_pos,0, Vector2i(1,1))
						var tile = tile_map.get_cell_tile_data(Constants.PLANT_LAYER,local_mouse_pos)
						tile.set_custom_data("planted_object", player.current_tool)
						tile.set_custom_data("days_planted", 0)
				Item.Item_Type.WATER_CAN:
					if tile_data_2 and tile_data_2.get_custom_data("can_be_watered"):
						tile_map.set_cell(Constants.ABOVE_GROUND_LAYER, local_mouse_pos,0, Vector2i(0,2))

	if Input.is_action_pressed("CLICK_RIGHT"):
		var tile_data: TileData = tile_map.get_cell_tile_data(Constants.ABOVE_GROUND_LAYER,local_mouse_pos)
		
		if tile_data:
			if player.current_action == 1:
				if tile_data.get_custom_data("can_be_untilled"):
					tile_map.erase_cell(Constants.ABOVE_GROUND_LAYER, local_mouse_pos)
					tile_map.erase_cell(Constants.PLANT_LAYER, local_mouse_pos)
	
	handle_action_slots()
		
func handle_mouse_pos():
	mouse_pos = get_global_mouse_position()
	mouse_pos.x = clamp(mouse_pos.x, player.global_position.x - 100, player.global_position.x + 100)
	mouse_pos.y = clamp(mouse_pos.y, player.global_position.y - 100, player.global_position.y + 100)
	local_mouse_pos = tile_map.local_to_map(mouse_pos)
	interact_square.position = tile_map.map_to_local(local_mouse_pos)
	
func handle_action_slots():
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
	
func handle_day_night_cycle(delta:float):
	day_night_time += delta
	if day_night_time >= day_night_time_limit:
		handle_new_day()

func handle_new_day():
	day_number += 1
	day_night_time = 0
	
	for tile_pos in tile_map.get_used_cells(2):
		if tile_map.get_cell_tile_data(2,tile_pos) and tile_map.get_cell_tile_data(2,tile_pos).get_custom_data("watered"):
			tile_map.set_cell(2,tile_pos,0,Vector2i(0,1))
			if tile_map.get_cell_tile_data(3,tile_pos):
				var days_planted = tile_map.get_cell_tile_data(3,tile_pos).get_custom_data("days_planted")
				days_planted += 1
				#if days_planted >= tile_map.get_cell_tile_data(3,tile_pos).get_custom_data("planted_object").days_until_harvest:
				#	tile_map.erase_cell(3,tile_pos)
				tile_map.get_cell_tile_data(3,tile_pos).set_custom_data("days_planted", days_planted)
	if(randf_range(0,1) <= 0.2):
		rainy_day()

func rainy_day():
	for tile_pos in tile_map.get_used_cells(2):
		tile_map.set_cell(2,tile_pos,0,Vector2i(0,2))
