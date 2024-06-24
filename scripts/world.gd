extends Node2D

@onready var tile_map = $TileMap
@onready var day_night_progress = %"Day Bar"

var day_number: int = 1
var day_night_time: float = 0
var day_night_time_limit: float = Constants.DAY_TIME_LIMIT

func _ready():
	day_night_progress.max_value = day_night_time_limit

func _process(delta):
	handle_day_night_cycle(delta)

func _input(_event):
	pass

func handle_day_night_cycle(delta:float):
	day_night_time += delta
	day_night_progress.value = day_night_time
	if day_night_time >= day_night_time_limit:
		handle_new_day()

func handle_new_day():
	day_number += 1
	day_night_time = 0
	
	var tilled = Constants.ABOVE_GROUND_LAYER
	
	for tile_pos in tile_map.get_used_cells(tilled):
		var tiledata = WorldDataDatabase.get_tile_data(tile_pos)
		if tiledata.get_data("watered"):
			if tiledata.get_data("planted_object"):
				var days_planted = tiledata.get_data("days_planted")
				days_planted += 1
				tiledata.set_data({"days_planted": days_planted})
				if days_planted >= tiledata.get_data("planted_object").item_info.days_until_harvest:
					tiledata.set_data({"can_be_harvested": true})
			if tiledata.get_data("tilled"):
				tile_map.set_cell(tilled,tile_pos,0,Vector2i(0,1))
			else:
				erase_tile_map_cell(tilled, tile_pos)
			tiledata.set_data({"watered": false})
			
	if(randf_range(0,1) <= 0.2):
		rainy_day()

func rainy_day():
	for tile_pos in tile_map.get_used_cells(2):
		tile_map.set_cell(2,tile_pos,0,Vector2i(0,2))
		WorldDataDatabase.get_tile_data(tile_pos).set_data({"watered": true})

func erase_tile_map_cell(layer:int, coord:Vector2i):
	tile_map.erase_cell(layer, coord)
