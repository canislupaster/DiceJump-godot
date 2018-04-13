extends Position3D

onready var offsetpos = translation

func _ready():
	pass

func _process(delta):
	translation = (get_node("../RigidBody").translation)+offsetpos