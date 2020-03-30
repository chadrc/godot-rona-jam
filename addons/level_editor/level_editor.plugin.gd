tool
extends EditorPlugin

var dock


func _enter_tree():
	# Initialization of the plugin goes here
	dock = preload("res://addons/level_editor/LevelEditor.tscn").instance()
	
	print("loading level editor")
	
	add_control_to_dock(DOCK_SLOT_LEFT_UR, dock)


func _exit_tree():
	# Clean-up of the plugin goes here
	remove_control_from_docks(dock)
	
	dock.free()
