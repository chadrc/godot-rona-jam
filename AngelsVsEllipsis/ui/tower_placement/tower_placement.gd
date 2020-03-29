extends Button
class_name TowerPlacement

var is_showing_menu := false

onready var plus_sign: Label = $Label

# towers
onready var tl_tower: TowerButton = $tl_tower
onready var tr_tower: TowerButton = $tr_tower
onready var br_tower: TowerButton = $br_tower
onready var bl_tower: TowerButton = $bl_tower

func _ready():
	toggle_mode = true
	
	is_showing_menu = false
	set_menu_state(is_showing_menu)
	
	tl_tower.connect("spawn_tower", self, "on_spawn_tower")
	tr_tower.connect("spawn_tower", self, "on_spawn_tower")
	br_tower.connect("spawn_tower", self, "on_spawn_tower")
	bl_tower.connect("spawn_tower", self, "on_spawn_tower")


func on_spawn_tower(tower):
	var new_tower = tower.instance()
	new_tower.position = get_position()
	
	get_tree().root.add_child(new_tower)
	queue_free()


func _toggled(button_pressed: bool):
	is_showing_menu = button_pressed
	set_menu_state(is_showing_menu)


func set_menu_state(show: bool):
	plus_sign.visible = !show
	
	tl_tower.visible = show
	tr_tower.visible = show
	bl_tower.visible = show
	br_tower.visible = show
