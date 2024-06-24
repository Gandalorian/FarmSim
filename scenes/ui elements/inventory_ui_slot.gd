extends Control
class_name InventoryUISlot

@export var img: TextureRect
@export var inventory_index: int

@onready var red_border = $"TextureRect"

func setup_slot(texture:Texture2D):
	img.texture = texture

func has_point(at_position):
	if at_position.x < global_position.x or at_position.x > global_position.x + img.size.x: return false
	if at_position.y < global_position.y or at_position.y > global_position.y + img.size.y: return false
	return true
