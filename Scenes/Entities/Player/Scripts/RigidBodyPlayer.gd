extends RigidBody

onready var cam = get_node("../InterpolatedCamera")
onready var game = global.get_game()

var time_speed = 1

const zerovector = Vector3(0,0,0)

var jumpcooldown = 3
var livejumpcooldown = 0

var respawn = true
var checkpoint = false

var torque = zerovector
var angular_limit = Vector3(20,20,20)

var vjump = Vector3(0,10,0)
const vforward = Vector3(-5,0,0)
const vbackward = Vector3(5,0,0)
const vleft = Vector3(0,0,2)
const vright = Vector3(0,0,-2)

var vel = zerovector
var speed = 2
var damp = 1

var rotateangle = 0.1

signal use_power (who, newpower, oldpower)
signal try_kill (reason)

func _death (reason):
	respawn = true
func _checkpoint ():
	checkpoint = true

func _ready():
	print("ready:"+str(game.get_initial_transform()))
	game.connect("death", self, "_death")
	game.connect("checkpoint", self, "_checkpoint")
	#self.connect("try_kill", self, "_try_kill")
	
	if not game.get_initial_transform():
		game.emit_signal("checkpoint")

func moveWASD (input, dirvel):
		if Input.is_action_pressed(input):
			var rad = cam.rotation.y
			
			
			torque+=(dirvel*speed).rotated(Vector3(0,1,0),rad)

func _process(delta):
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
	
	vel = global.zerovector
	torque = global.zerovector
	
	if damp > 1:
		state.linear_velocity = state.linear_velocity/damp
	
	if checkpoint:
		game.set_initial_transform(state.transform)
		checkpoint = false
	
	if respawn:
		state.transform = game.get_initial_transform()
		state.linear_velocity = Vector3(0,0,0)
		state.angular_velocity = Vector3(0,0,0)
		
		respawn = false

# POWERUPS

var currentpower = gamedata.Slot.None

func _on_RigidBody_body_shape_entered(body_id, body, body_shape, local_shape):
	if body.is_in_group("touch_death"):
		game.try_kill_player_rb(self, body.killreason)
	else:
		var power = game.get_loadout()[local_shape]
		
		emit_signal("use_power", self, power, currentpower)
		
		currentpower = power