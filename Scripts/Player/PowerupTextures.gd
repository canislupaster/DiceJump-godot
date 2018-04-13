extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var children = [$FrontTexture, $BackTexture, $TopTexture, $BottomTexture, $LeftTexture, $RightTexture]

func loadout_tostring (x):
	return gamedata.slotarray[x]

func _loadout_reload(x):
	var i2 = 0
	for i in x:
		children[i2].set_texture(load("res://Assets/Loadout/Powerup/"+loadout_tostring(i)+".png"))
		i2+=1

func _ready():
	var game = get_node("/root/Game")
	game.connect("loadout_reload",self,"_loadout_reload")

	_loadout_reload(game.get_loadout())

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass