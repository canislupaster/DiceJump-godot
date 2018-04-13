extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var levels = ["Tests/PlayerTest.tscn"]

var levelnum
var levelnode

signal level_done
signal game_done

func load_level(num):
	if levelnode:
		levelnode.queue_free()
		
	if levelnum < levels.size():
		get_node("./Overlay/Level").set_text("LEVEL "+str(num+1))
		var levelpath = levels[levelnum]
	
		var level = load(levelpath).instance()
		add_child(level)
		levelnode = level
	else: emit_signal("game_done")

func _level_done():
	levelnum=levelnum+1
	load_level(levelnum)

func _ready():
	for i in range(levels.size()):
		levels[i] = "res://Scenes/Game/Levels/"+levels[i]
	
	levelnum = gamedata.save["level"]
	load_level(levelnum)
	
	self.connect("level_done", self, "_level_done")
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass