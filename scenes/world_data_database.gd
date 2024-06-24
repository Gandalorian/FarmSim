extends Node2D

var cache : Dictionary = {}

func _ready():
	for entry in testing_values:
		add_data(entry, ground_setup)
	for entry in testing_other:
		add_data(entry,{})
	
func add_data(pos:Vector2i,dict:Dictionary):
	if cache.find_key(pos):
		cache[pos].set_data(dict)
	else:
		cache[pos] = CustomTileData.new()
		cache[pos].set_data(dict)

func get_tile_data(pos:Vector2i) -> CustomTileData:
	if cache.has(pos):
		return cache[pos]
	else:
		add_data(pos,{})
		return cache[pos]

var testing_values: Array[Vector2i] = [
	Vector2i(2,1),
	Vector2i(2,2),
	Vector2i(2,3),
	Vector2i(3,-1),
	Vector2i(3,0),
	Vector2i(3,1),
	Vector2i(3,2),
	Vector2i(3,3),
	Vector2i(3,4),
	Vector2i(3,5),
	Vector2i(4,-3),
	Vector2i(4,-2),
	Vector2i(4,-1),
	Vector2i(4,0),
	Vector2i(4,1),
	Vector2i(4,2),
	Vector2i(4,3),
	Vector2i(4,4),
	Vector2i(4,5),
	Vector2i(5,-3),
	Vector2i(5,-2),
	Vector2i(5,-1),
	Vector2i(5,0),
	Vector2i(5,1),
	Vector2i(5,2),
	Vector2i(5,3),
	Vector2i(5,4),
	Vector2i(6,-3),
	Vector2i(6,-2),
	Vector2i(6,-1),
	Vector2i(6,0),
	Vector2i(6,1),
	Vector2i(6,2),
	Vector2i(6,3),
	Vector2i(6,4),
	Vector2i(6,5),
	Vector2i(7,-3),
	Vector2i(7,-2),
	Vector2i(7,-1),
	Vector2i(7,0),
	Vector2i(7,1),
	Vector2i(7,2),
	Vector2i(7,3),
	Vector2i(7,4),
	Vector2i(7,5),
	Vector2i(8,-3),
	Vector2i(8,-2),
	Vector2i(8,-1),
	Vector2i(8,0),
	Vector2i(8,1),
	Vector2i(8,2),
	Vector2i(8,3),
	Vector2i(8,4),
	Vector2i(8,5)]

var testing_other: Array[Vector2i] = [
	Vector2i(-1,0),
	Vector2i(0,0),
	Vector2i(1,0),
	Vector2i(-1,1),
	Vector2i(0,1),
	Vector2i(1,1),
	Vector2i(-1,2),
	Vector2i(0,2),
	Vector2i(1,2)
]

var ground_setup: Dictionary = {
		"can_be_tilled": true,
		"can_be_watered": true,
		"watered": false
}
