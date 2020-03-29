extends Button
class_name TowerPlacement

var is_showing_menu := false

onready var plus_sign: Label = $Label

# towers
onready var tl_tower: Button = $tl_tower
onready var tr_tower: Button = $tr_tower
onready var br_tower: Button = $br_tower
onready var bl_tower: Button = $bl_tower

func _ready():
	toggle_mode = true
	
	is_showing_menu = false
	set_menu_state(is_showing_menu)

func _toggled(button_pressed: bool):
	is_showing_menu = button_pressed
	set_menu_state(is_showing_menu)

func set_menu_state(show: bool):
	plus_sign.visible = !show
	
	tl_tower.visible = show
	tr_tower.visible = show
	bl_tower.visible = show
	br_tower.visible = show
