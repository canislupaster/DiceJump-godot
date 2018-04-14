extends ColorRect

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	visible = false
	set_process_input(true)
	pause_mode=PAUSE_MODE_PROCESS

func _input(event):
	if event.is_action_pressed("game_pause"):
		var game = global.get_game()
		if visible:
			visible = false
			game.lock_mouse()
			get_tree().paused = false
		else:
			visible = true #toggle visiblility
			game.unlock_mouse() #fix mouse
			get_tree().paused = true