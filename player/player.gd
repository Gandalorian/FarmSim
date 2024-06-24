extends CharacterBody2D

enum State{GAME,INVENTORY}

@export var SPEED = 200.0

@onready var action_bar = %"Action Bar"
@onready var ui = %"UI Canvas Layer"

var current_action : int = 1
var current_tool: Item
var inventory : Inventory

var mouse_pos: Vector2
var local_mouse_pos: Vector2i

var state: State = State.GAME

signal request_local_mouse_pos(m_pos)
signal attempt_till(l_m_pos)
signal attempt_untill(l_m_pos)
signal attempt_plant(l_m_pos)
signal attempt_water(l_m_pos)
signal attempt_harvest(l_m_pos)

func _ready():
	inventory = Constants.starter_items()
	current_tool = inventory.get_item(0)
	ui.request_inventory_swap.connect(inventory.swap_positions)
	inventory.inventory_changed.connect(update_ui)
	
	for slot in inventory.get_slots():
		print(slot.item.base.name)

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	handle_mouse_pos()
	handle_movement_input()
	if state != State.INVENTORY:
		handle_left_click()
		handle_right_click()
		handle_action_slots()
	
	if Input.is_action_just_pressed("INVENTORY"):
		if ui.toggle_inventory(): state = State.INVENTORY
		else: state = State.GAME

	move_and_slide()

func update_ui():
	ui.update(inventory)
	
func swap_action(index:int):
	action_bar.toggle_slot(index)
	current_action = index
	var new_tool = inventory.get_item(index - 1)
	if new_tool:
		current_tool = new_tool
	else:
		current_tool = null

func add_to_inventory(item:ItemBase, count:int):
	inventory.add_item(item, count)
	
func handle_movement_input():
	var xDirection = Input.get_axis("LEFT", "RIGHT")
	if xDirection:
		velocity.x = xDirection * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var YDirection = Input.get_axis("UP", "DOWN")
	if YDirection:
		velocity.y = YDirection * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

func handle_mouse_pos():
	mouse_pos = get_global_mouse_position()
	mouse_pos.x = clamp(mouse_pos.x, global_position.x - 100, global_position.x + 100)
	mouse_pos.y = clamp(mouse_pos.y, global_position.y - 100, global_position.y + 100)
	
	request_local_mouse_pos.emit(mouse_pos)
	
	#if debug:
		#var td = WorldDataDatabase.get_tile_data(local_mouse_pos)
		#debug_info_box.update_info(local_mouse_pos,td,inventory_ui.get_slot_node_at_position(mouse_pos))

func handle_left_click():
	if Input.is_action_pressed("CLICK_LEFT"):
		var tiledata = WorldDataDatabase.get_tile_data(local_mouse_pos)
		
		if !current_tool:
			return
		
		match current_tool.base.type:
				Item.ItemType.HOE:
					if tiledata.get_data("can_be_tilled"):
						attempt_till.emit(local_mouse_pos)
						#tile_map.set_cell(Constants.ABOVE_GROUND_LAYER, local_mouse_pos,0, Vector2i(0,1))
						tiledata.set_data({
							"can_be_tilled": false, 
							"tilled": true, 
							"can_be_untilled": true,
							"can_be_planted": true
							})
				Item.ItemType.SEED:
					if tiledata.get_data("can_be_planted"):
						attempt_plant.emit(local_mouse_pos)
						#tile_map.set_cell(Constants.PLANT_LAYER, local_mouse_pos,0, Vector2i(1,1))
						tiledata.set_data({
							"can_be_planted": false,
							"planted_object": current_tool.base,
							"grows_into": current_tool.base.item_info.grows_into,
							"grows_into_amount": current_tool.base.item_info.grows_into_amount,
							"days_planted": 0
						})
						inventory.remove_item(current_tool.base)
				Item.ItemType.WATER_CAN:
					if tiledata.get_data("can_be_watered"):
						tiledata.set_data({"watered": true})
						attempt_water.emit(local_mouse_pos)
						#if tiledata.get_data("tilled"):
						#	tile_map.set_cell(Constants.ABOVE_GROUND_LAYER, local_mouse_pos,0, Vector2i(0,2))
						#else:
						#	tile_map.set_cell(Constants.ABOVE_GROUND_LAYER, local_mouse_pos,0, Vector2i(12,0))
				Item.ItemType.SCYTHE:
					if tiledata.get_data("can_be_harvested"):
						attempt_harvest.emit(local_mouse_pos)
						add_to_inventory(tiledata.get_data("grows_into"), tiledata.get_data("grows_into_amount"))
						tiledata.set_data({
							"planted_object": null,
							"days_planted": 0,
							"grows_into": null,
							"can_be_planted": true
							})
						#tile_map.erase_cell(Constants.PLANT_LAYER, local_mouse_pos)
				Item.ItemType.CONSUMABLE:
					current_tool.base.item_info.use()
					inventory.remove_item(current_tool.base)

func handle_right_click():
	if Input.is_action_pressed("CLICK_RIGHT"):
		var tiledata: CustomTileData = WorldDataDatabase.get_tile_data(local_mouse_pos)
		
		if !current_tool:
			return
		match current_tool.base.type:
			Item.ItemType.HOE:
				if tiledata.get_data("can_be_untilled"):
					attempt_untill.emit(local_mouse_pos)
					if tiledata.get_data("planted_object"):
						add_to_inventory(tiledata.get_data("planted_object"), tiledata.get_data("grows_into_amount"))
						#erase_tile_map_cell(Constants.PLANT_LAYER, local_mouse_pos)
					#erase_tile_map_cell(Constants.ABOVE_GROUND_LAYER, local_mouse_pos)


func handle_action_slots():
	if Input.is_action_just_pressed("ACTION_SLOT_1"):
		swap_action(1)
	elif Input.is_action_just_pressed("ACTION_SLOT_2"):
		swap_action(2)
	elif Input.is_action_just_pressed("ACTION_SLOT_3"):
		swap_action(3)
	elif Input.is_action_just_pressed("ACTION_SLOT_4"):
		swap_action(4)
	elif Input.is_action_just_pressed("ACTION_SLOT_5"):
		swap_action(5)
	elif Input.is_action_just_pressed("ACTION_SLOT_6"):
		swap_action(6)
	elif Input.is_action_just_pressed("ACTION_SLOT_7"):
		swap_action(7)
	elif Input.is_action_just_pressed("ACTION_SLOT_8"):
		swap_action(8)
	elif Input.is_action_just_pressed("ACTION_SLOT_9"):
		swap_action(9)
	
	if Input.is_action_just_released("ACTION_SLOT_PREV"):
		current_action -= 1
		if current_action <= 0:
			current_action += 9
		action_bar.toggle_slot(current_action)
	else: if Input.is_action_just_released("ACTION_SLOT_NEXT"):
		current_action += 1
		if current_action >= 10:
			current_action -= 9
		action_bar.toggle_slot(current_action)

func set_local_mouse_pos(lm,isp):
	local_mouse_pos = lm
	ui.update_square(isp)
	
