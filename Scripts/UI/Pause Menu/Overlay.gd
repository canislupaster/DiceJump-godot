extends ColorRect

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process_input(true)
	pause_mode=PAUSE_MODE_PROCESS

func _input(event):
	if event.is_action_pressed("game_pause"):
		var game = global.get_game()
		if visible:
			visible = false
			game.set_control_open(0)
		else:
			visible = true #toggle visiblility
			game.set_control_open(1)