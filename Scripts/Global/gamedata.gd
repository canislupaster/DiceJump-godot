extends Node

enum Slot {None, TripleJump, Shield}
const slotarray = ["None", "TripleJump", "Shield"]

var savepath = "user://save.bin"

var save = {"level":0, "loadout":[Shield,TripleJump,Shield,TripleJump,Shield,TripleJump]} setget set_save, get_save
func set_save(x):
	save=x
	var savegame = File.new()
	
	savegame.open_encrypted_with_pass(savepath, File.WRITE, OS.get_unique_id())
	savegame.store_var(x)
	
func get_save(): return save

func _ready():
	var savegame = File.new()
	
	if not savegame.file_exists(savepath):
		savegame.open_encrypted_with_pass(savepath, File.WRITE, OS.get_unique_id())
		savegame.store_var(save)
	else:
		savegame.open_encrypted_with_pass(savepath, File.READ, OS.get_unique_id())
		save = savegame.get_var()
	savegame.close()