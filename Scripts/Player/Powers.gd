extends Node

onready var player = get_parent()

var slot = gamedata.Slot

func set_time_scale(scale):
	var slowtimed = get_tree().get_nodes_in_group("timeslow")
	for i in slowtimed:
		i.time_speed = scale
	Engine.time_scale = scale

func reset_powers(who):
	who.jumpcooldown = 3
	set_time_scale(1)
	who.speed = 2

func _use_power(who,power,currentpower):
	if currentpower != power:
		reset_powers(who)
	
	if power == slot.TripleJump:
		who.jumpcooldown = 0.5
		
	if power == slot.Shield:
		who.killable=false
		
	if power == slot.SlowTime:
		set_time_scale(0.4)
		
	if power == slot.Speed:
		who.speed = 5

func _ready():
	player.connect("use_power", self, "_use_power")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
