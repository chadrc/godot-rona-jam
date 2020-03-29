extends Area2D
signal attack(target)
signal hit

export (float) var atkDamage = 5
export (float) var atkSpeed = 1

export (float) var maxHealth
export (float) var health 

onready var ANIM = $AnimatedSprite


var currentAtkTime = 0
#dictionary of current targets with a value of body and their index in the currentTargets array
var currentTargetsData = {}
#array of target instance_ids. Key values of the currentTargetsData
var currentTargets = []


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = 'idle'


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#We have targets in our list
	if currentTargets.size() > 0: 
		$AnimatedSprite.animation = 'active'
		#subtract our attack speed by deltaTime
		currentAtkTime -= delta
		
		#When attack time reaches 0, attack the enemy that's at the front of our current targets array
		if currentAtkTime <= 0 && currentTargets[0] != null: 
			currentTargetsData[currentTargets[0]].area.take_damage(atkDamage)
			currentAtkTime = atkSpeed
			
	else: 
		$AnimatedSprite.animation = 'idle'

#Add the enemy to a dictionary using it's instance id as a key and it's body as a value.
func _on_Tower_area_entered(area):
	if area.is_in_group(get_node("/root/Globals").EnemyGroupName):
			currentTargetsData[area.get_instance_id()] = {"area": area, "index": currentTargets.size() - 1 if (currentTargets.size() != 0) else 0}
			currentTargets.push_back(area.get_instance_id())

#Remove the Enemy if it leaves the tower's radial space
func _on_Tower_area_exited(area):
	if area.is_in_group(get_node("/root/Globals").EnemyGroupName):
			currentTargets.remove(currentTargetsData[area.get_instance_id()].index)
			currentTargetsData.erase(area.get_instance_id())
