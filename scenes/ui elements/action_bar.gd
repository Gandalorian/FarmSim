extends PanelContainer

@export var slot1: Action_Slot
@export var slot2: Action_Slot
@export var slot3: Action_Slot
@export var slot4: Action_Slot
@export var slot5: Action_Slot
@export var slot6: Action_Slot
@export var slot7: Action_Slot
@export var slot8: Action_Slot
@export var slot9: Action_Slot

func _ready():
	slot1.label.text = "1"
	slot2.label.text = "2"
	slot3.label.text = "3"
	slot4.label.text = "4"
	slot5.label.text = "5"
	slot6.label.text = "6"
	slot7.label.text = "7"
	slot8.label.text = "8"
	slot9.label.text = "9"
	
	toggle_slot(1)

func toggle_slot(next:int):
	match next:
		1: 
			slot1.toggle_selected(true)
			slot2.toggle_selected(false)
			slot3.toggle_selected(false)
			slot4.toggle_selected(false)
			slot5.toggle_selected(false)
			slot6.toggle_selected(false)
			slot7.toggle_selected(false)
			slot8.toggle_selected(false)
			slot9.toggle_selected(false)
		2: 
			slot1.toggle_selected(false)
			slot2.toggle_selected(true)
			slot3.toggle_selected(false)
			slot4.toggle_selected(false)
			slot5.toggle_selected(false)
			slot6.toggle_selected(false)
			slot7.toggle_selected(false)
			slot8.toggle_selected(false)
			slot9.toggle_selected(false)
		3: 
			slot1.toggle_selected(false)
			slot2.toggle_selected(false)
			slot3.toggle_selected(true)
			slot4.toggle_selected(false)
			slot5.toggle_selected(false)
			slot6.toggle_selected(false)
			slot7.toggle_selected(false)
			slot8.toggle_selected(false)
			slot9.toggle_selected(false)
		4: 
			slot1.toggle_selected(false)
			slot2.toggle_selected(false)
			slot3.toggle_selected(false)
			slot4.toggle_selected(true)
			slot5.toggle_selected(false)
			slot6.toggle_selected(false)
			slot7.toggle_selected(false)
			slot8.toggle_selected(false)
			slot9.toggle_selected(false)
		5:
			slot1.toggle_selected(false)
			slot2.toggle_selected(false)
			slot3.toggle_selected(false)
			slot4.toggle_selected(false)
			slot5.toggle_selected(true)
			slot6.toggle_selected(false)
			slot7.toggle_selected(false)
			slot8.toggle_selected(false)
			slot9.toggle_selected(false)
		6:
			slot1.toggle_selected(false)
			slot2.toggle_selected(false)
			slot3.toggle_selected(false)
			slot4.toggle_selected(false)
			slot5.toggle_selected(false)
			slot6.toggle_selected(true)
			slot7.toggle_selected(false)
			slot8.toggle_selected(false)
			slot9.toggle_selected(false)
		7:
			slot1.toggle_selected(false)
			slot2.toggle_selected(false)
			slot3.toggle_selected(false)
			slot4.toggle_selected(false)
			slot5.toggle_selected(false)
			slot6.toggle_selected(false)
			slot7.toggle_selected(true)
			slot8.toggle_selected(false)
			slot9.toggle_selected(false)
		8:
			slot1.toggle_selected(false)
			slot2.toggle_selected(false)
			slot3.toggle_selected(false)
			slot4.toggle_selected(false)
			slot5.toggle_selected(false)
			slot6.toggle_selected(false)
			slot7.toggle_selected(false)
			slot8.toggle_selected(true)
			slot9.toggle_selected(false)
		9:
			slot1.toggle_selected(false)
			slot2.toggle_selected(false)
			slot3.toggle_selected(false)
			slot4.toggle_selected(false)
			slot5.toggle_selected(false)
			slot6.toggle_selected(false)
			slot7.toggle_selected(false)
			slot8.toggle_selected(false)
			slot9.toggle_selected(true)
			
func setup_slot(slot:int, item:Item):
	match slot:
		1: slot1.img.texture = item.inventory_icon
		2: slot2.img.texture = item.inventory_icon
		3: slot3.img.texture = item.inventory_icon
		4: slot4.img.texture = item.inventory_icon
		5: slot5.img.texture = item.inventory_icon
		6: slot6.img.texture = item.inventory_icon
		7: slot7.img.texture = item.inventory_icon
		8: slot8.img.texture = item.inventory_icon
		9: slot9.img.texture = item.inventory_icon

func toggle_visible():
	visible = not visible
