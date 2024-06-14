extends CharacterBody2D

@export var SPEED = 200.0
@export var world : Node2D
@export var start_items: Array[Item]

@onready var action_bar = %"Action Bar"

var current_action : int = 1
var current_tool: Item
var inventory : Inventory = Inventory.new()

func _ready():
	for item in start_items:
		inventory.add_item(item)
	update_actionbar()
	current_tool = inventory.get_item(0)

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
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

	move_and_slide()

func update_actionbar():
	print("update")
	for i in range(inventory.get_items().size()):
		action_bar.setup_slot(i+1,inventory.get_item(i))
	current_tool = inventory.get_item(current_action)
	
func swap_action(index:int):
	action_bar.toggle_slot(index)
	current_action = index
	var new_tool = inventory.get_item(index - 1)
	if new_tool:
		current_tool = new_tool
	else:
		current_tool = null
