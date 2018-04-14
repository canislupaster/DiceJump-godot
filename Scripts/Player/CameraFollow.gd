extends Position3D

onready var offsetpos = translation
var rot_offset = 75 setget set_rot_offset, get_rot_offset #90

func set_rot_offset (x): rot_offset = x
func get_rot_offset(): return rot_offset

func _ready():
	rotation_degrees.y += rot_offset

func _process(delta):
	translation = (get_node("../RigidBody").translation)+offsetpos+Vector3(rot_offset/8,0,0)