extends CharacterBody2D

@export var SPEED = 200.0
@export var world : Node2D

@onready var action_bar = $"Action Bar"

@onready var current_action : int = 1
var inventory : Inventory = Inventory.new()

func _ready():
	pass

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
