extends Position3D

onready var offsetpos = translation
var rot_offset = 0 #90

func _ready():
	rotation_degrees.y += rot_offset

func _process(delta):
	translation = (get_node("../RigidBody").translation)+offsetpos