extends Control

@export var inventory_slots: Array[InventoryUISlot]
@export var action_bar_slots: Array[InventoryUISlot]

var inventory

signal request_inventory_swap(index1, index2)

func _get_drag_data(at_position):
	#print("Start of drag")
	var dragSlotNode = get_slot_node_at_position(at_position)
	#print("at_position: " + str(at_position))
	if not dragSlotNode: return
	#print("dragnode.position(" + str(dragSlotNode.inventory_index) + "): " + str(dragSlotNode.position))
	
	var dragPreviewNode: TextureRect = dragSlotNode.img.duplicate()
	dragPreviewNode.custom_minimum_size = Vector2i(32,32)
	
	var c = Control.new()
	c.add_child(dragPreviewNode)
	dragPreviewNode.position = -0.5  * (get_global_mouse_position() - global_position)
	set_drag_preview(c)
	
	return dragSlotNode

func _can_drop_data(at_position, _data):
	#print("Check for drop")
	var targetSlotNode = get_slot_node_at_position(at_position)
	
	return targetSlotNode != null 

func _drop_data(at_position, dragSlotNode):
	#print("End of drag")
	var targetSlotNode = get_slot_node_at_position(at_position)
	var targetTexture = targetSlotNode.img.texture
	
	targetSlotNode.img.texture = dragSlotNode.texture
	dragSlotNode.img.texture = targetTexture
	
	request_inventory_swap.emit(targetSlotNode.inventory_index, dragSlotNode.inventory_index)

func get_slot_node_at_position(at_position) -> InventoryUISlot:
	var allSlotNodes = (inventory_slots + action_bar_slots)
	
	at_position = global_position + at_position
	
	for node in allSlotNodes:
		if node.has_point(at_position):
			return node
	return null
		
func populate():
	var allSlots = action_bar_slots + inventory_slots
	for i in range(0,allSlots.size()):
		var i_slot = inventory.get_slot(i)
		allSlots[i].setup_slot(i_slot.item.base.icon)
		# implement item counts

func update(_inventory):
	inventory = _inventory
	populate()

func toggle_visible():
	visible = not visible

func toggle_red(debug:bool):
	var allSlots = action_bar_slots + inventory_slots
	for slot in allSlots:
		slot.red_border.visible = debug
