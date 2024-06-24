extends PanelContainer

@onready var tile_pos:Label = $"VBoxContainer/Tile Map Position"
@onready var can_be_tilled:Label = $"VBoxContainer/can_be_tilled"
@onready var can_be_untilled:Label = $"VBoxContainer/can_be_untilled"
@onready var can_be_watered:Label = $"VBoxContainer/can_be_watered"
@onready var watered:Label = $"VBoxContainer/watered"
@onready var can_be_planted:Label = $"VBoxContainer//can_be_planted"
@onready var planted_object:Label = $"VBoxContainer/planted_object"
@onready var days_planted:Label = $"VBoxContainer/days_planted"
@onready var inventory_slot:Label = $VBoxContainer/inventory_slot

func update_info(pos:Vector2i, td:CustomTileData,slot:InventoryUISlot):
	if td:
		tile_pos.text = "Position: {},{}".format([pos.x,pos.y], "{}")
		can_be_tilled.text = "can_be_tilled: {}".format([td.get_data("can_be_tilled")], "{}")
		can_be_untilled.text = "can_be_untilled: {}".format([td.get_data("can_be_untilled")], "{}")
		can_be_watered.text = "can_be_watered: {}".format([td.get_data("can_be_watered")], "{}")
		watered.text = "watered: {}".format([td.get_data("watered")], "{}")
		can_be_planted.text = "can_be_planted: {}".format([td.get_data("can_be_planted")], "{}")
		var obj = td.get_data("planted_object")
		if obj: planted_object.text = "planted_object: {}".format([obj.name], "{}")
		else: planted_object.text = "planted_object: N/A"
		days_planted.text = "days_planted: {}".format([td.get_data("days_planted")], "{}")
	if slot:
		inventory_slot.text = "Inventory slot index: " + str(slot.inventory_index)
	else:
		inventory_slot.text = "Inventory slot index: N/A"
