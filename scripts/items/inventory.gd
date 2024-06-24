class_name Inventory

var content : Array[InventorySlot]

signal inventory_changed

func _init():
	for i in 36:
		content.append(InventorySlot.empty())

func add_item(item:ItemBase, count:int = 1):
	#print("Adding {} {} to inventory.".format([count, item.name],"{}"))
	if !item or count < 1:
		return
	for slot in content:
		if slot.item.base == item and slot.count + count <= slot.item.base.max_count:
			slot.count += count
			inventory_changed.emit()
			#print("You now have {} {} in inventory.".format([get_item_count(item), item.name], "{}"))
			return
		else: if slot.item.base == item and not slot.count == slot.item.base.max_count:
			count = slot.item.base.max_count - slot.count
			slot.count = slot.item.base.max_count
	
	for slot in content:
		if slot.item.base.type == Item.ItemType.EMPTY:
			slot.set_slot(item,count)
			inventory_changed.emit()
			return
	#print("You now have {} {} in inventory.".format([get_item_count(item), item.name], "{}"))
	
	
func add_empty():
	content.append(InventorySlot.new(null,0))

func remove_item(item:ItemBase, amount:int = 1) -> bool:
	#print("Removing {} {} from inventory.".format([amount, item.name],"{}"))
	for slot in content:
		if slot.item.base == item:
			slot.count -= amount
			#print("You now have {} {} in inventory.".format([get_item_count(item), item.name], "{}"))
			if slot.count == 0:
				slot = InventorySlot.empty()
			inventory_changed.emit()
			return true
	return false

func get_item(index:int):
	if index < content.size():
		return content[index].item
	return null
	
func get_item_count(item:ItemBase) -> int:
	var count = 0
	for slot in content:
		if slot.item:
			if slot.item.base == item:
				count += slot.count
	return count
	
func get_slot(index:int):
	if index < content.size():
		return content[index]
	return null
	
func get_slots():
	return content
	
func size():
	return content.size()

func swap_positions(first:int, second:int):
	var temp = content[first]
	content[first] = content[second]
	content[second] = temp
