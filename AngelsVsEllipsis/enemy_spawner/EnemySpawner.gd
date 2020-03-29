extends Node2D

signal waves_complete

export (NodePath) var TargetPath
export (String) var DataFileName

var follow_enemy = preload("res://AngelsVsEllipsis/enemy_spawner/PathFollowEnemy.tscn")

var wave_data
var current_wave = 0
var timers = []
var deployed = []
var spawn_path

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_path = get_node(TargetPath)
	var file = File.new()
	file.open("res://AngelsVsEllipsis/data/levels/" + DataFileName + ".json", File.READ)
	wave_data = JSON.parse(file.get_as_text()).result
	start_wave(current_wave)
	
	
func start_wave(index):
	var first_wave = wave_data[index]
	var enemies = first_wave["enemies"]
	var duration = first_wave["duration"]
	
	var highest = 0
	for i in range(0, enemies.size()):
		var interval = duration / enemies[i]["count"]
		# print("interval for ", i, " : ", interval)
		
		var enemy_timer = Timer.new()
		enemy_timer.wait_time = interval
		enemy_timer.connect("timeout", self, "_on_enemy_timer", [i, enemies[i]["count"]])
		add_child(enemy_timer)
		timers.append(enemy_timer)
		deployed.append(0)
		
		enemy_timer.start()
		
		if interval > highest:
			highest = interval
	
	# add highest interval to wave duration
	# because first enemy is actually deployed interval time after start
	$WaveTimer.wait_time = duration + highest
	$WaveTimer.start()
	

func _on_enemy_timer(index, limit):
	# print("[", current_wave, "] enemy tick: ", index)
	
	if deployed[index] < limit:
		# deploy enemy
		deployed[index] += 1
		
		var data = wave_data[current_wave]["enemies"][index]
		var follower = follow_enemy.instance()
		var enemy = load("res://AngelsVsEllipsis/enemies/types/" + data["type"] + ".tscn").instance()
		
		follower.speed = enemy.move_speed
		follower.v_offset = rand_range(10.0, 100.0)
		
		enemy.connect("death", self, "_remove_enemy", [follower])
		follower.connect("reached_end", self, "_remove_enemy", [follower])
		
		follower.add_child(enemy)
		
		spawn_path.add_child(follower)


func _remove_enemy(follower):
	follower.queue_free()


func _on_WaveTimer_timeout():
	for timer in timers:
		timer.stop()
		timer.disconnect("timeout", self, "_on_enemy_timer")
		timer.queue_free()
		
	timers = []
	deployed = []
	
	# print("Wave ended")
	
	current_wave += 1
	
	if current_wave < wave_data.size():
		start_wave(current_wave)
	else:
		# print("Waves Complete")
		emit_signal("waves_complete")
