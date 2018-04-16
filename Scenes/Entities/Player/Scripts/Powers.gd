extends Node

onready var player = get_parent()
onready var game = global.get_game()

var slot = gamedata.Slot

var shield_killable = 2
var shield_platform = preload("res://Scenes/Decor/Platform/Domino/Platform.tscn")
var shield_platform_instance

func set_time_scale(scale):
	var slowtimed = get_tree().get_nodes_in_group("timeslow")
	for i in slowtimed:
		i.time_speed = scale
	Engine.time_scale = scale

func _platform_timer_end():
	shield_platform_instance.queue_free()
	shield_killable = true

func _try_kill(reason):
	var who = player
	if who.currentpower == slot.Shield and not shield_killable:
		who.vel += Vector3(0,5,0) + who.torque/2
		shield_platform_instance = shield_platform.instance()
		get_node("../../../").add_child(shield_platform_instance)
		shield_platform_instance.translation = who.translation
		shield_platform_instance.translation += Vector3(rand_range(-2,2),-2,rand_range(-2,2))
		
		var timer = Timer.new()
		timer.set_wait_time(1)
		timer.set_one_shot(true)
		timer.connect("timeout",self,"_platform_timer_end")
		add_child(timer)
		timer.start()
		shield_killable = 0
	else: game.emit_signal("death",reason)

func reset_powers(who):
	who.jumpcooldown = 3
	set_time_scale(1)
	who.speed = 2
	shield_killable = false

func _use_power(who,power,currentpower):
	if currentpower != power:
		reset_powers(who)
	
	if power == slot.TripleJump:
		who.jumpcooldown = 0.5
		
	if power == slot.SlowTime:
		set_time_scale(0.4)
	
	#if power == slot.Shield:
	
	if power == slot.Speed:
		who.speed = 5

func _death(reason):
	reset_powers(player)

func _ready():
	player.connect("use_power", self, "_use_power")
	player.connect("try_kill", self, "_try_kill")
	game.connect("death",self,"_death")
