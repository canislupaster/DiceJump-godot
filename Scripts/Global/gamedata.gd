extends Node

enum Slot {None, TripleJump, Shield, SlowTime}
const slotarray = ["None", "TripleJump", "Shield", "SlowTime"]

var savepath = "user://save.txt"
var defaultsave = {"level":0, "transform":null, "loadout":[SlowTime,SlowTime,SlowTime,SlowTime,SlowTime,SlowTime]}
var save = defaultsave setget set_save, get_save
func set_save(x):
	save=x
	var savegame = File.new()
	
	savegame.open(savepath, File.WRITE)
	savegame.store_var(x)
	
func get_save(): return save

func _ready():
	var savegame = File.new()
	
	if not savegame.file_exists(savepath):
		savegame.open(savepath, File.WRITE)
		savegame.store_var(save)
	else:
		savegame.open(savepath, File.READ)
		save = savegame.get_var()
	savegame.close()