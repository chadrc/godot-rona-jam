tool
extends Control

var list_item_scene = preload("res://addons/level_editor/level_list_item.tscn")


func _ready():
	var directory = Directory.new()
	directory.open("res://AngelsVsEllipsis/data/levels/")
	directory.list_dir_begin(true, true)
	
	var file = directory.get_next()
	while file != "":
		$LevelsList.add_item(file)
		file = directory.get_next()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
