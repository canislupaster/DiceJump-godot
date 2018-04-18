extends Control

onready var game = global.get_game()

func intload(path):
	visible = true
	game.set_control_open(1)
	
	var loader = ResourceLoader.load_interactive(path)
	var count = loader.get_stage_count()
	$ProgressBar.max_value = count
	
	for i in count:
		$ProgressBar.value = loader.get_stage()
		var err = loader.poll()
	
	var resource = loader.get_resource()
	var instance = resource.instance()
	global.get_game().emit_signal("level_load",instance)
	
	game.set_control_open(0)
	visible = false

func bgload(path):
	Thread.new().start(self,"intload",path)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
