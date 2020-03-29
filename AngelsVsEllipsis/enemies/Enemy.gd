extends PathFollow2D

export var speed = 50


func _ready():
	add_to_group(get_node("/root/Globals").EnemyGroupName)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset = offset + speed * delta
