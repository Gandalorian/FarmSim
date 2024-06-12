class_name Item
extends Resource

@export var name:String
@export var world_item:PackedScene
@export var inventory_icon:Texture2D
@export var type:Item_Type

enum Item_Type{
	HOE,
	WATER_CAN,
	AXE,
	PICKAXE,
	SEED
}
