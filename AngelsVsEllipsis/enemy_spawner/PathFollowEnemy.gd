extends PathFollow2D

signal reached_end

var speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset += speed * delta
	if unit_offset == 1.0:
		emit_signal("reached_end")
