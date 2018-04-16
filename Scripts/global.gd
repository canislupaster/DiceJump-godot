extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var zerovector = Vector3(0,0,0)
const player = "res://Scenes/Entities/Player/Scripts/RigidBodyPlayer.gd"

func get_game():
	return get_node("/root/Game")

func degreetoradian (deg):
	return deg*(PI/180)

func changescene (path):
	get_tree().change_scene(path)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
