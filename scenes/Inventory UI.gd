extends Control

@onready var inventory_container = $"Inventory Slots"
@onready var action_container = $"Action Bar"

func _get_drag_data(at_position):
	var dragSlotNode = get_slot_node_at_position(at_position)
	
	if not dragSlotNode or dragSlotNode.texture == null: return
	
	var dragPreviewNode = dragSlotNode.duplicate()
	dragPreviewNode.custom_minimum_size = Vector2i(60,60)
	set_drag_preview(dragPreviewNode)
	
	return dragSlotNode

func _can_drop_data(at_position, _data):
	var targetSlotNode = get_slot_node_at_position(at_position)
	
	return targetSlotNode != null

func _drop_data(at_position, dragSlotNode):
	var targetSlotNode = get_slot_node_at_position(at_position)
	var targetTexture = targetSlotNode.texture
	
	targetSlotNode.texture = dragSlotNode.texture
	dragSlotNode.texture = targetTexture

func get_slot_node_at_position(at_position):
	var allSlotNodes = (inventory_container.get_children() + action_container.get_children())
	
	for node in allSlotNodes:
		var nodeRect = node.get_global_rect()
		
		if nodeRect.has_point(at_position): return node
		
func populate(inventory):
	var a_nodes = action_container.get_children()
	for i in range(0,a_nodes.size()):
		if inventory.get_item(i):
			a_nodes[i].texture = inventory.get_item(i).inventory_icon
	var i_nodes = inventory_container.get_children()
	for i in range(0,i_nodes.size()):
		if inventory.get_item(i + a_nodes.size()):
			i_nodes[i].texture = inventory.get_item(i + a_nodes.size()).inventory_icon

func toggle_visible():
	visible = not visible
