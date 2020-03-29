extends Button

var is_showing_menu

onready var plus_sign = $Label

# towers
onready var tl_tower = $tl_tower
onready var tr_tower = $tr_tower
onready var br_tower = $br_tower
onready var bl_tower = $bl_tower

func _ready():
	toggle_mode = true
	
	is_showing_menu = false
	set_menu_state(is_showing_menu)

func _toggled(button_pressed):
	is_showing_menu = button_pressed
	set_menu_state(is_showing_menu)

func set_menu_state(show):
	plus_sign.visible = !show
	
	tl_tower.visible = show
	tr_tower.visible = show
	bl_tower.visible = show
	br_tower.visible = show
