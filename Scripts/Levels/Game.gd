extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var levels = ["Tests/PlayerTest.tscn"]

var levelnum
var levelnode

var initial_transform

signal level_done
signal game_done

signal death(reason)
signal checkpoint

signal loadout_reload(x)


var loadout setget set_loadout, get_loadout
func set_loadout(x):
	loadout = x
	emit_signal("loadout_reload")
func get_loadout(): return loadout

func get_gamesave():
	return {"level":levelnum, "transform":initial_transform, "loadout":loadout}

func _game_done():
	gamedata.set_save(gamedata.defaultsave)

func load_level(num):
	if levelnode:
		levelnode.queue_free()
		
	if levelnum < levels.size():
		get_node("./Overlay/Level").set_text("LEVEL "+str(num+1))
		var levelpath = levels[levelnum]
	
		var level = load(levelpath).instance()
		add_child(level)
		levelnode = level
	else:
		emit_signal("game_done")

func _level_done():
	levelnum=levelnum+1
	load_level(levelnum)

func is_player_rb(rb):
	return rb is preload("res://Scripts/Player/RigidBodyPlayer.gd")
	
func try_kill_player_rb(rb,reason):
	if is_player_rb(rb):
		if rb.get_killable():
			self.emit_signal("death", reason)
		else: rb.set_killable(true)

func lock_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func unlock_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _ready():
	for i in range(levels.size()):
		levels[i] = "res://Scenes/Game/Levels/"+levels[i]
	
	levelnum = gamedata.save["level"]
	loadout = gamedata.save["loadout"]
	emit_signal("loadout_reload",loadout)
	
	load_level(levelnum)
	
	self.connect("level_done", self, "_level_done")
	self.connect("game_done", self, "_game_done")
	
	lock_mouse()