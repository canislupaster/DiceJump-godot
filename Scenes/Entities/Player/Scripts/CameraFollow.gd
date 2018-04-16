extends Position3D

onready var offsetpos = translation
var rot_offset = 0 setget set_rot_offset, get_rot_offset #90
var cameravel = Vector2(0,0)
var sensitivity = 1


func set_rot_offset (x):
	rot_offset = x
	rotation_degrees.y= rot_offset
func get_rot_offset(): return rot_offset

func _ready():
	set_process_input(true)

func fix_camera_axis(ax):
	if ax > 360: return 0
	elif ax < -360: return 0
	else: return ax	

func _process(delta):
	var posz = 0
	#if rotation_degrees.y > 180 or rot < -180:
	#	posz-=offsetpos.z*2
	translation = (get_node("../RigidBody").translation)+offsetpos+Vector3(0,0,posz)
	
	rotation_degrees.x += -cameravel.y
	rotation_degrees.y += cameravel.x
	
	rotation_degrees.y = fix_camera_axis(rotation_degrees.y)
	
	cameravel = global.zerovector

func _input(event):
	if event is InputEventMouseMotion:
		cameravel = (event.relative/10)*sensitivity