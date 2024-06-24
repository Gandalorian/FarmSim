extends Sprite2D
class_name AbstractItem

var item: ItemBase = null:
	set(value):
		item = value
		
		if value != null:
			texture = value.icon

func _ready():
	item = ItemDatabase.get_item("hoe")
