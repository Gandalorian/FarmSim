class_name Action_Slot
extends PanelContainer

@export var empty: Texture2D

@onready var label: Label = $Image/Label
@onready var count: Label = $Image/ItemCount
@onready var img = $Image

func _ready():
	img.texture = empty

func toggle_selected(selected:bool):
	$Selected.visible = selected

func set_slot_count(itemcount:int):
	if itemcount > 1:
		count.text = "{}".format([itemcount],"{}")
		count.visible = true
	else:
		count.visible = false

func set_texture(texture:Texture2D):
	img.texture = texture
