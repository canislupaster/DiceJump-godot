extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var levels = ["1/Level.tscn"]

var levelnum
var levelnode

var initial_transform

signal level_load(instance)
signal level_done
signal game_done

signal death(reason)
signal checkpoint

signal loadout_reload(x)

func focus():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false

func unfocus():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true

var loadout setget set_loadout, get_loadout
func set_loadout(x):
	loadout = x
	emit_signal("loadout_reload", x)
func get_loadout(): return loadout
func loadout_tostring (x):
	return gamedata.slotarray[x]

func get_gamesave():
	return {"level":levelnum, "transform":initial_transform, "loadout":loadout}

func _game_done():
	gamedata.set_save(gamedata.defaultsave)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	global.changescene("res://Scenes/Game/End.tscn")

func load_level(num):
	if levelnode:
		levelnode.queue_free()
		
	if levelnum < levels.size():
		get_node("UI/Overlay/Level").set_text("LEVEL "+str(num+1))
		var levelpath = levels[levelnum]
		get_node("UI/Loader").bgload(levelpath)
	else:
		emit_signal("game_done")

func _level_load(l):
	add_child(l)
	levelnode = l
	
	emit_signal("loadout_reload",loadout)
	focus()

func _level_done():
	levelnum=levelnum+1
	load_level(levelnum)

func is_player_rb(rb):
	return rb is preload("res://Scripts/Player/RigidBodyPlayer.gd")
	
func try_kill_player_rb(rb,reason):
	if is_player_rb(rb):
		rb.emit_signal("try_kill", reason)
	
var control_open = 0 setget set_control_open, get_control_open
func set_control_open(x):
	if x > 0:
		control_open+=1
	else:
		control_open-=1
	
	if control_open > 0:
		unfocus()
	else: focus()

func get_control_open(): return control_open

func _ready():
	for i in range(levels.size()):
		levels[i] = "res://Scenes/Game/Levels/"+levels[i]
	
	self.connect("level_done", self, "_level_done")
	self.connect("game_done", self, "_game_done")
	self.connect("level_load", self, "_level_load")
	
	levelnum = gamedata.save["level"]
	loadout = gamedata.save["loadout"]
	
	load_level(levelnum)