extends RigidBody

onready var cam = get_node("../InterpolatedCamera")
onready var game = global.get_game()

var time_speed = 1

const zerovector = Vector3(0,0,0)

var jumpcooldown = 3
var livejumpcooldown = 0

var respawn = false
var killable = true setget set_killable, get_killable
func set_killable(x): killable = x
func get_killable(): return killable

var torque = zerovector
var angular_limit = Vector3(20,20,20)

var vjump = Vector3(0,10,0)
const vforward = Vector3(-5,0,0)
const vbackward = Vector3(5,0,0)
const vleft = Vector3(0,0,2)
const vright = Vector3(0,0,-2)

var vel = zerovector
var speed = 2

var rotateangle = 0.1

signal use_power (newpower, oldpower)

func _death (reason):
	respawn = true
func _checkpoint ():
	game.initial_transform = self.transform


func _ready():
	game.connect("death", self, "_death")
	game.connect("checkpoint", self, "_checkpoint")
	
	if gamedata.save["transform"]:
		game.initial_transform = gamedata.save["transform"]
		respawn = true
	else: game.initial_transform = self.transform

func moveWASD (input, dirvel):
		if Input.is_action_pressed(input):
			var rad = global.degreetoradian(cam.rotation_degrees.y)
			
			
			torque+=(dirvel*speed).rotated(Vector3(0,1,0),rad)

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
		livejumpcooldown = livejumpcooldown - (delta/time_speed)

func _integrate_forces(state):
	state.apply_torque_impulse(torque)
	set_axis_velocity(vel)
	
	if respawn:
		state.transform = game.initial_transform
		state.linear_velocity = Vector3(0,0,0)
		state.angular_velocity = Vector3(0,0,0)
		
		respawn = false

# POWERUPS

var currentpower = gamedata.Slot.None

func _on_RigidBody_body_shape_entered(body_id, body, body_shape, local_shape):
	var power = game.get_loadout()[local_shape]
	
	emit_signal("use_power", self, power, currentpower)
	
	currentpower = power
	