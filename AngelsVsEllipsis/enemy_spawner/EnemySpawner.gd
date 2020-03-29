extends Node2D

export (NodePath) var PathReference
export (Resource) var Data


# Called when the node enters the scene tree for the first time.
func _ready():
	print("spawner ready: ", Data.new().Waves)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
