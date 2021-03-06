extends Node2D

class_name Enemy

export (float) var move_speed = 50

var max_health
export (float) var health

export (float) var regen_per_second = 0

onready var sprite = $Sprite
onready var health_bar: TextureProgress

var is_dead = false
signal death(verts)

export (int) var verts = 0


func _ready():
	add_to_group(get_node("/root/Globals").EnemyGroupName)
	
	max_health = health
	
	health_bar = $HealthBar
	health_bar.max_value = max_health

func _process(delta):
	if !is_dead:
		process_health(delta)

func process_health(delta):
	if health < max_health:
		health += regen_per_second * delta
	else:
		health = max_health
	
	health_bar.value = health
	
func take_damage(damage):
	health -= damage
	
	if health <= 0:
		if !is_dead:
			die()

func die():
	is_dead = true
	sprite.visible = false
	
	emit_signal("death", verts)
	queue_free()
