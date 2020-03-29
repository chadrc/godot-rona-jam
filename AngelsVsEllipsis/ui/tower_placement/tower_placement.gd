extends Button

var is_showing_menu

onready var plus_sign = $Label

func _ready():
	toggle_mode = true
	
	is_showing_menu = false
	set_menu_state(is_showing_menu)

func _toggled(button_pressed):
	is_showing_menu = button_pressed
	set_menu_state(is_showing_menu)

func set_menu_state(show):
	plus_sign.visible = !show;
