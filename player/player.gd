extends CharacterBody2D

@export var SPEED = 200.0
@export var interact_square : Sprite2D
@export var world : Node2D

var current_item : Item
var inventory : Inventory = Inventory.new()

func _ready():
	pass

func _physics_process(delta):
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
	
	var mouse_pos = get_global_mouse_position()
	var local_mouse_pos = world.tile_map.local_to_map(mouse_pos)
	interact_square.position = local_mouse_pos
