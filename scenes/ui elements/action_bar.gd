extends PanelContainer

@export var slots: Array[Action_Slot]

var current:int = 1

func _ready():
	for i in range(0,slots.size()):
		slots[i].label.text = ".".format([i+1], ".")
	
	toggle_slot(1)

func toggle_slot(next:int):
	
	slots[current].toggle_selected(false)
	current = next - 1
	slots[current].toggle_selected(true)

func setup_slot(slot:int, inv_slot:InventorySlot):
	if inv_slot and inv_slot.item:
		slots[slot].set_texture(inv_slot.item.base.icon)
		slots[slot].set_slot_count(inv_slot.count)
	else:
		slots[slot].img.texture = slots[slot].empty
		slots[slot].set_slot_count(0)

func toggle_visible():
	visible = not visible
	
func update(inventory):
	for i in range(0,slots.size()):
		var i_slot = inventory.get_slot(i)
		slots[i].set_texture(i_slot.item.base.icon)
		slots[i].set_slot_count(i_slot.count)
