class_name Action_Slot
extends PanelContainer

@export var item:Item
@export var empty: Texture2D

@onready var label: Label = $Image/Label
@onready var img = $Image

func _ready():
	if item:
		img.texture = item.inventory_icon
	else:
		img.texture = empty

func toggle_selected(selected:bool):
	$Selected.visible = selected
