class_name CustomTileData

var can_be_tilled: bool
var can_be_watered: bool
var can_be_planted: bool
var can_be_harvested: bool
var can_be_untilled: bool
var can_be_fished: bool
var can_be_axed: bool
var can_be_mined: bool

var watered: bool
var tilled: bool

var planted_object: ItemBase
var days_planted: int = 0
var grows_into: ItemBase
var grows_into_amount: int = 1

var season: String

func set_data(dict:Dictionary):
	for key in dict:
		match key:
			"can_be_tilled": can_be_tilled = dict[key]
			"can_be_watered": can_be_watered = dict[key]
			"can_be_planted": can_be_planted = dict[key]
			"can_be_harvested": can_be_harvested = dict[key]
			"can_be_untilled": can_be_untilled = dict[key]
			"can_be_fished": can_be_fished = dict[key]
			"can_be_axed": can_be_axed = dict[key]
			"can_be_mined": can_be_mined = dict[key]
			"watered": watered = dict[key]
			"tilled": tilled = dict[key]
			"planted_object": planted_object = dict[key]
			"days_planted": days_planted = dict[key]
			"grows_into": grows_into = dict[key]
			"grows_into_amount": grows_into_amount = dict[key]

func get_data(arg:String):
	match arg:
		"can_be_tilled": return can_be_tilled
		"can_be_watered": return can_be_watered
		"can_be_planted": return can_be_planted
		"can_be_harvested": return can_be_harvested
		"can_be_untilled": return can_be_untilled
		"can_be_fished": return can_be_fished
		"can_be_axed": return can_be_axed
		"can_be_mined": return can_be_mined
		"watered": return watered
		"tilled": return tilled
		"planted_object": return planted_object
		"days_planted": return days_planted
		"grows_into": return grows_into
		"grows_into_amount": return grows_into_amount
	
