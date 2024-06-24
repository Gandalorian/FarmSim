class_name InventorySlot

var item:Item
var count:int

func _init(_item:ItemBase, _count:int = 1):
	item = Item.new(_item)
	count = _count
	
static func empty() -> InventorySlot:
	return InventorySlot.new(load("res://data/items/empty.tres"),0)

func set_slot(_item:ItemBase, _count:int = 1):
	item = Item.new(_item)
	count = _count
