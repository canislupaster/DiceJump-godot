extends RigidBody

onready var cam = get_node("../InterpolatedCamera")

const zerovector = Vector3(0,0,0)

var jumpcooldown = 1
var livejumpcooldown = 0

var torque = zerovector
var vjump = Vector3(0,10,0)
const vforward = Vector3(-5,0,0)
const vbackward = Vector3(5,0,0)
const vleft = Vector3(0,0,2)
const vright = Vector3(0,0,-2)

var vel = zerovector
var speed = 2

var rotateangle = 0.1

func _ready():
	pass


func moveWASD (input, dirvel):
		if Input.is_action_pressed(input):
			var rad = global.degreetoradian(cam.rotation_degrees.x)
			torque+=(dirvel*speed).rotated(Vector3(0,1,0),-rad)

func _process(delta):
	vel = global.zerovector
	torque = global.zerovector
	
	if Input.is_action_pressed("move_jump") and livejumpcooldown <= 0:
		livejumpcooldown = jumpcooldown
		vel += vjump
		
	moveWASD("move_forward",vforward)
	moveWASD("move_backward",vbackward)
	moveWASD("move_left",vleft)
	moveWASD("move_right",vright)
	
	if livejumpcooldown > 0:
		livejumpcooldown = livejumpcooldown - delta

func _integrate_forces(state):
	state.apply_torque_impulse(torque)
	set_axis_velocity(vel)

# POWERUPS

var loadout = gamedata.save["loadout"]
var slot = gamedata.Slot		
var currentpower = slot.None

func reset_powers():
	jumpcooldown=1

func _on_RigidBody_body_shape_entered(body_id, body, body_shape, local_shape):
	var power = loadout[local_shape]
	
	if currentpower != power:
		reset_powers()
	
	if power == slot.TripleJump:
		jumpcooldown = 0.5