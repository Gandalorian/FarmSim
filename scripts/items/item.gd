class_name Item

var base: ItemBase

func _init(item:ItemBase):
	base = item

enum ItemType{
	HOE,
	WATER_CAN,
	SCYTHE,
	SEED,
	PLANT,
	AXE,
	PICKAXE,
	CONSUMABLE,
	FISHING_ROD,
	EMPTY
}
