class_name Constants

#Game constants
const DAY_TIME_LIMIT: float = 5

#TileMap Layers
const WATER_LAYER: int = 0
const GROUND_LAYER: int = 1
const ABOVE_GROUND_LAYER:int = 2
const PLANT_LAYER:int = 3
const INTERACT_LAYER:int = 4

static func starter_items() -> Inventory:
	var inventory = Inventory.new()
	var hoe = Item.new(load("res://data/items/hoe.tres"))
	var water_can = Item.new(load("res://data/items/watercan.tres"))
	var scythe = Item.new(load("res://data/items/scythe.tres"))
	var axe = Item.new(load("res://data/items/axe.tres"))
	var pickaxe = Item.new(load("res://data/items/pickaxe.tres"))
	var wheat_seeds = Item.new(load("res://data/items/wheat_seed.tres"))
	inventory.add_item(hoe.base)
	inventory.add_item(water_can.base)
	inventory.add_item(scythe.base)
	inventory.add_item(axe.base)
	inventory.add_item(pickaxe.base)
	inventory.add_item(wheat_seeds.base, 99)
	return inventory
