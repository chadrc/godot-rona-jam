extends Node2D

export (float) var move_speed = 50

var max_health
export (float) var health
export (float) var regen_per_second = 0
var is_dead = false

export (int) var verts = 0

func _ready():
	add_to_group(get_node("/root/Globals").EnemyGroupName)
	
	max_health = health

func _process(delta):
	process_health(delta)
	
func take_damage(damage):
	health -= damage
	
	if health <= 0:
		is_dead = true
		# emit death signal

func process_health(delta):
	if health < max_health:
		health += regen_per_second * delta
	else:
		health = max_health
