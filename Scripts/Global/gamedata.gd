extends Node

enum Slot {None, TripleJump}
var savedata = {"level":0, "loadout":[None,None,None,None,None,None]}

var savepath = "user://save.bin"

var save
	

func _ready():
	var savegame = File.new()
	
	if not savegame.file_exists(savepath):
		savegame.open_encrypted_with_pass(savepath, File.WRITE, OS.get_unique_id())
		savegame.store_var(savedata)
		save = savedata
	else:
		savegame.open_encrypted_with_pass(savepath, File.READ, OS.get_unique_id())
		save = savegame.get_var()
	savegame.close()