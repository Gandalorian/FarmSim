extends ItemInfo
class_name ConsumableInfo

@export var stat: PlayerStat
@export var amount: int
@export var time_limit: float

func use():
	if time_limit == 0:
		stat.value += amount
	else:
		stat.value += amount
		await get_local_scene().get_tree().create_timer(time_limit).timeout
		stat.value -= amount
