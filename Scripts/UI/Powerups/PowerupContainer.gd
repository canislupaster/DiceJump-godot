extends VBoxContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var game = global.get_game()
onready var children = get_tree().get_nodes_in_group("powerup_ui")

func _loadout_reload(x):
	var i2 = 0
	for i in x:
		children[i2].set_normal_texture(load("res://Assets/Loadout/Powerup/"+game.loadout_tostring(i)+".png"))
		children[i2].set_meta("powerup_enum",i)
		children[i2].set_meta("powerup_sidenum", i2)
		i2+=1

func powerup_pressed(x):
	var power = x.get_meta("powerup_enum")
	var side = x.get_meta("powerup_sidenum")
	var newpow
	if power+1 >= gamedata.Slot.size():
		newpow = 0
	else: newpow = power+1
	var loadout = game.get_loadout()
	loadout[side] = newpow
	game.set_loadout(loadout)

func _ready():
	set_process_input(true)
	pause_mode=PAUSE_MODE_PROCESS
	
	for i in children:
		i.connect("pressed_node", self, "powerup_pressed", [i])
	
	game.connect("loadout_reload",self,"_loadout_reload")

func _input(event):
	if event.is_action_pressed("game_toggle_powerup"):
		var x = get_parent().get_parent()
		if x.visible:
			x.visible = false
			game.set_control_open(0)
		else:
			x.visible = true #toggle visiblility
			game.set_control_open(1)