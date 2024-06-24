extends CanvasLayer

@onready var action_bar = %"Action Bar"
@onready var inventory_ui = %"Inventory UI"
@onready var interact_square = %"Interact Square"
@onready var debug_info_box = %"DebugInfo"

var debug: bool = false

signal request_inventory_swap(index_1,index_2)

func _ready():
	inventory_ui.request_inventory_swap.connect(_on_request_inventory_swap)

func _physics_process(_delta):
	handle_toggle_debug()

func _on_request_inventory_swap(index1, index2):
	request_inventory_swap.emit(index1,index2)

func update(inventory):
	inventory_ui.update(inventory)
	action_bar.update(inventory)

func update_square(pos):
	interact_square.global_position = pos

func toggle_inventory() -> bool:
	inventory_ui.visible = not inventory_ui.visible
	action_bar.visible = not action_bar.visible
	interact_square.visible = not interact_square.visible
	
	return inventory_ui.visible

func handle_toggle_debug():
	if Input.is_action_just_pressed("DEBUG"):
		debug = not debug
		debug_info_box.visible = not debug_info_box.visible
		#inventory_ui.toggle_red(debug)
