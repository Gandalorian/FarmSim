class_name Action_Slot
extends PanelContainer

@export var item:Item

@onready var label: Label = $Image/Label

func _ready():
	if item:
		$Image.texture = item.inventory_icon
	else:
		$Image.texture = %"res://gfx/empty.svg"

func toggle_selected(selected:bool):
	$Selected.visible = selected
