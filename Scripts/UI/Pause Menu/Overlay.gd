extends ColorRect

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	visible = false
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("game_pause"):
		var game = global.get_game()
		if visible:
			visible = false
			game.lock_mouse()
		else:
			visible = true #toggle visiblility
			game.unlock_mouse() #fix mouse