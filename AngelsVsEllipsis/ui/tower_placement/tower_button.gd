extends Button
class_name TowerButton

export var tower: PackedScene

signal spawn_tower(tower)

func _pressed():
	emit_signal("spawn_tower", tower)
