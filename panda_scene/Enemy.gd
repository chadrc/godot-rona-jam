extends PathFollow2D

export var speed = 50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset = offset + speed * delta
