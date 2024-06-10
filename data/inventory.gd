class_name Inventory

var _content:Array[Item] = []

func add_item(Item):
	_content.append(Item)

func remove_item(Item):
	_content.erase(Item)

func get_items() -> Array[Item]:
	return _content
