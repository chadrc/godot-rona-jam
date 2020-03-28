extends Node2D

export (PackedScene) var Enemy
export (NodePath) var PathReference

var SpawnPath


func _ready():
	SpawnPath = get_node(PathReference)


func _on_Timer_timeout():
	var enemy = Enemy.instance()
	SpawnPath.add_child(enemy)
