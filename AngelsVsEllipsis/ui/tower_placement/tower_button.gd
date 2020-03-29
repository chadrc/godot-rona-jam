extends Button
class_name TowerButton

export var tower: PackedScene
export var sprite: Texture

onready var textureRect: TextureRect = $TextureRect

func _ready():
	textureRect.texture = sprite

signal spawn_tower(tower)

func _button_up():
	emit_signal("spawn_tower", tower)
